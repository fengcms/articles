title: Python3 初学实践案例（11）判断质数以及计算一个数字的质因数
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -python
    -质数
    -质因数
    -脚本
---

# Python3 初学实践案例（11）判断质数以及计算一个数字的质因数

昨天晚上看到群里有人问如何计算质因数，我想了一下，实现了这个计算质因数的脚本。

> 质因数（素因数或质因子）在数论里是指能整除给定正整数的质数。除了1以外，两个没有其他共同质因子的正整数称为互质。因为1没有质因子，1与任何正整数（包括1本身）都是互质。正整数的因数分解可将正整数表示为一连串的质因子相乘，质因子如重复可以用指数表示。根据算术基本定理，任何正整数皆有独一无二的质因子分解式[1]  。只有一个质因子的正整数为质数。
> 举例：10 = 2 * 5； 8 = 2 * 2 * 2； 9 = 3 * 3

好，知道了具体的概念，我们就开始时间代码：

## 计算一个数字的质因数完整代码

```python
#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
import sys
# 判断一个数字是否为质数
def isPrime(n):
    if n <= 1:
        return False
    i = 2
    while i*i <= n:
        if n % i == 0:
            return False
        i += 1
    return True

# 计算一个数字的质因数
def calc(num):
    i = 2
    while i*i <= int(num):
    #for i in range(2,int(num**0.5) + 1):
        if num%i == 0:
            arr.append(i)
            if isPrime(num/i):
                arr.append(int(num/i))
            else:
                calc(num/i)
            break
        i += 1
# 输入数字
def checkInput():
    num = len(sys.argv) > 1 and sys.argv[1] or input('输入: ')
    while not num.isdigit():
        print('输入的内容必须是正整数哦！')
        num = input('输入: ')
    return int(num)
# 输出结果
def echo(num, a):
    res = '数字 '+str(num)+' 的质因数结果是: '
    if len(a) == 0:
        res += str(num)
    else:
        res += str(a)[1:len(str(a))-1].replace(', ','*')
    print(res)
# 主函数
if __name__ == '__main__':
    print('这是一个计算一个数字的质因数的程序\n请输入您要计算质因数的数字')
    num = checkInput()
    arr = []
    calc(num)
    echo(num, arr)
```

## 重点解析

**判断数字是否为质数**

判断是否为质数，我之前用 `js` 写过，详情参见：http://blog.csdn.net/FungLeo/article/details/51483844

计算质数的关键是要减少运算量。如果傻呢，就从1循环到这个数字来进行全量循环计算。聪明一点就不需要了，只需要循环到这个数字的平方根的数字即可。

我之前在 `js` 中就是这么干的。上面的代码我是从网上找到的，仔细看了一下，这段代码真的是绝顶聪明。因为循环到平方根，和循环数字用乘法递增，显然后者的运算量要小很多。

重点代码:

```python
while i*i <= n:
    if n % i == 0:
        return False
    i += 1
```

实际体验下来，确实计算效率非常非常高！然后我把计算质因数也改成了这种乘法运算，抛弃了原来的计算平方根的算法。

**检查输入是否为数字**

在第一步中，我们就需要用户输入一个数字。这里我们使用 `python` 自带的 `input` 方法获取用户的输入。但是用户输入的不一定是一个数字，所以需要进行校验，如果不正确的话，就必须重新输入。

一开始我是用的递归的方式来进行处理，但是发现这样如果 `return` 处理不好就会很麻烦。所以改变了思路，使用 `while` 来进行处理，果然简单了很多。

**and or 用法**

这个脚本允许你直接在脚本后面缀上数字来进行直接运算，也可以先进入脚本，然后输入数字进行运算，最重要的就是这个 `and or` 的使用：

```python
num = len(sys.argv) > 1 and sys.argv[1] or input('输入: ')
```

如果有传参，则使用传参，如果没有传参，则让用户输入一个参数。传参和输入，是使用的同一个校验脚本。

有点类似于三元运算，但是又不是。

**字符串的截取与替换**

`python` 的字符串的截取实在是太方便了。

```python
string[1,5]
```
简单方便不用记忆。

而在替换方面和 `js` 是差不多的。都是 `replace` 方法。

计算质因数本身没什么特别的，只是利用了一个数组来存放这个它的质因数。算法比较简单，就不做另外的说明了。

最后，看下执行结果以及运算效率：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/18/7c81474805af119f321d403d90e922.png)
上图是几个很小的数字的运算的结果，顺便演示了传参和后输入数字的结果。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/f7/4fab5dfda60228f7633608cb7a7e10.gif)
从结果我们可以看到这个质数是非常大的，但是运算还是很快就结束了。

我没有再使用命令行处理库来更加完善这个脚本，因为目前这个样子已经非常精简非常好用了。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


