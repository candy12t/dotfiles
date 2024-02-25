local wezterm = require("wezterm")
local config = {}

config.color_scheme = "Tokyo Night Moon"
config.window_background_opacity = 0.93
config.font = wezterm.font("HackGen Console NF", { weight = "Regular", stretch = "Normal", style = "Normal" })
config.font_size = 16.0

return config
