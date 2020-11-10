#!/usr/bin/env bash

# BASE CONFIGURATION ##########################################################

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Used to source various files
source_if_readable() {
	# shellcheck disable=1090
	[ -f "$1" ] && [ -r "$1" ] && source "$1"
}

# Some work machines have this....
# shellcheck disable=1091
source_if_readable /usr/local/lib/bashrc.source

# Vi mode
set -o vi
bind -m vi-insert "\C-l":clear-screen

# Check window size after each command and update $LINES and $COLUMNS as needed
[ "$DISPLAY" ] && shopt -s checkwinsize

# Recursive **/* and `cd` when only entering a path (does not work on OS X)
if [ "$(uname -s)" != "Darwin" ]; then
	shopt -s globstar
	shopt -s autocd
fi

# Fix perl complaining about LC_ALL
export LC_ALL=en_US.UTF-8

# Fix spelling
shopt -s cdspell
[ "$(uname -s)" != 'Darwin' ] && shopt -s dirspell

# Fix gpg agent
GPG_TTY="$(tty)"
export GPG_TTY

# Fix ssh agent
# http://rabexc.org/posts/pitfalls-of-ssh-agents
if [ -x "$(command -v ssh-agent)" ]; then

	# Test if agent is running
	ssh-add -l >/dev/null 2>/dev/null
	if [ "$?" -gt 1 ]; then # agent not running

		# Test if agent config exists in file
		test -r ~/.ssh-agent &&
			eval "$(<~/.ssh-agent)" >/dev/null

		# Test again if running
		ssh-add -l &>/dev/null
		if [ "$?" -gt 1 ]; then # agent not running
			(
				umask 066
				ssh-agent -t 600 >~/.ssh-agent
			)
			eval "$(<~/.ssh-agent)" >/dev/null
		fi
	fi
fi

# Tabs default to four spaces wide
[ -x "$(command -v tabs)" ] && tabs 4

# BASH PROMPT #################################################################

source_if_readable "$HOME"/.config/gitstatus/gitstatus.plugin.sh

