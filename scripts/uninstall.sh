#!/bin/bash

# shellcheck source=/dev/null
source "$(pwd)/scripts/env.sh"

# remove cache
# shellcheck disable=SC2154
if [ -e "$JAliasStorePath" ]; then
    rm -rf "$JAliasStorePath"
    echo "clear $JAliasStorePath success!"
fi

# remove source path
# shellcheck disable=SC2154
if [ -e "$JAliasSrc" ]; then
    rm -rf "$JAliasSrc"
    echo "clear $JAliasSrc success!"
fi

rc_file="$(shell_rc_file)"

# unregister j alias
check=$(grep "alias j=jalias" "$rc_file")
if [ -n "$check" ]; then
    set -i "" "/^alias j=jalias/d" "$rc_file"
fi

# unregister env
# shellcheck disable=SC2154
check=$(grep "source $JAliasSrc/scripts/jalias.sh" "$rc_file")
if [ -n "$check" ]; then
    set -i "" "s/^source $JAliasSrc/scripts/jalias.sh//g" "$rc_file"
fi
del_env JAliasStorePath "$rc_file"
del_env JAliasSrc "$rc_file"
del_env JAliasBin "$rc_file"
echo "clean env success"

echo "by ~"
