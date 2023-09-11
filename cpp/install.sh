#!/usr/bin/env bash
set -x

function install_cpp {
    sudo apt install -y cmake ccache ninja-build nasm yasm clangd-12
    source ./cpp/llvm.sh 16 # ./cpp/llvm.sh?
}