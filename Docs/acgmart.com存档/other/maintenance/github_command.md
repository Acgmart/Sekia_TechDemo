---
title: Github客户端命令
categories:
- [其他, 运维]
date: 2020-05-03 12:03:58
---

\[toc\]GithubDesktop很好用，但是只能Commit、Push，更复杂的操作还是得靠git命令。

# 更改本地git的文本类型文件换行符为Unix

git config --global core.autocrlf input 这样一来，新提交的文件自动转换成Unix格式，使整个项目统一使用Unix。

# 打开git命令行工具

GithubDesktop-菜单栏-Repository-Open in Command Prompt

# reset操作 退回到某次commit

```bash
git reset --soft HEAD~1
```

指定一个commit，这里HEAD~1表示最新的commit(HEAD~0)的上一个commit --soft表示 被取消的改动退回到暂存区 我们可以修改后继续提交commit

# 找回丢失的commit

rebase操作同样可以用于找回丢失的commit 比如：先提交commit1，再提交commit2，再reset到commit1 我们可以通过reset命令恢复commit2 但是由于commit2消失在了队列中 无法使用HEAD~X 需要使用ID 我们可以使用git reflog命令查看所有提交历史 找到这个ID 比如bd505d3 然后：`git reset --hard bd505d3` 就可以挽回劳动成果了。

# rebase操作 合并commit

利用rebase操作 我们可以将一个commit与它前一个commit合并 可以重新设置Commit的标题和注释

## 进入rebase模式

```bash
git rebase -i
```

\-i后面可选加一个参数：要忽略的commit(你可能想保留这个commit) 回车后进入命令行文本编辑模式 输入“i”进入编辑模式 比如：现有4个commit没有提交，分别是： A 1分钟前 HEAD~0 B 10分钟前 HEAD~1 C 1小时前 HEAD~2 D 24小时前 HEAD~3 我们想将ABCD合并为一个新的Commit 如果有必要忽略最新的commit则：

```bash
git rebase -i HEAD~0
```

## 编辑rebase操作内容

文件中列出了当前还没有提交的commit 每一行表示一个commit 每一行前面第一个单词表示要执行的操作 pick：**参与**合并操作，commit必须**参与**才会被修改 squash(简写“s”)：参与合并操作，并与前一个commit合并 默认情况下，内容基本上是：

```bash
pick 9b0a3c(ID) 标题D(标题 如果是中文就可能显示的乱码)
pick xxxxxxx 标题C
pick xxxxxxx 标题B
pick xxxxxxx 标题A
```

ID和标题不需要我们手打上去，默认就有，我们只需要修改操作内容即可。 默认的内容表示：ABCD这4个commit都会参与合并，但是没有操作内容。 所以直接保存(ESC后输入“:wq”)后，成功执行，但是没有任何修改。 根据我们的要求，ABCD合并为1个commit：

```bash
pick xxxxxxx 标题D
s xxxxxxx 标题C
s xxxxxxx 标题B
s xxxxxxx 标题A
```

将要被合并消失的项改为s即可，保存后，如果执行成功，进入修改标题和注释环节。

## 修改标题和注释

#开头的行将不显示 不修改直接保存也能执行成功 第一个有效的行表示标题 后面的行是注释

# config操作 行尾处理

github在提交文件时会对文件的行尾进行修改，通常我们都难以察觉。 但是，如果我们使用Unity这样，会生成各种后缀文件的编辑器时，就可能造成麻烦。 要理解行尾处理的纠结处，就需要知道行尾有什么用。 我们经常在Unity写代码的时候，有时候从其他地方复制一段代码到CS脚本里面，返回编辑器的时候被提示： 有不同行尾，是否统一行尾。 混合了多种行尾就可能报错，我们可以用format保存插件来应对这个。 每种操作系统的默认行尾格式可能不同，混合了行尾后可能造成二进制文件无法被识别。 而github则做了一个非常贴心的事，在仓库内保存LF行尾的版本，根据用户的客户端转换为其他版本。 这样的好处是，在可以跨平台协作的时候，你的队友能更方便一些。 缺点是，换了行尾的文件，严格上来说是另一个文件了，这种反复检查行尾的事本身就很消耗注意力。 关闭行尾自动转换：

```bash
git config --global core.safecrlf false
```

这样一来，github就不会更改我们的文件了，提交的是什么文件，下载的也是什么文件。