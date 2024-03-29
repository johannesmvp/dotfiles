# df
alias dfh='df -h'

# du with human sorting
alias dusort='du -d1 -h | sort -h'

# Easier navigation: .., ..., ...., .....
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Combine cd and cd
alias cdcd='cd;cd'

# Combine cd and ls
alias cdl='cl'
cl() {
    dir=$1
    if [[ -z "$dir" ]]; then
        dir=$HOME
    fi
    if [[ -d "$dir" ]]; then
        cd "$dir"
        ls
    else
        if [[ "$dir" == \- ]]; then
            cd -
            ls
        else
            echo "bash: $0: '$dir': Directory not found"
        fi
    fi
}

# Combine mkdir and cd
alias mkdircd='cdmkdir'
function cdmkdir() {
	# check the input 
	if [ ! "$1" ] || [ "$1" == '-h' ] ; then
		echo "Usage: cdmkdir (filename)"
		return 2
	fi

	# check if a file with that name exists
    if [ -e "$1" ] ; then
		echo "cdmkdir: $1 exists"
		return 1
	else
        mkdir -p "$1" && cd "$1"
    fi
}

# grep
alias grep='grep --color=auto'

## ls
# List all files
alias l='ls -aph'
alias ll='ls -alph'
alias ls='ls -p'
# List only directories
alias lsd="ls -lp ${colorflag} | grep --color=auto '^d'"
# List hidden files
alias l.='ls -d .*'

# docker aliases
type -P docker > /dev/null \
    && alias dopu='docker compose pull' \
    && alias dockup='docker compose up -d'

# colorcat
type -P pygmentize > /dev/null \
    && alias ccat='pygmentize'

# ccze
type -P ccze > /dev/null \
    && alias czze='ccze'

# Sudo stuff
type -P iptables > /dev/null \
	&& alias 'iptables'="echo;sudo iptables"
type -P ifconfig > /dev/null \
	&& alias 'ifconfig'='sudo ifconfig'

# apt-get
type -P apt-get > /dev/null \
	&& alias 'apt-get'="echo;sudo apt-get" \
	&& alias canhaz='echo;sudo apt-get install' \
	&& alias icanhaz='echo;sudo apt-get update && sudo apt-get install' \
	&& alias uppy='echo;sudo apt-get update && sudo apt-get upgrade' \
	&& alias uppyy='echo;sudo apt-get update && sudo apt-get -y upgrade'

# apt # overwrite apt-get aliases if apt exists
type -P apt > /dev/null \
  && alias apt='echo;sudo apt' \
	&& alias canhaz='echo;sudo apt install' \
	&& alias icanhaz='echo;sudo apt update && sudo apt install' \
	&& alias uppy='echo;sudo apt update && sudo apt upgrade' \
	&& alias uppyy='echo;sudo apt update && sudo apt -y upgrade'

# nala needs sudo
type -P nala > /dev/null \
  && alias nala='echo;sudo nala' && \
  alias nuppy='echo;sudo nala upgrade'

# Enable aliases to be sudo’ed
type -P sudo > /dev/null \
	&& alias sudo='sudo '


# OS X has no `md5sum`, so use `md5` as a fallback
type -P md5sum > /dev/null \
	|| alias md5sum="md5"

# OS X has no `sha1sum`, so use `shasum` as a fallback
type -P sha1sum > /dev/null \
	|| alias sha1sum="shasum"

# Screen
type -P screen > /dev/null \
	&& alias descreen='screen -dmS' \
	&& alias sc="screen -S" \
	&& alias sl="screen -ls" \
	&& alias sr="screen -r"

# Recursively delete `.DS_Store` and/or `Thumbs.db` files
alias cleanup="find . -type f \( -name '*.DS_Store' -or -name 'Thumbs.db' \) -ls -delete"
alias maccleanup='find . -type f -name '\''*.DS_Store'\'' -ls -delete'
alias wincleanup='find . -type f -name '\''Thumbs.db'\'' -ls -delete'

# Ring the terminal bell, and put a badge on Terminal.app’s Dock icon
# (useful when executing time-consuming commands)
alias badge="tput bel"

# One of @janmoesen’s ProTip™s
type -P lwp-request > /dev/null \
	&& for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
	alias "$method"="lwp-request -m '$method'"
	done

# Stuff I never really use but cannot delete either because of http://xkcd.com/530/
type -P osascript > /dev/null \
	&& alias stfu="osascript -e 'set volume output muted true'" \
	&& alias pumpitup="osascript -e 'set volume 7'"

# Git aliases
alias g="git"
alias gst="git status"
alias gmit="git commit -m"
alias gamit="git commit -a -m"
alias gadd="git add"
alias gd="git diff"
alias gdiff="git diff"
alias gdift="git difftool"
alias gpull="git pull"
alias gpush="git push"
alias gbr="git branch"
alias gco="git checkout"
alias glast="git last"
alias gstapush="git stashpush"
# gitignore.io
function gi(){
    curl http://gitignore.io/api/\$@ ;
}

# Frequent typo's
alias brwe="brew"

# ip address
alias myip='curl ip.frostia.net'

# identify and search for active network connections
spy (){
	lsof -i -P +c 0 +M | grep -i "$1"
}

# Show lines that are not blank or commented out
alias active='grep -v -e "^$" -e"^ *#"'

# Serve directory on localhost:8888
servedir(){
	python -m SimpleHTTPServer 8000
}

# shortcut to router/modem web gui
type -P netstat > /dev/null \
	&& alias router="command -v netstat >/dev/null && open http://$(netstat -rn |grep -iE "(^default|^0\.0\.0\.0)"| awk '{ print $2 }')"

# use htop instead of top
type -P htop > /dev/null \
    && alias top="htop"

# shortcut to download the Brezan price list
alias brezan='cd /tmp ; wget http://www.brezan.nl/content/downloads/files/Brezan_prijzen_ASCII_Ned.zip && unzip -u Brezan_prijzen_ASCII_Ned.zip && cd Brezan_prijzen_ASCII_Ned/'
alias brezangroep='cd /tmp ; wget http://www.brezan.nl/content/downloads/files/Brezan_prijzen_per_groep_ASCII_Ned.zip && unzip -u Brezan_prijzen_per_groep_ASCII_Ned.zip && cd Brezan_prijzen_per_groep_ASCII_Ned/'

# SSH connection multiplexing
alias sshcheck='ssh -O check'
alias sshstop='ssh -O stop'

# reload the bash profile files
alias reload='source ~/.bash_profile'

# load the local aliases, if available
if [ -f ~/.bash_aliases_local ]; then
    . ~/.bash_aliases_local
fi

