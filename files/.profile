# Basic stuff
export HISTIGNORE=":exit:shutdown:reboot"

# GPG stuff
GPGKEY=80ABE8A7

# Aliases
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# Locale
export LC_ALL="en_US.UTF-8"
