#!/usr/bin/env bash

(cd ../colemickens.github.io && sudo rm -rf * && sudo rm -rf .git)

make build-blog

echo "colemickens.io" > ../colemickens.github.io/CNAME

cd ../colemickens.github.io

git init
git add -A .
git commit -m "auto-update"
git remote add origin git@github.com:colemickens/colemickens.github.io.git
git push origin master -f
