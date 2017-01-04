# Generic "Host Independent" Bash Settings

source ~/dotfiles/bash_colors.sh

# Interesting little set of functions for git/svn info.
function parse_git_branch() {
	local DIRTY STATUS
	STATUS=$(git status --porcelain 2>/dev/null)
	[ $? -eq 128 ] && return
	[ -z "$(echo "$STATUS" | grep -e '^.M')" 	] || DIRTY="*"
	[ -z "$(echo "$STATUS" | grep -e '^[MDA]')" 	] || DIRTY="${DIRTY}+"
	[ -z "$(git stash list)" ]
	echo "[$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* //')$DIRTY]"
}

function parse_svn_revision() {
	local DIRTY REV=$(svn info 2>/dev/null | grep Revision | sed -e 's/Revision: //')
	[ "$REV" ] || return
	[ "$(svn st | grep -e '^ \?[M?] ')" ] && DIRTY='*'
	echo "[r$REV$DIRTY]"
}

# Pretty sure this is broken (still)
#function parse_hg_branch() {
#	local STATUS DIRTY=""
#	STATUS=$(hg status 2>/dev/null)
#	[[ `hg branch 2>/dev/null` ]] || return
#	[ -z "$(echo "$STATUS" | grep -e '^[^?]')" ] || DIRTY="${DIRTY}+"
#	echo "[$(hg branch 2>/dev/null | awk '{print $1}')$DIRTY]"
#}

function parse_vcs {
	local STATUS
	STATUS="$(parse_git_branch)$(parse_svn_revision)$(parse_hg_branch)"
	if [ "$STATUS" ]; then
		echo $STATUS
	else
		echo "[-]"
	fi
}

# Check for an interactive session (What?)
[ -z "$PS1" ] && return

# Bash specifics
if [[ $SHELL == "/bin/bash" ]]; then
	# Make bash check the window size after each command
	shopt -s checkwinsize

	# Bash Prompt
	PS1_ES=0
	PROMPT_COMMAND='PS1_ES=$?'
	PS1_TIME="\[$Cyan\][\@]\[$Color_Off\]"
	PS1_USER="\[$Red\]\u\[$Color_Off\]"
	PS1_HOST="\[$Blue\]\h\[$Color_Off\]"
	PS1_CWD="\[$Green\]\w\[$Color_Off\]"
	PS1_VCS="\[$Purple\]\$(parse_vcs)"
	PS1_END_COLOR='$(if [[ $PS1_ES -eq 0 ]]; then echo -ne "\[$Green\]"; else echo -ne "\[$Red\]"; fi)'
	PS1_END="$PS1_END_COLOR\$\[$Color_Off\]"
	PS1="$PS1_TIME $PS1_USER@$PS1_HOST:$PS1_CWD $PS1_VCS$PS1_END "
fi

# Useful Aliases
alias ls='ls --color=auto'
alias emacs='emacs -nw'
alias info='info --vi-keys'
alias pdb='python -m pdb'
alias pdb3='python3 -m pdb'
alias rm='rm -I'

export EDITOR="vim"

# If neovim is available, alias vim with that
if hash nvim ; then
	alias vim="nvim"
	export EDITOR="nvim"
fi

export VISUAL=$EDITOR # Stupid legacy variable for the same shit.
export PAGER="less"

# Add ~/bin to PATH if it exists
if [ -d ~/bin ] ; then
	export PATH=$PATH":"$HOME"/bin"
fi
