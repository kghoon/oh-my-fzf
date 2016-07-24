# fd - cd to selected directory
fd() {
	local dir
	dir=$(find ${1:-*} -path '*/\.*' -prune \
		-o -type d -print 2> /dev/null | fzf +m) &&
		cd "$dir"
}

# fda - including hidden directories
fda() {
	local dir
	dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# fdr - cd to selected parent directory
fdr() {
	local declare dirs=()
	get_parent_dirs() {
		if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
		if [[ "${1}" == '/' ]]; then
			for _dir in "${dirs[@]}"; do echo $_dir; done
		else
			get_parent_dirs $(dirname "$1")
		fi
	}
	local DIR=$(get_parent_dirs $(realpath "${1:-$(pwd)}") | fzf-tmux --tac)
	cd "$DIR"
}

# cdf - cd into the directory of the selected file
cdf() {
	local file
	local dir
	file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

