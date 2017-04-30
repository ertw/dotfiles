# vim:foldmethod=marker:foldlevel=0
# *** Function definitions *** {{{
# function to determine if a command exisits
command_exists () {
    type "$1" &> /dev/null ;
}
# return bool for platform from uname:
# FreeBSD, Darwin, Linux
platform_is () {
	unamestr=$(uname)
	if [[ "$1" == "$unamestr" ]]; then
		return 0
	else
		return 1
	fi
}
# }}}
# *** Environment *** {{{
export TERM="xterm-256color"
if platform_is "Darwin"; then
	# append Homebrew to path
	path+=(/Volumes/Storage/goinfre/$(whoami)/homebrew/bin)
	# append Racket to path
	path+=($HOME/Applications/racket/bin)
	# rust
	source $HOME/.cargo/env
	# check if nvm is installed; if so set up env
	if command_exists "$(brew --prefix nvm)/nvm.sh"; then
		export NVM_DIR="$HOME/.nvm"
		source $(brew --prefix nvm)/nvm.sh
	fi
fi
export PATH
# check if vim is intalled; if so set it as manpager
if command_exists "vim"; then
	PAGER='col -bx | vim -c ":set ft=man nonu nolist" -R -'
fi
# }}}
# *** zsh & term config *** {{{
# omzsh plugins
plugins=(git vi-mode)
export ZSH_THEME=robbyrussell
# make double-j behave like vi <ESC> in vi-mode
bindkey -M viins "jj" vi-cmd-mode
# set timeout in vi-mode to 180ms
export KEYTIMEOUT=18
# make tmux show colors
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
# }}}
# *** alias definitions *** {{{ 
# lldb - print frame vars on each step
alias db="lldb -s <(echo 'target stop-hook add --one-liner \"frame variable\"')"
# debug compile alias
alias ccw="cc -Wall -Werror -Wextra -fsanitize=address"
# alias to quickly cd to current project
alias f="~/Documents/ft_printf"
# check if nvim is intalled; if so alias vim
if platform_is "Darwin"; then
	# homebrew alias
	alias brew="/Volumes/Storage/goinfre/$(whoami)/homebrew/bin/brew"
	# neovim alias
	if command_exists "$HOME/bin/nvim"; then
		alias vim="$HOME/bin/nvim"
	fi
else
	if command_exists "nvim"; then
		alias vim="nvim"
	fi
fi
# aliases for remote connectivity
if command_exists "mosh"; then
	alias bsd="mosh --ssh=\"ssh -p 28674\" ertw@b.erik.tw"
	alias lin="mosh --ssh=\"ssh -p 28673\" ertw@l.erik.tw"
else
	alias bsd="ssh -p 28674 ertw@b.erik.tw"
	alias lin="ssh -p 28673 ertw@l.erik.tw"
fi
# fancy diff alias
if command_exists "diff-so-fancy"; then
	alias gd="git diff --color | diff-so-fancy"
fi
# }}}
