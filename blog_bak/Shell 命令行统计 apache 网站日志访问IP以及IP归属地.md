title: Shell 命令行统计 apache 网站日志访问IP以及IP归属地
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -apache
    -shell
    -统计ip
    -curl
---

# Shell 命令行统计 apache 网站日志访问IP以及IP归属地

我的一个站点用 apache 服务跑着，积攒了很多的日志。我想用 shell 看看有哪些人访问过我的站点，并且他来自哪里。

因为日志太长了，所以我没跑完就放弃了，因为跑起来太慢了。。。

## 分析 apache 日志

```
140.205.16.220 - - [26/Jun/2017:03:49:51 +0800] "GET /content_article_3.html HTTP/1.1" 200 3
```

日志内容如上，这个很简单，只要以空格分割，取第一个就得到了IP了。

## 编写脚本

```
i=1
# 要分析的日志文件
log=apache.log
l=$(wc -l $log | sed 's/^[ \t]*//g' | cut -d ' ' -f1)
echo $l
while read line; do
  echo -en "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b"`echo $i*100/$l | bc `'%/'$i'/'$l
  ((i++))
  ip=`echo $line | cut -d ' ' -f1`
  grep "\<$ip\>" ip.txt >/dev/null
  if [ $? -ne 0 ]; then
    curl -sL http://ip.cn/index.php?ip=$ip >> ip.txt
  fi
done < $log
echo -e '\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\bbOK     '
```

首先呢，当然是把我昨天写的进度拿出来整合进去啦。[Shell 循环中实现展示进度百分比的脚本方法](http://blog.csdn.net/fungleo/article/details/76576487)，但是因为文件是在是太长了一点，百分比已经看不到动态的表现，所以就又加上了显示行数和总行数。

然后用 `cut` 获取到每行的 `ip` 地址。

然后用 `grep` 在 `ip.txt` 这个文件中查找一下这个 `ip` 存在不存在，但是我不想把结果打印到终端，所以用输入到 `/dev/null` 实现禁止标准输出。

然后用 `$?` 输出结果是否为 `0` 判断这个 `ip` 是否存在过。

如果不存在，就去 `ip.cn` 查询一下 `ip` 归属地，并将结果追加到 `ip.txt` 文件

最后就完成了。

因为要上网查，所以效率是比较慢的。不过结果不重要，重要的是实现的过程。通过解决问题，还是学习到两个知识点。

以上脚本均在 mac 下测试通过，在 Linux 下可能会有稍许不同。
本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

