function laravel_prompt_info() {
  if [ -f artisan ]; then
    # shellcheck disable=SC1087
    echo "%{$fg[red]%}$(php artisan --version | sed -e 's/Laravel Installer Version //')%{$reset_color%} "
  fi
}
