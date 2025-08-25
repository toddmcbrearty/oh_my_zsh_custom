#!/bin/zsh

if [[ "$COMMAND_TO_RUN" == 'make' ]]; then
  if [[ -z "$PARAMETER1" ]]; then
    echo "$fg[red]Please pass a make command.${reset_color}"
    exit 1
  fi

  cd "$LOCAL_DEV_PATH" && make "$PARAMETER1"
  exit 0
fi
