#!/usr/bin/env bash
set -x

function install_zeal {
    sudo apt -y install zeal wmctrl xdotool 
    sudo gem install wmctile

    # TODO: Setup zeal shortcut
    # https://stackoverflow.com/questions/3247412/how-do-i-create-keyboard-shortcuts-programmatically-in-kde
}