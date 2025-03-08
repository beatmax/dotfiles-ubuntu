#!/bin/bash

set -e

./do_apply_pkg.sh "$@"

if [ -e package ]; then
  DIR="$PWD"
  for p in "$DIR"/package/*; do
    cd "$p"
    "$DIR/do_apply_pkg.sh" "$@"
  done
fi
