# Tokyo Night theme
# [START]----------- THEME CONFIGURATION ------------------
# Highlight color: #82aaff
# Normal color: #828bb8
# Background color: #2f334d
#
set -g message-style "fg=colour231,bg=colour240"

set -g @dark_color "#2f334d"
set -g @light_color "#82aaff"

set -g status-justify "left"
set -g status-left-style "none"
set -g status-right-style "none"
set -g status-style "none,bg=colour236"
set -g status-right-length "100"
set -g status-left-length "100"

set -g status-justify "centre"

# [COLORIZE]
set -g status-bg "#2f334d"

# ** Pane Status
# [COLORIZE]
# set -g pane-border-style "fg=#828bb8"
# set -g pane-active-border-style "fg=#82aaff,bold"

setw -g pane-border-status "bottom"
setw -g pane-border-format " ###P "
setw -g pane-border-lines "simple"
# ---- Bars -------
# [COLORIZE]
set -g status-left "#[fg=#82aaff,bg=#2f334d]#[fg=#2f334d,bg=#82aaff]  #[fg=white,bg=#4c5569] #S #[fg=#4c5569,bg=#2f334d]"
set -g status-right "#[fg=#fca7ea,bg=#2f334d]#[fg=#2f334d,bg=#fca7ea]  #[fg=white,bg=#4c5569] %Y-%m-%d #[fg=#4c5569,bg=#2f334d] #[fg=#ff966c,bg=#2f334d]#[fg=#2f334d,bg=#ff966c]祥 #[fg=white,bg=#4c5569] %H:%M #[fg=#4c5569,bg=#2f334d]"
# ---- Windows ----
setw -g window-status-activity-style "none"
setw -g window-status-separator ""
setw -g window-status-style "none,fg=#15d69e,bg=colour236"

# [COLORIZE]
set -g window-status-format "#[fg=#b4f9f8,bg=#2f334d]#[fg=#2f334d,bg=#b4f9f8] #I #[fg=white,bg=#4c5569] #W #[fg=#4c5569,bg=#2f334d] "
set -g window-status-current-format "#[fg=#4fd6be,bg=#2f334d]#[fg=#2f334d,bg=#4fd6be] #I #[fg=white,bg=#4c5569] #W #[fg=#4c5569,bg=#2f334d] "
# [END]----------- THEME CONFIGURATION ------------------ 
# local ret = {
#   none = "NONE",
#   bg_dark = "#1e2030", --
#   bg = "#222436", --
#   bg_highlight = "#2f334d", --
#   terminal_black = "#444a73", --
#   fg = "#c8d3f5", --
#   fg_dark = "#828bb8", --
#   fg_gutter = "#3b4261",
#   dark3 = "#545c7e",
#   comment = "#7a88cf", --
#   dark5 = "#737aa2",
#   blue0 = "#3e68d7", --
#   blue = "#82aaff", --
#   cyan = "#86e1fc", --
#   blue1 = "#65bcff", --
#   blue2 = "#0db9d7",
#   blue5 = "#89ddff",
#   blue6 = "#b4f9f8", --
#   blue7 = "#394b70",
#   purple = "#fca7ea", --
#   magenta2 = "#ff007c",
#   magenta = "#c099ff", --
#   orange = "#ff966c", --
#   yellow = "#ffc777", --
#   green = "#c3e88d", --
#   green1 = "#4fd6be", --
#   green2 = "#41a6b5",
#   teal = "#4fd6be", --
#   red = "#ff757f", --
#   red1 = "#c53b53", --
# }
