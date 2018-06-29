title: 好用的 Linux \ Mac 搜索命令 fd 命令用法
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -
---

# 好用的 Linux \ Mac 搜索命令 fd 命令用法

我们平时在使用搜索工具的时候，一般使用 `find` 命令，这个命令比较繁琐，需要输入的参数较多。

```shell
find ./ -iname "*.txt"
```

![](https://raw.githubusercontent.com/fengcms/articles/master/image/5f/bda8c5bc740f08cedfe427a06b898a.png)
今天发现了一个好用的命令 `fd` 命令

该命令 github 仓库地址： https://github.com/sharkdp/fd

## fd 命令安装方法

### Ubuntu or Deepin
*... and other Debian-based Linux distributions.*

Download the latest `.deb` package from the [release page](https://github.com/sharkdp/fd/releases) and install it via:
``` bash
sudo dpkg -i fd_7.0.0_amd64.deb  # adapt version number and architecture
```

### Arch Linux

```shell
pacman -S fd
```

### On macOS

You can install `fd` with [Homebrew](http://braumeister.org/formula/fd):
```
brew install fd
```

使用演示：

![fd 命令用法](https://github.com/sharkdp/fd/raw/master/doc/screencast.svg?sanitize=true)

这个命令还是非常好用的。希望大家喜欢。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

