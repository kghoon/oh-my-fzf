#!/bin/bash

function install_git()
{
    [ -z $(which git) ] && sudo yum install -y git
}

function install_moreutils()
{
    [ -z $(which ifne) ] && sudo yum install -y moreutils
}

function install_ag()
{
    if [ -z $(which ag) ]; then
        if [ "$(os_version)" -ge 7 ]; then
            sudo yum install -y epel-release.noarch the_silver_searcher
        else
            build_ag
        fi
    fi
}

function build_ag()
{
    sudo yum -y groupinstall "Development Tools"
    sudo yum -y install pcre-devel xz-devel
    git clone https://github.com/ggreer/the_silver_searcher.git ~/.ag && cd ~/.ag
    ./build.sh
    sudo make install
}
