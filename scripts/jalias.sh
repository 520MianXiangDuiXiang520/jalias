#!/bin/bash
export JAliasStorePath=~/.jalias
mkdir -p $JAliasStorePath

sh_type=""

case $SHELL in  
    *bash*)  
        sh_type="bash"
        ;;  
    *zsh*)  
        sh_type="zsh"
        ;;  
    *fish*)  
        sh_type="fsh" 
        ;;   
    *)  
        echo "Unsupported shell types"  
        ;;  
esac

# shellcheck source=jalias/jalias.sh
# shellcheck disable=SC1091
source "./scripts/jalias.$sh_type.sh"

