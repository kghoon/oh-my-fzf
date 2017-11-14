# Ag - Search contents using silver searcher and open editor
Ag() {
    if [ -z "$(which ifne)" ]; then
        echo "Error: 'ifne' required. Install moreutils"
        return
    fi

    if [ -z "$(which ag)" ]; then
        echo "Error: 'ag' required. Install silver_searcher"
        return
    fi

    local result=$(ag --json --js --html --cc --cpp --java --xml --make --nogroup --column "$*" | ifne fzf --query="$*")
    if [ ! -z "$result" ]; then

        if [[ $result =~ ([^:]+):([0-9]+):([0-9]+):.+ ]]; then
            local filename="${BASH_REMATCH[1]}"
            local lineno="${BASH_REMATCH[2]}"

            vim +$lineno $filename
        fi
    fi
}
