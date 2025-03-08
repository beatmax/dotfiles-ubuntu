#!/bin/bash

set -e

if [[ $UID == 0 ]]; then
  echo >&2 "ERROR: Do not run as root."
  exit 1
fi

~/.local/system/apply.sh "$@"
