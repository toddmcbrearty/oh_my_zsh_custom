GG_COMMON_VERSION_CACHE=""

function laravel_prompt_info() {
  if [ -f artisan ]; then
  version=$(get_cached_gg_common_version)

    echo "
|  %{$fg[red]%}$(php artisan --version | sed -e 's/Laravel Installer Version //')%{$reset_color%} "
  fi
}

function gg_common_version_prompt_info() {
  version=$(get_cached_gg_common_version)
  if [[ "$version" != "0" ]]; then
    echo "
|  %{$fg[green]%}GG-Common: $version%{$reset_color%} "
  fi
}

function get_cached_gg_common_version() {
  if [[ -z "$GG_COMMON_VERSION_CACHE" ]]; then
    GG_COMMON_VERSION_CACHE=$(gg_common_version)
  fi
  echo "$GG_COMMON_VERSION_CACHE"
}
