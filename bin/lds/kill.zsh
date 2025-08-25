#!/bin/zsh

if [[ "$COMMAND_TO_RUN" == "-k" || "$COMMAND_TO_RUN" == 'kill' ]]; then
  echo "$fg[green]Stopping react${reset_color}"
  kill_react > /dev/null 2>&1

  echo "$fg[green]Stopping admin${reset_color}"
  kill_admin> /dev/null 2>&1

  echo "$fg[green]Killing session${reset_color}"
  tmux kill-session -t "$LDS_SESSION_NAME"> /dev/null 2>&1

  exit 0
fi
