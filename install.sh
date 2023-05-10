#!/usr/bin/env bash

set -P

OS=""
VER=""
PACKAGES_MISSING=""
PACKAGES=("neofetch" "tmux" "htop" "fish" "curl")
NEOVIM_STABLE="https://github.com/neovim/neovim/releases/download/stable/nvim.appimage"
NEOVIM_IMAGE="nvim.appimage"

check_package() {
    pkgs=()
    for package in $@; do
        if ! command -v  &> /dev/null; then
            pkgs+=("$i")
        fi
    done
    echo ${pkgs[@]}
}

configuration() {
    echo ">>> Backuping your folders <<<"
    mv ~/.config/htop ~/.config/htop.bak &> /dev/null
    mv ~/.config/nvim ~/.config/nvim.bak &> /dev/null
    mv ~/.config/tmux ~/.config/tmux.bak &> /dev/null
    mv ~/.config/fish ~/.config/fish.bak &> /dev/null

    echo ">>> Move configurations to ~/.config <<<"
    mv `pwd`/.config/htop ~/.config/
    mv `pwd`/.config/nvim ~/.config/
    mv `pwd`/.config/tmux ~/.config/
    mv `pwd`/.config/fish ~/.config/
}

install_neovim_from_github() {
    echo ">>> NEOVIM INSTALL FROM GITHUB <<<"
    curl -fsSL $NEOVIM_STABLE -o $IMAGE_NEOVIM
    echo "WIP"
}

if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
    ID=$ID_LIKE
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi

if [[ ${ID^^} -eq "DEBIAN" ]]; then
    echo ">>> UPDATE & UPGRADE SYSTEM <<<"
    sudo apt update -y && sudo apt upgrade -y

    echo ">>> INSTALL PACKAGES <<<"
    PACKAGES_MISSING=$(check_package ${PACKAGES[@]})
    sudo apt install ${PACKAGES_MISSING[@]} -y

    configuration
else
    echo ">>> ${OS^^} IS NOT IMPLEMENTED <<<"
fi
