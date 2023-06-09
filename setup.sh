#!/usr/bin/env bash
set -x
sudo apt update 
sudo apt install -y vim tmux htop

# Setup dot files 
touch $HOME/.bashrc 
cat .bashrc >> $HOME/.bashrc

touch $HOME/.tmux.conf
cat .tmux.conf >> $HOME/.tmux.conf
