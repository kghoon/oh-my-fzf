#!/bin/bash

function install_git()
{
    [ -z $(which git) ] && $SUDO apt-get install -y git
}

function install_moreutils()
{
    [ -z $(which ifne) ] && $SUDO apt-get install -y moreutils
}

function install_ag()
{
    if [ -z $(which ag) ]; then

        $SUDO apt-get install -y bc
        local os_ver="$(os_version)"
        if [ "$(echo \"$os_ver >= 13.10\" | bc)" = "1" ]; then
            $SUDO apt-get install -y silversearcher-ag
        else
            build_ag
        fi
    fi
}

function build_ag()
{
    $SUDO apt-get install -y build-essential automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev
    git clone https://github.com/ggreer/the_silver_searcher.git ~/.ag && cd ~/.ag
    ./build.sh
    $SUDO make install
}

[ "$(id -u)" == 0 ] || SUDO="sudo"

$SUDO apt-get update
$SUDO apt-get install -y curl
