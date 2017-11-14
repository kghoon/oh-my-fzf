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
    [ -z $(which ag) ] && $SUDO apt-get install -y silversearcher-ag
}

[ "$(id -u)" == 0 ] || SUDO="sudo"

$SUDO apt-get update
$SUDO apt-get install -y curl
