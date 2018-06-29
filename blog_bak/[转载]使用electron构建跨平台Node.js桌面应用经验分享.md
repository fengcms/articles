title: [转载]使用electron构建跨平台Node.js桌面应用经验分享
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -经验分享
    -桌面应用
    -跨平台
    -node.js
    -可视化
---

#[转载]使用electron构建跨平台Node.js桌面应用经验分享

>本文原文地址：http://www.zhangxinxu.com/wordpress/2017/05/electron-node-js-desktop-application-experience/

最近，把团队内经常使用的一个基于Node.js制作的小工具给做成了可视化操作的桌面软件，使用的是electron，这里简单分享一下使用electron的一些经验和心得。

##一、如何使用electron把基本的开发环境给跑起来？

我是这么处理的，`electron`官方提供了一个名为“electron-quick-start”的示例项目，地址为：https://github.com/electron/electron-quick-start

然后把相关资源给弄下来，如果你是下载Zip包解压的，则资源默认都会放在一个名为“electron-quick-start-master”的文件夹中，把“electron-quick-start-master”改成你项目的名字，当然你不改也没关系，就怕过段时间忘记，然后小手一抖，当做普通资源给删掉了，到时候就男默女泪了。

然后安装：
```#
npm install
```
由于安装包比较大，所以-\/要转好几分钟才能装好。如果安装不顺利，试试换成使用淘宝NPM镜像：
```#
npm install -g cnpm --registry=https://registry.npm.taobao.org
```
然后再这么安装：
```#
cnpm install
```

![](https://raw.githubusercontent.com/fengcms/articles/master/image/d8/ac85477beaca5494aa8380c90079ae.png)
然后启动：
```#
npm start
```
然后就会出现这样的框框：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/b8/e8d3b1c36ae85c6d86c47a654fa136.png)
环境就这么跑起来了。
`Ctrl + R`就可以刷新。

##二、electron开发该怎么入手？
一旦环境跑起来，接下来的工作就跟做一个网页几乎就没什么区别，加载点CSS，图片啊，JS什么的，就可以了。因为本质上，`electron`就是给你搞了一个Chrome浏览器的壳子，只是比传统网页多了一个访问桌面文件的功能。

当然，具体操作并不可能像嘴皮子动的那么简单，前期还是需要了解一些基础知识。

