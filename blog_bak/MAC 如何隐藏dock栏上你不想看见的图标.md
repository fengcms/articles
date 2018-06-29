title: MAC 如何隐藏dock栏上你不想看见的图标
date: 2016-08-20 17:03:11 +0800
update: 2016-08-20 17:03:11 +0800
author: fungleo
tags:
    -mac
    -dock
    -隐藏图标
---


##为什么要隐藏DOCK栏图标？

一个你不得不开，但是开了也不想看见，只想他在后台默默的工作就好，关键是图标还巨丑，实在是不想看见，所以，我要隐藏掉-_-|||

好吧。因为实在是受够了在mac和windows系统之间切换，导致快捷键不一样，以至于心情很烦躁严重影响了工作效率的情况下，我决定，把我的台机也黑成MAC系统。。。

一切顺利的安装成功之后，必须安装一个wifi管理工具，否则没办法无线上网。别让我连有线，我连根网线都没有。。。。

联网成功之后，一个很纠结的问题困扰我。。。就是，这个图标太TMD丑了！！！

还是百度相关的方法。结果很让人不满意。

虽然作为一个程序员，但是因为谷歌要翻墙，所以在能用百度的情况下就用吧。但是真心让我失望，国内的网站上都语焉不详。因此，翻墙出去，迅速找到答案。

##怎么隐藏DOCK栏图标？

打开终端，

```
#进入APP目录
cd /Applications/
#查看目录下安装的软件
ls
#假设你的软件名字是 YouAppName
cd YouAppName/Contents
#编辑配置文件
vim Info.plist
#进入VIM编辑器
```
进入编辑器之后，找到`<dict>`的部分节点，插入下面红框内的内容
![](https://raw.githubusercontent.com/fengcms/articles/master/image/97/fc3f38c1f3411a2546a410981b1f0e.png)
代码如下：
```
<key>LSUIElement</key>
<true/>
```
>VIM操作说明。（HJKL高手略过）
>先用方向键将光标挪动到`<dict>`这一行，然后按字母`o`插入一行，并进入编辑模式，输入上面的代码或用鼠标右击粘贴，然后按`esc`键退出编辑模式，输入冒号`shift+:`，然后输入`wq`回车保存退出

保存之后，退出相关程序，再次打开，DOCK栏上就没有这个软件的图标了。

本文为我原创，但资料来源于[CNET](http://www.cnet.com/news/prevent-an-applications-dock-icons-from-showing-in-os-x/)。

首发地址：http://blog.csdn.net/fungleo/article/details/52262315 允许转载，但必须附上首发地址，谢谢！

**2017年11月23日补充**

有人反映在10.13上会失效。我测试了两个程序，atom和 qq浏览器。结果是 QQ浏览器会报错，但是ATOM正常。达到了隐藏图标的效果。

所以代码还是没问题的。可能有一些软件不能这么做。
