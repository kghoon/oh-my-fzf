#!/bin/bash

function __require()
{
    [ -z $(which brew) ] && 
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

function install_git()
{
    __require

    [ -z $(which git) ] &&
        brew install git
}

function install_moreutils()
{
    __require

    [ -z $(which ifne) ] &&
        brew install moreutils
}

function install_ag()
{
    __require

    [ -z $(which ag) ] &&
        brew install the_silver_searcher
}

