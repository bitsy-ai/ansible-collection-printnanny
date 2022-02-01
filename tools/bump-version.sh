#!/usr/bin/env bash

git config --global user.email "releases@bitsy.ai"
git config --global user.name "Release Automation"


bump2version --current-version $(cat version.txt) --new-version "$1" patch

git push origin
git push --tags