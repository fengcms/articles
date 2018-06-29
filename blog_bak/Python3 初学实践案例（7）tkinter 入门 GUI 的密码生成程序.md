title: Python3 初学实践案例（7）tkinter 入门 GUI 的密码生成程序
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -python
    -密码
    -tkinter
    -gui
    -界面
---

# Python3 初学实践案例（7）tkinter 入门 GUI 的密码生成程序

前面我已经非常好的完成了 `cli` 的密码生成程序的编写 http://blog.csdn.net/fungleo/article/details/78842597

虽然这个脚本已经非常理想了，但是对于大多数人来说，还是用不上的。毕竟，我不能要求所有人都去使用命令行。所以我决定写一个 `gui` 的图形界面的程序。

说起来简单，但做起来就太难了。我没有任何编写图形界面程序的经验，通过几天的研究，终于实现了部分功能：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/e0/cd017ef8fe50d960de880dd9846701.gif)
## tkinter 实现完成代码

这真是个垃圾玩意儿，我决定放弃这个东西了。接下来没想好到底学习哪个库，估计在 `wxpython` 或者 `pyqt` 里面选择一个。但目前没有确定。

先来说说 `tkinter` 这个东西吧。这个是 `python` 自带的 `gui` 的库。它的说明文档非常糟糕，我勉强写下了下面的程序：

```python
from tkinter import *
import sys
import clipboard
import random

def cutLength(leng, level):
    res = []
    for i in range(level, 1, -1):
        res.append(random.randint(1, leng - sum(res) - i + 1))
    res.append(leng - sum(res))
    random.shuffle(res)
    return res

def makePassword(dists, arr):
    res = []
    for i in range(len(arr)):
        for j in range(arr[i]):
            res += random.choice(dists[i])
    random.shuffle(res)
    return ''.join(res)

def getPassword(leng, level):
    arr = cutLength(leng,level)
    str1 = '01'
    str2 = '23456789'
    str3 = 'abcdefghijkmnpqrstuvwxyz'
    str4 = 'ABCDEFGHJKMNPQRSTUVWXYZ'
    str5 = '_@!,.:;-=+/?'

    dists = {
        1: [str1 + str2],
        3: [str2, str3, str4],
        4: [str2, str3, str4, str5]
    }
    return makePassword(dists[level], arr)

def test(res):
    if res.isdigit():
        return int(res) > 4
    else:
        return False

def calcPlus():
    leng.set(int(leng.get()) + 1)

def calcSubt():
    lengVal = int(leng.get())
    if lengVal > 4:
        leng.set(lengVal - 1)

def getPw():
    res = getPassword(int(leng.get()),level.get())
    clipboard.copy(res)
    pw.set(res)

if __name__ == "__main__":
    root = Tk()
    root.title('密码生成器')
    leng = StringVar()
    leng.set(8)

    f1 = Frame(root)
    f1.pack(padx=10,pady=5)

    testCMD = root.register(test)

    Label(f1, text="密码长度：").grid(row=0,column=0)

    f1r = Frame(f1)
    f1r.grid(row=0, column=1)

    e1 = Entry(f1r, textvariable=leng, width=5, validate="key",validatecommand=(testCMD, '%P')).grid(row=0,column=1)


    Button(f1r, text="+", command=calcPlus).grid(row=0, column=2)
    Button(f1r, text="-", command=calcSubt).grid(row=0, column=3)

    level = IntVar()
    level.set(3)

    Label(f1, text="密码强度：").grid(row=1,column=0)

    f1rb = Frame(f1)
    f1rb.grid(row=1, column=1)

    Radiobutton(f1rb, text="简单", variable=level, value=1).grid(row=1, column=1)
    Radiobutton(f1rb, text="一般", variable=level, value=3).grid(row=1, column=2)
    Radiobutton(f1rb, text="复杂", variable=level, value=4).grid(row=1, column=3)

    pw = StringVar()
    Entry(root,textvariable=pw,state="readonly").pack()

    submit = Button(root,text="生成密码并复制到剪切板", command=getPw)
    submit.pack()

    mainloop()
```

## 补充说明

首先我们创建了一个最简单的图形界面的程序

```python
# 引入库
from tkinter import *
# 创建一个实例
root = Tk()
# 主循环进程
mainloop()
```

然后我们在命令行中输入命令 `pyhton3 xxx.py` 就可以跑起来一个图形界面的程序了。

默认是没有任何东西的。我们可以往里面去添加东西。就是不断的往 `root` 下面添加东西。

首先呢，我们可以设置一下程序的标题：

```python
root.title('密码生成器')
```

然后，在里面可以添加框架，框架里面添加文本框，文字，按钮这些东西。

基础使用请看下我上面的代码吧。都是非常基础的知识。主要是文档太烂了，我不准备再继续研究了，太累了。

仅以此文纪念我的第一个GUI程序~

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

