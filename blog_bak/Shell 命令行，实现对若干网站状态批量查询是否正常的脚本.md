title: Shell 命令行，实现对若干网站状态批量查询是否正常的脚本
date: 2017-08-03 17:05:21 +0800
update: 2017-08-03 17:05:21 +0800
author: fungleo
tags:
    -shell
    -脚本
    -curl
    -查看网站状态
---

# Shell 命令行，实现对若干网站状态批量查询是否正常的脚本

如果你有比较多的网站，这些网站的运行状态是否正常则是一件需要关心的事情。但是逐一打开检查那简直是一件太糟心的事情了。所以，我想写一个 shell 脚本来实现对若干网站进行批量状态查询的脚本。

原理没什么要解释的，就是使用 `curl -I` 对网站的状态码进行查询。轮着查就是了。

## 文件准备

在要执行的脚本文件夹下面创建两个文件和一个文件夹，分别是

| 文件、文件夹|说明|
|:---|:---|
| ./watch.sh | 我们的批量查询脚本文件 |
| ./siteList.txt | 我们的域名列表文件 |
| ./log/ | 存放日志的文件夹 |

当然，你不需要完全按照我的设计来，但是需要知道一一对应的知道文件关系。

**siteList.txt** 文件内容
```
www.youtube.com
www.google.com
www.xxx.com
www.baidu.com
www.sina.com.cn
www.weibo.com
www.sohu.com
www.renren.com
```
如上的域名列表，一行一个，把你的网站全写进去即可。

## 实现 shell 脚本

```
logfile='./log/webSite-Status-'`date '+%Y%m%d'`'.log'
#touch $logfile
echo '--- watch web site by Fungleo ---' >> $logfile
echo '--- Web:blog.csdn.net/fungleo ---' >> $logfile
echo '--- Begin '`date '+%Y-%m-%d %H:%M:%S'`' ---' >> $logfile

sitelist=siteList.txt

i=0
l=$(wc -l $sitelist | sed 's/^[ \t]*//g' | cut -d ' ' -f1)
while read url; do
  # 进度百分比
  echo -en "\b\b\b\b"`echo $i*100/$l | bc `'%'
  ((i++))
  # 运行内容
  #result=$(curl --connect-timeout 3 -sI $url )
  result=$(curl --connect-timeout 3 -sL -D- $url -o /dev/null)
  curl_status=$?
  if [[ $curl_status -eq 0 ]]; then
    status=$(echo $result | grep HTTP | cut -d ' ' -f2)
  else
    status='die'
  fi
  echo 'status:'$status' | curl status:'$curl_status' | site:'$url  >> $logfile
done < $sitelist;

echo -e '--- End '`date '+%Y-%m-%d %H:%M:%S'`' ---\n' >> $logfile
echo -e '\b\b\b\bOK     '
```

## 解释原理

1. 根据当前时间创建一个日志文件，存放在 `./log/` 文件夹下
2. 输出开头的一些内容，可以自行调整
3. 获取域名列表文件并存放到变量
4. 计算进度百分比内容，更多参考 [Shell 循环中实现展示进度百分比的脚本方法](http://blog.csdn.net/fungleo/article/details/76576487)
5. `curl` 去查状态码，超过3秒就认为是失败了。时间可以自定义。
6. 根据执行结果判断是否正常，正常就返回正常的`HTTP`状态码，否则输出`die`
7. 将执行结果输出到日志文件
8. 打印完成时间
9. 在终端标准输出 `ok` 表示脚本执行完成。

## 后续

在 `curl -I www.qq.com` 的时候，长时间没有响应，不知道为什么。可能是QQ网站禁止这样查询。但如何跳过不知道怎么解决，我是设定了超出时间的。比较奇怪，有知道的朋友告诉我一下。

> 上网查了一下相关资料，将  `result=$(curl --connect-timeout 3 -sI $url )` 更换为 `result=$(curl --connect-timeout 3 -sL -D- $url -o /dev/null)` 就解决了查 www.qq.com 会停止响应的问题。因为有一些网站会屏蔽掉 `head` 查询。
> 算解决了。你有更好的方法吗？

在 MAC 下，这个脚本用 `sh watch.sh` 执行会轻微出错，必须用 `bash watch.sh` 执行。

或 `chmod +x ./watch.sh` 赋予执行权限后 `./watch.sh` 执行。

以上脚本均在 mac 下测试通过，在 Linux 下可能会有稍许不同。
本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

