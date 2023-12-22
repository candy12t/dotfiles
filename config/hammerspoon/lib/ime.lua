local KeyDown = 10
local ESC = 53

local function switchEnglishWithEcs(event)
  local keyCode = event:getKeyCode()
  if event:getType() == KeyDown and keyCode == ESC then
    hs.keycodes.setMethod("Alphanumeric (Google)")
  end
end

return {
  switchEnglishWithEcs = switchEnglishWithEcs,
}
