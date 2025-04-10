if [[ "$1" = 'c9' ]]; then
  command="cd /home/ubuntu/environment"

  if [[ "$2" == "api" ]]; then
    command="cd /home/ubuntu/environment/gg-api"
  fi

  if [[ "$2" == "admin" ]]; then
    command="cd /home/ubuntu/environment/giftogram-admin/site"
  fi

  if [[ "$2" == "ordersite" ]]; then
    command="cd /home/ubuntu/environment/giftogram-order-site/dev/api"
  fi

  subcommand="${@:2}"

  if [[ -n "$subcommand" ]]; then
    subcommand="&& source ~/.zshrc && ${subcommand[@]}"
  fi

  ssh c9 -t "$command $subcommand && zsh -i;"
fi
