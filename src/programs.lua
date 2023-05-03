local environment = require("sandbox/environment")
local sandbox = require("sandbox/sandbox")
local id = 1
local processes = {} 

local function openProgram(basalt, root, menubar, func, program, x, y, w, h)
	local pId = id
	id = id + 1
	local title = program.name.." ("..tostring(pId)..")" or "New Program".." ("..tostring(pId)..")"
	local programFrame
	local newW = w or 30
	local newH = h or 12
	local f = root:addMovableFrame()
		:setSize(newW, newH)
		:setPosition(x or math.random(2, 12), y or math.random(2, 8))
		:setFocus()

	f:addImage()
		:setSize(2, 1)
		:blit(program.icon[1], program.icon[2], program.icon[3])

	f:addLabel()
		:setSize("parent.w - 3", 1)
		:setPosition(3)
		:setBackground(colors.white)
		:setForeground(colors.black)
		:setText(title)

	programFrame = f:addProgram()
		:setSize("parent.w", "parent.h - 1")
		:setPosition(1, 2)
		:execute(function()
			local env = environment.build({
				processes = processes, 
				id = pId
			})
			local sandboxed_f = sandbox.protect(func, {env=env, quota=false})
			local _, _ = pcall(sandboxed_f)
		end)
		:setFocus()
		:onDone(function()
			f:remove()
			processes[pId] = nil
		end)

	f:addButton()
		:setSize(1, 1)
		:setText("\183")
		:setBackground(colors.white)
		:setForeground(colors.red)
		:setPosition("parent.w", 1)
		:onClick(function()
			f:remove()
			processes[pId] = nil
		end)

	local process = {
		id = pId,
		frame = f,
		programFrame = programFrame
	}

	processes[pId] = process
	return process
end

local function getProcesses() 
	return processes
end

return {
	openProgram = openProgram,
	getProcesses = getProcesses
}