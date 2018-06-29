title: Shell 命令行获取本机IP，grep的练习
date: 2017-08-02 17:39:50 +0800
update: 2017-08-02 17:39:50 +0800
author: fungleo
tags:
    -shell
    -grep
    -获取本机IP
    -mac
    -linux
---

# Shell 命令行获取本机IP，grep的练习

在 mac 下面输入 `ifconfig` 或者在 `linux` 下面输入 `ip a` 就可以得到我们的网卡信息。不过通常情况下，我们需要查看的是我们的IP地址，不需要这么多的信息。所以，我想把这些信息给摘取出来。

## mac ifconfig 下面的实现

我们输入 `ifconfig` 会得到大段的信息，我们可以看到我们想要的IP地址前面的字符串是 `inet`

所以，我们优化一下代码如下：

```
ifconfig | grep inet
```
得到如下信息：

```
	inet 127.0.0.1 netmask 0xff000000
	inet6 ::1 prefixlen 128
	inet6 fe80::1%lo0 prefixlen 64 scopeid 0x1
	inet6 fe80::85e:9798:4041:1717%en0 prefixlen 64 secured scopeid 0x4
	inet 192.168.12.139 netmask 0xffffff00 broadcast 192.168.12.255
	inet6 fd86:415c:c5f9::c72:1c02:f044:65de prefixlen 64 autoconf secured
	inet6 fd86:415c:c5f9::cd76:7bb1:f77d:46f0 prefixlen 64 deprecated autoconf temporary
	inet6 fd86:415c:c5f9::508d:685b:6a66:b3ce prefixlen 64 autoconf temporary
	inet6 fe80::9446:a1ff:fe5e:9b8f%awdl0 prefixlen 64 scopeid 0x9
	inet6 fe80::9d71:6fa:3da5:9cb6%utun0 prefixlen 64 scopeid 0xa
```
好，已经精简很多了。

我们再排除掉 `inet6` 和 `127` 的信息，就可以得到我们的本地IP了

```
ifconfig | grep inet | grep -v inet6 | grep -v 127
```
得到

```
	inet 192.168.12.139 netmask 0xffffff00 broadcast 192.168.12.255
```

最前面是一个制表符，我们不管，我们用空格分割，并取第二个字段，就可以得到我们的IP信息了

```
ifconfig | grep inet | grep -v inet6 | grep -v 127 | cut -d ' ' -f2
```
就顺利的得到另外我们想要的本机IP地址。

我们在 `~/.bin/`下面创建一个 `getip` 的文件，并用 `chmod +x ~/.bin/getip` 赋予执行权限。然后在命令行里输入 `getip` 就可以得到我们的本机IP了。

> 需要先把 `~/.bin/` 配置为环境变量，请参考 [将这个命令作为一个系统命令，可以随时执行](http://blog.csdn.net/fungleo/article/details/76582074#t3)

## 在 linux centos 7 下面实现获取本机IP的脚本

`linux` 不使用　`ifconfig` 命令来获取信息，而是使用 `ip a` 来获取。

所以我们把上面的命令修改一下，改成

```
ip a | grep inet | grep -v inet6 | grep -v 127 | sed 's/^[ \t]*//g' | cut -d ' ' -f2
```

由于 linux 中得到的信息的最前面不是制表符而是空格，所以加上了 `sed 's/^[ \t]*//g'` 来清除开头的空格。

其他的逻辑是一样的。如果喜欢的话，也可以搞成全局的，逻辑基本和mac是一致的。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

