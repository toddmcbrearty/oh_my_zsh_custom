if [[ "$1" == "-k" || "$1" == 'kill' ]]; then
  echo "Killing react"
  kill_react
  echo "Killing admin"
  kill_admin
  echo "Killing session"
  tmux kill-session -t "$SESSION_NAME"
  exit 0
fi
