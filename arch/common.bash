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

function update_vimrc() {

    abspath=$(abs-path $CWD)

    [ -z "$(grep '\.fzf' ~/.vimrc 2>/dev/null)" ] && cat >> ~/.vimrc <<EOF
set rtp+=~/.fzf
EOF
    [ -z "$(grep $abspath ~/.vimrc 2>/dev/null)" ] && cat >> ~/.vimrc <<EOF
set rtp+=$abspath
EOF
}

function os_name()
{
    if [ -f /etc/os-release ]; then
        cat /etc/os-release | egrep "^ID=" | sed "s/ID=//g"
    elif [ -f /etc/lsb-release ]; then
        cat /etc/lsb-release | egrep "^DISTRIB_ID=" | sed "s/DISTRIB_ID=//g"
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


