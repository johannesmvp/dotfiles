# Basic stuff
export HISTIGNORE=":exit:shutdown:reboot"

# GPG stuff
GPGKEY=0x0FB99FB3ADA8673B27D3F29953665A0480ABE8A7

# Aliases
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# Colored command prompt
if [ -f ~/.bash_prompt ]; then
	. ~/.bash_prompt
fi

# Bash auto-completion
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# Locale
export LC_ALL="en_US.UTF-8"
