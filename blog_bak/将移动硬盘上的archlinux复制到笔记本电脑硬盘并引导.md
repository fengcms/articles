title: 将移动硬盘上的archlinux复制到笔记本电脑硬盘并引导
date: 2017-06-12 17:27:12 +0800
update: 2017-06-12 17:27:12 +0800
author: fungleo
tags:
    -arch linux
---

# 将移动硬盘上的archlinux复制到笔记本电脑硬盘并引导

每次安装archlinux我都非常痛苦，在同事的协助下才能完成。为了避免这个问题，我在我的移动硬盘上安装好archlinux，并制作了一个包含linux和grub4dos的启动U盘。在遇到新电脑的时候，只需要把系统复制到新电脑硬盘上，并引导一下，就完成了系统的制作。因为移动硬盘上的archlinux是可以启动的，所以，我可以把常用软件以及配置都安装好，然后一次性就完成啦。

本篇博文对于看官可能没什么作用，除非你已经拥有了安装好arch的移动硬盘和包含linux和grub4dos的启动U盘。

## 复制系统到新电脑

首先，用启动U盘启动电脑，格式化电脑并完成分区。类似于普通电脑的PE操作，但是是基于linux的。

硬盘分区格式为`ext4`

打开终端

```#
# 查看硬盘以及分区信息
fdisk -l
# 挂载笔记本硬盘到系统
mount /dev/sda1 /media/usbdisk
# 挂载装好arch系统的移动硬盘到系统
mount /dev/sdb3 /media/cdrom
// 上面是我的电脑的分区，你自己的需要通过第一个命令查看好，然后修改路径
// 挂载的这两个位置是因为U盘linux自带了这俩文件夹，省得建文件夹了
# 复制系统到笔记本硬盘
cp -rav /media/cdrom/* /media/usbdisk
```
好，就开始复制了，但是因为系统比较大，有10G左右，所以会卡半天，为了便于查看进度，我们新开一个终端窗口，输入下面的命令
```#
# 查看进度
watch du -sh /media/usbdisk
```
在输出的内容中会定时刷新，最下面有大小变化，可以看到。有一些权限不够的提示忽略

## U盘grub4dos引导，进去笔记本硬盘arch系统

完成复制后，我们在终端里面输入`reboot`重启电脑，重启后进入启动U盘菜单，按`c`进入`grub4dos`界面

```#
# 挂载根分区
root (hd1,0)
# 指定系统linux内核 根位置 可读写
kernel /boot/vm<TAB> root=/dev/sda1 rw
# 什么虚拟盘之类的
ini<TAB> /boot/init<TAB>-<TAB>
# 启动
boot
```

不同的版本的 `grub4dos`可能命令格式不一样，比如第一行命令前面需要加上`set`前缀，大概是这么个意思
> `<TAB>`表示按TAB键补全

## 2018年01月12日补充用 archlinux 的 grub 来引导

```#
set root=(hd1,<tab>)
linux /boot/vm<tab> root=/dev/sda1 rw
ini<TAB> /boot/init<TAB>-<TAB>
# 启动
boot
```

## 进入系统后实现引导

初次进入系统可能比较慢，我们可以按`ctrl+alt+f1`和`ctrl+alt+f2`在命令行和图形界面之间切换，多切换几次，就能进入桌面了。

进入系统后，我们打开终端。

```#
# 安装grub
sudo grub-install /dev/sda
# 生成grub菜单
sudo grub-mkconfig -o /boot/grub/grub.cfg
# 完成后重启
reboot
```

然后系统就搞好了。

如果你有相关工具，本文对你会有价值，否则你不知道我在说什么，我写下来是防止自己忘记。

