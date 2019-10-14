#!/bin/bash

if [ -z "$DOTPATH" ]; then
  echo 'err: $DOTPATH not found';
  exit 1
fi


for dirname in $(find "$DOTPATH" -not -path '*/\.*' -mindepth 1 -maxdepth 1 -type d); do
  f="$dirname"/deploy.sh
  if [ -f "$f" ]; then
    if [ -x "$f" ]; then
    . "$dirname"/deploy.sh
    else
      echo "permission denied: $f"
      exit 1
    fi
  fi
done
