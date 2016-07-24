#!/bin/bash

# Directory bookmark with keyword
# -------------------------------
LINKHOME=$HOME/.bookmarks
[ -e $LINKHOME ] || mkdir -p $LINKHOME

to() {
    if [ -z $1 ]; then
        if [ "$(which fzf-tmux)" != "" ]; then
            _to_using_fzf
            return
        else
            _to_usage
            return 1
        fi
    fi

    if [ $1 = "-a" ]; then
        if [ -z $2 ]; then
            echo "target name is not specified!!"
            return 1
        else
            if [ ! -e $LINKHOME ]; then
                echo "Make directory = $LINKHOME"
                mkdir -p $LINKHOME
            fi

            echo "Set $PWD => $2";
            rm -f $LINKHOME/$2
            echo "$PWD" > $LINKHOME/$2
        fi
    elif [ $1 = "-d" ] && [ ! -z $2 ]; then
        if [ -f $LINKHOME/$2 ]; then
            echo "Remove bookmark $2"
            rm $LINKHOME/$2
        fi
    else
        if [ ! -e $LINKHOME/$1 ]; then
            _to_usage
            return 1
        else
            cd $(cat $LINKHOME/$1)
        fi
    fi
}

_to_using_fzf() {
    local dest=$(ls $LINKHOME | while read name; do printf "%20s => %s\n" $name $(cat $LINKHOME/$name); done | fzf-tmux)
    if [ ! -z "$dest" ]; then
        dest="$(echo $dest | awk '{print$1}')"
        cd $(cat $LINKHOME/$dest)
    fi
}

_to_usage() {
    echo ""
    echo "Directory bookmark utility"
    echo ""
    echo "usage : to [-a|-d] <target_name>"
    echo "   -a : add current directory to bookmarks with given name"
    echo "   -d : remove given name from bookmarks"
    echo ""
}

_to_complete()
{
    COMPREPLY=( $(compgen -W "$(ls $LINKHOME)" -- "${COMP_WORDS[COMP_CWORD]}") )
}
complete -F _to_complete to

