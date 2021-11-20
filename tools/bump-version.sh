#!/usr/bin/env bash

FILES=("galaxy.yml")

for f in "${FILES[@]}"
do
   : 
   sed -i "s/$1/$2/g" $f
done

git add -A
git config --global user.email "releases@bitsy.ai"
git config --global user.name "Release Automation"
git commit -m "🚀 Bump version: $1 -> $2"