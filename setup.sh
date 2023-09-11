#!/usr/bin/env bash
set -x

sudo apt update 
sudo apt install -y git software-properties-common \
    vim \
    tmux \
    htop \
    rubygems \
    tree \
    python3 \
    wget \
    gnupg \
    lsb_release \
    gawk

# TODO: Script is not idempotent because this is 
#   added to the files multiple times
# Setup dot files 
touch $HOME/.bashrc 
cat .bashrc >> $HOME/.bashrc

touch $HOME/.tmux.conf
cat .tmux.conf >> $HOME/.tmux.conf

# Install vscode
. ./vscode/install.sh
install_vscode

# Install zeal 
. ./setup/install.sh
install_zeal