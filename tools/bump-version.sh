#!/usr/bin/env bash

FILES=("galaxy.yml")

old_tag="$(echo $1 | sed 's/v//g')"
new_tag="$(echo $2 | sed 's/v//g')"
for f in "${FILES[@]}"
do
   :
   sed -i "s/$old_tag/$new_tag/g" $f
done

git add -A
git config --global user.email "releases@bitsy.ai"
git config --global user.name "Release Automation"
git commit -m "🚀 Bump version: $1 -> $2"
git push origin $3