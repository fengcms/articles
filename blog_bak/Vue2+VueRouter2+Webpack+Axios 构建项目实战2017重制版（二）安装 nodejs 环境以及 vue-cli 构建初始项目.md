title: Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（二）安装 nodejs 环境以及 vue-cli 构建初始项目
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -Vue
    -VueRouter
    -Webpack
    -vue-cli
    -nodejs
---

# Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（二）安装 nodejs 环境以及 vue-cli 构建初始项目

在上一篇《[Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（一）基础知识概述](http://blog.csdn.net/fungleo/article/details/77575077)》中，我简要的说明了我为什么要写这个系列的博文，以及我们需要了解的一些基础知识。希望你已经认真阅读，并查阅了一定量的相关资料。对我们要做的事情，有一个起码的认知，否则在接下来的博文中，很可能你不知道我说的是什么，导致学习比较困难。

当然，我也不反对上来就干这种学习心态。但是，一定要认真，just do it，绝不代表鲁莽上阵。

另外，建议你能翻墙，这样可以很好的使用 `google` 搜索引擎 以及 `github` 这样的网站。

## 安装 nodejs 环境

你可以在 `https://nodejs.org/` nodejs 官方网站下载安装包，然后进行安装。如果是 `linux` 或者 `mac` 命令行的用户，也可以使用命令行安装。

### mac 安装 nodejs

![](https://raw.githubusercontent.com/fengcms/articles/master/image/85/2cb0fad78ac91c6026b04829e845a5.png)
如果你没有安装 `brew` 包管理器，可以直接使用下面的命令安装：

```#
curl "https://nodejs.org/dist/latest/node-${VERSION:-$(wget -qO- https://nodejs.org/dist/latest/ | sed -nE 's|.*>node-(.*)\.pkg</a>.*|\1|p')}.pkg" > "$HOME/Downloads/node-latest.pkg" && sudo installer -store -pkg "$HOME/Downloads/node-latest.pkg" -target "/"
```

如果你安装了 `brew` 包管理器，用下面的命令安装

```#
brew install node
```
### linux 安装 nodejs

**Arch linux**

```#
pacman -S nodejs npm
```

其他 linux 系统我没有上手实践，不敢乱说，请参考官方网站的文档操作 [命令行安装 nodejs](https://nodejs.org/en/download/package-manager/)

> windows 虽然可以安装 nodejs 直接在官方网站下载安装包就可以安装。但是我还是强烈建议你换个操作系统。否则，请确保你能自行解决 windows 自身的很多问题。

在安装好了 `nodejs` 之后，我们在终端中输入以下两个命令：

```#
node -v
npm -v
```
![](https://raw.githubusercontent.com/fengcms/articles/master/image/db/29479b99e5368fd555d4a9d1725f52.png)
能够得到如上图的版本号信息，则说明你的 `nodejs` 环境已经安装完成了。

## 安装 vue-cli VUE的脚手架工具

在终端中输入

```#
npm install -g vue-cli
```

这里我简单说下：

1. `npm` 是 `nodejs` 的官方包管理器。可以简单的理解为，用这个来管理所有的依赖包，虽然不仅仅是如此。
2. `install` 命令表示执行安装操作。
3. `-g` 是命令参数，代表，这个包将安装为系统全局的包。也就是说，在任何地方都可以用这个包。
4. `vue-cli` 是我们安装的包的命令。

安装完成后，我们在终端中输入：

```#
vue -V
```

注意，这里的 `V` 是大写的。如果输出为下面的图片中的内容，则代表你安装正确。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/4e/6c0cc2afbb7d181885c12464bbb2a7.png)
> 每个软件的参数都是不一样的，一般，在命令名称后面加上 `--help` 命令，就可以查看这个命令的帮助信息。当然，大多数软件在直接输入命令后回车，也可以看到帮助信息，或者告诉你，如何查看帮助信息。

## 用 vue-cli 构建一个项目

先得了解一些基本的 终端命令。可以看下我的博文《[打造前端MAC工作站（五）让我们熟悉一下 MAC 命令行吧！](http://blog.csdn.net/fungleo/article/details/58623587)》。

> 在 `linux` 系统和 `mac` 中大多数命令是差不多的。但是因为 `mac` 是基于 `unix` 系统的，所以命令比 `linux` 的要严格一些。
> 也就是说，`mac` 下面的命令，在 `linux` 中一般都能正确执行，但是 `linux` 的命令，由于参数放的位置比较随意，在 `mac` 下可能就执行出错。
> 本系列博文的命令是在 `mac` 下运行的，所以在 `linux` 下是完全没有问题的。

首先，我们进入准备放我们的项目的文件夹，以我本地为例，准备放在 `~/Site/MyWork` 文件夹下面。我们执行下面的命令：

```#
cd ~/Sites/MyWork/
```
跳转到我准备放项目的文件夹

```#
vue init webpack vue-demo-cnodejs
```

用我们刚刚安装的 `vue-cli` 脚手架命令 `vue` ，初始化 `init` 一个以 `webpack` 为模板的名叫 `vue-demo-cnodejs` 的项目。

> `vue-cli` 脚手架工具不仅仅支持以 `webpack` 为构架的项目模板，还支持其他的。详情参看 `vuejs-templates` 的 `github` [vuejs-templates](https://github.com/vuejs-templates)

然后，终端里面会问你：

```#
? Project name (vue-demo-cnodejs)
```
项目名称是不是 `vue-demo-cnodejs` ，我们按回车，表示，是。当然，你也可以重写一个，然后回车。

然后，又问你：

```#
? Project description (A Vue.js project)
```

项目藐视，一个 `vue.js` 的项目。同样，我们可以填写内容，或者直接回车。

然后，又问你：

```#
? Author (fungleo <web@fengcms.com>)
```
作者，直接回车。

然后
```#
? Vue build (Use arrow keys)
❯ Runtime + Compiler: recommended for most users
  Runtime-only: about 6KB lighter min+gzip, but templates (or any Vue-specific HTML) are ONLY allowed in .vue files -
render functions are required elsewhere
```

这里是问你，需要不需要安装编译器，我们选择需要安装，也就是第一个，也就是直接回车就OK了。

然后

```#
? Install vue-router? (Y/n)
```

问是不是需要安装 `vue-router` ，需要安装，这个是管理路由的。我们直接回车。

> 在 `mac` 或者 `linux` 系统中，出现这样的选项，默认选项一般会是大写，如上 `(Y/n)` 就表示直接回车，将代表同意，如果你看到了 `(y/N)` 这样的，就表示，默认选择的是否，这时候，就需要输入 `y` 然后回车。当然，前提是你决定要这样做。

然后

```#
? Use ESLint to lint your code? (Y/n)
```
是否需要使用 `ESLint` 来检查你的代码。需要！所以同上，我们直接回车。

然后

```#
? Pick an ESLint preset (Use arrow keys)
❯ Standard (https://github.com/feross/standard)
  Airbnb (https://github.com/airbnb/javascript)
  none (configure it yourself)
```

然后问你需要使用哪种风格来检查你的代码。我们选择第一个 `Standard` 来检查代码。所以，直接回车。

然后问你

```#
? Setup unit tests with Karma + Mocha? (Y/n)
```

是否需要安装测试功能。不要。我们输入 `n` 然后回车。

然后问你

```#
? Setup e2e tests with Nightwatch? (Y/n)
```

还是关于测试的内容，我们还是输出 `n` 然后回车。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/02/2fc99ce723bf95e05dad1cbfb01de7.png)
如上图所示，最终，这个项目初始完成了。

并且，终端里面，告诉你，接下来执行三条命令：

```#
cd vue-demo-cnodejs
npm install
npm run dev
```
分别是，进入项目文件夹； 对项目进行初始安装； 测试运行项目；

PS:

其中， `npm install` 因为需要联网，并且是去连 `github` ，如果你没有翻墙的话，可能速度会比较慢。我们可以使用国内淘宝提供的 `npm` 镜像源来进行安装，解决翻墙的问题。

安装方法

```#
npm install -g cnpm --registry=https://registry.npm.taobao.org
```

更多内容，请参考 `cnpm` 官方网站： https://npm.taobao.org/

好，拉回正题，上面的命令执行截图如下：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/f4/20f753c03e38c850cd9f55de9f52eb.png)![](https://raw.githubusercontent.com/fengcms/articles/master/image/7e/a84d9b2f2242102a2822d8c616322e.png)
执行完 `npm run dev` 命令后，默认会在浏览器里面打开页面。页面如下：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/23/dbb90bfe1d20a612d8a5b8c38bd0ca.png)
好，到这里，我们已经顺利的安装了 `nodejs` 环境和 `vue-cli` 脚手架工具，并且利用脚手架工具生成了一个基于 `webpack` 的项目。

你的第一个基于 `vue` 项目已经顺利的执行了。

> 如果文章由于我学识浅薄，导致您发现有严重谬误的地方，请一定在评论中指出，我会在第一时间修正我的博文，以避免误人子弟。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

## standard 标准风格规范说明

我们在上面安装了代码校验，并且采用了 `standard` 标准风格规范。那么这到底是一个什么规范呢？其实我上文给出了它的官方 `github` 仓库地址：https://github.com/feross/standard 但是，这里说明的是英文，可能你英文不太好，所以我找了一下中文翻译，如下：

- 缩进使用两个空格。
- 字符串使用单引号，用双引号只是为了避免转义单引号。
- 无未使用变量。这能帮助发现大量的错误。
- 不使用分号。这么做，没问题，真的！
- 行首不能是 `(` ，`[`  或 `` ` ``  。
	- 这是省略分号时唯一陷阱—— `standard` 自动为你检查。
- 关键字后面放一个空格。`if (condition) { ... }`
- 函数名字后面放一个空格。`function name (arg) { ... }`
- 始终用 `===`，不要用 `==`。不过可以用 `obj == null` 检测 `null || undefined`。
- 始终处理 `node.js` 回调的 `err` 参数。
- 始终以 `window` 引用浏览器的全局变量。 `document` 和 `navigator` 除外。
	- 这是为了防止使用浏览器那些命名糟糕的全局变量，比如 `open`, `length`, `event` 和 `name`。

更多中文内容，请访问：http://hongfanqie.github.io/standardjs/ 这里查看。我只是简单看了一下这里，更多资料请自行搜索。

本人一开始是一个坚定的缩进 `tab` 党，并且是能不使用空格就不使用空格，并且强调一定要写分号的。

现在完全适应了这套风格规范，已经在这套风格规范下面写了一年多的代码了。最重要的是，团队当中的每一个人都采用这种规范写代码，合作会变得比较顺畅。
