local basalt = require("basalt") -- Loads Basalt into our project

local main = basalt.createFrame() -- Creates a base frame. On that frame, we are able to add objects

-- Here we would add additional objects
local aButton = main:addButton():setText("Click")

aButton:onClick(function(self,event,button,x,y)
  -- if(event=="mouse_click")and(button==1)then
    aButton:hide()
  -- end
end)

basalt.autoUpdate() -- Starts listening to incoming events and draw stuff on the screen. This should nearly always be the last line.
