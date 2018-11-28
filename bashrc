#!/usr/bin/env bash

# BASE CONFIGURATION ##########################################################

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Check window size after each command and update $LINES and $COLUMNS as needed
[ "$DISPLAY" ] && shopt -s checkwinsize

# Recursive **/* and `cd` when only entering a path (does not work on OS X)
if [ "$(uname -s)" != "Darwin" ]; then
	shopt -s globstar
	shopt -s autocd
fi

# Fix perl complaining about LC_ALL
export LC_ALL=en_US.UTF-8

# BASH PROMPT #################################################################
# git portion pulled from @jcgoble3's gitprompt.sh
# https://github.com/jcgoble3/gitstuff/blob/master/gitprompt.sh

git_branch() {
	git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

git_status() {
	# + changes are staged and ready to commit
	# * unstaged changes are present
	# ? untracked files are present
	# - changes have been stashed
	# ^ local commits need to be pushed to the remote
	local status=''
	status="$(git status --porcelain 2>/dev/null)"
	local output=''
	grep -q '^[MADRC]' <<<"$status" && output="$output+"
	grep -q '^.[MD]' <<<"$status" && output="$output*"
	grep -q '^??' <<<"$status" && output="$output?"
	[[ -n $(git stash list) ]] && output="${output}-"
	[[ -n $(git log --branches --not --remotes) ]] && output="${output}^"
	printf '%s' "$output"
}

git_color() {
	# - White if everything is clean
	# - Green if all changes are staged
	# - Red if there are uncommitted changes with nothing staged
	# - Yellow if there are both staged and unstaged changes
	# - Blue if there are unpushed commits
	local staged=''
	staged=$([[ $1 =~ \+ ]] && printf '%s' "yes")
	local dirty=''
	dirty=$([[ $1 =~ [*\?] ]] && printf '%s' "yes")
	local needs_push=''
	needs_push=$([[ $1 = *"^" ]] && printf '%s' "yes")
	if [[ -n $staged ]] && [[ -n $dirty ]]; then
		printf '\033[1;33m'  # bold yellow
	elif [[ -n $staged ]]; then
		printf '\033[1;32m'  # bold green
	elif [[ -n $dirty ]]; then
		printf '\033[1;31m'  # bold red
	elif [[ -n $needs_push ]]; then
		printf '\033[1;36m'  # bold teal
	else
		printf ''
	fi
}

git_prompt() {
	# First, get the branch name...
	local branch=''
	branch=$(git_branch)
	# Empty output? Then we're not in a Git repository, so bypass the rest
	# of the function, producing no output
	if [[ -n "$branch" ]]; then
		local state=''
		state=$(git_status)
		local color=''
		color=$(git_color "$state")
		# Now output the actual code to insert the branch and status
		printf ' \x01%s\x02%s\x01\033[00m\x02' "$color" "($branch$state)" # last bit resets color
	fi
}

bash_prompt_command() {
	# Git
	GTBR=$(git_prompt)
	# How many characters of the $PWD should be kept
	local pwdmaxlen=$((COLUMNS - 34 - ${#HOSTNAME} - ${#USER} - ${#GTBR}))
	# Indicate that there has been dir truncation
	local trunc_symbol="..."
	local dir=${PWD##*/}
	pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
	CPWD=${PWD/#$HOME/\~}
	local pwdoffset=$(( ${#CPWD} - pwdmaxlen ))
	if [ ${pwdoffset} -gt "0" ]
	then
		CPWD=${CPWD:$pwdoffset:$pwdmaxlen}
		CPWD=${trunc_symbol}/${CPWD#*/}
	fi
}

bash_prompt() {
	local U="\\[\\e[0m\\]"     # default foreground color

	# regular colors
	local G="\\[\\e[0;32m\\]"  # green

	# emphasized (bolded) colors
	local ER="\\[\\e[1;31m\\]" # bold red
	local EY="\\[\\e[1;33m\\]" # bold yellow
	local EB="\\[\\e[1;34m\\]" # bold blue
	local EC="\\[\\e[1;36m\\]" # bold cyan

	local UC=$EY                # user's color
	[ $UID -eq "0" ] && UC=$ER  # root's color

   	PS1="\\n    \\t \\d ${UC}\\u${U}@${EC}\\h${U}:${EB}\${CPWD}${U}\${GTBR}\\n[${G}\\s${U}] ${UC}\\$ ${U}"
}

PROMPT_COMMAND=bash_prompt_command
bash_prompt
unset bash_prompt

# COLORIZE EVERYTHING #########################################################

# the tty/framebuffer console
if [ "$TERM" = "linux" ]; then
	printf "\\e]P0303030" # black
	printf "\\e]P1D73753" # red
	printf "\\e]P2907234" # green
	printf "\\e]P3C15522" # brown
	printf "\\e]P47A64E9" # blue
	printf "\\e]P5B25694" # magenta
	printf "\\e]P6538160" # cyan
	printf "\\e]P7C6C6C6" # light gray
	printf "\\e]P8474747" # gray
	printf "\\e]P9FF7384" # bright red
	printf "\\e]PAC8A565" # bright green
	printf "\\e]PBFE8A53" # yellow
	printf "\\e]PCB497FF" # bright blue
	printf "\\e]PDEC8BCA" # bright magenta
	printf "\\e]PE86B693" # bright cyan
	printf "\\e]PFFFFFFF" # white
	clear # fix artifacts
fi

# ls
if [ "$(uname -s)" == "Darwin" ]; then
	alias ls='ls -G'
else
	alias ls='ls --color=auto'
fi
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
[ -x "$(command -v dircolors)" ] && eval "$(dircolors -b)"

# grep
export GREP_COLOR="1;33"
if grep --color "a" <<< "a" &>/dev/null; then
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# diff
[ -x "$(command -v colordiff)" ] && alias diff='colordiff'

# less
if [ -e /usr/bin/source-higthlight-esc.sh ]; then
	export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
	export LESS='-R'
fi

# man - colored, and with help
man() {
	env \
		LESS_TERMCAP_mb="$(printf '\e[1;32m')" \
		LESS_TERMCAP_md="$(printf '\e[1;33m')" \
		LESS_TERMCAP_me="$(printf '\e[0m')" \
		LESS_TERMCAP_se="$(printf '\e[0m')" \
		LESS_TERMCAP_so="$(printf '\e[1;45;30m')" \
		LESS_TERMCAP_ue="$(printf '\e[0m')" \
		LESS_TERMCAP_us="$(printf '\e[0;34m')" \
		man "$@" || (help "$@" 2> /dev/null && help "$@" | less)
	}

# COMPLETION ##################################################################

# Bash completion where available
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Find-The-Command
[ -r /usr/share/doc/find-the-command/ftc.bash ] && source /usr/share/doc/find-the-command/ftc.bash

# Sudo Completion
[ -x "$(command -v sudo)" ] && complete -cf sudo

# DEFEAT LOGGING ##############################################################

# Defeat Snoopy logging (http://blog.rchapman.org/posts/Bypassing_snoopy_logging/)
[ ! -f "$HOME"/dotfiles/bin/bypass.so ] && \
	[ -x "$(command -v gcc)" ] && \
	[ -f "$HOME"/dotfiles/bin/bypass.c ] && \
	gcc -nostartfiles -shared -O3 -fPIC "$HOME"/dotfiles/bin/bypass.c -o "$HOME"/dotfiles/bin/bypass.so -ldl -Wall -Wextra
	[ -x "$HOME"/dotfiles/bin/bypass.so ] && export LD_PRELOAD=$HOME/dotfiles/bin/bypass.so

# GPG KEY #####################################################################
GPG_TTY="$(tty)"
export GPG_TTY

# HISTORY #####################################################################

# Avoid duplicates, and share history across terminals
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"

# Date and time format
#export HISTTIMEFORMAT='%Y.%m.%d %T  '

# Max history size
export HISTFILESIZE=8192

# PATH ########################################################################
export PATH="$PATH":"$HOME"/dotfiles/bin
[ -d "$HOME"/dotfiles/overrides ] && export PATH="$HOME"/dotfiles/overrides:$PATH

# NVM
# shellcheck disable=1091
[ -f /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh

# SPELLING ####################################################################
shopt -s cdspell
[ "$(uname -s)" != "Darwin" ] && shopt -s dirspell

# TABS ########################################################################
[ -x "$(command -v tabs)" ] && tabs 4

# USEFUL ALIASES ##############################################################

# cd
alias ..='cd ..'
alias cd..='cd ..'
alias .-='cd -'

# df
[ ! -x "$(command -v dh)" ] && alias dh='df -Tha --total'

# editor
if [ -x "$(command -v vim)" ]; then
	alias vi='vim'
	export EDITOR='vim'
fi

# git
[ ! -x "$(command -v amend)" ] && alias amend='git commit --amend'
[ ! -x "$(command -v commit)" ] && alias commit='git commit -m'
[ ! -x "$(command -v pull)" ] && alias pull='git pull origin master'
[ ! -x "$(command -v purr)" ] && alias purr='git pull --recurse-submodules -r origin master'
[ ! -x "$(command -v push)" ] && alias push='git push origin master'
[ ! -x "$(command -v puff)" ] && alias puff='git push -f origin master'
[ ! -x "$(command -v rebase)" ] && alias rebase='git rebase -i'
[ ! -x "$(command -v reflog)" ] && alias reflog='git reflog'

# https://help.github.com/articles/removing-sensitive-data-from-a-repository/
if [ ! -x "$(command -v repoclean)" ]; then
	repoclean() {
		git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch '"$*" --prune-empty --tag-name-filter cat -- --all
		git for-each-ref --format='delete %(refname)' refs/original | git update-ref --stdin
		git reflog expire --expire=now --all
		git gc --prune=now
	}
fi

# https://twitter.com/aran384/status/1046487063489437696
if [ ! -x "$(command -v tableflip)" ]; then
	tableflip() {
		while true; do
			read -r -p "Really throw it all away? [y/N]: " -n 1 yn
			printf '\n'
			case $yn in
				[Yy]* ) git fetch && git reset --hard && git clean -dfx; break;;
				[Nn]* ) break;;
				"" ) break;;
			esac
		done
	}
fi

# ls
[ ! -x "$(command -v ll)" ] && alias ll='ls -la'
[ ! -x "$(command -v sl)" ] && alias sl='ls'

# less is more
alias more='less'

# mkdir
alias mkdir='mkdir -pv'

if [ ! -x "$(command -v mkcd)" ]; then
	mkcd() {
		mkdir -pv "$@" && cd "$_" || exit
	}
fi

# makepkg
[ -x "$(command -v makepkg)" ] && alias mksrcinfo='makepkg --printsrcinfo > .SRCINFO'

# ping
[ ! -x "$(command -v pinc)" ] && alias pinc='ping -c'

# ps
[ ! -x "$(command -v pf)" ] && alias pf='ps auxf'
[ ! -x "$(command -v pg)" ] && alias pg='ps aux | grep -v grep | grep -i -e'

if [ ! -x "$(command -v tableflip)" ]; then
	kp() {
		local pid
		pid=$(ps -ef | sed 1d | eval "fzf -m --header='[kill:process]'" | awk '{print $2}')

		if [ "x$pid" != "x" ]; then
			echo "$pid" | xargs kill -"${1:-9}"
			kp "$@"
		fi
	}
fi

# tar
[ ! -x "$(command -v untar)" ] && alias untar='tar -zxvf'

# wget
[ -x "$(command -v wget)" ] && alias wget='wget -c'

# sudo (only run this part if we're not root, and sudo is installed)
if [ "$(id -u)" != 0 ] && [ -x "$(command -v sudo)" ]; then

	# Editor
	[ -x "$(command -v vim)" ] && alias svi="sudo vim"

	# Networking

	### firewalls
	[ -x "$(command -v firewall-cmd)" ] && alias sfw='sudo firewall-cmd'
	[ -x "$(command -v iptables)" ] && alias sipt='sudo iptables'
	[ -x "$(command -v nft)" ] && alias snft='sudo nft'

	### SS / Netstat
	if [ -x "$(command -v ss)" ]; then
		alias sss='sudo ss'
	elif [ -x "$(command -v netstat)" ]; then
		alias sss='sudo netstat'
	fi
	[ "$(type -t sss)" == "alias" ] && alias sll='sss -ltunp'

	# Package Managers

	### Apt (Apt-Metalink)
	if [ -x "$(command -v apt)" ]; then
		if [ -x "$(command -v apt-metalink)" ]; then
			alias apt='apt-metalink'
			alias sapt='sudo apt-metalink'
		else
			alias sapt='sudo apt'
		fi
		alias aptup='sapt update && sapt dist-upgrade && sapt autoremove'
	fi

	### DNF/Yum
	if [ -x "$(command -v dnf)" ]; then
		alias sdnf='sudo dnf'
	elif [ -x "$(command -v yum)" ]; then
		alias sdnf='sudo yum'
	fi
	alias dnfup='dnf -y update'

	### Pacman (Reflector/Powerpill/Aurman)
	if [ -x "$(command -v pacman)" ]; then

		# Reflector
		[ -x "$(command -v reflector)" ] && alias reflect='sudo printf "Updating Mirrorlist..." && sudo reflector -l 50 -a 12 -p https --sort rate --save /etc/pacman.d/mirrorlist'

		# Powerpill or Pacman
		if [ -x "$(command -v powerpill)" ]; then
			PACMAN="$(command -v powerpill)"
			alias pac='sudo powerpill'
		else
			PACMAN="$(command -v pacman)"
			alias pac='sudo pacman'
		fi
		export PACMAN
		alias pacup='yes | pac -Syyu --noconfirm'
		alias pacout='pac -Runcs $(pac -Qdtq)'

		# Aurman
		if [ -x "$(command -v aurman)" ]; then
			alias pac='aurman'
			alias pacup='yes | pac -Syyu --noedit --noconfirm --devel'
		fi

		# Combos
		if [ "$(type reflect 2>/dev/null)" ]; then
			alias rpac='reflect && pac'
			alias rpacup='reflect && pacup'
		fi
	fi

	# System
	[ -x "$(command -v su)" ] && alias su='sudo su'
	[ -x "$(command -v systemctl)" ] && alias sctl='sudo systemctl'
fi

# USER ALIASES ################################################################

# Import SSH aliases from protected file
# shellcheck source=/dev/null
[ -f "$HOME"/SafeDepositBox/"$USER"/ssh-aliases.sh ] && source "$HOME"/SafeDepositBox/"$USER"/ssh-aliases.sh
