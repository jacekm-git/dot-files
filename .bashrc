#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1="\[\033[1;36m\]\u@\h\[\033[33m\](\w)\n\t\[\033[32m\]\$ \[\033[0m\]"
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
	LESS_TERMCAP_md=$'\E[01;38;5;74m' \
	LESS_TERMCAP_me=$'\E[0m' \
	LESS_TERMCAP_se=$'\E[0m' \
	LESS_TERMCAP_so=$'\E[38;5;246m' \
	LESS_TERMCAP_ue=$'\E[0m' \
	LESS_TERMCAP_us=$'\E[04;38;5;146m' \
	man "$@"
}

alias hs-activate='eval "$(/app/halcyon/halcyon paths)"'
export PATH=$PATH:~/.composer/vendor/bin
export PATH=$PATH:~/.cabal/bin
export PATH=$PATH:~/Scripts
export TERM=xterm-256color
