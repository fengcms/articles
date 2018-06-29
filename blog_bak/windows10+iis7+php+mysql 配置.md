title: windows10+iis7+php+mysql 配置
date: 2015-12-14 00:07:16 +0800
update: 2015-12-14 00:07:16 +0800
author: fungleo
tags:
    -windows
    -mysql
    -php
    -iis
    -iis7.0
---

#windows10+iis7+php+mysql 配置
##前言
相信大家在工作中一般是使用linux或者mac系统。使用windows的话，一般是使用环境套件。

但是我不一样，因为历史原因，我有一些ASP开发的网站需要维护。所以呢，必须安装iis环境。同时，我现在的开发一般都是基于php环境的，所以我非常抑郁于在IIS下配置PHP环境。

每次都是需要不断的百度，还搞不定，今天又搞了一遍。写这篇博文，就是为了便于以后自己再配置的时候，不需要老是找资料了。

##iis的安装

这个比较简单，不截图了

1. 打开“控制面板”
2. 找到“程序和功能”,双击打开
3. 在左侧点击“启用和关闭windows功能”
4. 找到“internet information services”，点开前面的“+”号然后按照下图进行设置

![](https://raw.githubusercontent.com/fengcms/articles/master/image/a9/f95663bdddb609a380077811ec01e6.jpg)
什么安全性啦什么的，全部选上，基本上普通的ASP开发这样就可以了。


安装完成后，在浏览器中输入 `http://127.0.0.1` 就能够看到iis 已经安装成功了。

##PHP的安装

首先当然是要下载PHP安装文件，这里不推荐在国内的乱七八糟的网站进行下载。直接去官方网站进行下载。

下载地址：http://php.net/downloads.php

找到你想要的版本，点击 “Windows downloads”进入下载页面，选择 zip 版本的进行下载。例如：http://windows.php.net/downloads/releases/php-5.6.16-nts-Win32-VC11-x86.zip 这个下载地址。

把文件下载下来，解压到`d:\service\php ` 文件夹。网上大多数教程是说放在`d:\php`文件夹。我不习惯这么干。。。。等下还有mysql要放呢，直接放这里就好了。然后就一个文件夹，看着比较舒服。

解压到这里之后，把`php.ini-development`改名为`php.ini` 这个就是配置文件了。

然后用编辑器打开这个配置文件。

找到`date.timezone`将其修改为`date.timezone = PRC` 就是说，把时区设置为中国。

然后，就是配置一下需要的组件了。就是一堆 `extension=`啥的。可以根据需要打开，所谓打开，就是把前面的 `;` 给删掉就好了。如果你不知道需要打开什么，那么就打开下面几个一般就够用了：

```
extension=php_bz2.dll
extension=php_curl.dll
extension=php_fileinfo.dll
extension=php_gd2.dll
extension=php_gettext.dll
extension=php_gmp.dll
extension=php_intl.dll
extension=php_imap.dll
extension=php_mbstring.dll
extension=php_exif.dll
extension=php_mysql.dll
extension=php_mysqli.dll
extension=php_openssl.dll
extension=php_pdo_mysql.dll
```
好了。这里，会有很多傻逼说把`php.ini `给复制到windows目录去。我在这里强调一下——
**完全没有必要**
**完全没有必要**
**完全没有必要**
重要的事情说三遍。每次看到让复制就头疼。

时间不早了。剩下的明天写。