eval $(/opt/homebrew/bin/brew shellenv)

export EDITOR=nvim
export PAGER=less
export XDG_CONFIG_HOME=$HOME/.config

#remove duplicate entries from PATH
# zsh uses $path array along with $PATH
typeset -U PATH path


PATH=$HOME/.local/bin:$PATH
