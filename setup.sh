#!/usr/bin/bash

SCRIPT=$(realpath -s "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

function syncDotfiles() {
    FILES="$(ls -a)"
    echo $FILES
    for f in $FILES; do
    if [ -d $f ]; then
      echo "Directory ${f}, skipping"
    else
      if [ $f != "setup.sh" ]; then
        ln -s ${SCRIPTPATH}/${f} ${HOME}/$f
      fi
    fi
    done
}

function syncNeovimAndRG() {
    if [[ ! -d ~/.config ]]; then
        mkdir -p ~/.config
    fi
    ln -s ${SCRIPTPATH}/nvim ${HOME}/.config/nvm
    ln -s ${SCRIPTPATH}/ripgrep ${HOME}/.confg/ripgrp
}

function setupFzfObc() {
  if [[ ! -d ~/.local/opt/fzf-obc ]]; then
    mkdir -p ~/.local/opt/fzf-obc
  fi
  INSTALL_PATH=~/.local/opt/fzf-obc
  git clone https://github.com/rockandska/fzf-obc ${INSTALL_PATH}

}

function installNode() {
	curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
	source ~/.bashrc
	nvim install --lts
	npm install --global yarn
}

function installNvim() {
  sudo snap install nvim --classic
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  nvim --headless +PlugInstall +q
}

function installTmuxPlugins() {
	if [[ ! -d ~/.tmux/plugins/tpm ]]; then
		mkdir -p ~/.tmux/plugins/tpm
	fi
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	git clone git@github.com:imomaliev/tmux-bash-completion.git ../tmux-bash-completion
}

function runAll() {
	syncDotfiles;
	syncNeovimAndRG;
	setupFzfObc
	installNvim
	installNode
	installTmuxPlugins
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	runAll
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
			runAll
    fi;
fi;


unset doIt;
unset syncNeovim;
unset setupFzfObc
unset installNvim
unset installNode
