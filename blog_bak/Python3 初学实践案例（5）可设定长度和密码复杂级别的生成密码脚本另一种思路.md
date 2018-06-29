title: Python3 初学实践案例（5）可设定长度和密码复杂级别的生成密码脚本另一种思路
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -python
    -密码
    -脚本
    -设计
---

# Python3 初学实践案例（5）可设定长度和密码复杂级别的生成密码脚本另一种思路

在上一篇博文当中，我们用 `python` 脚本实现了一个可设定长度和密码复杂级别的生成密码的脚本，详情见：http://blog.csdn.net/fungleo/article/details/78803493 ，在上一篇博文当中，我是用掷骰子的方式实现的。

其实，我开始设计这个脚本的时候，就有两种思路。就像掷骰子一样，如果我们要得到一个 6，有两种方式，一种是我们要一次性成功的掷成功为 6 ，还有一种方式就是，不断的掷骰子，一直得到 6 这个结果才罢休。

在第一次准备实现的时候，我采用了不断扔，直到拿到符合条件的结果才输出。虽然实现了效果，但是当我想要取得一个4位的复杂密码的时候（同时满足数字、小写字母、大写字母、标点符号），其运行结果还是让我有点崩溃的。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/32/489e445dd8317f3cd0b91e17f2ff8c.png)
如上图所示，它运行了很多次才得到了我想要的记过。而问题是，从理论上来说，最坏的结果是，可能永远都得不到我想要的结果，虽然这个可能性非常低，但是总是存在的。

所以，我决定，把另外一个思路，就是一次性给扔出来，保证百分百只执行一次就可以的脚本实现出来。而我，实现了：

## 实现脚本

```python
#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
import random
import argparse

# 根据需要的结果，剪出一个数组
def cutLength(leng, level):
    # 算法比较复杂，简化来说，就是已知数组长度，和数组内数字的和
    # 求一个随机的数组，满足上面的两个条件
    res = []
    for i in range(level, 1, -1):
        res.append(random.randint(1, leng - sum(res) - i + 1))
    res.append(leng - sum(res))
    # 因为第一位生成大数字的几率高于后面的几位，
    # 所以在得到结果后，随机排序一下,以期待更随机一些
    random.shuffle(res)
    return res
# 根据上面生成的数组和对应的字典，制造一个密码数组
def makePassword(dists, arr):
    res = []
    for i in range(len(arr)):
        res += random.choices(dists[i], k=arr[i])
    return res
# 生成一个密码函数
def getPassword(leng, level):
    # 根据密码长度和等级，去求一个满足条件的数组
    arr = cutLength(leng,level)
    # 制造字典
    str1 = '01'
    str2 = '23456789'
    str3 = 'abcdefghijkmnpqrstuvwxyz'
    str4 = 'ABCDEFGHJKMNPQRSTUVWXYZ'
    str5 = '_@!,.:;-=+/?'

    sDist = [str1+str2]
    cDist = [str2,str3,str4]
    dDist = [str2,str3,str4,str5]

    # 生成密码
    res = []
    if level == 1:
        res = makePassword(sDist,arr)

    if level == 3:
        res = makePassword(cDist,arr)

    if level == 4:
        res = makePassword(dDist,arr)
    # 得到结果后，再一次随机排序
    random.shuffle(res)
    # 最后把数组变成字符串，并输出
    return ''.join(res)
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

    # 默认密码等级为一般
    level = 3

    if args.simple:
        level = 1
    if args.difficult:
        level = 4

    # 去得到密码
    res = getPassword(length, level)
    print(res)
    exit()
```

## 其他补充

其实代码本身没有什么难度，就是如何根据不同的条件，切出来一个符合条件的随机数组难为了我。我在纸上画了半天，终于写出来了。代码如下：

```python
res = []
for i in range(level, 1, -1):
    res.append(random.randint(1, leng - sum(res) - i + 1))
res.append(leng - sum(res))
```

TMD这个代码的详细解释我还解释不出来。不过确实是我自己在纸上画了半天之后，写了一堆的代码，然后不断的简化，最终得到的。

可惜的是，猛的一看这个代码，我也不知道是个啥意思……

![](https://raw.githubusercontent.com/fengcms/articles/master/image/21/f81d1addc95f18304392867eeef58a.png)
`python` 是可以实现图形界面的软件的。下面我准备把我这个脚本写成一个 `gui` 的软件。

是不是有点无聊啊？管它呢，学着玩儿呗~

本文由FungLeo原创，允许转载，但转载必须附注首发链接。谢谢。