# shellcheck disable=2120
gitstatus_prompt_update() {
	GITSTATUS_PROMPT=""

	gitstatus_query "$@" || return 1                  # error
	[[ "$VCS_STATUS_RESULT" == ok-sync ]] || return 0 # not a git repo

	local reset=$'\e[0m'         # no color
	local clean=$'\e[0;36m'      # green foreground
	local pbranch=$'\e[0;35m'    # purple foreground
	local otag=$'\e[0;93m'       # orange foreground
	local untracked=$'\e[0;94m'  # blue foreground
	local modified=$'\e[0;92m'   # yellow foreground
	local conflicted=$'\e[0;91m' # red foreground

	local p="${pbranch}"

	local where # branch name, tag or commit
	if [[ -n "$VCS_STATUS_LOCAL_BRANCH" ]]; then
		where="$VCS_STATUS_LOCAL_BRANCH"
	elif [[ -n "$VCS_STATUS_TAG" ]]; then
		p+="${otag}#"
		where="$VCS_STATUS_TAG"
	else
		p+="${otag}@"
		where="${VCS_STATUS_COMMIT:0:8}"
	fi

	((${#where} > 32)) && where="${where:0:12}…${where: -12}" # truncate long branch names and tags
	p+="${where}"

	# ⇣42 if behind the remote.
	((VCS_STATUS_COMMITS_BEHIND)) && p+=" ${clean}⇣${VCS_STATUS_COMMITS_BEHIND}"
	# ⇡42 if ahead of the remote; no leading space if also behind the remote: ⇣42⇡42.
	((VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND)) && p+=" "
	((VCS_STATUS_COMMITS_AHEAD)) && p+="${clean}⇡${VCS_STATUS_COMMITS_AHEAD}"
	# *42 if have stashes.
	((VCS_STATUS_STASHES)) && p+=" ${clean}*${VCS_STATUS_STASHES}"
	# 'merge' if the repo is in an unusual state.
	[[ -n "$VCS_STATUS_ACTION" ]] && p+=" ${conflicted}${VCS_STATUS_ACTION}"
	# ~42 if have merge conflicts.
	((VCS_STATUS_NUM_CONFLICTED)) && p+=" ${conflicted}~${VCS_STATUS_NUM_CONFLICTED}"
	# +42 if have staged changes.
	((VCS_STATUS_NUM_STAGED)) && p+=" ${modified}+${VCS_STATUS_NUM_STAGED}"
	# !42 if have unstaged changes.
	((VCS_STATUS_NUM_UNSTAGED)) && p+=" ${modified}!${VCS_STATUS_NUM_UNSTAGED}"
	# ?42 if have untracked files. It's really a question mark, your font isn't broken.
	((VCS_STATUS_NUM_UNTRACKED)) && p+=" ${untracked}?${VCS_STATUS_NUM_UNTRACKED}"

	GITSTATUS_PROMPT="${p}${reset}"
}

# Start gitstatusd in the background.
gitstatus_stop && gitstatus_start -s -1 -u -1 -c -1 -d -1

__prompt_command() {

	# Start with exit status of previous command, and date
	PS1="\\n    \\D{%a %Y.%m.%d %T} [\\j][\${PIPESTATUS[@]}]\\n"

	gitstatus_prompt_update
	[ -n "$GITSTATUS_PROMPT" ] && GITSTATUS_PROMPT=" ($GITSTATUS_PROMPT)"

	# How many characters of the $PWD should be kept
	local pwdmaxlen=$((COLUMNS - 32 - ${#HOSTNAME} - ${#USER} - ${#GITSTATUS_PROMPT}))
	local dir=${PWD##*/}
	pwdmaxlen=$(((pwdmaxlen < ${#dir}) ? ${#dir} : pwdmaxlen))
	CPWD=${PWD/#$HOME/\~}
	local pwdoffset=$((${#CPWD} - pwdmaxlen))
	if [ ${pwdoffset} -gt "0" ]; then
		CPWD=${CPWD:$pwdoffset:$pwdmaxlen}
		CPWD='.../'"${CPWD#*/}"
	fi

	# Colors
	local U="\\[\\e[0m\\]" # default foreground color

	## regular colors
	local R="\\[\\e[0;31m\\]" # red
	local G="\\[\\e[0;32m\\]" # green
	local Y="\\[\\e[0;33m\\]" # yellow
	local B="\\[\\e[0;34m\\]" # blue
	local M="\\[\\e[0;35m\\]" # magenta
	local C="\\[\\e[0;36m\\]" # cyan

	## emphasized (bolded) colors
	local ER="\\[\\e[1;31m\\]" # bold red

	local UC=$R # user's color

	if [ "$USER" == 'stick' ] || [ "$USER" == 'nstickney' ]; then
		UC=$Y
	elif [ "$USER" == 'emma' ] || [ "$USER" == 'emmafreester' ]; then
		UC=$M
	elif [ "$(id -u)" -eq '0' ]; then
		UC=$ER # root's color
	fi

	# Next line shows username, hostname, current working directory, git status
	PS1+="  ${UC}\\u${U}@${C}\\h${U}:${B}\${CPWD}${U}\${GITSTATUS_PROMPT}\\n"

	# Last line shows bash version and prompt level (root vs nonroot)
	PS1+="[${G}\\s \\V${U}] ${UC}\\$ ${U}"
}

PROMPT_COMMAND=__prompt_command

# COLORIZE EVERYTHING #########################################################

# the tty/framebuffer console
if [ "$TERM" = 'linux' ]; then
	printf "\\e]P01A1A1A" # black
	printf "\\e]P1C22436" # red     (red)
	printf "\\e]P2A58440" # green   (yellow)
	printf "\\e]P3E64D00" # brown   (orange)
	printf "\\e]P40077E6" # blue    (blue)
	printf "\\e]P5AB3B85" # magenta (purple)
	printf "\\e]P635B181" # cyan    (green)
	printf "\\e]P7E6E6E6" # light gray
	printf "\\e]P8333333" # gray
	printf "\\e]P9DF5363" # bright red
	printf "\\e]PAC6A86C" # bright green
	printf "\\e]PBFF7733" # yellow
	printf "\\e]PC338CFF" # bright blue
	printf "\\e]PDCB67AA" # bright magenta
	printf "\\e]PE62D0A6" # bright cyan
	printf "\\e]PFFFF8E7" # white
	clear                 # fix artifacts
fi

# cat
[ -x "$(command -v bat)" ] && alias cat='bat --style="plain"'

# ls
if [ "$(uname -s)" == 'Darwin' ]; then
	# shellcheck disable=2032
	alias ls='ls -G'
else
	alias ls='ls --color=auto'
fi
[ -x "$(command -v exa)" ] && alias ls=exa
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
[ -n "$(command -v dircolors)" ] && eval "$(dircolors -b)"

# grep
export GREP_COLOR='1;33'
if grep --color 'a' <<<'a' &>/dev/null; then
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# diff
[ -x "$(command -v colordiff)" ] && alias diff='colordiff'

# less
if [ -x /usr/bin/source-highlight-esc.sh ]; then
	export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
	export LESS='-R'
fi

# make
[ -x "$(command -v colormake)" ] && alias make='colormake'

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
		man "$@" || (help "$@" 2>/dev/null && help "$@" | less)
}

# ping
[ -x "$(command -v prettyping)" ] && alias ping='prettyping'

# COMPLETION ##################################################################

# Bash completion where available
source_if_readable /usr/share/bash-completion/bash_completion

# Fuzzy Finder
source_if_readable /usr/share/fzf/completion.bash
source_if_readable /usr/share/fzf/key-bindings.bash

# Git
source_if_readable /usr/share/git/completion/git-completion.bash

# History search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[5~": previous-history'
bind '"\e[6~": next-history'

# Sudo Completion
[ -n "$(command -v sudo)" ] && complete -cf sudo

# DEFEAT LOGGING ##############################################################

# Defeat Snoopy logging
# http://blog.rchapman.org/posts/Bypassing_snoopy_logging/
[ ! -f "$HOME"/bin/bypass.so ] &&
	[ -x "$(command -v gcc)" ] &&
	[ -f "$HOME"/bin/bypass.c ] &&
	gcc -nostartfiles -shared -O3 -fPIC "$HOME"/bin/bypass.c -o \
		"$HOME"/bin/bypass.so -ldl -Wall -Wextra
[ -x "$HOME"/bin/bypass.so ] &&
	export LD_PRELOAD=$HOME/bin/bypass.so

# HISTORY #####################################################################

# Colon seperated list of exact commands to ignore
export HISTIGNORE="clear:bg:fg:cd:cd -:exit:date:poweroff:reboot:* --help"

# Avoid duplicates, and share history across terminals
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="history -n;history -w;history -c;history -r;$PROMPT_COMMAND"

# Date and time format
#export HISTTIMEFORMAT='%Y.%m.%d %T  '

# Max history size
export HISTFILESIZE=8192

# PATH ########################################################################

# Remove duplicate items from path
# https://unix.stackexchange.com/a/338737
remove_dups() {
	local D=${2:-:}
	local path=
	local dir=
	while IFS= read -r -d"$D" dir; do
		[[ $path$D =~ .*$D$dir$D.* ]] || path+="$D$dir"
	done <<<"$1$D"
	printf %s "${path#$D}"
}
PATH="$(remove_dups "$PATH")"

# Cleanly add an item to the end of $PATH
# https://unix.stackexchange.com/a/124447
path_append() {
	case ":${PATH:=$1}:" in
	*:$@:*) ;;
	*) PATH="$PATH:$1" ;;
	esac
}

# Cleanly add an item to the beginning of $PATH
path_override() {
	case ":${PATH:=$1}:" in
	*:$@:*) ;;
	*) PATH="$1:$PATH" ;;
	esac
}

[ -d "$HOME/.local/bin" ] && path_override "$HOME/.local/bin"
[ -d "$HOME/.config/overrides" ] && path_override "$HOME/.config/overrides"
path_append "$HOME/bin"

# Add ~/.local/lib to library path (cleanly)
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"$HOME/.local/lib"
LD_LIBRARY_PATH="$(remove_dups "$LD_LIBRARY_PATH")"

# NVM
source_if_readable /usr/share/nvm/init-nvm.sh

# KEYBOARD SHORTCUTS ##########################################################

# Ctrl-Z sends to background, Ctrl-F brings to foreground!
bind -x '"\C-f":fg'

# USER ALIASES ################################################################

# Alias to directly cd into sub-directory of given path, from anywhere
alias_directories() {
	for i in "$1"/*; do
		_dir="${i##*/}"
		_dir="${_dir%% *}"
		if [ -d "$1/$_dir" ] && [ -z "$(command -v "$_dir")" ]; then
			# shellcheck disable=2139,2140
			alias "$_dir"="cd -- $1/$_dir || exit"
		fi
	done
}
alias_directories "$HOME"
[ -d "$HOME"/projects ] && alias_directories "$HOME"/projects

# apt
if [ -x "$(command -v apt)" ]; then
	if [ -x "$(command -v apt-fast)" ] || [ -x /usr/sbin/apt-fast ]; then
		alias apt='sudo apt-fast'
	else
		alias apt='sudo apt'
	fi
	alias aptup='apt update && apt dist-upgrade && apt autoremove'
fi

# aurvote
[ -x "$(command -v aurvote)" ] && [ -z "$(command -v aurvoteall)" ] &&
	alias aurvoteall='pacman -Qm | cut -f1 -d" " | xargs aurvote'

# bats
[ -x "$(command -v bats)" ] && [ -x "$(command -v time)" ] &&
	alias bats='time bats'

# cd
alias .='cd -'
alias cd..='cd ..'
if [ -z "$(command -v pd)" ]; then
	pd() {
		if [ -n "$1" ]; then
			pushd "$1" || exit
		else
			popd || exit
		fi
	}
fi

# dnf (and yum)
if [ -x "$(command -v dnf)" ]; then
	alias dnf='sudo dnf'
elif [ -x "$(command -v yum)" ]; then
	alias dnf='sudo yum'
fi
[ "$(type -t dnf)" == 'alias' ] && alias dnfup='dnf -y update'

# editor
[ -x "$(command -v vi)" ] && export EDITOR='vi'
if [ -x "$(command -v vim)" ]; then
	# shellcheck disable=2139
	alias vi='$(command -v vim)'
	alias vimrc='$(command -v vim) ~/.vim/vimrc'
	EDITOR="$(command -v vim)"
	export EDITOR
fi
[ -x "$(command -v sudo)" ] && alias se='sudo -e'

# ls
[ -z "$(command -v ll)" ] && alias ll='ls -ahl'
[ -z "$(command -v sl)" ] && alias sl='ls'

# mkdir
alias mkdir='mkdir -pv'

# makepkg
[ -n "$(command -v makepkg)" ] &&
	alias mksrcinfo='makepkg --printsrcinfo > .SRCINFO'

# mosh
[ -n "$(command -v mosh)" ] && [ ! -v "$(command -v mop)" ] &&
	alias mop='mosh -p 59999'

# networking
[ -z "$(command -v ipme)" ] && alias ipme="curl ifconfig.me; printf '\n'"
[ -z "$(command -v pinc)" ] && alias pinc='ping -c'

# pacman
if [ -x "$(command -v pacman)" ]; then
	pacowns() {
		pacman -Qo "$(command -v "$1")"
	}
fi
[ -x "$(command -v powerpill)" ] &&
	PACMAN="$(command -v powerpill)" &&
	export PACMAN
if [ -x "$(command -v reflector)" ] && [ -z "$(command -v reflect)" ]; then
	reflect() {
		local OPTS='--age 12 --fastest 50 --protocol https --sort rate'
		if [ -x "$(command -v spinner)" ]; then
			sudo spinner "reflector $OPTS --save /etc/pacman.d/mirrorlist" \
				"Updating mirrorlist:" 'unicode'
		else
			printf 'Updating mirrorlist:'
			# shellcheck disable=2086
			reflector $OPTS --save /etc/pacman.d/mirrorlist
			printf ' Done\n'
		fi
	}
fi
if [ -x "$(command -v paru)" ]; then
	[ -z "$(command -v pac)" ] && alias pac='paru'
	[ -z "$(command -v pup)" ] && alias pup='paru -Syu --noconfirm --devel'
fi
[ "$(type -t reflect)" == 'function' ] && [ "$(type -t pup)" == 'alias' ] &&
	[ -z "$(command -v rup)" ] && alias rup='reflect && pup'

# ps
[ -z "$(command -v pf)" ] && alias pf='ps auxf'
[ -z "$(command -v pg)" ] && alias pg='ps aux | grep -v grep | grep -i -e'

if [ -z "$(command -v kp)" ] && [ -x "$(command -v fzf)" ]; then
	kp() {
		local pid
		pid=$(ps -ef | sed 1d | eval "fzf -m --header='[kill:process]'" | awk \
			'{print $2}')

		if [ -n "$pid" ]; then
			echo "$pid" | xargs kill -"${1:-9}"
			kp "$@"
		fi
	}
fi

# ssh
if [ -x "$(command -v ssh)" ]; then

	# Fix "'alacritty': unknown terminal type"
	alias ssh='TERM=xterm-256color ssh'

	# Easy tunnel creation
	if [ -z "$(command -v tunnel)" ]; then
		# Create ssh tunnel on port $2 (default 19998) to server $1
		tunnel() {
			ssh -f -N -D "${2:-19998}" -4 "$1"
		}

		# Kill the ssh tunnel running on server or port $1 (default all tunnels)
		kill_tunnel() {
			local PID
			PID="$(pgrep -a ssh | grep "\-f \-N \-D .*$1.*" | cut -f1 -d' ' |
				xargs)"
			if ((${#PID} > 0)); then
				kill "$PID"
			else
				printf 'No ssh tunnels running.\n'
			fi
		}
	fi
fi

# su and sudo
[ -x "$(command -v su)" ] && [ -x "$(command -v sudo)" ] && alias su='sudo su'

# systemctl
[ -x "$(command -v systemctl)" ] && [ -z "$(command -v sctl)" ] &&
	alias sctl='sudo systemctl'

# tmux
# https://www.nathankowald.com/blog/2014/03/tmux-attach-session-alias/
if [ -x "$(command -v tmux)" ]; then
	if [ -z "$(command -v tmax)" ]; then
		tmax() {
			if (($# > 0)); then
				tmux attach -t "$1" 2>/dev/null || tmux new -s "$@"
			else
				tmux attach 2>/dev/null || tmux new "$@"
			fi
		}
		_tmax() {
			# shellcheck disable=2033
			read -ra COMPREPLY <<<"$(compgen -W "$(tmux ls -F '#S' | xargs)" \
				-- "${COMP_WORDS[COMP_CWORD]}")"
		}
		complete -F _tmax tmax
	fi
	[ -z "$(command -v tmls)" ] && alias tmls='tmux ls'
	if [ "$(type -t tmax)" == 'function' ] &&
		[ -z "$(command -v tv)" ] &&
		[ -n "$EDITOR" ]; then
		tv() {
			tmax 'editor' "$EDITOR $*"
		}
	fi
fi

# wget, curl, aria2c
[ -x "$(command -v wget)" ] && alias wget='wget -c'
if [ -z "$(command -v ttfb)" ]; then
	ttfb() {
		local line='Connect: %{time_connect}'
		line+=' TTFB: %{time_starttransfer}'
		line+=' Total time: %{time_total} \n'
		curl -sSo /dev/null -w "$line" "$1"
	}
fi

# Import bash secrets from protected file
source_if_readable "$HOME"/safe/bash-secrets.sh

# Dotfiles bare repository
if [ -x "$(command -v dots)" ]; then
	printf '***** WARNING ***********************************'
	# shellcheck disable=2016
	printf 'The `dots` command exists on this system already!'
	printf '*************************************************'
else
	alias dots='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
fi
