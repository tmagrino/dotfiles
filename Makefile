# Makefile for setting up dot/config files

default: install

# Lines to add to bashrc
BASH_COMMENT=\# Host Independent Settings
BASH_SOURCE =source ~/dotfiles/bash_settings.sh

install-bash: bash_settings.sh
	grep "${BASH_SOURCE}" ~/.bashrc || \
		(echo "" >> ~/.bashrc && \
		 echo "${BASH_COMMENT}" >> ~/.bashrc && \
		 echo "${BASH_SOURCE}" >> ~/.bashrc)

install-vim: vim vimrc
	-ln -s ~/dotfiles/vimrc ~/.vimrc
	-ln -s -T ~/dotfiles/vim ~/.vim
	-mkdir ~/.backup

install-nvim: vim vimrc
	-mkdir -p ~/.config
	-ln -s ~/dotfiles/vim ~/.config/nvim

install-screen: screenrc
	-ln -s ~/dotfiles/screenrc ~/.screenrc

install-tmux: tmux.conf
	-ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

install: install-bash install-vim install-screen install-tmux install-nvim

.PHONY: install clean install-bash install-vim install-screen install-tmux install-nvim
