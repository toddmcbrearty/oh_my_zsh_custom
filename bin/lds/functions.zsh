#!/bin/zsh

function show_help() {
  echo "Usage: $0 [options]"
  echo ""
  echo "Parameters:"
  echo "  make          Run a make command from local-dev."
  echo "  new           Start a new tmux session."
  echo "  attach        Attach a tmux session."
  echo "  kill          Kill a tmux session."
  echo "  restart       Restart all containers and the tmux session."
  echo "  restart-js    Restart nodejs servers."
  echo "  truncate      Truncates laravel.log files."
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
  exit 0
}

function kill_react() {
  tmux send-keys -t "$LDS_SESSION_NAME":0.0 "sudo fuser -k 3000/tcp" C-m
}
function start_react() {
  tmux send-keys -t "$LDS_SESSION_NAME":0.0 "cd $LOCAL_DEV_PATH && make shell-into-gg-react" C-m
  tmux send-keys -t "$LDS_SESSION_NAME":0.0 "npm run dev" C-m
}

function kill_admin() {
  tmux send-keys -t "$LDS_SESSION_NAME":0.1 "sudo fuser -k 3000/tcp" C-m
}
function start_admin() {
  tmux send-keys -t "$LDS_SESSION_NAME":0.1 "cd $LOCAL_DEV_PATH && make shell-into-gg-admin" C-m
  tmux send-keys -t "$LDS_SESSION_NAME":0.1 "npm run build" C-m
}

function attach_to_session() {
  tmux attach -t "$LDS_SESSION_NAME":0
  exit 0
}

function get_repo_name() {
   local repo="$1"  # The first argument is the repository path
   local REPO_NAME=""

   # Ensure the repo path is normalized for comparison
   repo=$(realpath "$repo") 2>/dev/null

   case "$repo" in
     $(realpath $GGAPI_PATH))
       REPO_NAME="GGAPI"
       ;;
     $(realpath "$REACT_PATH"))
       REPO_NAME="GGReact"
       ;;
     $(realpath "$ORDERSITE_PATH"))
       REPO_NAME="Ordersite"
       ;;
     $(realpath "$COMMON_PATH"))
       REPO_NAME="GGCommon"
       ;;
     $(realpath "$ADMIN_PATH"))
       REPO_NAME="GGAdmin"
       ;;
     *)
       echo "Unknown repository path: $repo"
       return 1
       ;;
   esac

   echo "$REPO_NAME"
}
