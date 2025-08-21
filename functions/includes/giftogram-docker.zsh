bundle_dir="$ROOT_CODE_DIR/giftogram/local-dev"

if [[ "$1" == "giftogram-order-site" || "$1" == "ordersite" || "$1" == "order" ]]; then
  code_dir="$bundle_dir/giftogram-order-site/dev/api"
fi

if [[ "$1" == "api" || "$1" == "ggapi" ]]; then
  code_dir="$bundle_dir/gg-api"
fi

if [[ "$1" == "common" || "$1" == "ggcommon" ]]; then
  code_dir="$bundle_dir/gg-common"
fi

if [[ "$1" == "giftogram-admin" || "$1" == "admin" ]]; then
  code_dir="$bundle_dir/giftogram-admin/site"
fi

if [[ "$1" == "react" || "$1" == "frontend" ]]; then
  code_dir="$bundle_dir/gg-react"
fi
