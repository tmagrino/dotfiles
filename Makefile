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

install-screen: screenrc
	-ln -s ~/dotfiles/screenrc ~/.screenrc

install: install-bash install-vim install-screen

.PHONY: install clean install-bash install-vim install-screen
