if [[ -f "$HOME/.oh-my-zsh/custom/env.zsh" ]]; then
  source "$HOME/.oh-my-zsh/custom/env.zsh"
fi

IAM=$(whoami)

export IAM="$IAM"
export ZSH_ALIASES="$ZSH_CUSTOM/aliases"
export ZSH_FUNCTIONS="$ZSH_CUSTOM/functions"
export FPATH="$ZSH_CUSTOM/functions:$FPATH"

autoload -U "$ZSH_FUNCTIONS"/*

# shellcheck source=$HOME/.oh-my-zsh/custom/aliases
source <(cd "$ZSH_ALIASES" && cat ./*)
chmod +x <(cd "$ZSH_ALIASES" && cat ./*)
