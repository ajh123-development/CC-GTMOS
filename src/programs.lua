local environment = require("sandbox/environment")
local sandbox = require("sandbox/sandbox")
local id = 1
local processes = {} 

local function makeResizeable(frame, minW, minH, maxW, maxH)
	minW = minW or 4
	minH = minH or 4
	maxW = maxW or 99
	maxH = maxH or 99
	frame:addButton()
		:setPosition("parent.w", "parent.h")
		:setSize(1, 1)
		:setText("/")
		:setForeground(colors.blue)
		:setBackground(colors.black)
		:onDrag(function(self, event, btn, xOffset, yOffset)
			local w, h = frame:getSize()
			local wOff, hOff = w, h
			if(w+xOffset-1>=minW)and(w+xOffset-1<=maxW)then
				wOff = w+xOffset-1
			end
			if(h+yOffset-1>=minH)and(h+yOffset-1<=maxH)then
				hOff = h+yOffset-1
			end
			frame:setSize(wOff, hOff)
		end)
end

local function openProgram(root, menubar, func, title, icon, x, y, w, h)
	local pId = id
	id = id + 1
	title = title.." ("..tostring(pId)..")" or "New Program".." ("..tostring(pId)..")"
	local programFrame
	local f = root:addFrame()
		:setMovable()
		:setSize(w or 30, h or 12)
		:setPosition(x or math.random(2, 12), y or math.random(2, 8))
		:setFocus()

	f:addImage()
		:setSize(2, 1)
		-- :blit(icon[1], icon[2], icon[3]) -- Need to wait for new Basalt update.

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
			local env = environment.deep_copy(environment.env)
			local sandboxed_f = sandbox.protect(func, {env=env, quota=false})
			local ok, mess = pcall(sandboxed_f)
			if not ok then
				f:remove()
				processes[pId] = nil

				local errFrame = root:addFrame()
				:setSize("parent.w / 2", "parent.h / 2")
				:setPosition("parent.w / 2 - self.w / 2", "parent.h / 2 - self.h / 2")
				:setMovable()

				errFrame:addLabel()
				:setSize("parent.w", 1)
				:setBackground(colors.white)
				:setForeground(colors.black)
				:setText("Error in `"..title.."`")

				errFrame:addButton()
				:setSize(1, 1)
				:setText("\183")
				:setBackground(colors.white)
				:setForeground(colors.red)
				:setPosition("parent.w", 1)
				:onClick(function()
					errFrame:remove()
				end)

				errFrame:addLabel()
					:setPosition(2, 3)
					:setSize("parent.w - 2", "parent.h - 3")
					:setText(mess)

				makeResizeable(errFrame)
			end
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

	makeResizeable(f)

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