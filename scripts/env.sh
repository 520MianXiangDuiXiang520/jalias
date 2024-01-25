#!/bin/bash

function find_var {
    prefix=$1
    env_name=$2
    file=$3
    grep "^$prefix $env_name=" "$file" | awk -F= '{print $2}' | tr -d '"' | tr -d ' '
}

function find_env {
    find_var export "$1" "$2"
}

function del_var() {
    prefix=$1
    env_name=$2
    file=$3
    sed -i .bak "s/$prefix $env_name=.*$//g" "$file"
}

function del_env() {
    del_var export "$1" "$2"
}

function check_and_set_var() {
    prefix=$1
    env_name=$2
    env_value=$3
    file=$4
    cur_value=$(find_env "$env_name" "$file")
    if [[ -z $cur_value ]]; then
        echo "$prefix $env_name=""$env_value""" >>"$file"
    elif [[ "$cur_value" != "$env_value" ]]; then
        del_var "$prefix" "$env_name" "$file"
        echo "$prefix $env_name=""$env_value""" >>"$file"
    fi
}

function check_and_set_env() {
    check_and_set_var export "$1" "$2" "$3"
}

function shell_rc_file() {
    case $SHELL in
    *bash*)
        # sh_type="bash"
        echo ~/.bashrc
        ;;
    *zsh*)
        # sh_type="zsh"
        echo ~/.zshrc
        ;;
    *)
        echo "Unsupported shell types"
        ;;
    esac
}
