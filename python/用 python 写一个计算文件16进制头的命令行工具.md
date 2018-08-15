# 用 python 写一个计算文件16进制头的命令行工具

文件十六进制头信息是在我们编程中非常常用的一个信息，如果不安装软件，要计算文件的十六进制文件头信息还是比较麻烦的。

所以我顺手写了一个计算文件十六进制头信息的命令行工具，方便自己随时使用。

在 `~/.bin/` 目录下新建 `get-file-hexadecimal` 文件，然后写下以下代码：

>  `~/.bin/` 目录我已经添加到系统环境目录了。

```python
#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
import argparse

# 字节码转16进制字符串
def bytes2hex(bytes):
    hexstr = u""
    for i in range(10):
        t = u"%x" % bytes[i]
        if len(t) % 2:
            hexstr += u"0"
        hexstr += t
    return hexstr.lower()

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.description='计算文件的16进制头字符串信息'
    parser.add_argument("-v", "--version",action='version', version='%(prog)s 1.0')
    parser.add_argument('filePath', help='Source directory', nargs='?')

    args = parser.parse_args()

    filePath = args.filePath
    if filePath:
        with open(filePath, 'rb') as f:
            print('该文件的十六进制文件头是：   ' + bytes2hex(f.read()))
    else:
        print('需要计算文件的路径不能为空!')
```

代码非常简单，主要就是对 `argparse` 命令行参数工具的使用。另外再配合一个二进制文件转16进制字符串的方法函数就构成了。

> 保存好后，`zsh` 用户使用 `. ~/.zshrc`， `bash` 用户使用 `. ~/.bash_profile` 使新添加的命令行工具生效。也可以关闭终端，然后再打开终端就生效了。

使用效果也非常理想：

![获取16进制文件头使用效果](https://raw.githubusercontent.com/fengcms/articles/master/image/b4/32aff6cc7b8554ab0fcfab7d322ce9.jpg)

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


