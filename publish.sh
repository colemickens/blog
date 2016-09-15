#!/usr/bin/env bash

cd ../colemickens.github.io
rm -rf .git
git init
git add -A .
git commit -m "auto-update"
git remote add origin git@github.com:colemickens/colemickens.github.io.git
git push origin master -f
