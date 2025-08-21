if [[ "$1" == "restart-js" ]]; then
  if [[ "$2" == "" ]]; then
    echo "You need to supply the node to restart"
    exit 1
  fi

  if [[ "$2" == "react" ]]; then
    if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
      kill_react
    fi

    start_react
    exit 0
  fi

  if [[ "$2" == "admin" ]]; then
    if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
      kill_admin
    fi

    start_admin
    exit 0
  fi

  echo "The node $2 does not exist."
  exit 1
fi
