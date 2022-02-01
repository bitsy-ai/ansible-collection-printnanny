#!/usr/bin/env bash

git config --global user.email "releases@bitsy.ai"
git config --global user.name "Release Automation"


bump2version --current-version $(cat version.txt) --new-version "$1" patch

git commit -m "🚀 Bump version: $1 -> $2"
git push origin "$3"