title: git 统计项目各个开发人员开发情况工具 git-fame 的使用
date: 2018-01-11 21:48:43 +0800
update: 2018-01-11 21:48:43 +0800
author: fungleo
tags:
    -git
    -git-fame
    -统计代码
---

#git 统计项目各个开发人员开发情况工具 git-fame 的使用

作为管理人员，我们需要统计一下小组内各个开发人员的详细开发情况，使用 git 可以很方便的统计，但是怎么统计，这是个问题。

今天我找到了一个工具 `git-fame` 使用非常方便。

```#
#install
sudo gem install git-fame
```

安装完成后，在项目中使用 `git fame` 命令，就可以看到统计情况了，结果如下：

```#
$ git fame
Git Fame:      100% |ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo| Time:   0:00:02

Statistics based on master
Active files: 35
Active lines: 10,516
Total commits: 12

Note: Files matching MIME type image, binary has been ignored

+---------+--------+---------+-------+-----------------------+
| name    | loc    | commits | files | distribution (%)      |
+---------+--------+---------+-------+-----------------------+
| fungleo | 10,516 | 12      | 35    | 100.0 / 100.0 / 100.0 |
+---------+--------+---------+-------+-----------------------+
1 row in set
```

非常清楚，希望大家喜欢这个工具。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。