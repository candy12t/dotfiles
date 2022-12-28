local KeyDown = 10
local ESC = 53

local function pressEscSwitchEnglishEvent(event)
  local keyCode = event:getKeyCode()
  if event:getType() == KeyDown then
    if keyCode == ESC then
      hs.keycodes.setMethod('Alphanumeric (Google)')
    end
  end
end

pressEscSwitchEnglishEventer = hs.eventtap.new(
  {hs.eventtap.event.types.keyDown},
  pressEscSwitchEnglishEvent
)
pressEscSwitchEnglishEventer:start()
