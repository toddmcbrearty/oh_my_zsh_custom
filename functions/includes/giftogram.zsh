bundle_dir="$ROOT_CODE_DIR/giftogram"

if [[ "$1" == "giftogram-order-site" || "$1" == "ordersite" || "$1" == "order" ]]; then
  code_dir="$bundle_dir/ordersite/dev/api"
fi

if [[ "$1" == "api" ]]; then
  code_dir="$bundle_dir/api"
fi

if [[ "$1" == "common" ]]; then
  code_dir="$bundle_dir/common"
fi

if [[ "$1" == "giftogram-admin" || "$1" == "admin" ]]; then
  code_dir="$bundle_dir/admin/site"
fi

if [[ "$1" == "react" || "$1" == "frontend" ]]; then
  code_dir="$bundle_dir/frontend"
fi