我们可以重点关注一下上一节安装好的开发环境的一些资源文件，主要是`index.html`, `main.js`和`renderer.js`，如下图：
![](https://raw.githubusercontent.com/fengcms/articles/master/image/de/122c47e1c649fab62e969f4c6d89ef.png)
在我看来，如果我们要开发的桌面应用只要不像QQ软件那样复杂，其实可以完全不用管`main.js`，`main.js`的作用就是用来显示`npm start`后出现的那个窗口的，而我们的工作只是窗口里面内容，因此，`main.js`无需关心。

`index.html`是打开的窗口加载的页面，可以看成是入口页面，就是一个普通的静态页面啊，没什么特殊的。

`renderer.js`默认里面就一堆注释，用来放业务相关JS的，和网页JS的区别在于，这里的`JS`不仅可以访问`DOM`，还能使用`Node.js`所有的API。能前能后，想怎么玩都行。

所以，我们的工作思路就很清晰了：

1、先把我们桌面应用的可视窗口界面给弄出来，这个就需要使用`CSS`和`HTML`代码了。相比网页开发而言，开发桌面应用要更轻松，因为根本不要考虑兼容性的问题，而且很多最新的`chrome`特性，都可以也很愉快的玩起来。我们的`CSS`代码可以外链线上的资源，也可以放到本地，也可以直接内联在页面中，非常自由，非常随意啊，都可以。我个人建议是放在本地的，因为就算断网了我们的桌面应用也能正常使用。假设一番折腾，我们的界面弄好了，类似这样：
![](https://raw.githubusercontent.com/fengcms/articles/master/image/2f/3ff5bf8cd460b326c6e4b5e2af40ab.png)接下来就是折腾交互了。
 
2、交互效果开发和传统web网站一样，很自由，你喜欢jQuery，就用jQuery，你喜欢Vue，也可以使用Vue等等，没有什么顾虑，就是干！例如我给团队做的这个桌面应用就是用的jQuery，最后应用跑得很畅快。 
3、借助Node.js API或者其他第三方的npm工具或者electron API开发我们的应用。例如，引入Node.js API：

```js
const fs = require('fs');
stat = fs.stat;

const path = require('path');
const url = require('url');
```
引入第三方库：
```js
const minify = require('html-minifier').minify;
```
等等。

例如我做这个桌面应用有需要选择本地文件夹的功能，这个时候就需要借助`electron API`，由于我们的业务`JS`都是写在`renderer.js`中的，并非主线程，因此，调用的使用要使用`remote`，例如：
```js
const electron = require('electron');

const dialog = electron.remote.dialog;
```
此时，我们想要点击按钮打开系统的选择文件夹弹框就可以这么处理：
```js
dialog.showOpenDialog({
    properties: ['openDirectory', 'createDirectory']
}, callback);
```
具体可参考`electron API`文档，有中文版。


于是，简简单单的三步曲，我们的桌面应用功能就开发好了，逻辑还是以前Node.js工具的逻辑，多的仅仅是可视化的界面，以及参数是从输入框等表单控件获取。

开发的过程要比之前预估的要轻松得多，那种随便怎么玩都支持的感觉真的很美妙。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/ad/f5b2e965d3fe9bee3d594f8b815244.gif)
##三、electron开发好的应用该如何发布？
`electron`桌面在自己的开发环境下跑起来了，跑通了，如让其他小伙伴也能方便快捷地使用呢？我们的目标是`windows`系统下直接点击个`.exe`文件，`Mac OS X`直接点击`.app`文件就可以跑起来，我们的小伙伴无需再麻烦安装一堆`node modules`。

我们需要使用专门的打包工具，我是使用的`electron-packager`，首先全局安装一下：
```#
npm install electron-packager -g
```
然后就可以执行打包了，例如：
```#
electron-packager . bobo --out ../electron
```
这段语句表示的意思是把当前文件目录下的资源`（.）`命名为`bobo`打包到父级的`electron`文件夹。

此时`electron-packager`就会自动判别当前的操作系统打包对应的文件，例如`windows`系统下就会打包成`.exe`格式。

如果你想一次性把所有的操作系统都打包一遍，可以在上面打包语句后面加上`-all`。

由于打包的时候会把浏览器内核完整打包进去，所以就算你的项目开发就几百k的资源，但最终的打包文件估计有40到50M。

然后有一点需要特别注意一下，如果你开发的桌面要有第三方的`npm`模块依赖，则你打包好的运行文件无论是跑不起来的，有打包的时候并不会把第三方的`npm`模块依赖也打不进去，需要自己手动复制进去。我的做法是把第三方依赖的`npm`模块打包成一个名为`require-node_modules.zip`文件夹，此时这个文件会一起被打包带走，一同被放在app文件夹下，具体路径为：
```#
windows：\resources\app OS X：显示包内容 → \Contents\Resources\app
```

此时，只要直接解压就可以使用了。


##四、electron发布好的桌面应用如何有效升级？
我们平常的桌面软件要升级的话，一般都需要下载完整的安装包。`electron`作为桌面应用，似乎也逃脱不了这种宿命，但实际上，在绝大部分场景下，我们根本就无需要下载完整的安装包，因为`electron-packager`打包的其实是浏览器内核和主线程控制脚本，具体的业务代码全部都是独立在`app`文件夹下的，也就是说，只要我们的桌面应用主线程逻辑不变，什么UI样式调整，什么交互效果改变，什么业务逻辑变更，我们都只要更新app文件夹下的这资源就可以了：
```#
windows：\resources\app OS X：显示包内容 → \Contents\Resources\app
```
例如，我们的`renderer.js`做了一些升级改动，此时我们的小伙伴想要更新怎么办，无需再重新发布一个安装包，直接把app文件夹下`renderer.js`切换一下就好了，非常简单和快捷。

甚至如果有精力的话，我们桌面应用可以做成自动检测是否有版本更新以及在线升级，升级的内容就是`CSS`，`HTML`，`image`或者`JS`这些静态资源。


>刚看了一下版权申明，不能全文转载，所以剩余内容请阅读原文地址：http://www.zhangxinxu.com/wordpress/2017/05/electron-node-js-desktop-application-experience/





