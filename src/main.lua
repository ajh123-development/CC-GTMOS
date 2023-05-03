local tArgs = { ... }
local path = "/"..fs.getDir(shell.getRunningProgram())
if #tArgs > 0 then
	path = tArgs[1]
end

local basalt = require("basalt")
local theme = require("theme")
local programs = require("programs")
local config = dofile(path.."/config.lua")

basalt.setTheme(theme)
local main = basalt.createFrame()

local startMenu = main:addFrame():setSize(20, 15):setPosition(1, "parent.h - 15")
local startMenuPrograms = startMenu:addScrollableFrame():setSize(14, 15):setPosition("parent.w - 14", 2)

local menubar = main:addMenubar()
:setSize("parent.w - 15")
:setPosition(8, "parent.h")

for nameCount = 1, #config.programs do
	local color = colors.gray
	local foreColor = colors.white
	if nameCount %2 == 0 then
		color = colors.lightGray
		foreColor = colors.black
	end

	startMenuPrograms:addButton()
	:setText("   "..config.programs[nameCount].name)
	:setPosition(1, nameCount)
	:setSize(14, 1)
	:setBackground(color)
	:setForeground(foreColor)
	:onClick(function(self, event, button, x, y)
		-- if(event=="mouse_click")and(button==1)then
			startMenu:hide()
			programs.openProgram(basalt, main, menubar, function()
					local program = config.programs[nameCount].path
					if not string.starts(program, "/") then
						program = path.."/src/programs/"..program
					end
					if program ~= "/rom/programs/shell.lua" then
						os.run({}, "/rom/programs/shell.lua", program)
					else
						os.run({}, program)
					end
				end,
				config.programs[nameCount]
			)
		-- end
	end)
	startMenuPrograms:addImage()
	:setPosition(1, nameCount)
	:setSize(2, 1)
	:blit(
		config.programs[nameCount].icon[1], 
		config.programs[nameCount].icon[2], 
		config.programs[nameCount].icon[3]
	):setZIndex(499)
end


startMenu:hide()
startMenu:onLoseFocus(
	function(self) 
		self:hide()
	end
)

main:addButton()
:setText("Start")
:setPosition(1, "parent.h")
:setSize(7, 1)
:setForeground(colors.white)
:onClickUp(function(self, event, button, x, y)
	-- if(event=="mouse_up")and(button==1)then
		startMenu:setOffset(0, 0):show():setFocus():setZIndex(1000)
	-- end
end)

local clockThread = main:addThread()
local clock = main:addLabel()
:setText("10:10 PM")
:setSize(8, 1)
:setForeground(colors.white)
:setBackground(colors.gray)
:setPosition("parent.w - 7", "parent.h")

local function clockTask()
	while true do
		clock:setText(textutils.formatTime(os.time(), true))
		os.sleep(0.5)
	end
end

clockThread:start(clockTask)

-- menubar:addItem("Start", theme.MenubarBG, theme.MenubarText,
-- 	function()
-- 		startMenu:setOffset(0, 0)
-- 		startMenu:show()
-- 		startMenu:setFocus()
-- 	end
-- )

-- menubar:onChange(function()
-- 	startMenu:hide()
-- 	local menuIndex = menubar:getItemIndex()
-- 	local func = menubar:getItem(menuIndex).args[1]
-- 	menubar:selectItem(0)
-- 	func()
-- end)


-- local startDropdown = main:addDropdown({text="Start"})
-- startDropdown:addItem("Shell", theme.MenubarBG, theme.MenubarText, {
-- 	function()
-- 		os.run({}, "/rom/programs/shell.lua")
-- 	end,
-- 	"Shell"
-- })

-- startDropdown:onChange(function()
-- 	local menuIndex = startDropdown:getItemIndex()
-- 	local tbl = startDropdown:getItem(menuIndex).args[1]
-- 	programs.openProgram(main, table.unpack(tbl))
-- 	startDropdown:selectItem(0)
-- end)
-- menubar:selectItem(0)

basalt.autoUpdate()