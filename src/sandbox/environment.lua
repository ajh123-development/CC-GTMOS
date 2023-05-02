-- Define some handy functions.

local function deep_copy(original, copies)
	if type( original ) ~= 'table' then return original end

	-- original is a table.
	copies = copies or {} -- this is a cache of already copied tables.

	-- This table has been copied previously.
	if copies[original] then return copies[original] end

	-- We need to deep copy the table not deep copied previously.
	local copy = {}
	copies[original] = copy -- store a reference to copied table in the cache.
	for key, value in pairs( original ) do
		local dc_key, dc_value = deep_copy( key, copies ), deep_copy( value, copies )
		copy[dc_key] = dc_value
	end
	setmetatable(copy, deep_copy( getmetatable( original ), copies) )
	return copy
end


-- Load the CC expect libraray.
local expect

do
	local h = fs.open("rom/modules/main/cc/expect.lua", "r")
	local f, err = loadstring(h.readAll(), "@expect.lua")
	h.close()

	if not f then error(err) end
	expect = f().expect
end


-- Begin sandbox environment.

newEnv = deep_copy(_G) -- Copy parent environment because we don't want to overide it.
newEnv._G = newEnv
newEnv._ENV = newEnv

-- Base LUA libs.

-- Copy the real load function but use a custom global environment.
newEnv["load"] =  function(x, name, mode, env)
	local global = deep_copy(newEnv)
	for k,v in pairs(global) do env[k] = v end
	local info = load(x, name, mode, env)
	return info
end

-- Copy the real loadstring function but use custom load.
newEnv["loadstring"] = function(string, chunkname) return newEnv["load"](string, chunkname) end

-- Copy the real loadfile function but use custom load.
newEnv["loadfile"] = function(filename, mode, env)
	-- Support the previous `loadfile(filename, env)` form instead.
	if type(mode) == "table" and env == nil then
		mode, env = nil, mode
	end

	expect(1, filename, "string")
	expect(2, mode, "string", "nil")
	expect(3, env, "table", "nil")

	local file = fs.open(filename, "r")
	if not file then return nil, "File not found" end

	local func, err = newEnv["load"](file.readAll(), "@" .. fs.getName(filename), mode, env)
	file.close()
	return func, err
end

-- Copy the real dofile function but use custom loadfile.
newEnv["dofile"] = function(_sFile)
	expect(1, _sFile, "string")

	local fnFile, e = newEnv["loadfile"](_sFile, nil, newEnv._G)
	if fnFile then
		return fnFile()
	else
		error(e, 2)
	end
end

-- GTMOS OS API.
local newOS = deep_copy(os) -- Copy parent OS API because we don't want to overide it.
newOS.version = function()
	return "GT MOS 0.0.1"
end

newOS.run = function(_tEnv, _sPath, ...)
	expect(1, _tEnv, "table")
	expect(2, _sPath, "string")

	local tEnv = _tEnv
	setmetatable(tEnv, { __index = _G })

	if settings.get("bios.strict_globals", false) then
		-- load will attempt to set _ENV on this environment, which
		-- throws an error with this protection enabled. Thus we set it here first.
		tEnv._ENV = tEnv
		getmetatable(tEnv).__newindex = function(_, name)
			error("Attempt to create global " .. tostring(name), 2)
		end
	end

	local fnFile, err = newEnv["loadfile"](_sPath, nil, tEnv)
	if fnFile then
		local ok, err = pcall(fnFile, ...)
		if not ok then
			if err and err ~= "" then
				printError(err)
			end
			return false
		end
		return true
	end
	if err and err ~= "" then
		printError(err)
	end
	return false
end


