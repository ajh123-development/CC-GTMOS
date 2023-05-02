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

local startMenu = main:addFrame():setScrollable():setSize(20, 15):setPosition(1, 2)
local menubar = main:addMenubar():setScrollable()
:setSize("parent.w - 7")
:setPosition(8, 1)

for nameCount = 1, #config.programs do
	startMenu:addButton()
	:setText(config.programs[nameCount].name)
	:setPosition(2, 4*nameCount-2)
	:onClick(function(self, event, button, x, y)
		if(event=="mouse_click")and(button==1)then
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
		end
	end)
end


startMenu:hide()
startMenu:onLoseFocus(
	function(self) 
		self:hide()
	end
)

main:addButton()
:setText("Start")
:setPosition(1, 1)
:setSize("7", "1")
:onClickUp(function(self, event, button, x, y)
	if(event=="mouse_up")and(button==1)then
		startMenu:setOffset(0, 0):show():setFocus()
	end
end)


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