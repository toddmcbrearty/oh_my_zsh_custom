#!/bin/zsh

# updates all git repos
if [[ "$COMMAND_TO_RUN" == "pull" ]]; then
    for repo in "${REPOS[@]}"; do
      REPO_NAME=$(get_repo_name "$repo")

      git -C "$repo" pull
      echo "$REPO_NAME updated."
    done
    exit 0
fi

#Checks all out base projects to chosen branch
if [[ "$COMMAND_TO_RUN" == "checkout" ]]; then
  if [[ "$PARAMETER1" == "" ]]; then
    echo "Pass a branch fella..."
    exit 1
  fi

  for repo in "${REPOS[@]}"; do
    REPO_NAME=$(get_repo_name "$repo")

    GIT_STATUS=$(git -C "$repo" status --porcelain --untracked-files=no)

    if [[ "${GIT_STATUS[0]}" != "" ]]; then
      echo "\n$fg[red]$GGAPI_PATH has changes that need to be commited.${reset_color}"
    else
      BRANCH="$PARAMETER1"

      if [[ "$repo" == "$COMMON_PATH" && "$PARAMETER1" == 'master' ]]; then
        BRANCH="main"
      fi

      git -C "$repo" checkout "$BRANCH"
      echo  "$REPO_NAME is now at branch $BRANCH"
      echo ""
    fi
  done
  exit 0
fi
