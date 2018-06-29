title: curl 模拟 GET\POST 请求，以及 curl post 上传文件
date: 2018-06-15 11:41:45 +0800
update: 2018-06-15 11:41:45 +0800
author: fungleo
tags:
    -curl
    -curl post
    -curl get
    -curl file
    -man curl
---

# curl 模拟 GET\POST 请求，以及 curl post 上传文件

一般情况下，我们调试数据接口，都会使用一个 `postman` 的工具，但是这个工具还是有点大了。事实上，我们在调试一些小功能的时候，完全没有必要使用它。在命令行中，我们使用 `curl` 这个工具，完全可以满足我们轻量的调试要求。

下面，我们来简单的说一下，`curl` 的一些常见使用方法：

## curl GET 请求

`curl`命令 + 请求接口的地址。

```shell
curl localhost:9999/api/daizhige/article
```

如上，我们就可以请求到我们的数据了，如果想看到详细的请求信息，我们可以加上 `-v` 参数

```shell
curl localhost:9999/api/daizhige/article -v
```

操作结果如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/39/a82372f54d55cd0e383dc91f03726f.jpg)

## curl POST 请求

我们可以用 `-X POST` 来申明我们的请求方法，用 `-d` 参数，来传送我们的参数。

> 所以，我们可以用 `-X PUT` 和 `-X DELETE` 来指定另外的请求方法。

```shell
curl localhost:9999/api/daizhige/article -X POST -d "title=comewords&content=articleContent"
```

如上，这就是一个普通的 `post` 请求。

但是，一般我们的接口都是 `json` 格式的，这也没有问题。我们可以用 `-H` 参数来申明请求的 `header`

```shell
curl localhost:9999/api/daizhige/article -X POST -H "Content-Type:application/json" -d '"title":"comewords","content":"articleContent"'
```

> so, 我们可以用 `-H` 来设置更多的 `header` 比如，用户的 `token` 之类的。

同样，我们可以用 `-v` 来查看详情。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/dc/8d5af88b2b876f4975c197079ec6ea.jpg)
## curl POST 上传文件

上面的两种请求，都是只传输字符串，我们在测试上传接口的时候，会要求传输文件，其实这个对于 `curl` 来说，也是小菜一碟。

我们用 `-F "file=@__FILE_PATH__"` 的请示，传输文件即可。命令如下：

```shell
curl localhost:8000/api/v1/upimg -F "file=@/Users/fungleo/Downloads/401.png" -H "token: 222" -v
```

执行结果如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/38/71194ba9c6156a1e249187aa2ea948.jpg)
更多 `curl` 的使用方法，以及参数说明，可以在系统中输入 `man curl` 来进行查看。或者，点击 [curl man](https://curl.haxx.se/docs/manpage.html) 查看网页版的介绍。

> 所以，我们可以用 `man 命令名称` 来查看更多的工具的介绍。当然，一些非主流的命令行工具，应该是没有相关的介绍的。

可能你会感觉用这些命令才进行操作，感觉破烦。但是，当你仅仅需要请求一个接口，进行一个轻量的操作的时候，是顺手在终端中输入一个命令来得方便，还是打开一个重型的图形工具来得方便呢？

命令行是可以保存历史记录的，我们使用 `ctrl+r` 快捷键可以进行历史命令搜索，这样，我们可以非常方便的重复进行命令调试。

我现在已经养成了在终端中写代码，跑代码，以及调试代码的习惯，我感觉这样非常方便。

当然，我的想法不一定是正确的，但是依然希望，能够对看官有所帮助。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


