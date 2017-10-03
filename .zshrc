# vim:foldmethod=marker:foldlevel=0
# *** Function definitions *** {{{
# async source
lazy_source () {
    eval "$1 () { [ -f $2 ] && source $2 && $1 \$@ }"
}
# function to determine if a command exisits
command_exists () {
    [[ -s "$1" ]]
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
# make dir and enter it
mkcd () {
	mkdir "$1"
	cd "$1"
}
# }}}
# *** Environment *** {{{
#export TERM="screen-256color"
#export TERM="xterm-256color"
if platform_is "Darwin"; then
	# append Homebrew to path
	export PATH=/Volumes/Storage/goinfre/$(whoami)/homebrew/bin:$PATH
fi
# check if asdf is installed; if so source it
if command_exists "$HOME/.asdf/asdf.sh"; then
	source $HOME/.asdf/asdf.sh
#	source $HOME/.asdf/completions/asdf.bash
fi
# check if most is intalled; if so set it as manpager
if command_exists "$(which most)"; then
	PAGER='most'
fi
# for MacOS - check if vim is intalled; if so set it as manpager
if platform_is "Darwin"; then
	if command_exists "$(which nvim)"; then
		PAGER='col -bx | vim -c ":set ft=man nonu nolist" -R -'
	fi
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
# debug compile flags
alias ccw="cc -g -Wall -Werror -Wextra -fsanitize=address"
# push to all remotes
alias gpa="git remote | xargs -L1 git push --all"
# check if nvim is intalled; if so alias vim
if platform_is "Darwin"; then
	# homebrew alias
	alias brew="/Volumes/Storage/goinfre/$(whoami)/homebrew/bin/brew"
	# neovim alias
	if command_exists "$HOME/bin/nvim"; then
		alias vim="$HOME/bin/nvim"
	fi
	# compile for starfleet
	if command_exists "$HOME/bin/compile"; then
		alias compile="$HOME/bin/compile"
	fi
else
	if command_exists "$(which nvim)"; then
		alias vim="nvim"
	fi
fi
# aliases for remote connectivity
if command_exists "$(which mosh)"; then
	alias lin="mosh --ssh=\"ssh -p 28673\" ertw@v.erik.tw"
else
	alias lin="ssh -p 28673 ertw@v.erik.tw"
fi
# fancy diff alias
if command_exists "$(which diff-so-fancy)"; then
	alias gd="git diff --color | diff-so-fancy"
fi
# }}}
