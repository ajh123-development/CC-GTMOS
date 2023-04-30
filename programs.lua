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

local function openProgram(root, func, title, x, y, w, h)
	local pId = id
	id = id + 1
	local f = root:addFrame()
		:setMovable()
		:setSize(w or 30, h or 12)
		:setPosition(x or math.random(2, 12), y or math.random(2, 8))

	local process = {
		id = pId,
		frame = f,
		state = {
			selected = true
		}
	}

	f:addLabel()
		:setSize("parent.w", 1)
		:setBackground(colors.white)
		:setForeground(colors.black)
		:setText(title or "New Program")

	f:addProgram()
		:setSize("parent.w", "parent.h - 1")
		:setPosition(1, 2)
		:execute(function()
			-- local sandboxed_f = sandbox.protect(func, {env = {
			-- 	_G = environment,
			-- 	_ENV = environment,
			-- 	os = environment.os,
			-- 	shell = environment.shell
			-- }})
			local sandboxed_f = sandbox.protect(func, {env=environment, quota=false})
			local ok, mess = pcall(sandboxed_f, environment)
			if not ok then
				print(mess)
			end
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
	processes[pId] = process
	return process
end

return {
	openProgram = openProgram
}