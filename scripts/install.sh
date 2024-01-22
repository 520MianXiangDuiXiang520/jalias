#!/bin/bash

# rename _jalias
os=$(uname -s | awk '{print tolower($0)}')
arch=$(uname -m | awk '{print tolower($0)}')
if [ -f "$(pwd)/bin/_jalias_${os}_${arch}" ]; then
    mv "$(pwd)/bin/_jalias_${os}_${arch}" "$(pwd)/bin/_jalias"
fi

# sh_type=""
rc_file=""

case $SHELL in
*bash*)
    # sh_type="bash"
    rc_file=~/.bashrc
    ;;
*zsh*)
    # sh_type="zsh"
    rc_file=~/.zshrc
    ;;
*)
    echo "Unsupported shell types"
    ;;
esac

{
    echo "export JAliasStorePath=~/.jalias"
    echo "export JAliasSrc=$(pwd)"
    echo "export JAliasBin=$(pwd)/bin"
    echo "source $(pwd)/scripts/jalias.sh"
} >>"$rc_file"

# shellcheck disable=SC1090
source "$rc_file"

