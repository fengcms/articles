title: Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（十）打包项目并发布到子目录
date: 2017-08-26 19:11:54 +0800
update: 2017-08-26 19:11:54 +0800
author: fungleo
tags:
    -vue
    -nodejs
    -httpserver
    -webpack
    -axios
---

# Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（十）打包项目并发布到子目录

## 前情回顾

通过上一章《[Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（九）再把内容页面渲染出来](http://blog.csdn.net/fungleo/article/details/77604490)》的学习，我们其实已经完成了我们设想的项目的开发。但是，我们做好的这套东西，是基于 `nodejs` 开发的。而我们最终希望，我们开发的项目，生成好一堆文件，然后随便通过任何一个 `http` 服务就能跑起来，也就是，还原成我们熟悉的 `html+css+js` 的模式。

好，这章，我们来讲解这部分内容。

## 打包项目

我们进入到终端，并且进入到我们的开发目录：

```#
cd ~/Site/MyWork/vue-demo-cnodejs
```

然后运行如下代码，进行打包：

```#
npm run build
```
运行结果如下：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/86/1958c6a704dc437b5c9b044ebd8b9e.png)
好，我们已经打包好了。文件打包位置于项目目录里面的 `dist` 文件夹内。

但是，我们从上图可以看到，我们生成了一些 `.map` 的文件。这就有点恶心了。当我们的项目变得比较大的时候，这些文件，第一个是，非常大，第二个，编译时间非常长。所以，我们要把这个文件给去掉。

### 去掉 map 文件

我们编辑 `/config/index.js` 文件，找到其中的

```js
productionSourceMap: true,
```

修改为：

```js
productionSourceMap: false,
```

然后我们重新运行打包命令：

```#
npm run build
```
好，我们看下运行结果：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/2a/f4f8e4616de7c56947c198c56442c6.png)
没用的 `map` 文件已经没有了。

好，我们可以从上图中看出，有一个 `tip` 。它告诉我们，打包出来的文件，必须在 `http` 服务中运行，否则，不会工作。

### 安装 http-server 启动 http 服务

我们进入 `dist` 文件夹，然后启动一个 `http` 服务，来看看可以不可以访问。

你可能不知道如何启动这样一个 `http` 服务，或者，你现在已经到 `apache` 里面去进行配置去了。不用那么麻烦，我们有 `nodejs` 环境，只要全局安装一个 `http-server` 服务就好了呀。

```#
npm install http-server -g
```

![](https://raw.githubusercontent.com/fengcms/articles/master/image/8d/5c30b49572b1e30cc12d7712015fb3.png)
> 这里用 `cnpm` 替代了 `npm`

好，通过这个命令，我们就安装好了。安装好了之后正常我们就能够使用 `http-server` 命令来跑服务了。但是，这个世界不正常的时候是很多的嘛！

在终端里面输入，
```#
http-server
```
看能否正常启动，还是爆 `-bash: http-server: command not found` 错误，这里，是说没有找到这个命令，没有关系，这是表示，我们的 `nodejs` 的程序执行路径，没有添加到环境变量中去。

首先，如上图所示，我们的 `http-server` 安装到了 `/usr/local/Cellar/node/7.6.0/bin/` 这个目录下面，我们只要把这个目录，添加到环境变量即可。

> 请注意，你的安装路径可能和我的是不一致的，请注意调整。

我们在终端内执行下面两个命令，就可以了。

```#
echo 'export PATH="$PATH:/usr/local/Cellar/node/7.6.0/bin/"' >> ~/.bash_profile 
. ~/.bash_profile
```
第一条命令是追加环境变量，第二个命令是，使我们的追加立即生效。

> 当然，你也可以直接编辑 `~/.bash_profile` 文件，把上面命令中的单引号里面的内容插入到文件最后面，然后执行第二个命令生效。随便。

好，一个插曲结束。

忘记了我们要干嘛了吗？我们要把我们打包出来的东西跑起来呀！ 

```#
cd dist
http-server -p 3000
```
如果你是严格按照我的教程来的，那么现在已经可以顺利的跑起来了。我们在浏览器中输入 `http://127.0.0.1:3000` 就应该可以访问了。

当然，会报错，说是接口找不到，404错误。因为我们把接口给通过代理的方式开启到了本地，但是这里我们并没有开启代理，所以就跑不起来了。很正常的。

这是因为示例的接口的问题。实际开发你还要按照我的这个做。只不过，最终代码放到真实的服务器环境去和后端接口在一个 `http` 服务下面的话，就不存在这个问题了。

好，我们就跑起来了。

## 将项目打包到子目录

刚刚，我们是将文件，打包为根目录访问的。也就是说，必须在 `dist` 文件夹下面启动一个服务，才能把项目跑起来。

但是我们开发的大多数项目，可能是必须跑在二级目录，甚至更深层次的目录的。怎么做呢？

我们编辑 `config/index.js` 文件，找到：

```js
assetsPublicPath: '/',
```

把 `'/'` 修改为你要放的子目录的路径就行了。这里，我要放到 `/dist/` 目录下面。于是，我就把这里修改为

```js
assetsPublicPath: '/dist/',
```

然后，重新运行

```#
npm run build
```
进行打包。

很快，就打包好了。

还记得，我们在项目文件夹中用 `npm run dev` 就可以开启一个 `http` 服务吗？并且那里，我们还代理了接口的。

好，我们就这么做。

然后我们访问二级目录 `/dist/` 我们就可以看到效果了。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/66/d1439f4d5529af2c3ff30aef23a749.png)
注意，我访问的不是根目录，而是 `/dist/` 这个子目录哦，这里是访问的我们打包的文件的。

```#
├── index.html
└── static
    ├── css
    │   └── app.d41d8cd98f00b204e9800998ecf8427e.css
    └── js
        ├── app.8ffccad49e36e43a4e9b.js
        ├── manifest.7a471601ff5a8b26ee49.js
        └── vendor.057dd4249604e1e9c3b5.js
```

好，到这里，我们的打包工作，就讲完了。

实际开发中，你只需要把 `dist` 文件夹中打包好的文件，给运维他们，让他们去部署到真实的服务器环境就好了。

关于项目打包时，图片等资源的处理，请查看我的博文 http://blog.csdn.net/fungleo/article/details/77799057

> 我知道我讲的有点绕了。但不知道如何组织语言，我相信你自己看两遍，应该能够理解的。

> 如果文章由于我学识浅薄，导致您发现有严重谬误的地方，请一定在评论中指出，我会在第一时间修正我的博文，以避免误人子弟。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


