title: Python3 初学实践案例（3）argparse 命令行参数库的使用
date: 2017-12-12 17:33:41 +0800
update: 2017-12-12 17:33:41 +0800
author: fungleo
tags:
    -python
    -argparse
---

# Python3 初学实践案例（3）argparse 命令行参数库的使用

在前面一篇博文中 http://blog.csdn.net/fungleo/article/details/78754419， 我实现了一个程序——将源目录中的图片用MD5重命名后移动或复制到目标文件夹。

虽然实现了效果，但是其中处理命令行传入的参数，是我自己手写判断的。这样做还是有缺点的：

1. 笨~用 `python` 语言就是用它各种各样牛逼的库
2. 参数的位置是固定的，不能放在前面
3. 如果要实现上一条，我的手写的代码部分的复杂度将要大大提高
4. 想要更多功能，就得更复杂，我表示无能为力

所以，我找一下有没有合适的库来做这个，有好些的还是。最终我选择了自带的比较新的 `argparse` 库。还有第三方的更简洁的库，不过我没有使用。

## argparse 使用简单说明

`argparse` 库功能比较强大，官方中文版资料见：http://python.usyiyi.cn/translate/python_278/library/argparse.html

需要注意的是，教程里面的语法是 `python2` 的，而我们现在一般学习的都是 `python3` 吧~

**引用 `argparse` 库**

```python
import argparse
```

就这样就可以直接引用了。非常简单。

首先，我们定义一个分析器

```python
parser = argparse.ArgumentParser()
```

官方教程就是这么写的，我粗浅的认为，这是为了让代码变得短一些。

定义分析器之后，我们就可以往里面添加我们需要的参数。

**为我们的脚本添加一个说明描述**

首先呢，我们的脚本是干啥的，得先描述一下。官方的代码如下：

```python
parser = argparse.ArgumentParser(description='这里写点描述信息')
```

我不太喜欢这种写法。于是，我是这样写的。

```python
parser = argparse.ArgumentParser()
parser.description='这里写点描述信息'
```

效果没差。

**设置 `-v` 为输出程序版本号**

好，描述好了，我们的程序应该是会版本升级的。所以呢，版本号很有必要。

```python
parser.add_argument("-v", "--version",action='version', version='%(prog)s 1.0')
```

如上，配置参数 `action` 的值为 `version` 就可以了。后面的 `%(prog)s` 代表你自己的脚本的名称。这个是可变的。并且是可以设置的。

**添加一个必填的参数**

我们用 `parser.add_argument` 来往分析器里面添加参数，上面我们已经添加了一个特殊的版权输出的参数。那么正常的添加普通参数，就是下面的方法了。

```python
parser.add_argument('sourceDir', help='Select source directory')
```

如上，添加了一个必填的参数 `sourceDir` ，后面的 *help* 是帮助信息，默认的参数格式是字符串，也就是 `str` 如果你需要参数是其他内容，需要指定 `type`。例如，你需要的参数是数字，就需要用 `type=int` 来指定类型。

**添加一个不带`-`前缀的选填的参数**

```python
parser.add_argument('targetDir', help='Select target directory', nargs='?')
```

如上，使用 `nargs='?'` 就可以使这个参数是选填的。它还有其他的值，可以参考官方文档。我这里使用问号表示可以接收0个（也就是不填）或者1个（也就是可以填）值。

**添加一个带 `-` 前缀的选填参数**

```python
parser.add_argument("-a", "--add", help="add something")
```

代码如上，只需要加上 `-` 前缀，那么就表示这个参数是选填了的。并且可以同时指定简写或者双横线的全拼，也可以只指定一个。根据你自己的需要来进行设置。

**添加一个互相排斥的二选一的选填参数**

上面添加的这些参数是可以满足很多场景，但是一个场景满足不了，比如，我需要 ` -m | -c ` 这两个参数只能出现一个，如果同时出现两个就不行。那么上面的方法就不够用了。

我们用下面的代码来进行实现。

