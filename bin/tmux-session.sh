#!/bin/bash

# Don't forget to chmod +x this script
LOCAL_DEV_PATH="$HOME/Code/giftogram/local-dev"
REACT_PATH="$LOCAL_DEV_PATH/gg-react"
GGAPI_PATH="$LOCAL_DEV_PATH/gg-api"
ORDERSITE_PATH="$LOCAL_DEV_PATH/giftogram-order-site/dev/api"
COMMON_PATH="$LOCAL_DEV_PATH/gg-common"
ADMIN_PATH="$LOCAL_DEV_PATH/giftogram-admin/site"

SESSION_NAME="gg_dev_session"

function show_help() {
  echo "Usage: $0 [options]"
  echo ""
  echo "Parameters:"
  echo "  make          Run a make command from local-dev"
  echo ""
  echo "Options:"
  echo "  -k            Kill the react and admin processes and terminate the tmux session."
  echo "  -a            Attach to the existing tmux session."
  echo "  -h, --help    Display this help message and exit."
  echo ""
  echo "Description:"
  echo "This script manages a tmux session for local development."
  echo "It can create sessions, attach to them, kill running processes, or terminate the session entirely."
  echo ""
  echo "Default Behavior:"
  echo "If no flag is passed, the script will check whether the session exists:"
  echo "  - If it exists, it will prompt to attach to it."
  echo "  - If it doesn't exist, it will create a new session with the predefined structure."
  exit 0
}

function kill_react() {
  tmux send-keys -t "$SESSION_NAME":0 "sudo fuser -k 3000/tcp" C-m
}
function start_react() {
  tmux send-keys -t "$SESSION_NAME":0 "cd $LOCAL_DEV_PATH && make shell-into-gg-react" C-m
  tmux send-keys -t "$SESSION_NAME":0 "npm run dev" C-m
}

function kill_admin() {
  tmux send-keys -t "$SESSION_NAME":0.1 "sudo fuser -k 3000/tcp" C-m
}
function start_admin() {
  tmux send-keys -t "$SESSION_NAME":0.1 "cd $LOCAL_DEV_PATH && make shell-into-gg-admin" C-m
  tmux send-keys -t "$SESSION_NAME":0.1 "npm run build" C-m
}

function attach_to_session() {
  tmux attach -t "$SESSION_NAME":0
  exit 0
}

if [[ "$1" == "-h" || "$1" == "help" ]]; then
  show_help
fi

if [[ "$1" == 'truncate' ]]; then
  if [[ "$2" == 'api' ]]; then
    truncate -s 0 "$LOCAL_DEV_PATH/gg-api/storage/logs/laravel.log"
    exit 0
  fi
  if [[ "$2" == 'ordersite' || "$2" == "os" ]]; then
    truncate -s 0 "$LOCAL_DEV_PATH/giftogram-order-site/dev/api/storage/logs/laravel.log"
    exit 0
  fi
  if [[ "$2" == 'admin' ]]; then
    truncate -s 0 "$LOCAL_DEV_PATH/giftogram-admin/site/storage/logs/laravel.log"
    exit 0
  fi

  if [[ "$2" == 'all' ]]; then
    truncate -s 0 "$GGAPI_PATH/storage/logs/laravel.log"
    truncate -s 0 "$ORDERSITE_PATH/storage/logs/laravel.log"
    truncate -s 0 "$ADMIN_PATH/storage/logs/laravel.log"
    exit 0
  fi

  echo "Invalid log passed"
  exit 1
fi

if [[ "$1" == 'make' ]]; then
  cd "$LOCAL_DEV_PATH" && make "$2"
  exit 0
fi

if [[ "$1" == "-k" || "$1" == 'kill' ]]; then
  echo "Killing react"
  kill_react
  echo "Killing admin"
  kill_admin
  echo "Killing session"
  tmux kill-session -t "$SESSION_NAME"
  exit 0
fi

if [[ "$1" == "-a" || "$1" == 'attach' ]]; then
  attach_to_session
fi


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

#Checks all out base projects to chosen branch
if [[ "$1" == "checkout" || "$1" == "--c" ]]; then
  if [[ "$2" == "" ]]; then
    echo "Pass a branch fella..."
    exit 1
  fi

  echo "Checking out branch $2"
  git -C "$GGAPI_PATH" status
  exit 0
fi



#DO NOT ADD ANY MORE PARAMETER OPTIONS AFTER THIS
# an unknown argument was passed
if [[ "$1" != "" ]]; then
  echo "Param not recognized: $1"
  show_help
fi

if tmux has-session -t "$SESSION_NAME":0 2>/dev/null; then
  echo "This session already exists. Would you like to attach to it? [n/Y]"
  read -r attach

  if [[ "$attach" == "" || "$attach" == "Y" || "$attach" == "Y" ]]; then
    echo "Attaching $SESSION_NAME"
    attach_to_session
  fi

  exit 0
fi

#IF YOU'VE MADE IT THIS FAR THEN WE'LL CREATE THE SESSION

# Start a new detached tmux session named "$SESSION_NAME" window name Frontends
tmux new-session -d -s "$SESSION_NAME" -n "Frontends"

# React Tab
start_react
# Admin Tab
tmux split-window -v -t "$SESSION_NAME":0 # Split horizontally on the first tab
start_admin

# Start a new detached tmux session named "$SESSION_NAME" window name Backends
tmux new-window -t "$SESSION_NAME" -n "Backends"

# Api Tab
tmux send-keys -t "$SESSION_NAME":1 "cd $LOCAL_DEV_PATH && make shell-into-gg-api" C-m
tmux send-keys -t "$SESSION_NAME":1 "composer install" C-m

# Ordersite Tab
tmux split-window -v -t "$SESSION_NAME":1 # Split horizontally in the second tab
tmux send-keys -t "$SESSION_NAME":1.1 "cd $LOCAL_DEV_PATH && make shell-into-gg-order-site" C-m
tmux send-keys -t "$SESSION_NAME":1.1 "composer install" C-m

# Start a new detached tmux session named "$SESSION_NAME" window name Logs
tmux new-window -t "$SESSION_NAME" -n "Logs"

# Api Tab
tmux send-keys -t "$SESSION_NAME":2 "cd $LOCAL_DEV_PATH/gg-log-viewer && php artisan serve" C-m

# Attach to the session
attach_to_session
