title: Python3 初学实践案例（12）将源目录中的图片根据设定最长边参数保存到目标目录脚本（Image 的使用）
date: 2017-12-25 18:55:16 +0800
update: 2017-12-25 18:55:16 +0800
author: fungleo
tags:
    -python
    -脚本
    -图片
    -Image
    -pil
---

# Python3 初学实践案例（12）将源目录中的图片根据设定最长边参数保存到目标目录脚本（Image 的使用）

如果我们给客户制作网站，客户会发送过来一堆的图片，这些图片一般都是通过手机或者数码相机拍摄的。有一个问题就是这些图片会比较大。那我们就需要对这些图片进行压缩的处理，这就是我写的这个脚本的实际用途。

关键问题是算法，例如，我要求图片最长边为 `400px`，那么理想情况下，处理的状态应该是：

1. 源图片尺寸为 `800*600`，则缩放后结果是 `400*300`
2. 源图片尺寸为 `600*800`，则缩放后结果是 `300*400`
3. 源图片尺寸为 `300*200`，因为无论是宽和高均小于我们设定的最长边，所以，原样保存不做处理。

好，如果我文字描述不足以让你理解，通过上面的详细举例，我相信应该能理解我的意图了。

## 最终实现源码

```python
#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
import argparse
import os
import imghdr
from PIL import Image

# 错误退出函数
def errMsn(msn):
    print('\033[31mError:\033[0m ' + msn)
    parser.print_usage()
    exit()

# 在源目录中找到所有图片并输出为数组
def findImg(sdir):
    res = []
    if not os.path.exists(sDir):
        errMsn('Source directory don\'t exist')
    for f in os.listdir(sdir):
        fp = os.path.join(sdir, f)
        if not os.path.isdir(fp):
            if imghdr.what(fp):
                res.append(fp)
    if len(res) == 0:
        errMsn('There is no image in the source directory')
    else:
        return res

# 循环缩放所有图片
def resizeImg(arr, size, tdir, imgQual):
    for img in arr:
        simg = Image.open(img)
        simg_w = simg.size[0]
        simg_h = simg.size[1]
        
        # 如果原图片宽高均小于设置尺寸，则将原图直接复制到目标目录中
        if simg_w <= size and simg_h <= size:
            simg.save(tdir + '/' + os.path.basename(img), quality=imgQual)
        else:
            # 比较源图片的宽高，计算处理后的宽高
            timg_w = size
            timg_h = int(size * simg_h / simg_w)
            if simg_w < simg_h:
                timg_w = int(size * simg_w / simg_h)
                timg_h = size
            # 缩小图片并保存
            timg = simg.resize((timg_w, timg_h),Image.ANTIALIAS)
            timg.save(tdir + '/' + os.path.basename(img), quality=imgQual)
    print('\033[32mSuccess:\033[0m Task Finish')

# 目标目录处理函数
def checkTargetDir(sdir, tdir):
    # 如果目标目录为空时提示用户确认
    if not tdir:
        print('\033[33mWarning:\033[0m If the target directory isn\'t set, the processing '\
                'results will cover the picture in the source directory\n'\
                '\033[36mWhether to Continue(Y/n)\033[0m ')
        confirm = input('Confirm:')
        if confirm in ('', 'Y', 'y'):
            print('\033[34mInfo:\033[0m The target directory is ' + sdir)
            return sdir
        else:
            exit()
    else:
        # 如果目标目录设定，但是不存在，则提示用户是否创建目标目录
        if not os.path.exists(tdir):
            print('Target directory don\'t exist\n'\
                    '\033[36mWhether to create the Target directory(Y/n)\033[0m')
            confirm = input('Confirm:')
            if confirm in ('', 'Y', 'y'):
                os.makedirs(tdir)
                return tdir
            else:
                exit()
        else:
            return tdir

if __name__ == "__main__":
    # 设置命令行参数
    parser = argparse.ArgumentParser()
    parser.description='Reduce the picture in the source directory and save it to \
            the target directory based on the longest side parameters'
    parser.add_argument("-v", "--version",action='version', version='%(prog)s 1.0')
    parser.add_argument('size', type=int, help='The max width or max height of a picture')
    parser.add_argument('sourceDir', help='Source directory')
    parser.add_argument('targetDir', help='Target directory', nargs='?')
    parser.add_argument('-q', '--quality', type=int, help='Save picture quality, default 60')
    args = parser.parse_args()

    size = args.size
    sDir = args.sourceDir
    imageArr = findImg(sDir)
    tDir = checkTargetDir(sDir,args.targetDir)
    imgQual = args.quality or 60
    # 执行处理 
    resizeImg(imageArr, size, tDir, imgQual)
```

## 运行结果

**查看帮助信息**

![](https://raw.githubusercontent.com/fengcms/articles/master/image/98/f58e686cdc9093e5af55c019d46f74.png)
**只设置了最长边参数以及源目录**

![](https://raw.githubusercontent.com/fengcms/articles/master/image/70/ee0e3cd00a4c8a92cf18b97d82f5fa.png)
脚本会提示，不设置目标目录则会覆盖源文件，直接回车，或者输入 `Y` 或者 `y` 确认，输入 `N` 或者 `n` 则退出程序。

**设定了目标目录，但目标目录不存在**

![](https://raw.githubusercontent.com/fengcms/articles/master/image/fa/ac8f9d61491c2a8ef932450c9d9afe.png)
脚本会提示目标目录不存在，直接回车，或者输入 `Y` 或 `y` 则会创建这个目录，输入 `N` 或者 `n` 则退出程序。

**正常以及报错状态**

![](https://raw.githubusercontent.com/fengcms/articles/master/image/e4/2601114e7d61651530e9ff49e1b55a.png)
## 代码解析

首先，要写命令行的脚本，就需要处理各种各样的参数，所以，`argparse` 库是必不可少的。关于这个库的使用，可以看下我学习 `python` 的第三篇博文的详细介绍[《argparse 命令行参数库的使用》](http://blog.csdn.net/fungleo/article/details/78784180) ，这里我就不详细说明了。


**Python os 库对文件夹的常见用法**
```python
# 判断目录是否存在
os.path.exists(__dir__)
# 判断文件是否存在
os.path.isfile(__file__)
# 判断路径是否为文件夹
os.path.isdir(__path__)
# 创建多层文件夹(也可以创建单层文件夹)
os.makedirs(__path__)
# 根据路径取得文件的文件名
os.path.basename(__path__)
```

更多可以查看文档 https://docs.python.org/3/library/os.path.html

关于图片处理，可以查看 `python pil` 的官方文档 http://infohost.nmt.edu/tcc/help/pubs/pil/pil.pdf

简单点，可以查看廖雪峰的文章 https://www.liaoxuefeng.com/wiki/001374738125095c955c1e6d8bb493182103fac9270762a000/00140767171357714f87a053a824ffd811d98a83b58ec13000

回头尝试一下用 `tk` 写一个 `gui` 这个工具，因为确实这个工具还蛮实用的。

更多内容源码里面已经注释了。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

