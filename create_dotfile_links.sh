# tests if a file exists, returns bool
file_exists () {
	if [[ -a "$1" ]]; then
		return 0
	else
		return 1
	fi
}
# takes (directory, file) creates a symlink
create_link () {
	ln -s "$HOME/dotfiles/$2" "$1/$2"
}
# takes (directory, file), tries to link
link_dotfile () {
if file_exists "$1/$2"; then
	printf "Warning - $2 already exists - skipping\n"
else
	create_link "$1" "$2"
	printf "Success - created $2\n"
fi
}
link_dotfile "$HOME" ".zshrc"
link_dotfile "$HOME/.config/nvim" "init.vim"
