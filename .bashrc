# >>>> Vagrant command completion (start)
if [ -f "/opt/vagrant/embedded/gems/2.2.14/gems/vagrant-2.2.14/contrib/bash/completion.sh" ]; then
    . /opt/vagrant/embedded/gems/2.2.14/gems/vagrant-2.2.14/contrib/bash/completion.sh
fi
# <<<<  Vagrant command completion (end)

[ -n "$PS1" ] && source ~/.bash_profile;
. "$HOME/.cargo/env"

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'micromamba shell init' !!
export MAMBA_EXE='/home/gallor/.local/bin/micromamba';
export MAMBA_ROOT_PREFIX='/home/gallor/micromamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from micromamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

[ -f ~/.fzf.bash ] && source ~/.fzf.bash


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/gallor/mambaforge/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/gallor/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/home/gallor/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/home/gallor/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/gallor/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/home/gallor/mambaforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

