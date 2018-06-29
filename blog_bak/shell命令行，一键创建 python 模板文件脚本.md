title: shell命令行，一键创建 python 模板文件脚本
date: 2017-12-20 10:39:48 +0800
update: 2017-12-20 10:39:48 +0800
author: fungleo
tags:
    -python
    -shell
    -vim
    -ide
    -脚本
---

# shell命令行，一键创建 python 模板文件脚本

写 `python` 文件时，每个文件开头都必须注明版本和编码。每次我 `touch` 文件之后粘贴这两句话让我不胜其烦。

由于我没有安装 `python` 的 `IDE` 工具，也没有为 `vim` 安装相应的插件。主要是为了练习自己的编码能力，而不希望过于依赖工具，所以为了解决这个问题，我写了这个脚本。

```#
#!/bin/bash
if [ -n "$1" ]; then
  if [ -f "$1" ]; then
    echo $1 '文件已经存在，不能重复创建'
  else
    echo '#!/usr/bin/env python3' > $1
    echo '# -*- coding: UTF-8 -*-' >> $1
    echo $1 '文件创建成功'
  fi
else
  echo '请添加新建 Python 文件名参数'
fi
```

将脚本保存在 `~/.bin` 目录下，命名为 `newpy` 文件，然后将  `~/.bin` 添加到系统环境变量中，然后就可以在命令行中输入

```#
newpy test.py
```

来创建一个自带注释的 `python` 脚本文件了。

如果需要更多的功能，可以不断丰富这个 `shell` 脚本文件。暂时没想到，就这么着吧~如果你有更好的方法，请给我留言哦~

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

