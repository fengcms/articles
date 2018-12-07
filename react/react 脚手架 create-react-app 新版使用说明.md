# React 脚手架 create-react-app 新版使用说明 重点是配置代理

近期更新了一下 `create-react-app` 工具，然后发现，和原来的老版本使用出现了略微的差异。比如原先想要处理 `sass` 还需要去手动配置 `webpack` 但是新版里面已经集成了。此外，代理的配置也完全不一样了。因此，如果是看我之前的 `react` 简明教程的话，是会出现一些不一样的地方的。因此，我重新来整理一下新版的 `create-react-app` 工具的使用说明。

## 安装 create-react-app 脚手架工具

虽然我们可以自己来随意配置 `webpack` 来构建自己的 `react` 开发环境，但是，这样非常不利于我们的团队的工作交接。除非是拥有自己完善的配置以及说明文档，否则，我个人还是推荐大家使用 `create-react-app` 脚手架工具的。因为这样的配置是大家最熟悉的。

`nodejs` 以及 `npm` 的安装我就不做说明了，前端工程师应该全部都知道。如果不知道的话，可以看我博客其他的文章，也是有详细的说明的。

安装 `create-react-app` 非常简单。

```bash
sudo npm i create-react-app -g
```

> 需不需要加 `sudo` 要根据您的操作系统以及权限来确定。

> 如果使用 `npm` 国外的源安装的话，可能会比较慢。因此可以将源设置为淘宝的镜像源，设置命令为：`npm config set registry https://registry.npm.taobao.org`，切换为官方的源可以用命令：`npm config set registry http://www.npmjs.org`。也可以删除 `~/.npmrc` 中的相关设置来恢复为官方源。

