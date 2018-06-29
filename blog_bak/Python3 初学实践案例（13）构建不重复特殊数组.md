title: Python3 初学实践案例（13）构建不重复特殊数组
date: 2018-01-23 22:38:37 +0800
update: 2018-01-23 22:38:37 +0800
author: fungleo
tags:
    -python
    -list
    -random
    -set
---

#  Python3 初学实践案例（13）构建不重复特殊数组

## 前言

今天遇到一个问题，很难用一句话描述。所以，我用一段文字来描述这个问题。

1. 输入一个数字，比如 `10`，
2. 得到一个这样的数组：`['2-6', '7-4', '9-4', '3-2', '8-5', '5-6', '4-1', '6-4', '1-3', '3-8']`
3. 里面的数字可以是 `1-10` 之间的任何一个数字。
4. 数组的每一段为两个随机数字，加上 `-` 构成。
5. 这两个数字不能重复，比如： `9-9` 这样的就不行。
6. 数组内不能重复的出现如 `['1-2', '1-2']` 这样的重复字符串。
7. 输出内不能出现如 `['1-2', '2-1']` 这样的字符串，也就是颠倒一下的也不行。
8. 这俩数字，有的前面比后面大，有的后面比前面大。

大概就是这样的要求，应该算是描述清楚了。

我们众人给出自己的方案，我的方案如下：

## 完整代码

```python
#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
import random

# 创建一个随机数组
def genList (x):
    # 根据 x 值，先创建一个可以选择的数组字典
    dic = []
    for i in range(1,x+1):
        dic.append(str(i))
    res = []
    # 生成 x*2 的随机字符串，放进 res 这个数组
    for i in range(1,x*2):
        # 从 dic 字典里随机取两个不重复的数字
        # 排序，然后用 - 分割形成一个符合要求的字符串
        res.append('-'.join(sorted(random.sample(dic,2))))
    # 将数组去重（set）方法
    arr = list(set(res))
    # 如果去重后的数组的长度小于要求的长度，则重新再来一次
    if len(arr) < x:
        return genList(x)
    # 否则，取前 x 个 return
    else:
        return arr[0:x]
# 上面得到的数组中的字符串的第一个数字一定小于第二个数字
# 所以这里进行一个随机的倒排
def randomList (x):
    # 先用上面的方法得到一个符合要求的数组
    # 但这个数组的第一个数字一定小于第二个数字
    arr = genList(x)
    res = []
    # 循环一下得到的数组
    for i in arr:
        # 在1和2之间得到一个随机数
        # 如果得到的随机数等于1则直接加入到 res 数组
        if random.randint(1,2) == 1:
            res.append(i)
        # 否则，将字符串用 - 分割成数组，倒排
        # 然后在用 - 分割组成字符串，添加到 res 数组
        else:
            res.append('-'.join(i.split('-')[::-1]))
    # 这一句本来是准备再把数组随机排序一下的
    # 但是好像没有必要，徒增运算量，就注释了
    #random.shuffle(res)
    # 返回结果
    return res

# 主函数，打印一下
if __name__ == "__main__":
    print(randomList(10))
```

## 关键点

**在一个序列中取出 n 个不重复的内容**

```python
random.sample(dic,n)
```
`n` 为数字，切不能大于序列 `dic` 的长度，否则会报错。

**数组排序**

```python
sorted()
```
数字或者字符串都能排序

**数组去重**

```python
list(set(arr))
```
原理非常简单，`set` 里面是不能有重复内容的。所以先转成 `set` 再转成 `list` 即可实现去重。


**数组转字符串**

```python
'-'.join(arr)
```
`'-'` 是确定分隔符，如果不需要分隔符，则 `''.join(arr)` 即可。

**字符串转数组**

```python
arr.split('-')
```
`'-'` 是确定分隔符，如果不需要分隔符，则 `''.join(arr)` 即可。

**数组倒排**

```python
arr[::-1]
```

字符串也可以用这个进行倒排

团队中几个专业后端都用不同的思路实现了，但是像我这样操作字符串的好像独一份。如果是你，你有什么好的方法吗？

## 补充其他实现代码

### 我自己的代码的装逼版

```python
import random

def genList (x):
    dic = [str(i+1) for i in range(x)]
    res = list(set(['-'.join(sorted(random.sample(dic,2))) for i in range(x*2)]))
    return genList(x) if len(res) < x else res[0:x]

def randomList (x):
    return [i if random.randint(1,2) == 1 else '-'.join(i.split('-')[::-1]) for i in genList(x)]

if __name__ == "__main__":
    print(randomList(10))
```

### 朋友给出的更加合理的方案

```python
import random
import itertools
def genList(x):
    dic = list(range(1,x+1))
    random.shuffle(dic)
    return [str(i[0]) + '-' + str(i[1]) for i in random.sample(list(itertools.combinations(dic,2)),x)]

if __name__ == "__main__":
    print(genList(10))
```

### 结合我的代码，给出最终装逼版

```python
import random
import itertools

# plan 1
def genList(x):
    return [i if random.randint(1,2) == 1 else '-'.join(i.split('-')[::-1]) for i in [str(i[0]) + '-' + str(i[1]) for i in random.sample(list(itertools.combinations(list(range(1,x+1)),2)),x)]]

if __name__ == "__main__":
    print(genList(10))
```

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

