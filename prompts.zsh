GG_COMMON_VERSION_CACHE=""

function node_version_prompt_info() {
  if [[ -f package.json ]]; then
    if [[ -f ./.nvmrc ]]; then
      version=$(cat ./.nvmrc)
    else
      return
    fi

    echo "
|  %{$FG[070]%}Required Node Version:%{$reset_color%} %{$FG[009]%}$version%{$reset_color%}"
  fi
}

function laravel_prompt_info() {
  composer_name=$(jq -r '.name' composer.json 2>/dev/null)
  if [[ -f artisan && ! -d './vendor' ]]; then
    echo "
|  %{$FG[166]%}Laravel Framework:%{$reset_color%} %{$FG[009]%}Not Installed%{$reset_color%} "
    return
  fi

  if [[ -f artisan && "$composer_name" != 'giftogram/gg-common' ]]; then
    laravel_version=$(php artisan --version)
    laravel_version="${laravel_version/Laravel Framework /}"
    echo "
|  %{$FG[166]%}Laravel Framework:%{$reset_color%} %{$FG[009]%}$laravel_version%{$reset_color%} "
  fi
}

function gg_common_version_prompt_info() {
  composer_name=$(jq -r '.name' composer.json 2>/dev/null)

  if [[ -d "./vendor" && -f artisan && "$composer_name" != 'giftogram/gg-common' ]]; then
    gg_common_package=$(jq -r '.require["giftogram/gg-common"]' composer.json 2>/dev/null)

    if [[ "$gg_common_package" ]]; then
      content=$(grep "\"giftogram/gg-common\":" "./composer.json")

      if [[ "$content" == "" ]]; then
        return
      fi

    fi

    version=$(get_cached_gg_common_version)
    if [[ "$version" != "0" ]]; then
      echo "
|  %{$FG[105]%}GG-Common:%{$reset_color%} %{$FG[009]%}$version%{$reset_color%} "
    fi
  fi
}

function get_cached_gg_common_version() {
  if [[ -z "$GG_COMMON_VERSION_CACHE" ]]; then
    GG_COMMON_VERSION_CACHE=$(gg_common_version)
  fi
  echo "$GG_COMMON_VERSION_CACHE"
}
