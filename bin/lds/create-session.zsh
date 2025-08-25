#!/bin/zsh

if [[ "$COMMAND_TO_RUN" == 'new' ]]; then
  # if the session exists we'll never go past this source
  source "$LDS_SCRIPT_DIR/session-exists.zsh"

  #IF YOU'VE MADE IT THIS FAR THEN WE'LL CREATE THE SESSION
  # Start a new detached tmux session named "$LDS_SESSION_NAME" window name Frontends
  tmux new-session -d -s "$LDS_SESSION_NAME" -n "Frontends"

  # React Tab
  start_react
  # Admin Tab
  tmux split-window -v -t "$LDS_SESSION_NAME":0 # Split horizontally on the first tab
  start_admin

  # Start a new detached tmux session named "$LDS_SESSION_NAME" window name Backends
  tmux new-window -t "$LDS_SESSION_NAME" -n "Backends"

  # Api Tab
  tmux send-keys -t "$LDS_SESSION_NAME":1 "cd $LOCAL_DEV_PATH && make shell-into-gg-api" C-m
  tmux send-keys -t "$LDS_SESSION_NAME":1 "composer install" C-m

  # Ordersite Tab
  tmux split-window -v -t "$LDS_SESSION_NAME":1 # Split horizontally in the second tab
  tmux send-keys -t "$LDS_SESSION_NAME":1.1 "cd $LOCAL_DEV_PATH && make shell-into-gg-order-site" C-m
  tmux send-keys -t "$LDS_SESSION_NAME":1.1 "composer install" C-m

  # Start a new detached tmux session named "$LDS_SESSION_NAME" window name Logs
  tmux new-window -t "$LDS_SESSION_NAME" -n "Logs"

  # Api Tab
  tmux send-keys -t "$LDS_SESSION_NAME":2 "cd $LOCAL_DEV_PATH/gg-log-viewer && php artisan serve" C-m

  # Attach to the session
  attach_to_session
fi
