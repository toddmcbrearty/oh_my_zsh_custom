#!/bin/zsh

function success() {
  echo "$fg[green]Log(s) have been truncated.${reset_color}"
  exit 0
}

if [[ "$COMMAND_TO_RUN" == 'truncate' ]]; then
  if [[ "$PARAMETER1" == 'api' ]]; then
    truncate -s 0 "$LOCAL_DEV_PATH/gg-api/storage/logs/laravel.log"
    success
  fi
  if [[ "$PARAMETER1" == 'ordersite' || "$PARAMETER1" == "os" ]]; then
    truncate -s 0 "$LOCAL_DEV_PATH/giftogram-order-site/dev/api/storage/logs/laravel.log"
    success
  fi
  if [[ "$PARAMETER1" == 'admin' ]]; then
    truncate -s 0 "$LOCAL_DEV_PATH/giftogram-admin/site/storage/logs/laravel.log"
    success
  fi

  if [[ "$PARAMETER1" == 'all' ]]; then
    truncate -s 0 "$GGAPI_PATH/storage/logs/laravel.log"
    truncate -s 0 "$ORDERSITE_PATH/storage/logs/laravel.log"
    truncate -s 0 "$ADMIN_PATH/storage/logs/laravel.log"
    success
  fi

  echo "$fg[red]Invalid log passed${reset_color}"
  exit 1
fi
