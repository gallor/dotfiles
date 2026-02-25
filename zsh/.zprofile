if [[ -d /opt/homebrew ]]; then
  eval $(/opt/homebrew/bin/brew shellenv)
elif [[ -e /usr/local/bin/brew ]]; then
  eval $(/usr/local/bin/brew shellenv)
fi

export EDITOR=nvim
export PAGER=less
export XDG_CONFIG_HOME=$HOME/.config
export ZDOTDIR=$HOME/.zsh
export FZF_PATH=$HOME/.fzf

#remove duplicate entries from PATH
# zsh uses $path array along with $PATH
typeset -U PATH path


PATH=$HOME/.local/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
