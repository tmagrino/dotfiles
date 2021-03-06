# Makefile for setting up dot/config files
#
# TODO: Figure out how to only run commands for programs installed on the
# current machine.  Maybe move to auto-tools?
# TODO: Update commands?

default: install

mkfile_dir := $(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))

# Bash

# Lines to add to bashrc
BASH_COMMENT=\# Host Independent Settings
BASH_SOURCE =source ${mkfile_dir}/bash_settings.sh

install-bash: ${mkfile_dir}/bash_settings.sh
	grep "${BASH_SOURCE}" ~/.bashrc || \
		(echo "" >> ~/.bashrc && \
		 echo "${BASH_COMMENT}" >> ~/.bashrc && \
		 echo "${BASH_SOURCE}" >> ~/.bashrc)

# Zsh

install-zsh: install-bash ${mkfile_dir}/zshrc ~/.oh-my-zsh/themes/agnoster-bluewres.zsh-theme

~/.zshrc: ~/.oh-my-zsh ${mkfile_dir}/zshrc
	-rm ~/.zshrc
	-ln -sf ${mkfile_dir}/zshrc ~/.zshrc

~/.oh-my-zsh/themes/agnoster-bluewres.zsh-theme: ~/.oh-my-zsh ${mkfile_dir}/agnoster-bluewres.zsh-theme
	-ln -sf ${mkfile_dir}/agnoster-bluewres.zsh-theme ~/.oh-my-zsh/themes/agnoster-bluewres.zsh-theme

~/.oh-my-zsh:
	-sh -c "$$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Vim

install-vim: ~/.vimrc ~/.vim ~/.backup-vim

~/.vimrc: ${mkfile_dir}/vimrc
	-ln -sf ${mkfile_dir}/vimrc ~/.vimrc

~/.vim: ${mkfile_dir}/vim
	-ln -sf -T ${mkfile_dir}/vim ~/.vim

~/.backup-vim:
	-mkdir -p ~/.backup-vim

# NeoVim

install-nvim: install-vim ~/.config ~/.config/nvim

~/.config:
	-mkdir -p ~/.config

~/.config/nvim: ~/.config vim
	-ln -sf ${mkfile_dir}/vim ~/.config/nvim

# Screen

install-screen: ~/.screenrc

~/.screenrc: screenrc
	-ln -sf ${mkfile_dir}/screenrc ~/.screenrc

# Tmux
# Using oh-my-tmux

install-tmux: ~/.tmux

~/.tmux:
	-git clone https://github.com/gpakosz/.tmux.git ~/.tmux
	-ln -sf ~/.tmux/.tmux.conf ~/.tmux.conf
	-ln -sf ${mkfile_dir}/tmux.conf.local ~/.tmux.conf.local

# All

install: install-bash install-vim install-screen install-tmux install-nvim install-zsh

.PHONY: install clean install-bash install-vim install-screen install-tmux install-nvim install-zsh
