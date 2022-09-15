[ -n "$PS1" ] && source ~/.bash_profile;



# >>>> Vagrant command completion (start)
VAGRANT_COMPLETION=/opt/vagrant/embedded/gems/2.2.14/gems/vagrant-2.2.14/contrib/bash/completion.sh
if [ -f "$VAGRANT_COMPLETION" ]; then
    . VAGRANT_COMPLETION
fi
# <<<<  Vagrant command completion (end)

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/gallor/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/gallor/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/gallor/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/gallor/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

