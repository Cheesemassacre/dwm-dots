# Sample .bashrc for SUSE Linux
# Copyright (c) SUSE Software Solutions Germany GmbH

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

test -s ~/.alias && . ~/.alias || true

# Prompt
PS1="\e[1;34m \W\e[0m \e[1;37m>\e[0m\e[1;35m> \e[0m" 
if (env | grep -Fq 'DISTROBOX'); then
	    PS1='\[\e[1;34m\]CONTAINER \w\[\e[m\] '
    else
	        PS1=$PS1
fi

export EDITOR="vim"
export TERM="kitty"

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
	        . /etc/bash_completion
fi

# Aliases
alias c="clear"
alias v="vim"
alias sv="sudo vim"
alias r="ranger"
#alias cd="z"
alias n="neofetch"
alias install="sudo apt install"
alias remove="sudo apt remove"
alias update="sudo apt update && sudo apt upgrade"
alias upfate="sudo apt update && sudo apt upgrade"
alias search="apt search"
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
# alias reboot='sudo /sbin/reboot'
# alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
# alias shutdown='sudo /sbin/shutdown'
alias sortsize='ls --human-readable --size -1 -S -F'
alias hist='history|grep'
alias count='find . -type f | wc -l'
alias trash='mv --force -t ~/.local/share/Trash '
alias fuckdiscord='./.discordfileshost.sh'
alias de='distrobox-enter'
alias dix='distrobox-export'
alias hx='helix'
alias wall='feh --bg-fill'
alias sus='systemctl suspend'
alias update-grub='./.grubreload.sh'
alias b='btop'







#export CC=gcc
export PATH=$PATH:/home/marin/.spicetify
export PATH=$PATH:/home/marin/.config/emacs/bin
export PATH=$PATH:$HOME/.local/bin

# if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
#     dbus-run-session Hyprland
# fi

eval "$(zoxide init bash)"
