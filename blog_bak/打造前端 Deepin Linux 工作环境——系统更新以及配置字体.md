title: 打造前端 Deepin Linux 工作环境——系统更新以及配置字体
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -前端
    -deepin
    -linux
    -meslo
    -安装字体
---

#打造前端 Deepin Linux 工作环境——系统更新以及配置字体

安装好编辑器，然后就准备码代码了，但是感觉字体不是很好看。所以决定配置一下字体。顺便把系统给更新一下

## Deepin linux 系统更新命令

执行下面的命令进行系统更新

```#
sudo apt-get update && sudo apt-get dist-upgrade -y
```

虽然 `deepin` 提供了图形界面的系统更新，但是说实话，我不太信任，还是使用命令行更新系统会让我更放心一些，毕竟发生了什么我都能够看到。

## 下载 `meslo` 系统等宽字体

由于我常年使用 `mac` 系统，所以对 `mac` 上的等宽字体 `menlo` 字体情有独钟。在 `linux` 上，有一款模仿的开源字体，叫 `meslo`。我们就安装这个字体就可以。

首先，我们到 https://github.com/andreberg/Meslo-Font/blob/master/dist/v1.2.1/Meslo%20LG%20v1.2.1.zip 这个地址下载字体文件，。

然后打开终端

```#
# 进入下载目录
cd ~/Downloads/
# 解压下载下来的字体文件
unzip Meslo\ LG\ v1.2.1.zip
# 回到家目录
cd ~
# 创建个人字体文件夹
mkdir .fonts
# 将解压下来的字体文件挪到刚刚创建的个人字体文件夹内
mv ~/Downloads/Meslo\ LG\ v1.2.1 ~/.fonts/Meslo
# 更新字体缓存
fc-cache
# 查看一下，字体是否安装成功
fc-list | grep Meslo
```
![](https://raw.githubusercontent.com/fengcms/articles/master/image/63/43269cb76b8932e1362eb6c4cb9627.png)
## 下载安装苹方中文字体

尝试了好几种中文字体，最终，还是习惯苹果的苹方字体。所以我从我的苹果系统中把字体提出来，并上传到了 `csdn` 的下载里面供大家下载。

下载地址：http://download.csdn.net/download/fungleo/10104776

下载之后，把我们字体文件复制到 `~/.fonts/Apple/`文件夹中。

```#
# 创建存放字体的文件夹
mkdir ~/.fonts/Apple
# 将字体文件放到文件夹中，如果你不是我这个路径，请自行调整命令
mv ~/Download/PingFang.ttc ~/.fonts/Apple/PingFang.ttc
# 更新字体缓存
fc-cache
# 查看一下，字体是否安装成功
fc-list | grep PingFang
```


## 设置系统默认字体

点击状态栏设置图标，在弹出的设置面板中，点击个性化，字体，然后按照下图进行设置：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/8e/6573ff69ecac8945379c0dd1d3eafa.png)
标准字体选择 **苹方-简**，等宽字体选择 **Meslo LG M**

> 如果你的等宽字体中没有刚刚安装的 `Meslo` 字体，那就注销一下系统，再看一下，应该就有了。
> 设置完之后，不会立即生效，需要注销一下，才能生效。

感觉一下设置的字体是否合你的心意，如果不行的话，再找找其他的字体，多尝试一下。我个人的感觉是 `deepin` 的字体渲染的效果比 `mac` 要有所欠缺，但是比 `windows` 还是要好上一些的。当然，可能你看习惯了 `windows` 的渲染效果，感觉这边也是怪怪的。总之，慢慢适应一下吧。

反正怎么安装字体是教给大家了。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。title: 打造前端 Deepin Linux 工作环境——系统更新以及配置字体
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -前端
    -deepin
    -linux
    -meslo
    -安装字体
---

#打造前端 Deepin Linux 工作环境——系统更新以及配置字体

安装好编辑器，然后就准备码代码了，但是感觉字体不是很好看。所以决定配置一下字体。顺便把系统给更新一下

## Deepin linux 系统更新命令

执行下面的命令进行系统更新

```#
sudo apt-get update && sudo apt-get dist-upgrade -y
```

虽然 `deepin` 提供了图形界面的系统更新，但是说实话，我不太信任，还是使用命令行更新系统会让我更放心一些，毕竟发生了什么我都能够看到。

## 下载 `meslo` 系统等宽字体

由于我常年使用 `mac` 系统，所以对 `mac` 上的等宽字体 `menlo` 字体情有独钟。在 `linux` 上，有一款模仿的开源字体，叫 `meslo`。我们就安装这个字体就可以。

首先，我们到 https://github.com/andreberg/Meslo-Font/blob/master/dist/v1.2.1/Meslo%20LG%20v1.2.1.zip 这个地址下载字体文件，。

然后打开终端

```#
# 进入下载目录
cd ~/Downloads/
# 解压下载下来的字体文件
unzip Meslo\ LG\ v1.2.1.zip
# 回到家目录
cd ~
# 创建个人字体文件夹
mkdir .fonts
# 将解压下来的字体文件挪到刚刚创建的个人字体文件夹内
mv ~/Downloads/Meslo\ LG\ v1.2.1 ~/.fonts/Meslo
# 更新字体缓存
fc-cache
# 查看一下，字体是否安装成功
fc-list | grep Meslo
```
![](https://raw.githubusercontent.com/fengcms/articles/master/image/63/43269cb76b8932e1362eb6c4cb9627.png)
## 下载安装苹方中文字体

尝试了好几种中文字体，最终，还是习惯苹果的苹方字体。所以我从我的苹果系统中把字体提出来，并上传到了 `csdn` 的下载里面供大家下载。

下载地址：http://download.csdn.net/download/fungleo/10104776

下载之后，把我们字体文件复制到 `~/.fonts/Apple/`文件夹中。

```#
# 创建存放字体的文件夹
mkdir ~/.fonts/Apple
# 将字体文件放到文件夹中，如果你不是我这个路径，请自行调整命令
mv ~/Download/PingFang.ttc ~/.fonts/Apple/PingFang.ttc
# 更新字体缓存
fc-cache
# 查看一下，字体是否安装成功
fc-list | grep PingFang
```


## 设置系统默认字体

点击状态栏设置图标，在弹出的设置面板中，点击个性化，字体，然后按照下图进行设置：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/8e/6573ff69ecac8945379c0dd1d3eafa.png)
标准字体选择 **苹方-简**，等宽字体选择 **Meslo LG M**

> 如果你的等宽字体中没有刚刚安装的 `Meslo` 字体，那就注销一下系统，再看一下，应该就有了。
> 设置完之后，不会立即生效，需要注销一下，才能生效。

感觉一下设置的字体是否合你的心意，如果不行的话，再找找其他的字体，多尝试一下。我个人的感觉是 `deepin` 的字体渲染的效果比 `mac` 要有所欠缺，但是比 `windows` 还是要好上一些的。当然，可能你看习惯了 `windows` 的渲染效果，感觉这边也是怪怪的。总之，慢慢适应一下吧。

反正怎么安装字体是教给大家了。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。