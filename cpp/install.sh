#!/usr/bin/env bash
set -x

function install_cpp {
    sudo apt install cmake ccache ninja-build nasm yasm
    source ./cpp/llvm.sh # ./cpp/llvm.sh?
}