![sudo npm i create-react-app -g](https://raw.githubusercontent.com/fengcms/articles/master/image/73/41eaf6adb7a31a18c09c964243308e.jpg)

安装好之后，我们就可以使用 `create-react-app` 命令来创建 `react` 项目了。但是这个命令会比较长一些，因此，我建议大家可以使用命令改写的方式缩短这个命令。

```bash
# zsh 用户运行该命令
echo 'alias cra="create-react-app"' >> ~/.zshrc && . ~/.zshrc
# bash 用户运行该命令
echo 'alias cra="create-react-app"' >> ~/.bash_profile && . ~/.bash_profile
```

> 通过这样设置之后，我们就可以用 `cra` 命令来代替 `create-react-app` 命令了。在使用上回比较简单一点。
> 如果看不懂上述命令是在干啥，就不用管了。本文中会一直用 `create-react-app` 来说明问题的。

## 创建项目

在命令行中，`cd` 到我们希望创建项目的目录后，运行 `create-react-app __PROJECTNAME__` 命令，来创建一个新项目。比如，我们现在要创建一个 `react-demo` 的项目，因此我运行命令：

```bash
create-react-app react-demo
```
![create-react-app react-demo](https://raw.githubusercontent.com/fengcms/articles/master/image/49/6104945b9bffe4fd816eb437c49fe3.jpg)

如上图所示，我们创建的项目已经可以了。

![查看默认文件](https://raw.githubusercontent.com/fengcms/articles/master/image/12/be997144578a7e9ef08ab953702f84.jpg)

我们从上图中可以看到，在默认情况下 `create-react-app` 将 `webpack` 的所有配置文件全部隐藏了，因此，我们需要执行命令打开所有的配置文件，方面我们自己的配置。

```bash
npm run eject
```
运行该命令后，它会让你再确认一下，我们输入 `y` 然后回车即可。

![npm run eject](https://raw.githubusercontent.com/fengcms/articles/master/image/7a/ba823692b1d5fb569e9b7df2a8be9b.jpg)

然后我们再来看一下，现在的目录文件有哪些：

![create-react-app 目录文件](https://raw.githubusercontent.com/fengcms/articles/master/image/40/67cdd2b02483d6cde82419a3382bc3.jpg)

通过上图，我们可以看到，多了 `scripts` 和 `config` 目录。

然后，我们可以通过 `npm start` 命令来启动项目了，浏览器会默认打开 `http://localhost:3000/` 来展示默认的页面的。

> 如果默认的 `3000` 端口有被占用的话，那么会询问你是否用其他的端口来代替，直接回车即可。

![npm start](https://raw.githubusercontent.com/fengcms/articles/master/image/a4/809c9570314364e40e8d0c21912879.jpg)


## 配置 @ 重定向符号

我在之前的 《React + webpack 开发单页面应用简明中文文档教程》简明教程中，也提到了配置 `@` 重定向的问题。我希望将 `/src/` 目录重定向为 `@` 符号，这样，就可以避免在程序中出现大量的 `../../../aaa/bbb` 这样的代码了。我们可以使用 `@/aaa/bbb` 来代替。

这样可以让我们的代码变得更加清晰一些。

我们打开项目根目录下的 `/config/webpack.config.dev.js` 文件，找到 `'react-native': 'react-native-web'`, 这一行，在下面加入：

```js
'@': path.join(__dirname, '..', 'src'),
```

![配置 @ 重定向符号](https://raw.githubusercontent.com/fengcms/articles/master/image/7d/bfae9612f9c2b7cb80ae51b84d7fc8.jpg)

如上图所示，这样配置一下。同时，我们需要修改 `/config/webpack.config.prod.js` 文件的相同部分，不再赘述。

> `webpack.config.dev.js` 是用于开发环境的配置文件，而 `webpack.config.prod.js` 是用于生产环境的配置。因此，开发环境进行了变更，生产环境也要进行同样的变更，否则，在项目最后编译输出的时候，是会出错的。

## 安装 sass 依赖

好的，因为新版本已经集成了 `sass` 的处理了，因此，就不需要额外的配置有关 `sass` 的内容了。但是，如果需要在项目中使用 `sass` 的话，还是需要安装依赖包的。

我们执行下面的命令安装：

```bash
npm i node-sass
```

![npm i node-sass](https://raw.githubusercontent.com/fengcms/articles/master/image/8e/85de52eca04b8be53b27ad28f2ce08.jpg)

安装好后，我们就可以放心的在我们的项目中使用 `sass` 了。

> 貌似 `create-react-app` 中并没有默认配置 `less` ，所以如果你需要使用 `less` 的话，自己找一下相关的资料。不过我的建议是 `less` 没有 `sass` 好用，并且转换没有任何困难，所以除非是老项目，否则建议大家使用 `sass` ，当然，我只是建议而已，各位看官还是要根据自己和团队的需要来确定。

## 配置代理

在原来的 `create-react-app` 脚手架中，是通过 `package.json` 配置文件来配置代理的。但是，在新版的脚手架中，通过 `package.json` 只能配置一个代理。如果需要配置多个代理的话，则不能这么干了。

新版的代理配置，是通过 `/src/setupProxy.js` 这个文件来配置的。比如，我们想要代理 `cnodejs.org` 这个网站的接口，我们可以通过创建这个文件，然后在期中录入以下内容来实现：

```js
const proxy = require('http-proxy-middleware')

module.exports = function(app) {
  app.use(
    proxy(
      '/api/v1', {
        target: 'https://cnodejs.org',
        changeOrigin: true
      }
    )
  )
}
```

创建好这个文件之后，会自动的引用它，不需要额外的配置。不过代理想要生效，必须重新运行项目。

我们重启项目之后，可以在命令行简单的测试一下：

```bash
# 测试命令
curl http://localhost:3000/api/v1/topics
```

![测试代理](https://raw.githubusercontent.com/fengcms/articles/master/image/d5/a2705f23d13c1d22164161d7a24890.jpg)

如上图所示，我们通过访问我们的本地地址，顺利获取到了想要代理的数据了。配置参数和在 `package.json` 中是一样的，只是换了个形式而已。

## 自动刷新的异同

在老版本的脚手架中，有一个 `src/registerServiceWorker.js` 文件，然后在 `src/index.js` 中是这样引用的：

```js
// 引用
import registerServiceWorker from '@/registerServiceWorker'
// 运行
registerServiceWorker()
```

在新版本的脚手架中，这个文件改了名字，并且里面的内容也产生了一些变化。在新版中，是 `src/serviceWorker.js` 文件，在 `src/index.js` 中的使用方法是：

```js
// 引用
import * as serviceWorker from './serviceWorker'
// 运行
serviceWorker.unregister()
```

其实没什么本质差别，只是改了个名字和引用方法而已。

其他更多的内容，请查看我原来的《[React + webpack 开发单页面应用简明中文文档教程](http://blog.csdn.net/fungleo/article/details/80841159)》即可，本文已经将重要的差异都列出来了。希望各位编码开心！

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

