#!/bin/bash

set -e

WORKSPACE="$HOME"/workspace
DOTPATH="$WORKSPACE"/dotfiles; export DOTPATH
DOTFILES_GITHUB="https://github.com/syouit523/dotfiles.git"; export DOTFILES_GITHUB

make_workspace () {
  if [ ! -d "$WORKSPACE" ];then
    mkdir "$WORKSPACE"
  fi
}

download_dotfiles () {
  if [ ! -d "$DOTPATH" ];then
    git clone "$DOTFILES_GITHUB" "$DOTPATH"
  fi
}

deploy_dotfiles () {
  . "$DOTPATH"/scripts/deploy.sh
}

initialize () {
  . "$DOTPATH"/scripts/initialize.sh
}

main () {
  make_workspace
  if [ -x "$(which curl)" ] && [ -x "$(which git)" ]; then
    download_dotfiles && deploy_dotfiles && initialize
  else
    echo "Please install dependencies: ('git', 'curl')"
    exit 1
  fi
}

main
