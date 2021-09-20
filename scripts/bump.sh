#!/bin/bash

set -euo pipefail

version=$1
category=$2
error=20

case $category in
  major) bump=1;;
  minor) bump=2;;
  patch) bump=3;;
  *) exit $error
esac

IFS=.
cursor=0

for category in `echo "$version" | sed -Ee 's/^v/v./'`; do
  ((error+=1))

  if [[ $category == v ]]; then
    echo -n v
    continue
  else
    [[ $category =~ ^[0-9]+$ ]] || { echo "error" 1>&2 && exit $error; }
  fi

  ((cursor+=1))

  if [[ -z ${bump:-} ]]; then
    echo -n 0
  else
    if [[ $cursor -lt $bump ]]; then
      echo -n $category
    else
      unset bump
      echo -n $((category+=1))
    fi
  fi

  if [[ $cursor -ge 3 ]]; then
    exit
  else
    echo -n .
  fi
done
