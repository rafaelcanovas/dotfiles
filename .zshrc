#########
# zinit #
#########

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Load the pure theme, with zsh-async library that's bundled with it.
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

# A glance at the new for-syntax – load all of the above
# plugins with a single command. For more information see:
# https://zdharma-continuum.github.io/zinit/wiki/For-Syntax/
zinit for \
    light-mode zsh-users/zsh-autosuggestions \
    light-mode zdharma-continuum/fast-syntax-highlighting \
               zdharma-continuum/history-search-multi-word

# Binary release in archive, from GitHub-releases page.
# After automatic unpacking it provides program "fzf".
zinit ice from"gh-r" as"program"
zinit light junegunn/fzf

# Scripts built at install (there's single default make target, "install",
# and it constructs scripts by `cat'ing a few files). The make'' ice could also be:
# `make"install PREFIX=$ZPFX"`, if "install" wouldn't be the only default target.
zinit ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zinit light tj/git-extras

# For GNU ls (the binaries can be gls, gdircolors, e.g. on OS X when installing the
# coreutils package from Homebrew; you can also use https://github.com/ogham/exa)
zinit ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!'
zinit light trapd00r/LS_COLORS

# Load direnv
zinit from"gh-r" as"program" mv"direnv* -> direnv" \
  atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' \
  pick"direnv" src="zhook.zsh" for \
  direnv/direnv

# Load diff-so-fancy
zi ice as"program" pick"bin/git-dsf"
zi light z-shell/zsh-diff-so-fancy


#########################
# Aliases and functions #
#########################

alias globalip="dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com | tr '\"' '\0'"
alias localip="ifconfig en0 | grep 'inet[ ]' | awk '{print $2}'"

# Enable MacOS clamshell mode without charger connected
caf () {
    sudo pmset -b sleep 0
    sudo pmset displaysleep 0
    sudo pmset -b disablesleep 1
    sudo systemsetup -setcomputersleep Never
}

# Disable MacOS clamshell mode without charger connected
decaf () {
    sudo pmset -b sleep 10
    sudo pmset displaysleep 5
    sudo pmset -b disablesleep 0
    sudo systemsetup -setcomputersleep 10
}

# Copy with progress
cp_p () {
    rsync -WavP --human-readable --progress $1 $2
}

# Get gzipped size
gz() {
    echo "original size: $(cat "$1" | wc -c)B"
    echo "gzipped size: $(gzip -c "$1" | wc -c)B"
}

# Clean .pyc and __pycache__
pyclean () {
    find . -type f -name "*.py[co]" -delete
    find . -type d -name "__pycache__" -delete
}


#######################
# Android Development #
#######################

export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$HOME/Library/Android/sdk/:$PATH"
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
export PATH="$HOME/Library/Android/sdk/cmdline-tools/latest/bin:$PATH"

###########
# openssl #
###########

export PATH="/usr/local/opt/openssl/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"


###########
# kubectl #
###########

export KUBE_EDITOR="codium --wait"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"


######
# go #
######

export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"


################
# Google Cloud #
################

source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
export USE_GKE_GCLOUD_AUTH_PLUGIN=True


########
# gems #
########

export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH


########
# dart #
########

export PATH="$PATH":"$HOME/.pub-cache/bin"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/rafaelcanovas/.dart-cli-completion/zsh-config.zsh ]] && . /Users/rafaelcanovas/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]


##############
# postgresql #
##############

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