local tAPIsLoading = {}
newOS["loadAPI"] = function(_sPath)
	expect(1, _sPath, "string")
	local sName = fs.getName(_sPath)
	if sName:sub(-4) == ".lua" then
		sName = sName:sub(1, -5)
	end
	if tAPIsLoading[sName] == true then
		printError("API " .. sName .. " is already being loaded")
		return false
	end
	tAPIsLoading[sName] = true

	local tEnv = {}
	newEnv["setmetatable"](tEnv, { __index = newEnv._G })
	local fnAPI, err = newEnv["loadfile"](_sPath, nil, tEnv)
	if fnAPI then
		local ok, err = pcall(fnAPI)
		if not ok then
			tAPIsLoading[sName] = nil
			return error("Failed to load API " .. sName .. " due to " .. err, 1)
		end
	else
		tAPIsLoading[sName] = nil
		return error("Failed to load API " .. sName .. " due to " .. err, 1)
	end

	local tAPI = {}
	for k, v in pairs(tEnv) do
		if k ~= "_ENV" then
			tAPI[k] =  v
		end
	end

	newEnv._G[sName] = tAPI
	tAPIsLoading[sName] = nil
	return true
end

newOS["unloadAPI"] = function(_sName)
	expect(1, _sName, "string")
	if _sName ~= "_G" and type(newEnv._G[_sName]) == "table" then
		newEnv._G[_sName] = nil
	end
end

newEnv["os"] = newOS -- Add the os API to the environment.

-- GTMOS settings API.
local newSettings = require("sandbox/settings")
-- Set default settings
newSettings.define("shell.autocomplete", {
	default = true,
	description = "Autocomplete program and arguments in the shell.",
	type = "boolean",
})
newSettings.define("edit.autocomplete", {
	default = true,
	description = "Autocomplete API and function names in the editor.",
		type = "boolean",
})
newSettings.define("lua.autocomplete", {
	default = true,
	description = "Autocomplete API and function names in the Lua REPL.",
		type = "boolean",
})

newSettings.define("edit.default_extension", {
	default = "lua",
	description = [[The file extension the editor will use if none is given. Set to "" to disable.]],
	type = "string",
})
newSettings.define("paint.default_extension", {
	default = "nfp",
	description = [[The file extension the paint program will use if none is given. Set to "" to disable.]],
	type = "string",
})

newSettings.define("list.show_hidden", {
	default = false,
	description = [[Show hidden files (those starting with "." in the Lua REPL)]],
	type = "boolean",
})

newSettings.define("motd.enable", {
	default = true,
	description = "Display a random message when the computer starts up.",
	type = "boolean",
})
newSettings.define("motd.path", {
	default = "/rom/motd.txt:/motd.txt",
	description = [[The path to load random messages from. Should be a colon (":") separated string of file paths.]],
	type = "string",
})

newSettings.define("lua.warn_against_use_of_local", {
	default = true,
	description = [[Print a message when input in the Lua REPL starts with the word 'local'. Local variables defined in the Lua REPL are be inaccessable on the next input.]],
	type = "boolean",
})
newSettings.define("lua.function_args", {
	default = true,
	description = "Show function arguments when printing functions.",
	type = "boolean",
})
newSettings.define("lua.function_source", {
	default = false,
	description = "Show where a function was defined when printing functions.",
	type = "boolean",
})
newSettings.define("bios.strict_globals", {
	default = false,
	description = "Prevents assigning variables into a program's environment. Make sure you use the local keyword or assign to _G explicitly.",
	type = "boolean",
})
newEnv["settings"] = newSettings

newEnv["string"]["starts"] = function(String,Start)
	return string.sub(String,1,string.len(Start))==Start
end

newEnv["gtmos"] = {}
newEnv["gtmos"]["test"] = function()
	print("hello")
end

return {
	build = function(outer)
		newEnv.gtmos.getCurrentProcessID = function()
			return outer.id
		end
		newEnv.gtmos.getProcesses = function()
			local result = {}
			for k, v in pairs(outer.processes) do
				result[k] = v.id
			end
			return result
		end
		return deep_copy(newEnv)
	end
}