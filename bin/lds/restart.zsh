#!/bin/zsh

if [[ "$COMMAND_TO_RUN" == 'restart' ]]; then
  lds -k
  lds make restart-all
  lds new
  exit 0
fi

if [[ "$COMMAND_TO_RUN" == "restart-js" ]]; then
  if [[ "$PARAMETER1" == "" ]]; then
    echo "$fg[red]You need to supply the node to restart${reset_color}"
    exit 1
  fi

  if [[ "$PARAMETER1" == "react" ]]; then
    kill_react
    start_react
    exit 0
  fi

  if [[ "$PARAMETER1" == "admin" ]]; then
    kill_admin
    start_admin
    exit 0
  fi

  echo "$fg[red]The node $2 does not exist.${reset_color}"
  exit 1
fi
