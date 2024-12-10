local wezterm = require("wezterm")

local config = {}

config.color_scheme = "Dracula (Official)"

config.window_background_opacity = 0.7

config.font = wezterm.font_with_fallback({
  "Juisee NF",
  "DejaVuSansM Nerd Font Mono",
  "Cica",
})

return config
