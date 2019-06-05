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
	local status
	status="$(git status --porcelain 2>/dev/null)"
	local output
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
	local staged
	staged=$([[ $1 =~ \+ ]] && printf '%s' "yes")
	local dirty
	dirty=$([[ $1 =~ [*\?] ]] && printf '%s' "yes")
	local needs_push
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
	local branch
	branch=$(git_branch)
	# Empty output? Then we're not in a Git repository, so bypass the rest
	# of the function, producing no output
	if [[ -n "$branch" ]]; then
		local state
		state=$(git_status)
		local color
		color=$(git_color "$state")
		# Now output the actual code to insert the branch and status
		printf ' (\x01%s\x02%s\x01\033[00m\x02)' "$color" "$branch$state" # last bit resets color
	fi
}

bash_prompt_command() {
	# Git
	GTBR=$(git_prompt)
	# How many characters of the $PWD should be kept
	local pwdmaxlen=$((COLUMNS - 34 - ${#HOSTNAME} - ${#USER} - ${#GTBR}))
	local dir=${PWD##*/}
	pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
	CPWD=${PWD/#$HOME/\~}
	local pwdoffset=$(( ${#CPWD} - pwdmaxlen ))
	if [ ${pwdoffset} -gt "0" ]; then
		CPWD=${CPWD:$pwdoffset:$pwdmaxlen}
		CPWD='.../'"${CPWD#*/}"
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
	[ $UID -eq '0' ] && UC=$ER  # root's color

	PS1="\\n    \\D{%a %Y.%m.%d %T}\\n    ${UC}\\u${U}@${EC}\\h${U}:${EB}\${CPWD}${U}\${GTBR}\\n[${G}\\s \\V${U}] ${UC}\\$ ${U}"
}

PROMPT_COMMAND=bash_prompt_command
bash_prompt
unset bash_prompt

# COLORIZE EVERYTHING #########################################################

# the tty/framebuffer console
if [ "$TERM" = 'linux' ]; then
	printf "\\e]P01B1B1B" # black
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
	printf "\\e]PFE2E2E2" # white
	clear # fix artifacts
fi

# ls
if [ "$(uname -s)" == 'Darwin' ]; then
	alias ls='ls -G'
else
	alias ls='ls --color=auto'
fi
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
[ -x "$(command -v dircolors)" ] && eval "$(dircolors -b)"

# grep
export GREP_COLOR='1;33'
if grep --color 'a' <<< 'a' &>/dev/null; then
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

# History search
if [[ $- == *i* ]]; then
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
    bind '"\e[5~": previous-history'
	bind '"\e[6~": next-history'
fi

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

# Colon seperated list of exact commands to ignore
export HISTIGNORE="clear:bg:fg:cd:cd -:exit:date:poweroff:reboot:* --help"

# Avoid duplicates, and share history across terminals
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"

# Date and time format
#export HISTTIMEFORMAT='%Y.%m.%d %T  '

# Max history size
export HISTFILESIZE=8192

# PATH ########################################################################

## Remove duplicate items
## https://unix.stackexchange.com/a/338737
remove_dups() {
    local D=${2:-:}
    local path=
    local dir=
    while IFS= read -r -d"$D" dir; do
        [[ $path$D =~ .*$D$dir$D.* ]] || path+="$D$dir"
    done <<< "$1$D"
    printf %s "${path#$D}"
}
PATH="$(remove_dups "$PATH")"

## Cleanly add an item to the end of $PATH
## https://unix.stackexchange.com/a/124447
path_append() {
	case ":${PATH:=$1}:" in
		*:$@:*) ;;
		*) PATH="$PATH:$1";;
	esac
}

## Cleanly add an item to the beginning of $PATH
path_override() {
	case ":${PATH:=$1}:" in
		*:$@:*) ;;
		*) PATH="$1:$PATH";;
	esac
}

[ -d "$HOME/dotfiles/overrides" ] && path_override "$HOME/dotfiles/overrides"
path_append "$HOME/dotfiles/bin"

# NVM
# shellcheck disable=1091
[ -f /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh

# SPELLING ####################################################################
shopt -s cdspell
[ "$(uname -s)" != 'Darwin' ] && shopt -s dirspell

# SSH-AGENT ###################################################################
if [ -x "$(command -v ssh-agent)" ]; then
	eval "$(ssh-agent -t 240)" >/dev/null
	trap '[ -n "$SSH_AGENT_PID" ] && eval $(ssh-agent -k); exit' EXIT
fi

# TABS ########################################################################
[ -x "$(command -v tabs)" ] && tabs 4

# USEFUL ALIASES ##############################################################

# aurvote
if [ -x "$(command -v aurvote)" ]; then
	aurvoteall() {
		pacman -Qm | cut -f1 -d' ' | xargs aurvote
	}
fi

# bats (Bash Automated Testing System)
[ -x "$(command -v bats)" ] && alias bats='time bats'

# cd
alias ..='cd ..'
alias cd..='cd ..'
alias .-='cd -'

# df
[ ! -x "$(command -v dh)" ] && alias dh='df -Tha --total'

# editor
[ -x "$(command -v vi)" ] && export EDITOR='vi'
if [ -x "$(command -v vim)" ]; then
	alias vi='vim'
	export EDITOR='vim'
fi

# git
if [ -x "$(command -v git)" ]; then
	# https://unix.stackexchange.com/a/97958
	git() {
		# For information on CL and CS, see the gitconfig file
		/usr/bin/git "$@" && if [ "$1" = 'clone' ] || [ "$1" = 'CL' ] || [ "$1" = 'CS' ] ; then
			local _repo="${*: -1}"
			_repo="${_repo%.git}"
			_repo="${_repo##*:}"
			cd "${_repo##*/}" || exit
		fi
	}

	if [ -x "$(command -v new-repo)" ]; then
		tkrepo() {
			cd "$(new-repo "$@")" || exit
		}
	fi
fi

# ls
[ ! -x "$(command -v ll)" ] && alias ll='ls -ahl'
[ ! -x "$(command -v sl)" ] && alias sl='ls'

# less is more
[ -x "$(command -v less)" ] && alias more='less'

# mkdir
alias mkdir='mkdir -pv'

if [ ! -x "$(command -v tkdir)" ]; then
	tkdir() {
		mkdir -pv "$@" && cd "$_" || exit
	}
fi

# makepkg
[ -x "$(command -v makepkg)" ] && alias mksrcinfo='makepkg --printsrcinfo > .SRCINFO'

# mosh
if [ -x "$(command -v mosh)" ] && [ ! -v "$(command -v mop)" ]; then
	alias mop='mosh -p 59999'
fi

# networking
[ ! -x "$(command -v ipme)" ] && alias ipme='curl ifconfig.me'
[ ! -x "$(command -v pinc)" ] && alias pinc='ping -c'

# pacman
if [ -x "$(command -v pacman)" ]; then
	pacowns() {
		pacman -Qo "$(command -v "$1")"
	}
fi

# ps
[ ! -x "$(command -v pf)" ] && alias pf='ps auxf'
[ ! -x "$(command -v pg)" ] && alias pg='ps aux | grep -v grep | grep -i -e'

if [ ! -x "$(command -v kp)" ] && [ -x "$(command -v fzf)" ]; then
	kp() {
		local pid
		pid=$(ps -ef | sed 1d | eval "fzf -m --header='[kill:process]'" | awk '{print $2}')

		if [ "x$pid" != "x" ]; then
			echo "$pid" | xargs kill -"${1:-9}"
			kp "$@"
		fi
	}
fi

# ssh
if [ -x "$(command -v ssh)" ] && [ ! -x "$(command -v tunnel)" ]; then
	# Create ssh tunnel on port $2 (default 19998) to server $1
	tunnel() {
		ssh -f -N -D "${2:-19998}" -4 "$1"
	}

	# Kill the ssh tunnel running on server or port $1 (default all tunnels)
	kill_tunnel() {
		local PID
		PID="$(pgrep -a ssh | grep "\-f \-N \-D .*$1.*" | cut -f1 -d' ' | xargs)"
		if ((${#PID} > 0)); then
			kill "$PID"
		else
			printf 'No ssh tunnels running.\n'
		fi
	}
fi

# tar
[ ! -x "$(command -v untar)" ] && alias untar='tar -zxvf'

# tmux
# https://www.nathankowald.com/blog/2014/03/tmux-attach-session-alias/
if [ -x "$(command -v tmux)" ]; then
	if [ ! -x "$(command -v tmax)" ]; then
		tmax() {
			if (($# > 0)); then
				tmux attach -t "$1" 2>/dev/null || tmux new -s "$@" 
			else
				tmux attach 2>/dev/null || tmux new
			fi
		}
		_tmax() {
			read -ra COMPREPLY <<< "$(compgen -W "$(tmux ls -F '#S' | xargs)" \
				-- "${COMP_WORDS[COMP_CWORD]}")"
		}
		complete -F _tmax tmax
	fi
	[ ! -x "$(command -v tmls)" ] && alias tmls='tmux ls'
	if [ ! -x "$(command -v tv)" ]; then
		tv() {
			tmux new "$EDITOR $*"
		}
	fi
fi

# wget, curl, aria2c
[ -x "$(command -v wget)" ] && alias wget='wget -c'
if [ ! -x "$(command -v ttfb)" ]; then
	ttfb() {
		curl -sSo /dev/null -w "Connect: %{time_connect} TTFB: %{time_starttransfer} Total time: %{time_total} \n" "$1"
	}
fi

# sudo (only run this part if we're not root, and sudo is installed)
if [ "$(id -u)" != 0 ] && [ -x "$(command -v sudo)" ]; then

	[ ! -x "$(command -v please)" ] && alias please="sudo !!"

	# Editor
	[ -x "$(command -v vim)" ] && alias svi="sudo vim"

	# Networking

	### firewalls
	[ -x "$(command -v firewall-cmd)" ] && alias sfw='sudo firewall-cmd'
	[ -x "$(command -v iptables)" ] && alias sipt='sudo iptables'
	[ -x "$(command -v nft)" ] && alias snft='sudo nft'

	### SS / Netstat
	if [ -x "$(command -v ss)" ]; then
		alias ss='sudo ss'
	elif [ -x "$(command -v netstat)" ]; then
		alias ss='sudo netstat'
	fi
	[ "$(type -t ss)" == "alias" ] && alias sl='ss -lnptu'

	# Package Managers

	### Apt
	if [ -x "$(command -v apt)" ]; then
		alias apt='sudo apt'
		export _UPDATE='apt update && apt dist-upgrade && apt autoremove'
	fi

	### DNF/Yum
	[ -x "$(command -v yum)" ] && alias dnf='sudo yum'
	[ -x "$(command -v dnf)" ] && alias dnf='sudo dnf'
	[ "$(type -t dnf)" == "alias" ] && export _UPDATE='dnf -y update'

	### Pacman (Reflector/Powerpill/Aurman)
	if [ -x "$(command -v pacman)" ]; then

		# Reflector
		if [ -x "$(command -v reflector)" ]; then
			export _REFLECT='sudo reflector -l 50 -a 12 -p https --sort rate --save /etc/pacman.d/mirrorlist'
			alias update_mirrors='$_REFLECT'
		fi

		# Powerpill or Pacman
		if [ -x "$(command -v powerpill)" ]; then
			PACMAN="$(command -v powerpill)"
			export _PAC='sudo powerpill'
		else
			PACMAN="$(command -v pacman)"
			export _PAC='sudo pacman'
		fi
		export PACMAN
		export _UPDATE="yes | $_PAC -Syyu --noconfirm"

		# Aurman
		if [ -x "$(command -v aurman)" ]; then
			export _PAC='aurman'
			export _UPDATE="yes | $_PAC -Syyu --noedit --noconfirm --devel"
		fi

		# Aliases
		alias pac='$_PAC'
		alias pacup='$_UPDATE'
		alias pacout='$_PAC -Runcs $($_PAC -Qdtq)'
	fi

	# Combos(
	if [ -n "$_UPDATE" ]; then
		if [ -n "$_REFLECT" ]; then
			export _FULL_UPDATE="$_REFLECT && $_UPDATE"
		else
			export _FULL_UPDATE="$_UPDATE"
		fi
		alias rpacup='$_FULL_UPDATE'
		# Tmux
		if [ -x "$(command -v tmux)" ] && \
			[ ! -x "$(command -v tu)" ] && \
			[ -n "$(command -v rpacup)" ]; then
					alias tu='tmux new "$_FULL_UPDATE"'
		fi
	fi

	# System
	[ -x "$(command -v su)" ] && alias su='sudo su'
	[ -x "$(command -v systemctl)" ] && alias sctl='sudo systemctl'
fi

# USER ALIASES ################################################################

# Import bash secrets from protected file
# shellcheck source=/dev/null
[ -f "$HOME"/SafeDepositBox//bash-secrets.sh ] && source "$HOME"/SafeDepositBox//bash-secrets.sh
