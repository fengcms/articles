title: centos7 yum 更新出现 [Errno 14] HTTP Error 404 - Not Found 的解决方法
date: 2016-03-17 15:56:10 +0800
update: 2016-03-17 15:56:10 +0800
author: fungleo
tags:
    -centos
    -yum
    -虚拟机
    -Errno-14
---

#centos7 yum 更新出现 [Errno 14] HTTP Error 404 - Not Found 的解决方法

今天准备研究一下centos下面的一些内容,找到虚拟机,打开早先弄好的centos7.进入系统之后,首先是更新了一下时间....还停留在2015年.然后,就需要安装一点软件了.

结果发现,软件更新不了,我以为是源里面没这个软件呢.换了一个,还是出现这个问题.晕死了,打开google找了一下,终于找到了解决方法

```
yum clean all
rpm --rebuilddb
```
执行了这两条命令之后,就一切恢复正常了.
