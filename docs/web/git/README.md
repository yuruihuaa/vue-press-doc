# 集中式和分布式

集中式：SVN

分布式：GIT

# 配置

全局配置，修改了~/.gitconfig

```shell
git config --global user.name 'name'
git config --global user.email 'name@outlook.com'
```

局部配置，--local可以省略

```shell
git config --local user.name 'name'
git config --local user.email 'name@outlook.com'
```

# 基本操作

创建仓库，新增.git文件夹，.git/config是这个仓库的配置文件

```shell
git init
```

touch命令新建空白文件，file.js状态是Untracked未追踪，没有被git追踪

```shell
touch file.js
```

执行git add后，文件被放入暂存区，状态是Changes to be committed，等待被提交

```shell
git add file.js  一个文件进入暂存区
git add .   所有文件进入暂存区
```

执行git commit后，提交到版本库

```shell
git commit -m "Commit描述"
git commit
```

修改file.js文件，file.js文件被修改，状态变成Changes not staged for commit

```shell
git status
```

.gitignore文件，告诉Git哪些文件不需要加入版本管理中

```
*.txt   忽略所有的文本文件
！file.txt  除了file.txt文件
/node_modules 忽略文件夹
```

执行git rm后，file.js从版本库和本地删除，加--cached参数时，只从版本库删除，本地保留，file.js状态变成Untracked

```shell
git rm file.js
git rm --cached file.js
```

git mv修改文件名

```shell
git mv file.js file.txt
```

git log查看历史提交

```shell
git log
git log -p 显示详细内容
git log -2 查看两条
git log --oneline 显示一行信息
git log --name-only 只看有变化的文件
git log --name-status 查看变化的文件是新增还是修改
```

git commit --amend修改最新一次Commit描述，如果暂存区如果有内容，执行命令后，暂存区的内容也一起提交到这次commit

```shell
git commit --amend 
```

撤销，git restore丢弃修改，同git checkout，git restore --staged将文件从暂存区撤回工作区，撤销git add

```shell
git restore --staged file.txt
git restore file.txt
```

给命令加别名，git s查看仓库状态

```shell
git config --global alias.s status
```

# 分支操作

```shell
git branch BranchName  新建Name分支
git branch  查看分支
git checkout BranchName  切换分支
git checkout -b BranchName 新建并切换到BranchName
git merge BranchName  位于当前分支，合并BranchName分支到当前分支
git branch -d BranchName 删除BranchName分支
```

分支冲突，不同的分支修改同一个资源，合并时产生冲突，修复冲突后add，commit，如冲突

```
<<<<<<< HEAD
content1
=======
content2
>>>>>>> Branch1
```

--merged查看已经合并到当前分支的分支列表，合并过的分支通常可以删除，--no-merged查看没有合并到当前分支的分支，慎重删除，如果删除没有合并的分支，会提示

```shell
git branch --merged
git branch --no-merged
Branch2
git branch -d Branch2
error: The branch 'Branch2' is not fully merged.
If you are sure you want to delete it, run 'git branch -D Branch2'.
```

一般master作为稳定分支，然后有一个develop分支作为开发分支，如果添加新功能，会基于develop分支新建功能分支，功能分支完成后合并到develop分支，develop分支测试通过后，合并到稳定的master分支

在当前分支工作，想切换到其他分支，在当前分支使用git stash临时存储，新增的文件因为不被git管理，git stash对新文件无效

```shell
git stash
git stash list
git stash apply  不删
git stash pop  删
git stash drop
```

打标签，如版本号，一般只有稳定的版本才打上标签

```shell
git tag  显示所有的标签
git tag v1.0 打标签
```

生成zip、tar压缩包发布代码，打包master分支

```shell
git archive --format=zip --prefix=git-docs/ master > git-1.4.0-docs.zip
```

从master分支新建一个子分支用于开发，在子分支完成工作后，这是master分支有新的commit，即master分支往前走了，此时在master分支执行merge子分支时提示冲突，并产生一次新的merge commit，解决方法时在子分支执行git rebase，修改子分支的基础点位master新commit，可能会产生冲突，由子分支的开发者处理，然后再在master分支执行git merge

这种情况和master分支和子分支共同修改同一个文件是不同的

```shell
git rebase master
```

# 远程仓库

GitHub国外代码托管平台

```shell
ssh-keygen -r rsa  生成密钥 公钥/私钥
```

本地分支与远程分支关联

```shell
git remote add origin git@github.com:XX/XX.git  添加远程仓库，并起名origin
git remote -v 显示所有远程仓库
git push origin 将当前分支推送到origin对应分支
git push origin master 将本地的master分支推送到origin主机
git push -u origin master  将本地的master分支推送到origin主机，同时指定origin为默认主机
git branch -a 显示所有的本地和远程分支

git branch --set-upstream-to=<remote>/<branch> master 为本地分支master添加上游分支，即添加远程分支

git pull origin BranchName:BranchName 本地没有BranchName分支，从远程拉去BranchName，并在本地新建BranchName

git push origin --delete BranchName
git push origin -d BranchName 删除远程分支BranchName
git branch -d BranchName 删除本地分支BranchName
```

