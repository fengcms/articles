title: 打造前端 Deepin Linux 工作环境——配置静态服务器
date: 2017-11-04 19:05:48 +0800
update: 2017-11-04 19:05:48 +0800
author: fungleo
tags:
    -python
    -httpserver
    -browsersyn
    -前端
    -deepin
---

#打造前端 Deepin Linux 工作环境——配置静态服务器

我们前面虽然已经安装了一个 `xampp` 的集成服务器环境，但是这个东西实在是太重了。一般情况下，我们写个`css`或者 `js` 居然要跑那个东西我实在是优点受不了。所以呢，我这一篇博文呢，就来讲一下，我们如何搞几个静态的服务器。

##Python 静态服务器

其实 `python` 的服务器功能还是蛮强大的，但是对于我们前端工程师来说，还是把它当成一个简单的静态 `http` 服务器就好。

好，首先我们打开终端工具，在里面输入

```#
python
```

看能否启动 `python` 环境，如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/76/b7f3304e6de09e4895ce9cb39eaf1c.png)
好，我们可以看到 跑的版本是是 `python 2.7.13` 也就是 `python 2` 了。

`python 2` 的启动 `httpserver` 的命令是：

```#
python -m SimpleHTTPServer
```

我们到前面配置 `xampp` 的时候随便写的一个 `html` 文件目录中执行这个命令，如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/3d/8c751e78f943336019319e27d66619.png)
然后我们在浏览器里面输入： `http://127.0.0.1:8000/`，就可以看到如下图所示的结果了。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/c8/a506e9ce9d2f2cb39bf1bcd3528179.png)
这个命令还是有点太长了。我们把这个命令缩短一点，还是用前面的章节中说的方法，在命令行中执行下面的命令：

```#
echo 'alias pyhttp="python -m SimpleHTTPServer"' >> ~/.bash_profile && . ~/.bash_profile
```

执行完成之后，我们就可以用 `pyhttp` 这个我们自定义的一个缩写的命令来启动 `pyhttp` 静态 `http` 服务了。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/da/22628dea7af8fcd4d5580df40a8afb.png)
如果想要换个端口来启动服务，则命令就是

```#
pyhttp 4000
```

这样就可以了。

> 如果你安装的是 `phthon 3` 那么命令就不是 `python -m SimpleHTTPServer` 而是要改成 `python -m http.server` 效果是一样的。

## 全局安装 nodejs 的 http-server 服务

有上面的那一个方法就可以哈，这里是作为一个补充。`nodejs` 有一个 `http-server` 的`http`服务包，全局安装之后，也可以启动一个 `http` 服务。

安装命令如下：

```#
sudo npm install http-server -g
```

安装完成之后，我们就可以使用 `http-server` 命令来启动一个 `http` 服务了。

```#
// 启动一个http服务 默认端口 8080
http-server
// 指定一个端口启动
http-server -p 9000
```

运行结果如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/f4/0b55e168a3adfa2208625a4fc99bd5.png)
这个命令不算太长，但是你和我一样还是喜欢短的，不需要进行缩短，因为它已经给了一个默认的缩短的了。

```#
// 启动一个http服务 默认端口 8080
hs
// 指定一个端口启动
hs -p 9000
```

这我就不放图了。

## 安装 Browsersync 服务

前面的两个静态服务器都是不会自己刷新的，我们为了提高效率，会搞一个自动刷新的 http 服务，然后我们边写代码，浏览器里就自动刷新，这样就可以大大提高我们的效率了。这个我以前的博文中也有推荐过，大家可以看详情：http://blog.csdn.net/fungleo/article/details/60476466

那边是说的 `mac` 系统，其实和 `linux` 是一样一样的。所以详情去我那篇博文看，我这里只说安装命令和命令缩短命令。

**安装 `Browsersync`**

```#
sudo npm install -g browser-sync
```

具体怎么使用，看我上面的连接，我把最常用的，缩短成`bshttp`：

```#
// 编辑配置文件
vim ~/.bash_profile
// 给文件末尾添加
alias bshttp='browser-sync start --server --files "**/*.css, **/*.html"'
//:wq 保存退出
// 使配置文件生效
. ~/.bash_profile
```

## 小结

`python` 一般系统都自带，所以直接用它的没什么不好的。`http-server` 是 `nodejs` 的一个服务包，喜欢就安装，不喜欢也无所谓。最后一个是 `Browsersync` 强烈推荐安装。具体怎么使用，请查看 [效率工具 Browsersync ，文件保存浏览器自动刷新](http://blog.csdn.net/fungleo/article/details/60476466)

本文由FungLeo原创，允许转载，但转载必须附注首发链接。谢谢。