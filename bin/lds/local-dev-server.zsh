#!/bin/zsh

# Don't forget to chmod +x this script
export LOCAL_DEV_PATH="$HOME/Code/giftogram/local-dev"
export REACT_PATH="$LOCAL_DEV_PATH/gg-react"
export GGAPI_PATH="$LOCAL_DEV_PATH/gg-api"
export ORDERSITE_PATH="$LOCAL_DEV_PATH/giftogram-order-site/dev/api"
export COMMON_PATH="$LOCAL_DEV_PATH/gg-common"
export ADMIN_PATH="$LOCAL_DEV_PATH/giftogram-admin/site"
export REPOS=("$GGAPI_PATH" "$REACT_PATH" "$ORDERSITE_PATH" "$COMMON_PATH" "$ADMIN_PATH")
export COMMAND_TO_RUN
export PARAMETER1
# Change this to whatever you want it to be
export LDS_SESSION_NAME="gg_dev_session"

SCRIPT_PATH=$(readlink -f "$0")
LDS_SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

# Load in all the functions
source "$LDS_SCRIPT_DIR/functions.zsh"

autoload -U colors && colors

# show help
if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
  show_help
fi

# this allows the sourced files to read the parameters
COMMAND_TO_RUN="$1"
PARAMETER1="$2"

source "$LDS_SCRIPT_DIR/make.zsh"
source "$LDS_SCRIPT_DIR/attach.zsh"
source "$LDS_SCRIPT_DIR/kill.zsh"
source "$LDS_SCRIPT_DIR/truncate.zsh"
source "$LDS_SCRIPT_DIR/restart.zsh"
source "$LDS_SCRIPT_DIR/git.zsh"
source "$LDS_SCRIPT_DIR/create-session.zsh"
source "$LDS_SCRIPT_DIR/choose-action.zsh"
