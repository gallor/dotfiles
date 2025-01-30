# >>>> Vagrant command completion (start)
if [ -f "/opt/vagrant/embedded/gems/2.2.14/gems/vagrant-2.2.14/contrib/bash/completion.sh" ]; then
    . /opt/vagrant/embedded/gems/2.2.14/gems/vagrant-2.2.14/contrib/bash/completion.sh
fi
# <<<<  Vagrant command completion (end)

[ -n "$PS1" ] && source ~/.bash_profile;
. "$HOME/.cargo/env"
