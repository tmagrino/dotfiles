# Generic "Host Independent" Bash Settings

# Interesting little set of functions for git/svn info.
function parse_git_branch() {
	local DIRTY STATUS
	STATUS=$(git status --porcelain 2>/dev/null)
	[ $? -eq 128 ] && return
	[ -z "$(echo "$STATUS" | grep -e '^.M')" 	] || DIRTY="*"
	[ -z "$(echo "$STATUS" | grep -e '^[MDA]')" 	] || DIRTY="${DIRTY}+"
	[ -z "$(git stash list)" ]
	echo ":[$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* //')$DIRTY]"
}

function parse_svn_revision() {
	local DIRTY REV=$(svn info 2>/dev/null | grep Revision | sed -e 's/Revision: //')
	[ "$REV" ] || return
	[ "$(svn st | grep -e '^ \?[M?] ')" ] && DIRTY='*'
	echo ":[r$REV$DIRTY]"
}

# Pretty sure this is broken (still)
function parse_hg_branch() {
	local STATUS DIRTY=""
	STATUS=$(hg status 2>/dev/null)
	[[ `hg branch 2>/dev/null` ]] || return
	#[ -z "$(echo "$STATUS" | grep -e '^\?')" ] || DIRTY="*"
	[ -z "$(echo "$STATUS" | grep -e '^[^?]')" ] || DIRTY="${DIRTY}+"
	echo ":[$(hg branch 2>/dev/null | awk '{print $1}')$DIRTY]"
}

function parse_vcs() {
	echo "$(parse_git_branch)$(parse_svn_revision)$(parse_hg_branch)"
}

# Check for an interactive session (What?)
[ -z "$PS1" ] && return

# Useful Aliases
alias ls='ls --color=auto'
alias emacs='emacs -nw'
alias info='info --vi-keys'
alias pdb='python -m pdb'
alias pdb3='python3 -m pdb'

# Bash Prompt
PS1="\[\e[0;36m\][\@] \[\e[0;31m\]\u@\h:\w\$(parse_vcs)\$\[\e[0m\] "

# Preferred Programs
export EDITOR="/usr/bin/vim"
export VISUAL=$EDITOR # Stupid legacy variable for the same shit.
export PAGER="/usr/bin/less"

# Add ~/bin to PATH if it exists
[ -e ~/bin ] && export PATH=$PATH":~/bin"
