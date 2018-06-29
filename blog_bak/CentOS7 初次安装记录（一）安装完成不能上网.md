title: CentOS7 初次安装记录（一）安装完成不能上网
date: 2015-11-17 15:58:57 +0800
update: 2015-11-17 15:58:57 +0800
author: fungleo
tags:
    -Centos7
    -linux不能上网
---

#CentOS7 初次安装记录（一）安装完成不能上网

CentOS7.1出来已经很久了，我的服务器也顺利的配置为了7.1，但是是运维同事帮我操作的。而上次出现问题，我重启了一下，出现了很多问题，折腾了很久才把问题解决。

因此，我决定，好好的学习一下 CentOS 7 的日常使用。

折腾虚拟机，怎么安装，这个就不说了。说说遇到的问题，和相应的解决方法

##安装完成后，配置网络的问题

安装完成后，ping 一下百度，不能访问。说明网络不通。

查看本机IP 发现ifconfig命令不好使了。百度一下，知道用IP命令替代了原来的 ifconfig 好啊，这个命令要短很多基本不用记忆了。

收集一下IP命令方法如下：

```language
ip link show						# 显示网络接口信息
ip link set eth0 upi				# 开启网卡
ip link set eth0 down				# 关闭网卡
ip link set eth0 promisc on			# 开启网卡的混合模式
ip link set eth0 promisc offi		# 关闭网卡的混个模式
ip link set eth0 txqueuelen 1200	# 设置网卡队列长度
ip link set eth0 mtu 1400			# 设置网卡最大传输单元
ip addr show						# 显示网卡IP信息
ip addr add 192.168.0.1/24 dev eth0	# 设置eth0网卡IP地址192.168.0.1
ip addr del 192.168.0.1/24 dev eth0	# 删除eth0网卡IP地址

ip route list						# 查看路由信息
ip route add 192.168.4.0/24via192.168.0.254 dev eth0	# 设置192.168.4.0网段的网关为192.168.0.254,数据走eth0接口
ip route add default via192.168.0.254dev eth0		 	# 设置默认网关为192.168.0.254
ip route del 192.168.4.0/24							 	# 删除192.168.4.0网段的网关
ip route del default				# 删除默认路由
```

使用 ip addr 命令看了一下，果然没有没有配置IP地址。进入 `/etc/sysconfig/network-scripts/` 查看 `ifcfg-eth0` 文件，我去，没有这个文件-_-!!! 

看看有啥呢？发现一个文件，文件名为：`ifcfg-eno16777736` 我勒个去，这是什么奇葩名字啊？ vi 打开瞅一眼

果然，这是网卡配置信息。不过奇葩的是 它的 `ONBOOT=no` 好像就是这个原因导致不能正常上网的。改成 `ONBOOT=yes` :wq 保存文件。重启网络服务 `service network restart` 。然后在ping一下百度，果然ping通了。这就说明网络正常了。

不过这里有一个问题，我需要把虚拟机里面的IP给定死，否则每次访问都不知道IP是啥，这是个问题。

再次VI这个文件。再里面添加上

```language
#BOOTPROTO=dhcp
IPADDR0=192.168.1.254
PREFIX0=24
GATEWAY0=192.168.1.1
DNS1=114.114.114.114
```
这里要把dhcp给关闭，所以在前面加上一个#号，注释掉。

再次保存，然后重启网络服务 `service network restart` 。

好了，在宿主机上用putty连接一下，果然连上了。

PS：文章技术资料来自于网络。