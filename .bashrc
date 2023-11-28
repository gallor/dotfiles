# >>>> Vagrant command completion (start)
if [ -f "/opt/vagrant/embedded/gems/2.2.14/gems/vagrant-2.2.14/contrib/bash/completion.sh" ]; then
    . /opt/vagrant/embedded/gems/2.2.14/gems/vagrant-2.2.14/contrib/bash/completion.sh
fi
# <<<<  Vagrant command completion (end)

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/gallor/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/gallor/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/gallor/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/gallor/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/gallor/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/home/gallor/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

[ -n "$PS1" ] && source ~/.bash_profile;
