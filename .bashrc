test -s ~/.alias && . ~/.alias || true

set -o vi

# Define colors
BLUE="\e[1;34m"
GREEN="\e[1;32m"
RED="\e[1;31m"
PURPLE="\e[1;37m"
RESET="\e[0m"

# Function to set the prompt color based on the last command's exit status
set_prompt() {
    if [ $? -eq 0 ]; then
        # Green prompt for success
        PS1="${BLUE}\W${RESET} ${PURPLE}${GREEN}${RESET} "
    else
        # Red prompt for failure
        PS1="${BLUE}\W${RESET} ${PURPLE}${RED}${RESET} "
    fi
}

# Set PROMPT_COMMAND to update the prompt before each command
PROMPT_COMMAND=set_prompt

# Prompt
# PS1="\e[1;34m\W\e[0m \e[1;32m\e[0m " 
# if (env | grep -Fq 'DISTROBOX'); then
# 	    PS1='\[\e[1;34m\]CONTAINER \w\[\e[m\] '
#     else
# 	        PS1=$PS1
# fi

export EDITOR="nvim"
export TERM="st-256color"

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
	        . /etc/bash_completion
fi

# Aliases
alias c="clear"
alias v="vim"
alias sv="sudo vim"
alias r="ranger"
#alias cd="z"
alias n="neofetch --kitty Pictures/marinkjutdownsc.png"
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
alias cdc='cd && clear'
alias po='poweroff'
alias extract='unrar x'
alias smi='sudo make clean install'






# export CC=gcc
# export PATH=$PATH:/home/marin/.spicetify
export PATH="$PATH:$HOME/.config/emacs/bin:$HOME/.spicetify:$HOME/.local/bin"
# export PATH=$PATH:$HOME/.local/bin
export PF_INFO="ascii title os kernel uptime pkgs memory"

# if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
#     dbus-run-session Hyprland
# fi
# pfetch

eval "$(zoxide init bash)"
# eval "$(starship init bash)"
