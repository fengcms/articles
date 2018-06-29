title: Shell 命令行实现将一个站点页面全部下载到本地并替换其中链接的脚本
date: 2017-08-04 15:14:55 +0800
update: 2017-08-04 15:14:55 +0800
author: fungleo
tags:
    -shell
    -脚本
    -curl
    -wget
---

# Shell 命令行实现将一个站点页面全部下载到本地并替换其中链接的脚本

不知道为什么，我总想用 Shell 脚本来实现把一个站点内容给下载下来。但是下载什么站点我确不知道。今天尝试了一下利用 `curl` 实现了下载一个站点列表的 `demo` 算是小试牛刀。

当脚本成功之后，我知道，要把这个站点完全下载下来也是没有问题的。不过是需要更加复杂的循环和匹配而已。

接下来有工作要做，所以 shell 的学习暂时先告一段落。

## 实现代码

```#
#!/bin/bash
echo '--开始下载首页--'
curl -s 'http://man.linuxde.net/par/5' > ./html/index.html
mh=./html/index.html
sl=$(nl $mh | grep '<div class="list_bd clearfix">' | head -1 | sed 's/^[ 	]*//g' | cut -d ' ' -f1)
el=$(nl $mh | grep "<div class='paging'>" | head -1 | sed 's/^[ 	]*//g' | cut -d ' ' -f1)
sed -n  "$sl","$el"'p' $mh > main.htm

echo '--开始下载内页--'
#<a href="
while read line; do
  url=$(echo $line | grep '<a href="' | sed 's/<div class="name"><a href="//g' | cut -d '"' -f1)
  if [[ -n $url ]]; then
    echo '--开始下载' $name '页面--'
    name=$(echo $url | cut -d '/' -f4)
    html='./html/'$name'.html'
    curl -s $url > $html
    # echo '--开始处理' $name '页面链接--'
    # sed -i 's/http:\/\/man\.linuxde\.net\//g' $html
  fi
done < main.htm

echo '--页面下载完成--'
echo '--处理页面链接--'

sed -i '' 's/http:\/\/man\.linuxde\.net\///g' $(grep -rl 'http://man.linuxde.net' ./html)
sed -i '' 's/" title="/\.html" title="/g' $(grep -rl '" title="' ./html)
echo '--链接处理完成--'
```

## 实现原理

1. 先下载列表首页。我这里只是尝试，所以只下载了第一页。如果要下载多页，做好循环之后，自动下载就是。
2. 截取页面的列表内容区域。
3. 根据页面特点，拆解出页面链接。
4. 循环下载链接并保存。
5. 批量替换页面的链接不合适的地方。

然后就大功告成了。

不过 `wget` 比 `curl` 可能更适合干这个工作。我目前还没有学到很深入。回头有时间再接着研究一下。

## 后续补充

看了下 `wget` 我气炸了。原来我要下载人家网站全站，用 `wget` 一句命令就可以搞定了 -_-|||

```#
wget --mirror -p --convert-links -P ./ http://man.linuxde.net/
```

神奇的 `shell` ！

以上脚本均在 mac 下测试通过，在 Linux 下可能会有稍许不同。 
本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


