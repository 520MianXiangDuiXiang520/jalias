#!/bin/bash

PATH=$PATH:$JAliasBin
mkdir -p $JAliasStorePath

global_compreply=($(_jalias __JAliasKeys))
_jalias_completions() {

    declare -a files
    files+=("${global_compreply[@]}")
    cur="${COMP_WORDS[COMP_CWORD]}"

    prefix_path="${cur%/*}"

    dir="$(_jalias "$prefix_path")"
    if [ -e "$dir" ]; then
        for file in "$dir"/*; do
            name=$(basename "$file")
            if [ -d "$file" ]; then
                files+=("$prefix_path/$name/")
            else
                files+=("$prefix_path/$name")
            fi
        done
    fi

    tmp=$(printf '%s\n' "${files[@]}")
    # shellcheck disable=SC2207
    COMPREPLY=($(compgen -W "$tmp" -- "$cur"))
}
complete -F _jalias_completions -o nospace jalias

function jalias() {
    # `jalias proj` such as `jalias cd proj`
    # if [ $# -eq 1 ]; then
    #     output="$(_jalias "$@")"
    #     eval "cd $output"
    # else

    # fi

    common=$1
    shift
    case "${common}" in
    "+" | "add")
        _jalias "$common" "${1}" "$(pwd)"
        ;;
    "-" | "del")
        _jalias "$common" "${1}"
        ;;
    "l")
        _jalias "__JAliasKeys"
        ;;
    "clean")
        _jalias "__JAliasClean"
        ;;
    *)
        output=""
        if [ $# -eq 0 ]; then
            pp=$common
            common="cd"
            output="$(_jalias "$pp")"
        else
            output="$(_jalias "$@")"
        fi
        eval "$common $output"
        ;;
    esac
}
