# React + webpack 开发单页面应用简明中文文档教程（二）创建项目

## React 入门系列教程导航

[React + webpack 开发单页面应用简明中文文档教程（一）一些基础概念](http://blog.csdn.net/fungleo/article/details/80841159)
[React + webpack 开发单页面应用简明中文文档教程（二）创建项目](http://blog.csdn.net/fungleo/article/details/80841181)
[React + webpack 开发单页面应用简明中文文档教程（三）目录说明以及调整项目构架文件](http://blog.csdn.net/fungleo/article/details/80841200)
[React + webpack 开发单页面应用简明中文文档教程（四）调整项目文件以及项目配置](http://blog.csdn.net/fungleo/article/details/80841220)
[React + webpack 开发单页面应用简明中文文档教程（五）配置 api 接口请求文件](http://blog.csdn.net/fungleo/article/details/80841241)
[React + webpack 开发单页面应用简明中文文档教程（六）渲染一个列表，初识 jsx 文件](http://blog.csdn.net/fungleo/article/details/80841255)
[React + webpack 开发单页面应用简明中文文档教程（七）jsx 组件中调用组件、父组件给子组件传值](http://blog.csdn.net/fungleo/article/details/80841263)
[React + webpack 开发单页面应用简明中文文档教程（八）Link 跳转以及编写内容页面](http://blog.csdn.net/fungleo/article/details/80841274)
[React + webpack 开发单页面应用简明中文文档教程（九）子组件给父组件传值](http://blog.csdn.net/fungleo/article/details/80841290)
[React + webpack 开发单页面应用简明中文文档教程（十）在 jsx 和 scss 中使用图片](http://blog.csdn.net/fungleo/article/details/80841296)
[React + webpack 开发单页面应用简明中文文档教程（十一）将项目打包到子目录运行](http://blog.csdn.net/fungleo/article/details/80841308)

****

在上一篇博文当中，你是否感觉我实在是太啰嗦了一点，说了很多你不喜欢听的东西呢。

不重要啦，这里，我们开始。

使用 `mac` 或者 `Linux` 系统的朋友直接进行，使用 `windows` 的朋友，先自行解决终端的问题。

> 上一篇博文让你安装 `nodejs` ，不会没安装吧？没安装赶紧去安装。

## 安装脚手架

打开终端工具，输入下面的命令，安装 `react` 脚手架

```shell
sudo npm i -g create-react-app
```

> 会要求你输入系统用户密码，输入密码的时候，看不见星号，完成后直接按回车。正确就会执行，否则会告诉你密码错误。

全局安装 `create-react-app` 工具。

然后我们就可以使用 `create-react-app` 来创建项目了。

****

这段可以跳过

我觉得这个命令比较长，所以我们可以将这个命令简写一下

**Bash 用户**

```shell
echo 'alias cra="create-react-app"' >> ~/.bash_profile
. ~/.bash_profile
```

**zsh 用户**

```shell
echo 'alias cra="create-react-app"' >> ~/.zshrc
. ~/.zshrc
```

然后我们就可以使用 `cra` 这个命令，来取代这个长命令了。

可跳过部分结束。

## 创建项目

在命令行中，进入到你希望创建项目的目录。

```shell
cd ~/Sites/Mywork
```

创建一个 `react-test` 的项目

```shell
create-react-app react-test
```

然后这个命令需要运行一会儿。它在下载一些东西。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/b3/1de48e5ebe2464425bf115131cd3fa.jpg)

如上图所示，我们已经执行完成了。已经给出了接下来要执行的命令。

## 运行项目

根据上图给出来的命令，我们直接执行：

```shell
cd react-test
npm start
```

![](https://raw.githubusercontent.com/fengcms/articles/master/image/da/d228164bdde7a9e28da5c8a4bb0264.jpg)

> 因为我 3000 端口被占用，所以跑在了 3002 端口上了。之前会有一个提示，直接回车即可继续运行。

然后应该会自动打开系统默认浏览器，访问 http://localhost:3002/ 地址。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/28/9650238d06ed80d2643568d664e7bd.jpg)


好，到这里，我们今天的工作就完成了，顺利的搭建，并跑起来了。

相信你也没遇到什么问题。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


