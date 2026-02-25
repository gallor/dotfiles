skip_global_compinit=1
export ZDOTDIR="$HOME/.zsh"
if [[ ! -d $HOME/.cache/.antidote ]]; then
        mkdir -p $HOME/.cache/.antidote
fi
export ANTIDOTE_HOME="$HOME/.cache/.antidote"

if [[ -d $HOME/.cargo ]]; then
. "$HOME/.cargo/env"
fi
