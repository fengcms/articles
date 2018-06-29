title: 打造前端 Deepin Linux 工作环境——开机自动加载 ~/.bash_profile 文件
date: 2017-11-06 09:59:49 +0800
update: 2017-11-06 09:59:49 +0800
author: fungleo
tags:
    -deepin
    -linux
    -bash
    -profile
---

#打造前端 Deepin Linux 工作环境——开机自动加载 ~/.bash_profile 文件

这个事情非常搞笑，当我把系统根据我的配置搞好之后，我就关机重启了一下。然后，我就发现，我设定的那些命令都失效了。

很明显。这说明我们配置的 `~/.bash_profile` 文件没有加载，只需要重新执行一下 `. ~/.bash_profile` 就可以了。但是如果每次启动都要这样运行一次，我感觉还是蛮扯淡的。

我的第一反应是，这应该是 `deepin linux` 的一个 `BUG`。本着没有能力开发也要大力配合开发的态度，我去官方提交了一个关于这个问题的用户反馈。

然后我想，肯定不会是我一个人遇到这个问题。于是在深度论坛一搜索，我去，很多人都在说这个问题。

但让我奇怪的是，官方或者是非官方的大神从来不解决这个问题，而是上来一顿训斥，告诉提问者，你这是不对的！系统启动就不应该执行这个文件！

![](https://raw.githubusercontent.com/fengcms/articles/master/image/88/90bb9421e11c8670a33e31f565ffe2.png)
哎呀我去！

虽然我读书少，但你们不能骗我对吧！我用的 `mac os` 也好 `arch linux` 都是这样设置，而从来没有人给我说过这样不行，到你这，怎么这么多理由呢？

另外，`.bashrc` 文件是每次打开一个新的终端窗口的时候执行的。而`.bash_profile` 文件是每次登录用户的时候执行一次。很明显，我们设定的一些参数，不是每开一个窗口都需要去设定一次，只需要我们登录的时候执行一次就可以了呀！所以我坚定的把命令放在 `.bash_profile` 文件里，而绝不放到 `.bashrc` 文件里。

但是如上图所示，他们跟我耍XX，说图形界面启动是非登录模式，既然是非登录模式，不执行是非常有道理的！

我一口老血喷出三里地呀！

**我们要的是解决问题，而不是让你告诉我们，我们的问题不是问题！**

靠人不如靠自己。打开谷歌开始找资料，终于在 `deepin` 官方的 `github` 提问里找到如下的解决方案：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/dc/c0fe7f86e1335d09e590f2c0c71742.png)
根据上图给出的方案，我们进行设置：

```
# 编辑文件
vim ~/.config/deepin/deepin-terminal/config.conf
# 找到第56行，讲 false 修改为 true
run_as_login_shell=true
# :wq 保存退出
:wq
```
注销系统后重新登录，问题解决。

本文由FungLeo原创，允许转载，但转载必须附注首发链接。谢谢。