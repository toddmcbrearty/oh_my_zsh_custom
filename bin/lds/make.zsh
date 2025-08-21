#!/bin/zsh

if [[ "$1" == 'make' ]]; then
  cd "$LOCAL_DEV_PATH" && make "$2"
  exit 0
fi
