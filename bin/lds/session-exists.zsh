#!/bin/zsh

if tmux has-session -t "$LDS_SESSION_NAME":0 2>/dev/null; then
  echo "$fg[082]This session already exists. Would you like to attach to it? [n/Y]${reset_color}"
  read -r attach

  if [[ "$attach" == "" || "$attach" == "Y" || "$attach" == "Y" ]]; then
    echo "Attaching $LDS_SESSION_NAME"
    attach_to_session
  fi

  exit 0
fi
