#!/bin/bash

# shellcheck source=/dev/null
source "$(pwd)/scripts/env.sh"

# rename _jalias
os=$(uname -s | awk '{print tolower($0)}')
arch=$(uname -m | awk '{print tolower($0)}')
if [ -f "$(pwd)/bin/_jalias_${os}_${arch}" ]; then
    cp "$(pwd)/bin/_jalias_${os}_${arch}" "$(pwd)/bin/_jalias"
fi

# register env
rc_file="$(shell_rc_file)"
check_and_set_env JAliasStorePath ~/.jalias "$rc_file"
check_and_set_env JAliasSrc "$(pwd)" "$rc_file"
check_and_set_env JAliasBin "$(pwd)/bin" "$rc_file"

# register alias for jalias
check=$(alias j)
if [ -n "$check" ]; then
    echo "command \"j\" exists on system"
else
    echo "alias j=jalias" >>"$rc_file"
fi

# shellcheck disable=SC2154
check=$(grep "source $(pwd)/scripts/jalias.sh" "$rc_file")
if [ -z "$check" ]; then
    echo "source $(pwd)/scripts/jalias.sh" >>"$rc_file"
fi

# shellcheck disable=SC1090
source "$rc_file"
