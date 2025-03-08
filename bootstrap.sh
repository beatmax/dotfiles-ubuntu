#!/bin/bash

set -e

sudo apt install stow

~/dotfiles/stow.sh
~/.local/bin/local-system-apply.sh
