local app = require("lib/app")
local ime = require("lib/ime")

local switchIMEWithECSEvent = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, ime.switchEnglishWithEcs)
switchIMEWithECSEvent:start()

hs.hotkey.bind({ "shift" }, "space", app.hideOrActiveApp("iTerm2"))
