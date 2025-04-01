if [[ "$ON_LOCAL" == true ]] ; then
  ssh-add ~/.ssh/Prizelabs ~/.ssh/cloud9 ~/.ssh/git > /dev/null 2>&1
fi
