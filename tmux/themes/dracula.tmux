# " Palette: {{{
#
# let g:dracula#palette           = {}
# let g:dracula#palette.fg        = ['#F8F8F2', 253]
#
# let g:dracula#palette.bglighter = ['#424450', 238]
# let g:dracula#palette.bglight   = ['#343746', 237]
# let g:dracula#palette.bg        = ['#282A36', 236]
# let g:dracula#palette.bgdark    = ['#21222C', 235]
# let g:dracula#palette.bgdarker  = ['#191A21', 234]
#
# let g:dracula#palette.comment   = ['#6272A4',  61]
# let g:dracula#palette.selection = ['#44475A', 239]
# let g:dracula#palette.subtle    = ['#424450', 238]
#
# let g:dracula#palette.cyan      = ['#8BE9FD', 117]
# let g:dracula#palette.green     = ['#50FA7B',  84]
# let g:dracula#palette.orange    = ['#FFB86C', 215]
# let g:dracula#palette.pink      = ['#FF79C6', 212]
# let g:dracula#palette.purple    = ['#BD93F9', 141]
# let g:dracula#palette.red       = ['#FF5555', 203]
# let g:dracula#palette.yellow    = ['#F1FA8C', 228]
#
# "
# " ANSI
# "
# let g:dracula#palette.color_0  = '#21222C'
# let g:dracula#palette.color_1  = '#FF5555'
# let g:dracula#palette.color_2  = '#50FA7B'
# let g:dracula#palette.color_3  = '#F1FA8C'
# let g:dracula#palette.color_4  = '#BD93F9'
# let g:dracula#palette.color_5  = '#FF79C6'
# let g:dracula#palette.color_6  = '#8BE9FD'
# let g:dracula#palette.color_7  = '#F8F8F2'
# let g:dracula#palette.color_8  = '#6272A4'
# let g:dracula#palette.color_9  = '#FF6E6E'
# let g:dracula#palette.color_10 = '#69FF94'
# let g:dracula#palette.color_11 = '#FFFFA5'
# let g:dracula#palette.color_12 = '#D6ACFF'
# let g:dracula#palette.color_13 = '#FF92DF'
# let g:dracula#palette.color_14 = '#A4FFFF'
# let g:dracula#palette.color_15 = '#FFFFFF'
#
# " }}}
#
# " vim: fdm=marker ts=2 sts=2 sw=2 fdl=0:

# Color palette definitions
fg="#F8F8F2"           # Foreground color (text)
bglighter="#424450"    # Background lighter shade
bglight="#343746"      # Background light shade
bg="#282A36"           # Background main color
bgdark="#21222C"       # Background dark shade
bgdarker="#191A21"     # Background darker shade 
cyan="#8BE9FD"         # Cyan accent color
green="#50FA7B"        # Green accent color
orange="#FFB86C"       # Orange accent color
pink="#FF79C6"         # Pink accent color
purple="#BD93F9"       # Purple accent color
red="#FF5555"          # Red accent color
yellow="#F1FA8C"       # Yellow accent color
git_status="#(~/dotfiles/tmux/scripts/git-status.sh #{pane_current_path})" # Git status script


# Status bar positioning
set-option -g status-position top

# Left side of status bar: session name and git status
set -g status-left "#[fg=${green},bg=default]#[fg=${bgdark},bg=${green}]  #[fg=${fg},bg=${bgdark}] #S #[fg=${bgdark},bg=default] ${git_status}"

# Right side of status bar: CPU usage, memory usage, and date
set -g status-right "#[fg=${green},bg=default]#[fg=${bgdark},bg=${green}]  #[fg=${fg},bg=${bgdark}] #{cpu -i 3} #[fg=${bgdark},bg=${orange}]   #[fg=${fg},bg=${bgdark}] #{mem} #[fg=${bgdark},bg=${pink}]   #[fg=${fg},bg=${bgdark}] %Y-%m-%d #[fg=${bgdark},bg=default]"

# Center the window list in the status bar
set -g status-justify centre

set -g status-style "bg=default"

# Format for inactive windows in the status bar
set -g window-status-format "#[fg=${fg},bg=default]#[fg=${bgdark},bg=${fg}] 󰄷 #I #[fg=${fg},bg=${bglighter}] #W:#{b:pane_current_path} #[fg=${bglighter},bg=default] "

# Format for the active window in the status bar
set -g window-status-current-format "#[fg=${purple},bg=default]#[fg=${bgdark},bg=${purple}] 󰄶 #I #[fg=${fg},bg=${bglighter}] #W:#{b:pane_current_path} #[fg=${bglighter},bg=default] "

# Active pane border style
set -g pane-active-border-style "fg=${green},bg=default"
# set -g windkw-status-last-style "fg=${default_fg},bg=default"
# set -g message-command-style "bg=default,fg=${default_fg}"
# set -g message-style "bg=default,fg=${default_fg}"
# set -g mode-style "bg=${session_selection_bg},fg=${session_selection_fg}"
# set -g pane-border-style "fg=brightblack,bg=default"
