if gtmos == nil then error("This program requries to be ran on GTMOS!") end

local basalt = require("basalt") --> Load the basalt framework into the variable called "basalt"

--> Now we want to create a base frame, we call the variable "main" - by default everything you create is visible. (you don't need to use :show())
local main = basalt.createFrame()

local button = main:addButton() --> Here we add our first button
button:setPosition(4, 4) -- of course we want to change the default position of our button
button:setSize(16, 3) -- and the default size.
button:setText("Click me!") --> This method displays what the text of our button should look like

local function buttonClick() --> Let us create a function we want to call when the button gets clicked 
    basalt.debug("I got clicked!")
end

-- Now we just need to register the function to the buttons onClick event handlers, this is how we can achieve that:
button:onClick(buttonClick)


basalt.autoUpdate() -- As soon as we call basalt.autoUpdate, the event and draw handlers will listen to any incomming events (and draw if necessary)
