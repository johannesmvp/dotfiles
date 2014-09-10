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

# Locale
export LC_ALL="en_US.UTF-8"
