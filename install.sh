#!/usr/bin/env bash

set -P

OS=""
VER=""
PACKAGES_MISSING=""
PACKAGES=("neofetch" "tmux" "htop" "fish" "curl" "git", "sqlite3")
NEOVIM_STABLE="https://github.com/neovim/neovim/releases/download/stable/nvim.appimage"
NEOVIM_IMAGE="nvim.appimage"
TMP_NVIM="/tmp/nvim"

check_package() {
    pkgs=()
    for package in $@; do
        if ! command -v $package &> /dev/null; then
            pkgs+=("$i")
        fi
    done
    echo ${pkgs[@]}
}

configuration() {
    echo ">>> BACKUPING YOUR CONFIGS <<<"
    mv ~/.config/htop ~/.config/htop.bak &> /dev/null
    mv ~/.config/nvim ~/.config/nvim.bak &> /dev/null
    mv ~/.config/tmux ~/.config/tmux.bak &> /dev/null
    mv ~/.config/fish ~/.config/fish.bak &> /dev/null

    echo ">>> MOVE FOLDERS TO ~/.config <<<"
    mv `pwd`/.config/htop ~/.config/
    mv `pwd`/.config/nvim ~/.config/
    mv `pwd`/.config/tmux ~/.config/
    mv `pwd`/.config/fish ~/.config/
}

install_neovim_from_github() {
    echo ">>> NEOVIM INSTALL FROM GITHUB <<<"
    mkdir $TMP_NVIM
    curl -fsSL $NEOVIM_STABLE -o $TMP_NVIM/$IMAGE_NEOVIM
    cd /tmp/nvim
    chmod u+x nvim.appimage
    ./nvim.appimage --appimage-extract &> /dev/null

    sudo mv ./squashfs-root/usr/bin/nvim          /usr/bin/
    sudo mv ./squashfs-root/usr/man/man1/nvim.1   /usr/share/man/man1/nvim.1.gz
    sudo mv ./squashfs-root/usr/lib/nvim          /usr/lib/
    sudo mv ./squashfs-root/usr/share/nvim        /usr/share/nvim

    if command -v nvim &> /dev/null; then
        echo ">>> NEOVIM STABLE VERSION INSTALLED WITH SUCCESSFULLY <<<"
    else
        echo ">>> ERROR INSTALLING NEOVIM STABLE VERSION <<<"
    fi
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

    install_neovim_from_github
    configuration
else
    echo ">>> ${OS^^} IS NOT IMPLEMENTED <<<"
fi
