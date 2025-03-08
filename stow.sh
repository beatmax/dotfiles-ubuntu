#!/bin/bash

set -e
DIR="$(readlink -f $(dirname "$0"))"

cd

packages=$(cat $DIR/stow-packages.txt)

for p in $packages; do
  if [[ -x $DIR/$p/.local/system/package/$p/pre-stow.sh ]]; then
    $DIR/$p/.local/system/package/$p/pre-stow.sh
  fi
  for i in $(find $DIR/$p -mindepth 1 -maxdepth 1 -type f -printf "%P\n"); do
    if [ -f $i -a \! -L $i ]; then
      mv $i $i.orig
      echo "NOTE: ~/$i moved to ~/$i.orig"
    fi
  done
done

cd "$DIR"
stow $packages
