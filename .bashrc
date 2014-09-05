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
	curl http://www.gitignore.io/api/$@;
}

# Run pngout through the entire dir
function pngoutdir() {
	for i in *.png; do
		[[ -f "$i" ]] || continue
		pngout $i
	done
}

# Quickly navigate your filesystem from the command-line
# http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
export MARKPATH=$HOME/.marks

function jump {
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark {
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark {
    rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}


############
# Autovenv #
############

# Automatic activation and deactivation of virtualenvs /*done right*/.
# https://github.com/skyenhasus/autovenv

. ~/.autovenv/autovenv.sh


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


###############
# Android SDK #
###############

export ANDROID_HOME="$HOME/.android/adt/sdk/tools"
export ANDROID_PLATFORM_TOOLS="$HOME/.android/adt/sdk/platform-tools"
export PATH="$ANDROID_HOME:$ANDROID_PLATFORM_TOOLS:$PATH"
