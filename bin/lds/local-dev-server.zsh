#!/bin/zsh

# Don't forget to chmod +x this script
LOCAL_DEV_PATH="$HOME/Code/giftogram/local-dev"
REACT_PATH="$LOCAL_DEV_PATH/gg-react"
GGAPI_PATH="$LOCAL_DEV_PATH/gg-api"
ORDERSITE_PATH="$LOCAL_DEV_PATH/giftogram-order-site/dev/api"
COMMON_PATH="$LOCAL_DEV_PATH/gg-common"
ADMIN_PATH="$LOCAL_DEV_PATH/giftogram-admin/site"

autoload -U colors && colors

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

source ./make.zsh
source ./attach.zsh
source ./kill.zsh
source ./truncate.zsh
source ./restart.zsh
source ./git.zsh

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
source ./create-session.zsh
