title: Python3 初学实践案例（2）将源目录中的图片用MD5命名并可以设定目标目录
date: 2017-12-08 18:13:00 +0800
update: 2017-12-08 18:13:00 +0800
author: fungleo
tags:
    -python
    -图片
    -md5
---

# Python3 初学实践案例（2）将源目录中的图片用MD5重命名后移动或复制到目标文件夹

尝试了一下用 `python` 实现了一个生成密码的程序。感觉还是比较好上手的。但是那个程序还是非常简单的一个小程序。这次我需要实现一个更加复杂的程序，就是整理图片。

## 列出需求

1. 将图片文件用图片的 `md5` 值进行重命名。
2. 可以设定源目录
3. 可以设定目标目录
4. 可以设定是移动，还是复制
5. 参数可以缺省

列出这些需求，我开始设计我的程序。

## 最终实现代码

```python
#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
import sys
import os
# 获取文件类型库
import imghdr
# MD5库
import hashlib
# 文件操作库
import shutil

# 设定默认参数
sourceDir = './'
targetDir = './'
operation = 'move'
images = []

# 用户操作说明
def Usage():
    print('USAGE: md5img [source dir] [target dir] [-m | -c]')
    sys.exit(0)

# 根据输入的参数，进行不同的处理
if len(sys.argv) == 1 or len(sys.argv) > 4:
    Usage()

if len(sys.argv) >= 2:
    sourceDir = sys.argv[1]
    targetDir = sys.argv[1]

if len(sys.argv) >= 3:
    targetDir = sys.argv[2]

if len(sys.argv) == 4:
    if sys.argv[3] == '-m':
        operation = 'move'
    elif sys.argv[3] == '-c':
        operation = 'copy'
    else:
        print('Operation method is not defined')
        Usage()

# 找到源目录下所有的图片
def findImage(sourceDir):
    # 如果源目录不存在，则报错退出
    if not os.path.exists(sourceDir):
        print('Source directory is not defined')
        Usage()
    # 循环目标目录中的文件
    for fil in os.listdir(sourceDir):
        # 取得文件的路径
        filPath = os.path.join(sourceDir, fil)
        # 判断文件是否为目录
        if not os.path.isdir(filPath):
            # 判断文件是否为图片
            if imghdr.what(filPath) != None:
                # 将图片插入需要处理的列表
                images.append(filPath)
# 计算 MD5 值函数
def calcMD5(filepath):
    with open(filepath,'rb') as f:
        md5obj = hashlib.md5()
        md5obj.update(f.read())
        hash = md5obj.hexdigest()
        return hash

# 处理所有图片
def md5img(images):
    # 如果目标目录不存在，则报错退出
    if not os.path.exists(targetDir):
        print('Target directory is not defined')
        Usage()
    # 循环需要处理的图片列表
    for img in images:
        # 根据图片的真实后缀，来确定图片的后缀，如果是 jpeg 则改成 jpg
        postfix = 'jpg' if imghdr.what(img) == 'jpeg' else imghdr.what(img)
        # os.rename(img, targetDir + '/' + calcMD5(img) + '.' + postfix)
        # 执行复制或者移动操作
        if operation == 'move':
            shutil.move(img, targetDir + '/' + calcMD5(img) + '.' + postfix)
        elif operation == 'copy':
            shutil.copy(img, targetDir + '/' + calcMD5(img) + '.' + postfix)
# 找图片
findImage(sourceDir)
# 处理图片
md5img(images)
# 完成
print('Finish')
```

## 代码说明

首先呢是引用各种需要的库。`sys`库和`os`库是非常基本并且常用的。然后就是针对各个需要的功能点，找的不同的库，进行引入。

然后，设定了各种默认参数。需要源目录，目标目录，操作方法，以及图片列表，一个空的数组。

**定义函数**

在 `js` 中，我们定义一个函数，用的是 `function` 。在 `python` 中，用的是 `def`。 我现在还不知道 `def` 代表的是啥意思，如果你知道，在品论中告诉我哈~

其他的内容，除了格式差异以外，我感觉和 `js` 是非常类似的。

但是，在 `js` 中，函数放在哪里并不会影响执行。但是在 `python` 中就不一样了。函数必须在执行的代码之前定义。否则就会报错。

目前我还没有进行多文件的编码。如果是进行多文件的编码的话，如何组织文件，需要我好好的想一下。

**用户使用说明**

首先，我定义了一个用户使用说明的函数。内容非常简单，就是告诉使用者，这个函数的使用方法。

然后，就是各种终端录入的参数的判断处理，根据录入的参数，重设我的默认值，如果是参数出错了，则需要告诉用户，出错了。

**三元运算**

`python` 中没有三元运算？？？但是有类似的处理方法，只是语法不一样而已。

比如在 `js` 中，三元运算如下:

```js
res = a > 5 ? 0 : 1
```

但是在 `python` 中没有三元运算，我们可以这样写：

```python
res = 0 if a > 5 else 1
```

比较怪异，但是比照着，也是能写的。

**判断一个路径是否存在**

我们可以使用 `os.path.exists(path)` 来判断 `path` 这个路径是否存在。

**找出来一个路径下的所有文件或者目录**

`os.listdir(path)` 就可以列出 `path` 这个目录下面所有的文件或者目录了。这里得到的是一个数组。

> 我比较习惯 `js` 的说法。 `python` 中说这是列表……

**判断一个文件是否为图片，如果为图片，则输出图片的类型**

这需要使用一个库 `imghdr`，我们在代码的开头引用进来即可。

然后我们可以使用 `imghdr.what(filPath)` 来看文件是否为图片，如果输出的是 `None` 则表示不是图片。如果是图片的话，则会输出图片的类型。比如 `jpg` 图片会输出 `jpeg` 这样。


## 其他小结

关键是找到对应的库，然后看库的方法就可以了。目前我很不熟悉，毕竟是刚刚开始学。但是通过 `google` 搜索，是可以很快找到解决各种问题的方法的。

唯一需要注意的是，需要加上关键词 `python3` 来避免看到 `python2` 的内容。我就遇到好几个 2 的代码，导致程序跑不起来出错的问题。

其他的说明我的注释里面已经说得非常清楚了。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

