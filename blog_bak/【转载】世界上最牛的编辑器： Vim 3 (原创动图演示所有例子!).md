title: 【转载】世界上最牛的编辑器： Vim 3 (原创动图演示所有例子!)
date: 2016-11-11 14:28:38 +0800
update: 2016-11-11 14:28:38 +0800
author: fungleo
tags:
    -vim
    -编辑器
---

>这篇文章非常好，发表在慕课网上，为了常常温习，因此收集到我的博客上了。如果作者感觉不合适，随时通知我删除。首发地址 http://www.imooc.com/article/13275

**阅读收获**

*   见识下最炫酷的编辑器是什么样的.
*   顺手可以学习下.


**目录**

[键盘方法论: 在键盘面前,你就是钢琴手!](http://www.imooc.com/article/13277)

[最牛编辑器: Vim. 第一节](http://www.imooc.com/article/13269)

[最牛编辑器: Vim. 第二节](http://www.imooc.com/article/13272)

[最牛编辑器: Vim. 第三节](http://www.imooc.com/article/13275)

上面三节课大家都要学会, 都是干货, 我把自己常用的Vim 操作都列出来了. 没有一个是用不上的.

Vim 自身的功能虽然有限，但是还是有很多插件可以供使用的. 下面的几个插件非常好用(Fuzzy finder, rails ... , 具体见 `.vimrc`文件)


**针对多个文件进行 查找和替换**

使用插件： Greplace

1.  `Gsearch -F '要替换的字符串' . -R --include=*rb`
    这里的 `-F`, `-R --include=*rb` 这些参数，跟`grep`中的一样。
2.  在返回的结果中，把该替换的替换。
3.  `Greplace` 然后选择 `y/a/n` 来决定是否替换。
4.  最后， 输入 `wa` 保存所有文件的改动。

![世界上最牛的编辑器：Vim3(原创动图演示所有例子!)_](http://img.mukewang.com/57e8e1f90001a95709340522.gif)


**自动补全**

凡是在 Vim 缓冲区中（近期打开过的文件）的代码，都可以补全。

*   从上到下选择候选词： `ctrl + n`
*   从下到上选择候选词： `ctrl + p`

![世界上最牛的编辑器：Vim3(原创动图演示所有例子!)_](http://img.mukewang.com/57e8e4710001d80009340522.gif)


**多重复制与粘贴**

现在在 Windows， Mac 和 Linux下的复制操作，都不支持多种复制。 很奇怪。

Vim中支持。 使用YRShow 插件。

在我的个人配置中， `,` + `a` 即可。原始命令： `:YRShow` 。 在弹出的“复制历史列表”中， 上下移动， 找到合适的后直接按回车即可。

![世界上最牛的编辑器：Vim3(原创动图演示所有例子!)_](http://img.mukewang.com/57e8e4d70001d28409340522.gif)


**设置背景 是亮还是暗**

切换背景色（很多默认的linux 其实vim很难看的)

*   `:set background=dark` 深色背景色
*   `:set background=light` 亮色北京色

![世界上最牛的编辑器：Vim3(原创动图演示所有例子!)_](http://img.mukewang.com/57e8e5640001155709340522.gif)


**代码配色**

每个人心中的代码配色都不同。 你的呢？

`:colorscheme <主题名>` 主题名包括： `desert`, `deepblue`, `vividchalk` 等等。 （不少需要到网上下载）

![世界上最牛的编辑器：Vim3(原创动图演示所有例子!)_](http://img.mukewang.com/57e8e5be0001027809340522.gif)


**分割屏幕**

让一个27寸显示器显示多个窗口是很酷的事儿（虽然我个人很少用）

*   竖屏分割： `vs` (vertical split缩写)
*   横屏分割： `sp` (split缩写)
*   来回跳换： `ctrl + w + w` （跳到下一个小窗口）, 或者 `ctrl + w + <j/k/h/l>` （跳到某个方向的小窗口）

![世界上最牛的编辑器：Vim3(原创动图演示所有例子!)_](http://img.mukewang.com/57e8e6340001b6ba00010001.gif)


**注释多行**

这里使用了插件： nerd-commentor. 我为它配置了自己的快捷键。

1.  选中多行 (`shift + v`)
2.  `,cb` (逗号 c b 三个键要快速按）

    取消注释： 使用传统的替换即可。

![世界上最牛的编辑器：Vim3(原创动图演示所有例子!)_](http://img.mukewang.com/57e8e6c000012e3c00010001.gif)


**为多行代码格式化**

多行选中后， 按 `=` 即可。 （注意：不是100%好用。 因为有的代码本身就是不完整的）
![世界上最牛的编辑器：Vim3(原创动图演示所有例子!)_](http://img.mukewang.com/57e8e7910001679509340524.gif)


**快速跳到当前光标所属文件（如果可能的话）**

在 Rails的 路由或者 视图文件中，很好用。`gf` 即可。 （gf = go to file)

*   在 View 中， 快速跳到一个 partial.
*   在 `config/routes.rb` 中跳到controller， 如下图所示。

![世界上最牛的编辑器：Vim3(原创动图演示所有例子!)_](http://img.mukewang.com/57e8e7df00019c9c09340522.gif)


**Rails插件**

Rails插件允许我们快速的在各种文件中跳来跳去（相信Vim 也有 Django, Spring， angular, 这样的插件， 有兴趣的朋友可以看看。）

*   跳转到 controller: `ctrl + c`
*   跳转到 model : `ctrl + m`
*   跳转到 view : 先移动到对应的action, 再 `ctrl + v`

![世界上最牛的编辑器：Vim3(原创动图演示所有例子!)_](http://img.mukewang.com/57e8e89b0001444100010001.gif)


**显示/隐藏行数**

*   `:set number` 显示行数
*   `:set nonumber` 取消行数

![世界上最牛的编辑器：Vim3(原创动图演示所有例子!)_](http://img.mukewang.com/57e8e97c0001ee8f00010001.gif)


**折叠/取消折叠过长的行**

*   `:set wrap` 折叠
*   `:set nowrap` 取消折叠

![世界上最牛的编辑器：Vim3(原创动图演示所有例子!)_](http://img.mukewang.com/57e8ea3d00017d4d00010001.gif)


**粘贴模式**

Vim 正常模式下的粘贴，会导致粘贴的代码一行接一行的缩进。 如果要取消这种缩进的话，就要进入到 "粘贴模式". （记得在这个模式下，无法使用 `ctrl + t` 命令来快速打开文件。 ）

*   `:set paste` 进入到粘贴模式
*   `:set nopaste` 取消粘贴模式

![世界上最牛的编辑器：Vim3(原创动图演示所有例子!)_](http://img.mukewang.com/57e8ecf10001c5aa09340508.gif)


**代码左移/右移 与 重复上一次操作。**

在我们格式化代码时会用到。 极度好用。

记住：你写的任何代码都要人肉加上良好的格式化。 能为你个人减少大量错误。

*   左移: 选多行后， `<` （ `shift + ,` ）
*   右移: 选多行后， `>` （ `shift + .` ）
*   重复上次操作: `.`

![世界上最牛的编辑器：Vim3(原创动图演示所有例子!)_](http://img.mukewang.com/57e8eeea00014a3405460007.gif)


**写在最后**

上面介绍的所有vim技巧,都是我回忆出来的, 是我在过去7年中一直在用的技巧. 各位同学需要每一样都要掌握.