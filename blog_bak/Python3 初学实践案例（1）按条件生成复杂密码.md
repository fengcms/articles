title: Python3 初学实践案例（1）按条件生成复杂密码
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -python
    -脚本语言
    -golang
    -密码
---

# Python3 初学实践案例（1）按条件生成复杂密码

最近事情太多，`golang` 学的东西忘记得差不多了。想想不如学习一下 `python` 吧~，反正我是一前端，学任何一门后端语言都是有助于自己的学习的。

最关键的事情是 `golang` 把我搞得头疼。里面的语法倒是不复杂，但是各种关键词和 `js` 差异太大，而 `python` 和 `js` 相比来说比较接近。

更关键的是，这是一个脚本语言，这点和 `js` 一样，不需要编译一下再跑的感觉还是蛮好的。

看了一些基础的入门文档，我决定写一个我用 `nodejs`、`golang`、`bash shell` 都写过的一个程序，生成复杂密码的脚本。

## 生成复杂密码 python 脚本

```python
#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
import random
import sys

pwLen = 8
if len(sys.argv) > 2:
    print('参数错误')
    sys.exit(0)

if len(sys.argv) == 2:
    if not sys.argv[1].isdigit():
        print('参数不是数字')
        sys.exit(0)
    pwLen = int(sys.argv[1])

chars = "abcdefghijkmnpqrstuvwxyzABCDEFGHJKMNPQRSTUVWXYZ23456789"

res = ''
for i in range(pwLen):
    res += chars[random.randint(0,54)]

print(res)
```

## 生成复杂密码 python 代码解析

首先是开头的两行注释，这里规定了我的脚本用 `python3` 执行。另外，我的脚本的编码是 `utf-8`。

目前还没有做项目，都是在 `shell` 里面跑着玩儿的。所以这样就还好。

**生成随机数**

需要使用库 `random` 用这个库生成随机数比较简单

```python
import random
random.randint(0,54)
```
如上代码，就是生成一个 0 到 54 之间的随机数

**获取命令行参数**

因为要和系统交互，所以需要使用 `sys` 这个库。

```python
import sys
```

获取系统参数 `sys.argv` 即可获取，这得到的是一个数组（`python`中称之为列表），其中第一个参数就是这个 `python` 文件本身。

可以使用 `len(sys.argv)` 来获得参数的长度。也就是说 `len()` 方法是获取数组长度的函数。

读取数组中的内容的方法和 `js` 类似。比如读取第二个内容，为 `sys.argv[1]` 这样。

**判断一个字符串是否为数字**

由于从命令行中拿到的所有参数都是字符串，所以如果我的参数是数字，但系统里输出依然为字符串。

我需要判断命令行中的输入是否正确，所以需要判断这个字符串是否为数字。方法如下：

```python
str = '0'
str.isdigit()
```
如上，如果一个字符串是数字，则会返回 `True` 否则，就会返回 `False`

这里需要注意的是，`python` 下面，布尔值的首字母是大写的，这和 `js` 可是不一样。

**将字符串转换为数字**

先要判断字符串是否为数字，如果不是数字的话，会直接报错。

转换也非常简单 `int(str)` 就可以转换了。

顺便提一下，啥都能转成字符串。`str(xxx)` 即可。

**退出程序**

当遇到一个条件，需要终止程序的时候，我们可以执行 `sys.exit(0)` 就可以终止程序。

**循环数字**

我一开始以为循环数字可以直接 `for i in 5:` 这样循环的。没想到直接被打脸。

循环数字需要加上一个 `range` 方法 `for i in range(5)` 这样来进行循环。

`range` 可以接收两个值，第一个是开始的数字，第二个是结束的数字，比如 `range(1，4)`，如果只填写了一个数字，那么就默认从 `0` 开始。很好理解。

**输出内容**

在 `shell` 中，输出是 `echo`，而在 `python` 中，输出是 `print()`。

## 其他小结

不需要写花括号，如果是在 `css` 中我有点想死的感觉。但是习惯了 `python` 感觉还是蛮好的。说不定，我以后就不用 `scss` 而用 `sass` 啦，哈哈~

但是要写 `:` 号，老是忘记写这个破玩意儿，导致程序出错。哎~

总体而言，`python` 是一个比较好玩的语言。以后再学习 `golang` 吧。我决定先把这个语言给研究到一定的水平。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。




