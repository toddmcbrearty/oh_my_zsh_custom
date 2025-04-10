if [[ "$1" == "giftogram-order-site" || "$1" == "ordersite" || "$1" == "order" ]]; then
  code_dir="$ROOT_CODE_DIR/giftogram-order-site/dev/api"
fi

if [[ "$1" == "api" ]]; then
  code_dir="$ROOT_CODE_DIR/gg-api"
fi

if [[ "$1" == "giftogram-admin" || "$1" == "admin" ]]; then
  code_dir="$ROOT_CODE_DIR/giftogram-admin/site"
fi
