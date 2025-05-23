ZSH_THEME="toddmcb"
#ZSH_THEME="afowler"

IAM=$(whoami)
if [[ "$IAM" == "$LOCAL_MACHINE_NAME" ]]; then
  plugins=(git gh brew laravel 1password docker docker-compose iterm2 macos npm npx zsh-syntax-highlighting zsh-autosuggestions)
else
  plugins=(git docker npm npx zsh-syntax-highlighting zsh-autosuggestions)
fi

ON_LOCAL=false
ON_REMOTE=false

if [[ "$IAM" == "$LOCAL_MACHINE_NAME" ]]; then
  ON_LOCAL=true
elif [[ "$IAM" == "$REMOTE_MACHINE_NAME" ]]; then
  ON_REMOTE=true
fi

export ON_LOCAL
export ON_REMOTE

if [[ -f "$ZSH_CUSTOM/env.zsh" ]]; then
  source "$ZSH_CUSTOM/env.zsh"
else
  echo "env.zsh not found.You'll need to create it now?"

  echo "Enter the path to the root code directory: "
  read -r root_code_dir
  root_code_dir=$(eval echo "$root_code_dir")

  if [[ ! -d "$root_code_dir" ]]; then
    echo "The directory does not exist. Please enter a valid directory."
    return
  fi

  echo "What is your preferred editor? (default: phpstorm)"
  read -r editor
  editor="${editor:-phpstorm}"

  echo "What is your local machine name, this must match the \`whoami\` command? (default: $IAM)"
  read -r local_name
  local_name="${local_name:-$IAM}"

  echo "What is your remote machine name, this must match the \`whoami\` command?"
  read -r remote_name

  touch "$ZSH_CUSTOM/env.zsh"
  echo "export ROOT_CODE_DIR=$root_code_dir
  export EDITOR=$editor
  export LOCAL_MACHINE_NAME=$local_name
  export REMOTE_MACHINE_NAME=$remote_name" >>"$ZSH_CUSTOM/env.zsh"

  source "$ZSH_CUSTOM/loader.zsh"
  echo "You're ready to go."
fi

export IAM="$IAM"
export ZSH_ALIASES="$ZSH_CUSTOM/aliases"
export ZSH_FUNCTIONS="$ZSH_CUSTOM/functions"
export FPATH="$ZSH_CUSTOM/functions:$FPATH"

autoload -U "$ZSH_FUNCTIONS"/*
autoload -U compinit
compinit

source "$ZSH_CUSTOM/completer.zsh"

source <(cd "$ZSH_CUSTOM/autocompletes" && cat ./*)

source <(cd "$ZSH_ALIASES" && cat ./*)
chmod +x <(cd "$ZSH_ALIASES" && cat ./*)
