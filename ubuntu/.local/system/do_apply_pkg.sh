#!/bin/bash

set -e

LIST=0
OPT=0
if [[ "$1" == "--list" ]]; then
  LIST=1
  shift
fi
if [[ "$1" == "--opt" ]]; then
  OPT=1
  shift
  # TODO
  exit 0
fi

if [[ -e pkglist.txt ]]; then
  pkgs=$(comm -13 <(dpkg -l | grep '^.i' | awk '{ print $2 }' | cut -d: -f1 | sort | uniq) <(grep -v -e "^$" -e "^#" pkglist.txt | sort) | tr '\n' ' ')
  if [ "$pkgs" ]; then
    if (( $LIST )); then
      echo -e "\nNeeded packages: $pkgs"
    else
      echo -e "\nInstalling packages: $pkgs"
      sudo apt install $pkgs
    fi
  fi
fi
