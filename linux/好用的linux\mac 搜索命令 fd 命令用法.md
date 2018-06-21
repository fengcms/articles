# 好用的 Linux \ Mac 搜索命令 fd 命令用法

我们平时在使用搜索工具的时候，一般使用 `find` 命令，这个命令比较繁琐，需要输入的参数较多。

```shell
find ./ -iname "*.txt"
```

![find 命令用法](https://img-blog.csdn.net/20171109143227657?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvRnVuZ0xlbw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

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

