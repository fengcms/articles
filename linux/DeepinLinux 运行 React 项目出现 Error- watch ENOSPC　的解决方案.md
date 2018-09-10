# DeepinLinux 运行 React 项目出现 Error: watch ENOSPC　的解决方案

今天给新来的前端同事安装了 `DeepinLinux`，然后在运行 `React` 项目的时候出现了 `Error: watch ENOSPC` 的报错。我很奇怪为什么会出现这个错误，随后找到了这篇文章，原文如下：

## Error: watch ENOSPC　的解决方案

在 `Fedora` 和 `Ubuntu` 的操作系统中，使用 `gulp` 时出现问题，`gulp` 报错 `Error：watch ENOSPC` 的问题

出现类似这种错误可以试试

```bash
Error: watch ENOSPC

    at errnoException (fs.js:1024:11)
    at FSWatcher.start (fs.js:1056:11)
    at Object.fs.watch (fs.js:1081:11)
    at startWatcher (/usr/local/lib/node_modules/coffee-script/lib/coffee-script/command.js:359:27)
    at watchDir (/usr/local/lib/node_modules/coffee-script/lib/coffee-script/command.js:392:14)
    at compilePath (/usr/local/lib/node_modules/coffee-script/lib/coffee-script/command.js:139:9)
    at Object.exports.run (/usr/local/lib/node_modules/coffee-script/lib/coffee-script/command.js:98:20)
    at Object.<anonymous> (/usr/local/lib/node_modules/coffee-script/bin/coffee:7:41)
    at Module._compile (module.js:456:26)
    at Object.Module._extensions..js (module.js:474:10)
    at Module.load (module.js:356:32)
    at Function.Module._load (module.js:312:12)
    at Function.Module.runMain (module.js:497:10)
    at startup (node.js:119:16)
    at node.js:902:3

```

当前问题主要是因为 `gulp` 的 `watch` 需要监听很多文件的改动，但是 `fedora`、 `ubuntu`系统的文件句柄其实是有限制的，因此可以使用以下命令：

```bash
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
```
　　
对于以上 `Linux` 下 `gulp` 报错 `Error：watch ENOSPC` 的解决方法就介绍完了

----

原文地址：https://blog.csdn.net/elliotnotebook/article/details/54599994

我们知道 `Ubuntu` 系统是基于 `Debian` 的，而 `Deepin` 也是基于 `Debian` 系统的。所以命令是通用的，我运行原文中给出的命令后，问题顺利解除。

> 转载文章内容，如有侵权请留言，我将删除本文。


