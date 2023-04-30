local basalt = require("basalt")
local theme = require("theme")
local programs = require("programs")

basalt.setTheme(theme)
local main = basalt.createFrame()

menubar = main:addMenubar():setScrollable()
:setSize("parent.w")
:addItem("Shell", theme.MenubarBG, theme.MenubarText, {
	function(env)
		-- env.shell.s
		-- shell.run("/rom/programs/shell.lua")
		-- env.shell = nil
		-- env._G.setmetatable = setmetatable
		-- env._G.getmetatable = getmetatable
		env.os.run(env._G, "/rom/programs/shell.lua")
		-- print(getmetatable, setmetatable)
		
	end,
	"Shell"
})

menubar:onChange(function()
	local menuIndex = menubar:getItemIndex()
	local tbl = menubar:getItem(menuIndex).args[1]
	programs.openProgram(main, table.unpack(tbl))
	menubar:selectItem(0)
end)
menubar:selectItem(0)

basalt.autoUpdate()