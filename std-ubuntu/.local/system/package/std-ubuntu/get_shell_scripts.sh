#!/bin/bash

set -e

if ! [ -d ~/local/shell ]; then
  mkdir -p ~/local/shell
fi

cd ~/local/shell

if ! [ -e git-prompt.sh ]; then
  echo "Downloading git-prompt.sh ..."
  wget https://github.com/git/git/raw/master/contrib/completion/git-prompt.sh
fi

if ! [ -e quitcd.bash_sh_zsh ]; then
  echo "Downloading quitcd.bash_sh_zsh ..."
  wget https://github.com/jarun/nnn/raw/master/misc/quitcd/quitcd.bash_sh_zsh
fi
