export ZSH="$HOME/.oh-my-zsh"
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(rbenv init - --no-rehash zsh)"
eval "$(starship init zsh)"

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export NVM_DIR="$HOME/.nvm"
export REACT_EDITOR=cursor

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/eh-token.zsh

# zoxide (better `cd`)
# ------------------------------------------------------------------------------
if type zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
else
  echo ERROR: Could not load zoxide shell integration.
fi

# eza (better `ls`)
# ------------------------------------------------------------------------------

# Next level of an ls 
# options :  --no-filesize --no-time --no-permissions 
if type eza &>/dev/null; then
  alias l="eza --icons=always"
#  alias ls="eza --icons=always"
  alias ls="eza --no-filesize --long --color=always --icons=always --no-user --no-time --no-permissions"
  # alias ll="eza -lag -lg --icons=always"
  alias la="eza -lag --icons=always"
  alias lt="eza -lTg --no-filesize --long --color=always --icons=always --no-user --no-time --no-permissions"
  alias lt2="eza -lTg --level=2 --no-filesize --long --color=always --icons=always --no-user --no-time --no-permissions"
  alias lt3="eza -lTg --level=3 --icons=always"
  alias lta="eza -lTag --icons=always"
  alias lta2="eza -lTag --level=2 --icons=always"
  alias lta3="eza -lTag --level=3 --icons=always"
else
  echo ERROR: eza could not be found. Skip setting up eza aliases.
fi


alias vim="nvim"
alias v="nvim"
