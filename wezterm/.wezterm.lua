local wezterm = require("wezterm")

local config = wezterm.config_builder()

local mux = wezterm.mux

wezterm.on("gui-startup", function()
  local _, _, window = mux.spawn_window({})
  window:gui_window():maximize()
end)

--window setting
config.window_background_opacity = 0.75
config.macos_window_background_blur = 85
config.color_scheme = "Darcula (Officail)"
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.macos_window_background_blur = 10
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.font = wezterm.font("JetBrains Mono")
config.font_size = 14
config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
}

--Keybindings
config.keys = {
  -- Default QuickSelect keybind (CTRL-SHIFT-Space) gets captured by something
  -- else on my system
  {
    key = 'A',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.QuickSelect,
  },
}



return config
