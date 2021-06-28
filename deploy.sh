#!/usr/bin/env sh

set -e
npm run build
cd docs/.vuepress/dist
git init
git config --local user.name yuruihuaa
git config --local user.email yuruihuaa@outlook.com
git add -A
git commit -m 'deploy'
git push -f https://github.com/yuruihuaa/yuruihuaa.github.io.git master
cd -