local basalt = require("basalt")

local main = basalt.createFrame():setTheme({FrameBG = colors.lightGray, FrameFG = colors.black})


local sidebar = main:addScrollableFrame()
:setBackground(colors.white)
:setPosition("3 - (self.w)", 1)
:setSize(15, "parent.h")
:setZIndex(25)

:onGetFocus(function(self)
  self:setPosition(1)
end)
:onLoseFocus(function(self)
  self:setPosition("3 - (self.w)")
end)


local sub = {
  {
    frame = main:addFrame():setPosition(1, 1):setSize("parent.w", "parent.h"),
    name = "Home"
  },
  {
    frame = main:addFrame():setPosition(1, 1):setSize("parent.w", "parent.h"):hide(),
    name = "Page 2"
  },
  {
    frame = main:addFrame():setPosition(1, 1):setSize("parent.w", "parent.h"):hide(),
    name = "Page 3"
  }
}

local y = 2
for k,v in pairs(sub)do
  sidebar:addButton():setText(v.name)
  :setBackground(colors.blue)
  :setForeground(colors.white)
  :setSize("parent.w - 2", 3)
  :setPosition(2, y)
  :onClick(function()
    for a, b in pairs(sub)do
      b.frame:hide()
      v.frame:show()
    end
  end)
  y = y + 4
end

sub[1].frame:addButton():setPosition(4, 2)

sub[2].frame:addLabel():setText("Hello World!"):setPosition(4, 2)

sub[3].frame:addLabel():setText("Now we're on example 3!"):setPosition(4, 2)
sub[3].frame:addButton():setText("No functionality"):setPosition(4, 4):setSize(18, 3)





basalt.autoUpdate()
