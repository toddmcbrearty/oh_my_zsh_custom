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
