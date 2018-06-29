title: 【转载】koala 编译scss不支持中文解决方案(新增MAC解决方案)
date: 2015-10-22 16:32:44 +0800
update: 2015-10-22 16:32:44 +0800
author: fungleo
tags:
    -koala
    -scss
    -中文注释
---

##前言
koala 是我一直在用的 scss 或者 lass 的编译软件。其设计小巧方便，使用非常便捷。但是，当你在scss文件中写入中文注释的时候，却会发生报错，提示不支持文件编码。
一开始我倒没有太在意，反正咱们英文不行，就当练英文了呗。
但是最近工作压力非常大，与其将时间浪费在如何写英文上，还不如直接写中文，还大家都看得懂。
但是报错怎么办呢？百度了一下，找到了解决方法。
##转载原文

scss文件编译时候使用ruby环境，出现

Syntax error: Invalid GBK character "\xE5"
检查了好久才发现 scss编译不支持中文字体，请教了下度娘才找到解决方案

解决方法很简单

进入到Koala 安装目录

D:\Koala\rubygems\gems\sass-3.4.9\lib\sass
修改 engine.rb 文件 

在require 最下面 加入以下代码 即可解决
```
Encoding.default_external = Encoding.find('utf-8')
```
##结语
实测成功！
原文地址：http://www.aseoe.com/show-26-611-1.html

##2016年08月22日补充MAC下方案解决方法

其实一样，只是目录路径不一样，比较难找，这里给出来。

```
cd /Applications/Koala.app/Contents/Resources/app.nw/rubygems/gems/sass-3.4.9/lib/sass
vim engine.rb
```
然后在结尾插入上面的代码。都不用重启koala，立即生效！

##2017年05月05日补充MAC下文件路径变化

最近KOALA升级了，下载了最新版本之后，发现这个问题依旧存在，解决方法是一致的，但是文件路径发生了变化，更新文件路径在此。想来windows也是一样的。
```
cd /Applications/Koala.app/Contents/Resources/app.nw/rubygems/gems/sass-3.4.23/lib/sass
vim engine.rb
```
代码一样，在文件末尾插入
```
Encoding.default_external = Encoding.find('utf-8')
```
编辑文件保存退出后，重启Koala即可。

##2017年05月12日补充不修改koala文件的解决方案

你可能并不想修改这个文件，所以，我就这个问题在koala的github上提问，给出了一个答案可以处理。

就是在包含中文的sass文件开头加上 `@charset "UTF-8";`即可避免这个问题。

你可以点击这个链接查看：[github issues](https://github.com/oklai/koala/issues/624)

## 2017年05月16日补充

最新版的`koala V2.2.0`已经解决这个问题。大家可以去https://github.com/oklai/koala/releases下载最新版本的`koala`软件