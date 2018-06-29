title: Python3 初学实践案例（4）可设定长度和密码复杂级别的生成密码脚本
date: 2017-12-14 15:48:53 +0800
update: 2017-12-14 15:48:53 +0800
author: fungleo
tags:
    -python
    -密码
    -脚本
---

# Python3 初学实践案例（4）可设定长度和密码复杂级别的生成密码脚本

在学习 `python` 的第一次实战中，我就完成了一个生成密码的脚本。原文链接：http://blog.csdn.net/fungleo/article/details/78753940

但是，在那次的实战中，最终的脚本只能设定一个参数，就是长度。我希望可以做一个更加完善的脚本，就是不但可以设定长度，并且可以设定密码复杂的等级。这样，才能满足我们在不同情况下所需要的密码。

另外，由于密码是在字典中随机取得字符组合在一起的。这个结果可能并不满足我们的想要的条件，因此，必须检查一下，如果不满足，则需要重新生成一个，直到满足为止。

好，设定我的程序的目标：

1. 随机生成一个密码
2. 可以指定密码的长度
3. 可以指定密码的复杂等级
    1. 简单：由纯数字组成
    2. 一般：数字+小写字母+大写字母
    3. 复杂：数字+小写字母+大写字母+标点符号
4. 密码必须符合指定的复杂等级才输出
5. 密码最小长度为 4 位，因为复杂模式必须由四种元素构成

好，确定目标之后，我就开始准备实现这个脚本。由于之前我已经学习了 `argparse` 命令行参数处理的库，《[argparse 命令行参数库的使用](http://blog.csdn.net/fungleo/article/details/78784180)》，所以处理命令行参数对于我来说变得异常简单，我配置好之后，只需要把努力全部放在逻辑处理上即可。

## 实现代码

```python
#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
import random
import argparse
import re

# 用字典和长度随机生成一个密码
def passwordMaker(leng, dicts):
    res = ''
    dictLen = len(dicts) - 1
    for i in range(leng):
        res += dicts[random.randint(0, dictLen)]
    return res

# 检查密码的等级
def checkPassword(passwd):
    res = ''
    if re.search(r'\d', passwd):
        res = 's'
        if re.search(r'[a-z]', passwd) and re.search(r'[A-Z]', passwd):
            res = 'c'
            if re.search(r'[_@!,.<>:;-=+/?]', passwd):
                res = 'd'
    return res

# 取得密码函数
def getPassword(leng,level,dicts):
    res = passwordMaker(leng, dicts)
    # 检查密码是否符合期望的条件，如果不负责，则重新生成一遍
    if checkPassword(res) != level:
        return getPassword(leng, level, dicts)
    return res

# 主函数
if __name__ == "__main__":
    # 设置命令行参数
    parser = argparse.ArgumentParser()
    parser.description='This program is used to generate simple or complex passwords'
    parser.add_argument("-v", "--version",action='version', version='%(prog)s 1.0')
    parser.add_argument('length', type=int, help='The length of the password (Default 8)', nargs='?')

    group = parser.add_mutually_exclusive_group()
    group.add_argument("-s", "--simple", help="The password is made up of pure numbers", action="store_true")
    group.add_argument("-c", "--commonly", help="The password is made up of numbers and letters (Default)", action="store_true")
    group.add_argument("-d", "--difficult", help="The password is made up of numbers, letters, and punctuation", action="store_true")

    # 获取命令行参数结果
    args = parser.parse_args()

    # 确定密码长度为命令行设置或者默认为8
    length = args.length or 8

    # 如果密码长度小于 4 则提示并退出
    if length < 4:
        parser.print_usage()
        print('error: The password length must be greater than 3')
        exit()

    # 设定三个等级的密码生成的词典
    sDict = '0123456789'
    cDict = 'abcdefghijkmnpqrstuvwxyzABCDEFGHJKMNPQRSTUVWXYZ23456789'
    dDict = cDict + '_@!,.:;-=+/?'
    # 根据命令行条件，打印最终的密码
    if args.simple:
        print(getPassword(length, 's', sDict))
    elif args.difficult:
        print(getPassword(length, 'd', dDict))
    else:
        # 默认输出为 一般复杂程度的密码
        print(getPassword(length, 'c', cDict))
```
**运行结果如下**

![](https://raw.githubusercontent.com/fengcms/articles/master/image/10/48378255afdc02cd7c2e7043422741.png)
## 完成后小结

**`main` 函数**

之前在写代码的时候，没有关注过这个问题。但是今天看到一副图之后，深以为然，决定以后写代码就按照这个规范来写。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/1c/40e40af64d71455d0b0142db4fb138.png)
定义一个主函数也是非常简单的，只需要在自己写的未封装的代码前面加上如下代码即可：

```python
if __name__ == "__main__":
```

**正则没有研究好**

我总感觉下面这句：

```python
if re.search(r'[a-z]', passwd) and re.search(r'[A-Z]', passwd):
```

可以优化成一句正则就可以了，但是死活没有想出来。反正不是这样的，高人给我指点一下呗：

```python
if re.search(r'[A-Za-z]', passwd):
```

还有就是，标点符号的正则，我用的是 `[_@!,.<>:;-=+/?]`，这能叫正则吗？反正我使用 `[:punct:]` 没能实现我的想法。希望有高人指点呀。

好吧，总结到这里。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


