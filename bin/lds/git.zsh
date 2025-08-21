#!/bin/zsh
REPOS=("$GGAPI_PATH" "$REACT_PATH" "$ORDERSITE_PATH" "$COMMON_PATH" "$ADMIN_PATH")

function get_repo_name() {
   local repo="$1"  # The first argument is the repository path
   local REPO_NAME=""

   # Ensure the repo path is normalized for comparison
   repo=$(realpath "$repo") 2>/dev/null

   case "$repo" in
     $(realpath $GGAPI_PATH))
       REPO_NAME="GGAPI"
       ;;
     $(realpath "$REACT_PATH"))
       REPO_NAME="GGReact"
       ;;
     $(realpath "$ORDERSITE_PATH"))
       REPO_NAME="Ordersite"
       ;;
     $(realpath "$COMMON_PATH"))
       REPO_NAME="GGCommon"
       ;;
     $(realpath "$ADMIN_PATH"))
       REPO_NAME="GGAdmin"
       ;;
     *)
       echo "Unknown repository path: $repo"
       return 1
       ;;
   esac

   echo "$REPO_NAME"
}

# updates all git repos
if [[ "$1" == "pull" || "$1" == "-p" ]]; then
    for repo in "${REPOS[@]}"; do
      REPO_NAME=$(get_repo_name "$repo")

      git -C "$repo" pull
      echo "$REPO_NAME updated."
    done
    exit 0
fi

#Checks all out base projects to chosen branch
if [[ "$1" == "checkout" || "$1" == "-c" ]]; then
  if [[ "$2" == "" ]]; then
    echo "Pass a branch fella..."
    exit 1
  fi

  for repo in "${REPOS[@]}"; do
    REPO_NAME=$(get_repo_name "$repo")

    GIT_STATUS=$(git -C "$repo" status --porcelain --untracked-files=no)

    if [[ "${GIT_STATUS[0]}" != "" ]]; then
      echo "\n$fg[red]$GGAPI_PATH has changes that need to be commited.${reset_color}"
    else
      BRANCH="$2"

      if [[ "$repo" == "$COMMON_PATH" && "$2" == 'master' ]]; then
        BRANCH="main"
      fi

      git -C "$repo" checkout "$BRANCH"
      echo  "$REPO_NAME is now at branch $BRANCH"
      echo ""
    fi
  done
  exit 0
fi
