#!/bin/bash

function abs-path()
{
    cd $1; pwd; cd - >/dev/null
}

function install_fzf()
{
    if [ -z $(which fzf) ]; then
        echo "Install fzf ..."
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --key-bindings --completion --update-rc
    fi
}

function update_bashrc()
{
    abspath=$(abs-path $CWD)

    cat > ~/.oh-my-fzf.bash  <<EOF
CWD=$abspath
for script_file in \$(ls \$CWD/bash/*.bash 2>/dev/null); do
    . \$script_file
done
EOF

    [ -z "$(grep 'oh-my-fzf.bash' ~/.bashrc)" ] && cat >> ~/.bashrc <<EOF
[ -f ~/.oh-my-fzf.bash ] && . ~/.oh-my-fzf.bash
EOF
}

function update_vimrc()
{
    abspath=$(abs-path $CWD)

    [ -z "$(grep '\.fzf' ~/.vimrc 2>/dev/null)" ] && cat >> ~/.vimrc <<EOF
set rtp+=~/.fzf
EOF
    [ -z "$(grep $abspath ~/.vimrc 2>/dev/null)" ] && cat >> ~/.vimrc <<EOF
set rtp+=$abspath
EOF
}

function update_tmux()
{
    abspath=$(abs-path $CWD)

    if [ "$PLATFORM" == "Darwin" ]; then
        cp $abspath/plugin/tmux.conf ~/.tmux.conf
    else
        tmux source-file $abspath/plugin/tmux.conf
    fi
}

function os_name()
{
    if [ -f /etc/os-release ]; then
        cat /etc/os-release | egrep "^ID=" | sed "s/ID=//g"
    elif [ -f /etc/lsb-release ]; then
        cat /etc/lsb-release | egrep "^DISTRIB_ID=" | sed "s/DISTRIB_ID=//g"
    elif [ -f /etc/centos-release ]; then
        cat /etc/centos-release | awk '{print $1}' | tr "[:upper:]" "[:lower:]"
    else
        echo "unknown"
    fi
}

function os_version()
{
    if [ -f /etc/os-release ]; then
        cat /etc/os-release | egrep "^VERSION_ID=" | sed "s/VERSION_ID=//g"
    elif [ -f /etc/lsb-release ]; then
        cat /etc/lsb-release | egrep "^DISTRIB_RELEASE=" | sed "s/DISTRIB_RELEASE=//g"
    else
        echo "unknown"
    fi
}

function _usage()
{
    cat << EOF
usage: $0 [OPTIONS]
   --d          Verbose
   --help       Show this message
EOF
}

function _banner()
{
    case $1 in
        "hi")
            cat << EOF
   ___           _        _ _  
  |_ _|_ __  ___| |_ __ _| | |  $PLATFORM
   | || '_ \/ __| __/ _v | | |  $(abs-path $CWD)
   | || | | \__ \ || (_| | | |
  |___|_| |_|___/\__\__,_|_|_|

EOF
            ;;
        "bye")
            cat << EOF

 Good Bye!

EOF
            #sleep .5
            #kill -9 $PPID
            ;;
    esac
}

function _progress()
{
    func=$1
    name=$2
    spin='-\|/'
    i=0

    if [ $OPTION_VERBOSE -gt 0 -o "$name" == "vim"  ]; then
        $func &
    else 
        $func 1>/dev/null 2>&1 &
    fi
    pid=$!

    while kill -0 $pid 2>/dev/null
    do
        i=$(((i+1)%4))
        printf "\r[${spin:$i:1}] Update $2"
        sleep .1
    done

    echo " "
} 
