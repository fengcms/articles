title: mac 下使用 iTerm 终端工具无法使用 alt+b 和 alt+f 快捷键的解决方法
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -mac
    -iTerm
    -终端
    -alt+b
    -alt+f
---

# mac 下使用 iTerm 终端工具无法使用 alt+b 和 alt+f 快捷键的解决方法

对于常在终端下工作的人来说，输入命令是家常便饭。但是当我们的命令输入错误的时候，需要调整就比较麻烦了。

一般来说，不经过学习都知道，使用左右方向键可以在输入的字母上进行跳转。但是问题是，这样操作效率太低。

因此，我们常用的命令有下面几个：

命令 | 解释
---|---
ctrl+a|跳转到命令最前面
ctrl+e|跳转到命令最后面
ctrl+b|向前跳转一个字符（作用相同于左方向键）
ctrl+f|向后跳转一个字符（作用相同于右方向键）
alt+b|向前跳转一个单词
alt+f|向后跳转一个单词

这几个常用命令在 `linux` 上是没有问题的。 `windows` 没有测试过，应该也没有问题吧。

但是在 `mac` 上面有一些不一致。前面四个 `ctrl` 的组合键没有问题，都是可以支持的。但问题是 `mac` 没有 `alt` 键。尝试用 `Option` 键来做同样的操作，结果是不可以的。

> `Option` 键相当于普通键盘的 `alt` 键

怎么解决这个问题呢？通过不停的查找资料，终于解决了这个问题。

## MAC 自带终端工具的配置

我们打开 `mac` 自带的终端工具，按 `command + ,` 打开设置界面，点击上面的 `描述文件` 选项卡，然后在左侧的风格列表中点击你当前使用的风格，然后在右侧出现的选项卡中点击 `键盘` 然后，勾选当前页面的 **将`Option`键用作`meta`键**，如下图操作：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/9f/671585760854687d7f35cba9cedee0.png)
然后就可以了。最终效果如下：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/2b/d11c9ef19bf1151650bc9f400cf2e4.gif)
## MAC iTerm 设置方法

自带的终端的问题解决了，但是我们还是更多的使用 `iTerm` 这个功能更加强大的终端工具，那么在 `iTerm` 里应该如何设置呢？

1. 首先用 `command+o` 快捷键打开 `profiles` 设置面板
2. 点击左下角的 `Edit Profiles...` 按钮
3. 然后就打开了 `Preferences` 设置面板，确保在该面板的 `Profiles` 选项卡中。
4. 点击下方右侧的选项卡标签 `Keys`。
5. 然后将下方默认的 `Normal` 选项换成 `Esc+` 选项

关闭后自然保存，然后就设置生效了。设置过程见下图：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/21/cde2150d3e2c4fe6c360cffc0250a6.png)![](https://raw.githubusercontent.com/fengcms/articles/master/image/d7/5fe352c16a92b2a39febe1ca01e388.png)
然后就 OK 了。实际效果如下图所示：


![](https://raw.githubusercontent.com/fengcms/articles/master/image/94/50c9f7ef708589235bebd01ca7e0cd.gif)
好，经过这个配置之后，我们终于可以愉快的使用终端啦！

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


