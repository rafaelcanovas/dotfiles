shopt -s nocaseglob histappend cmdhist checkwinsize
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups

###########
# Aliases #
###########

# IP addresses
alias globalip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ip a s|sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}'"

# Enhanced WHOIS lookup
alias whois="whois -h whois-servers.net"

# Simple HTTP server
alias server="python -m SimpleHTTPServer"

# Sublime Text
alias subl="/opt/sublime_text/sublime_text"


#############
# Functions #
#############

# Copy with progress
function cp_p () {
	rsync -WavP --human-readable --progress $1 $2
}

# Test if HTTP compression (RFC 2616 + SDCH) is enabled for a given URL
# Send a fake UA string for sites that sniff it instead of using the Accept-Encoding header
function httpcompression() {
	encoding="$(curl -LIs -H 'User-Agent: Mozilla/5.0 Gecko' -H 'Accept-Encoding: gzip,deflate,compress,sdch' "$1" | grep '^Content-Encoding:')"
	encoding=${encoding##* }

	if [[ -n $encoding ]]; then
		echo "$1 is encoded using ${encoding}"
	else
		echo "$1 is not encoded"
	fi
}

# Get gzipped size
function gz() {
	echo "original size: $(cat "$1" | wc -c)B"
	echo "gzipped size: $(gzip -c "$1" | wc -c)B"
}

# Command-line calculations
function calc () {
	echo "$*" | bc -l;
}

# Generate useful .gitignore files for your project
function gi() {
	curl https://www.gitignore.io/api/$@;
}

# Run pngout through the entire dir
function pngoutdir() {
	for i in *.png; do
		[[ -f "$i" ]] || continue
		pngout $i
	done
}


#######################
# Git Auto Completion #
#######################

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi


#################
# Liquid Prompt #
#################

# A full-featured & carefully designed adaptive prompt for Bash & Zsh
# https://github.com/nojhan/liquidprompt

. ~/.liquidprompt/liquidprompt


#######################
# Android Development #
#######################

export ANDROID_HOME="$HOME/.android/sdk"
export PATH="$PATH:$ANDROID_HOME/tools/:$ANDROID_HOME/platform-tools/"


##########
# direnv #
##########

_direnv_hook() {
  eval "$(direnv export bash)";
};
if ! [[ "$PROMPT_COMMAND" =~ _direnv_hook ]]; then
  PROMPT_COMMAND="_direnv_hook;$PROMPT_COMMAND";
fi


#####################
# virtualenvwrapper #
#####################

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/dev
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
source /usr/local/bin/virtualenvwrapper_lazy.sh
