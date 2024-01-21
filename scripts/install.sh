#!/bin/bash

make build
# shellcheck source=/dev/null

echo "source $(pwd)/scripts/jalias.sh" >> ~/.zshrc
source ~/.zshrc