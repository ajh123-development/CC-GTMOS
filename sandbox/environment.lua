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

-- Base LUA libs.

-- Copy the real load function but use a custom global environment.
newEnv["load"] =  function(x, name, mode, env)
	local global = deep_copy(newEnv)
	for k,v in pairs(env) do global[k] = v end
	return load(x, name, mode, global)
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

    local fnFile, e = newEnv["loadfile"](_sFile, nil, _G)
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
newEnv["os"] = newOS -- Add the os API to the environment.

-- GTMOS settings API.
local newSettings = deep_copy(settings) -- Copy parent settings API because we don't want to overide it.

newSettings["get"] = function(name, default)
    if name == "shell.allow_startup" or name == "shell.allow_disk_startup" then -- Disable shell startup files.
        return false
    end
    return settings.get(name, default)
end


newEnv["settings"] = newSettings

newEnv._G = newEnv
newEnv._ENV = newEnv

return newEnv