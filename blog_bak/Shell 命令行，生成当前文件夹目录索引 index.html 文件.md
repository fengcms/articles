title: Shell 命令行，生成当前文件夹目录索引 index.html 文件
date: 2017-10-14 13:17:24 +0800
update: 2017-10-14 13:17:24 +0800
author: fungleo
tags:
    -shell
    -生成索引
    -目录索引
---

# Shell 命令行，生成当前文件夹目录索引 index.html 文件

做了一些原型图放在 `git` 上面，在服务器配置好自动拉取 `git` 中的文件，并配置一个 `httpServer` 服务跑起来，我想就可以在浏览器中直接访问这些生成好的原型 `html` 文件了。

但实际情况下，为了安全考虑，服务器关闭了**目录索引**，也就是说，如果目录中不存在 `index.html` 文件的话，就会出现 `403` 错误。

好吧，为了这点东西让打开服务器的**目录索引**很明显是不合适的。但总不至于我每次都得去写一个 `index.html` 文件吧，这些原型图的变化还是很频繁的。

所以，我想写一个脚本，来一劳永逸的解决问题。

代码如下：

```#
files=$(ls)
main=index.html
cat /dev/null > $main
echo '<!DOCTYPE html><html lang="zh-CN"><head><meta charset="UTF-8"><title>产品组各类原型图</title></head><body><h1>产品组各类原型图</h1><ul>' > $main
for i in $files; do
  if [ $i != 'index.html' ] && [ $i != 'getindex.sh' ] && [ $i != 'main.html' ]; then
    echo '<li><a href="'$i'">'$i'</a></li>' >> $main
  fi
done
echo '</ul></body></html>' >> $main
echo '首页文件生成完毕'
```

逻辑非常的简单：

1. 用 `ls` 获取当前文件夹下的所有文件
2. 创建一个空的 `index.html` 文件，如果 `index.html` 文件存在，则将文件内容填充为空
3. 写进去文件头部的固定的代码
4. 将 `ls` 来的文件名称进行循环，用判断去除不需要的文件名，其他的循环写入 `index.html` 文件
5. 最后再写入固定的文件尾部内容
6. 提示生成完毕

以上脚本均在 centos 和 MAC 下测试通过，在其他 linux 下可能会有稍许不同。 
本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

