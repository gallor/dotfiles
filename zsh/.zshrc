# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

for file in ~/.{aliases,exports,zsh/.antidote/antidote.zsh,functions,extra}; do
		[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Autocomplete
autoload -Uz compinit
if [[ -z $HOME/.cache/zsh/zcompdump-$ZSH_VERSION ]]; then
    compinit -d "$HOME/.cache/zsh/zcompdump-$ZSH_VERSION"
else
    compinit -C;
fi;

antidote load


autoload -Uz promptinit
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # OS X `ls`
    colorflag="-G"
fi

# Always use color output for `ls`
alias ls="command ls ${colorflag}"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Forces TMUX into 256 color mode
alias ll="ls -la"

# Auto complete while typing
zstyle '*:compinit' arguments -D -i -u -C -w
# Case insensitive directory completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# Git completion
zstyle ':completion:*:*:git:*' script ~/.git-completion.bash, fzf-search-display true
zstyle ':completion:*:*:git:*' fzf-search-display true
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# Cache completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
# Fzf-tab enabled for everything
zstyle ':completion:*' fzf-search-display true
zstyle ':completion:*' group-name ''

# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

# Load Git Completion by appending function lookup
fpath=($HOME/.zsh $fpath)


# Add .local/bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Don't close shell until 3 consecutive Ctrl D
IGNOREEOF=3

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/gallor/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/gallor/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/gallor/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/gallor/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

# Fzf tab completion
# [[ ! -f ${ZDOTDIR:-$HOME}/fzf-tab-completion/zsh/fzf-zsh-completion.sh ]] || source ${ZDOTDIR:-$HOME}/fzf-tab-completion/zsh/fzf-zsh-completion.sh
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ${ZDOTDIR:-$HOME}/.p10k.zsh ]] || source ${ZDOTDIR:-$HOME}/.p10k.zsh

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'micromamba shell init' !!
export MAMBA_EXE='/home/grant/.local/bin/micromamba';
export MAMBA_ROOT_PREFIX='/home/grant/micromamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from micromamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<