```python
group = parser.add_mutually_exclusive_group()
group.add_argument("-m", "--move", help="The way to operate the file is to move", action="store_true")
group.add_argument("-c", "--copy", help="The way to operate the file is to copy", action="store_true")
```

如上，定义一个参数组 `group` 然后往这个组里添加不同功能的参数即可。

`action="store_true"` 这个配置项代表这个不需要填写值，直接写参数就可以了。输出的时候为布尔值。

**获取所有的参数**

```python
args = parser.parse_args()
print(args)
```

好，如上代码，我们就把参数定义为变量 `args` 了，然后，我们就可以用这个对象来获取我们的各种参数了。

**打印帮助信息**

我们在程序后面加上 `-h` 这个参数，就可以得到一个我们的程序的详细的帮助信息。这个是 `argparse` 自带的牛逼功能。省得我们自己去构建帮助信息，我表示非常喜欢。

但是如果只有这样才能获取帮助信息，那么有点索然无味了。其实， `argparse` 内置了一些方法，可以很方便的让我们调用帮助信息

```python
# 打印 usage
parser.print_usage()
# 打印完整的 help 信息
parser.print_help()
# 输出 usage
parser.format_usage()
# 输出 help
parser.format_help()
```

打印和输出的区别是，打印就直接打出来了。输出的话，只是输出，你可以拿来做任何事情，例如，你想输出了之后再打印出来就可以如下执行：

```python
print(parser.format_help())
```

好吧，有点脱裤子放屁的意思。不过你明白我想表达什么了。

## 优化过的“将源目录中的图片用MD5重命名后移动或复制到目标文件夹”源代码

```python
#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
import os
# 获取文件类型库
import imghdr
# MD5库
import hashlib
# 文件操作库
import shutil
# 命令行分析库
import argparse

# 处理命令行参数，使用 argparse 库
parser = argparse.ArgumentParser()
# 定义脚本描述信息
parser.description='Move or copy the images in the source directory with the name of MD5 into the target directory'
# 定义脚本版本
parser.add_argument("-v", "--version",action='version', version='%(prog)s 1.0')

# 添加源目录参数，必填
parser.add_argument('sourceDir', help='Select source directory')
# 添加目标目录参数，选填
parser.add_argument('targetDir', help='Select target directory', nargs='?')

# 定义一个互相排斥的参数，copy or move 不可同时存在
group = parser.add_mutually_exclusive_group()
group.add_argument("-m", "--move", help="The way to operate the file is to move", action="store_true")
group.add_argument("-c", "--copy", help="The way to operate the file is to copy", action="store_true")

# 将参数命名为变量 args
args = parser.parse_args()

# 设定默认参数
sourceDir = args.sourceDir
targetDir = args.targetDir or args.sourceDir
operation = 'copy' if args.copy == True else 'move'
images = []

# 定义出错函数
def errUsage(res):
    print('error: ' + res)
    parser.print_usage()
    exit()

# 找到源目录下所有的图片
def findImage(sourceDir):
    # 如果源目录不存在，则报错退出
    if not os.path.exists(sourceDir):
        errUsage('Source directory is not defined')
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
        errUsage('Target directory is not defined')

    method = {
        "move": shutil.move,
        "copy": shutil.copy
    }
    # 循环需要处理的图片列表
    for img in images:
        # 根据图片的真实后缀，来确定图片的后缀，如果是 jpeg 则改成 jpg
        postfix = 'jpg' if imghdr.what(img) == 'jpeg' else imghdr.what(img)
        # 执行复制或者移动操作
        method[operation](img, targetDir + '/' + calcMD5(img) + '.' + postfix)
# 找图片
findImage(sourceDir)
# 处理图片
md5img(images)
# 完成
print('Finish')
```

代码中已经添加了很多的注释了，应该来说可以非常简单的看懂，这里就不赘述了。

程序执行效果如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/17/0a3c773714b317079725896cd01e33.png)
OK，终于把这个脚本给写得相对来说满意了。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

