#!/bin/bash

set -e

cd "$(dirname "$0")"

OPT=0
APPLY_PKG_ARGS=""
if [[ "$1" == "--opt" ]]; then
  OPT=1
  APPLY_PKG_ARGS+=" --opt"
  shift
fi

./apply_pkg.sh $APPLY_PKG_ARGS

if [ -e package ]; then
  DIR="$PWD"
  for p in "$DIR"/package/*; do
    pushd "$p" > /dev/null
    if [[ -x post-apply.sh ]]; then
      ./post-apply.sh
    fi
    popd > /dev/null
  done
fi

if (( ! OPT )); then
  ./apply_pkg.sh --list --opt
fi
