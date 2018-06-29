title: VUEJS实战教程第一章,构建基础并渲染出列表
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -javascript
    -vue
    -前端框架
---

#VUEJS实战教程第一章,构建基础并渲染出列表
## 2017年8月补充

2016年，我写了一系列的 VUE 入门教程，当时写这一系列博文的时候，我也只是一个菜鸟，甚至在写的过程中关闭了代码审查，否则通不过校验。

本来写这一系列的博文只是为了给自己看的，但没想到的是，这系列博文的点击量超过了2万以上，搜索引擎的排名也是非常理想，这让我诚惶诚恐，生怕我写的博文有所纰漏，误人子弟。

再者，这一年的发展，VUE 项目快速迭代，看着我一年前写的博文，很可能各种提示已经发生改变，对照着过时的资料，非常可能导致新手在学习的过程中产生不必要的困扰。

因此，本人决定，重写这个系列的博文，力求以简明、清晰、准确的图文以及代码描述，配合 github 的项目开源代码，给各位 VUE 新手提供一个高质量的入门文案。

以下为我写的博文：

1. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（一）基础知识概述](http://blog.csdn.net/fungleo/article/details/77575077)
2. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（二）安装 nodejs 环境以及 vue-cli 构建初始项目](http://blog.csdn.net/fungleo/article/details/77584701)
3. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（三）认识项目所有文件](http://blog.csdn.net/fungleo/article/details/77585205)
4. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（四）调整 App.vue 和 router 路由](http://blog.csdn.net/fungleo/article/details/77600798)
5. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（五）配置 Axios api 接口调用文件](http://blog.csdn.net/fungleo/article/details/77601270)
6. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（六）将接口用 webpack 代理到本地](http://blog.csdn.net/fungleo/article/details/77601761)
7. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（七）初识 *.vue 文件](http://blog.csdn.net/fungleo/article/details/77602914)
8. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（八）渲染一个列表出来先](http://blog.csdn.net/fungleo/article/details/77603537)
9. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（九）再把内容页面渲染出来](http://blog.csdn.net/fungleo/article/details/77604490)
10. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（十）打包项目并发布到子目录](http://blog.csdn.net/fungleo/article/details/77606216)
11. [Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（十一）阶段性小结](http://blog.csdn.net/fungleo/article/details/77606321)

**以下为原文**


##前言

我的`javascript`水平比较一般.好吧,是相当的一般.因此,对于最新的前端框架技术,实在是有点困难,但现实让我必须面对.因此,学习是唯一的出路.

纵向比较了N款前端框架,最终选择了`VUE` ,为什么呢?理由如下:

1. angular 前途不明,1.x学习曲线高,并且好像被放弃了,而2则还没有正式推出.
2. react 比较厉害,但是没接触.
3. VUE简单,通过上手,比较适合我的思维和水平.
4. vue有中文文档,我看起来比较舒服.

既然决定学习`vue`,那么最好的学习方法就是实战.偶然看到 cNodeJs.Org 论坛有公开的`api`可以使用,这太方便了.于是,我决定用这个公开的`api`来写一个`demo`.

###接口简介

这是 **cNodeJs.Org** 公开提供的的接口.当然,他不仅仅是用来给我们前端用的.可以用在各种程序上.接口地址是http://cnodejs.org/api 通过这个页面,详细介绍了相关的内容.

![](https://raw.githubusercontent.com/fengcms/articles/master/image/23/bcd54ee58648488a422b8b2b8e5a62.jpg)
他们提供的接口是完全的,也就是说我们可以通过这些接口再做一个他们这样的论坛.

###项目计划

1. 做一个列表页面,可以读取cNodeJs的列表内容.
2. 做一个详情页面,在列表页面点击链接,进入详情页面.
3. 采用`ssi`技术实现`html`代码的复用.相关内容搜索`ssi+shtml`了解.
4. `css`代码使用`sass`预编译.

###文件目录

```javascript
├─index.shtml          渲染列表页面
├─content.shtml        渲染详情页面
├─inc                  碎片文件
│   ├─bar.html             侧边栏代码
│   ├─footer.html          版权部分代码
│   ├─head.html            head区域调用js等代码
│   └─header.html          页头logo以及导航代码
└─res                  资源文件
    ├─image
    ├─js
    │  ├─common             我的代码目录
    │  │  ├─common.js           公共执行js
    │  │  └─method.js           自定义方法js
    │  ├─jquery             jquery源码目录
    │  ├─plugins            其他插件目录
    │  │  └─laypage             laypage 分页插件
    │  └─vue                VUE源码目录
    └─style
        ├─style.scss        sass源文件
        ├─style.css         编译好的css 文件
        ├─base
        └─scss
```
下载我的源文件 https://github.com/fengcms/vue-cNodeJsOrgTest

##开始写代码

首先是按照上面的文件目录设计,开始往里面写文件.`res`里面是资源目录,你可以稍微看下,或者知道里面是什么就可以了.

其实重点就是 `index.shtml`和`content.shtml`两个文件而已.

###准备首页列表html文件

```html
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>title</title>
    <link rel="stylesheet" href="res/style/style.css">
</head>
<body>
    <header class="header">
        <h1 class="logo">
            <a href="index.html" title="cnNodeJs.Org Home By FungLeo">cnNodeJs.Org Home By FungLeo</a>
        </h1>
        <nav class="nav">
            <ul>
                <li>导航列表</li>
            </ul>
        </nav>
    </header>
    <section class="home">
        <section class="main">
            <ul class="list">
                <li>
                    <i class="user_ico">
                        <img src="#头像url" alt="用户名">
                        <span>用户名</span>
                    </i>
                    <time class="time">发表于 5 天前</time>
                    <a class="talk" href="content.html?链接ID">帖子标题</a>
                </li>
            </ul>
            <div class="page"></div>
        </section>
        <aside class="bar">
            <h3>本页说明</h3>
            ...
        </aside>
    </section>
    <footer class="copy">
       版权说明
    </footer>
    <div class="go_top"></div>
</body>
</html>
```
如上代码,是我首先写出来的静态页面.配合我的`css`,效果如下图所示:

![](https://raw.githubusercontent.com/fengcms/articles/master/image/95/41287326aba45b3e2d2b8a19ee477f.jpg)
> 完整代码请从`github` 里面获取

###引入`vue&jquery`等js文件

```html
<script src="res/js/jquery/jquery-2.2.3.min.js"></script>
<script src="res/js/vue/vue.min.js"></script>
<script src="res/js/common/common.js"></script>
```

###从接口获取数据

首先,无论怎么样,我们先要从接口拿到数据才能接着往下干.我们通过`jquery`用`ajax`方法把数据拿过来再说.

如下代码:

```javascript
$(function(){
    $.ajax({
        type:'get',
        url:"http://cnodejs.org/api/v1/topics",
        dataType: 'json',
        success: function(data){
            if (data.success){
                console.log(data)
            }else{
                alert(JSON.stringify(data));
            }
        },
        error: function(data){
            alert(JSON.stringify(data));
        }
    });
})
```

代码如上,我们看下浏览器控制台,截图如下:

![](https://raw.githubusercontent.com/fengcms/articles/master/image/d2/80275eb2128b610884f851043a54c7.jpg)
如上图所示,我们成功的拿到了数据.

###分析数据

![](https://raw.githubusercontent.com/fengcms/articles/master/image/83/958498f880f79d0f543416c2be58c0.jpg)
如上图所示,数据里面包含了如下内容

1. 作者
	1.作者头像url
	2.作者用户名
2. 作者ID
3. 帖子内容
4. 发布时间
5. 是否是精华
6. 帖子ID
7. 最后回复时间
8. 回复数量
9. 归属标签
10. 帖子标题
11. 是否置顶
12. 浏览统计

数据接口如上.当然,如果是做全功能的论坛的话,这些数据都是有作用的.而在我的项目中,有很多是用不到的.我们来看下我需要那些.

```html
<li>
    <i class="user_ico">
        <img src="#头像url" alt="用户名">
        <span>用户名</span>
    </i>
    <time class="time">发表于 5 天前</time>
    <a class="talk" href="content.html?链接ID">帖子标题</a>
</li>
```

如上代码所示,我们需要循环的内容包括

1. 作者头像url
2. 作者用户名
3. 发布时间
4. 帖子ID
5. 帖子标题

没有问题,我们所需要的内容,接口全部都是有的.

### 封装 ajax 代码

`ajax` 代码虽然不长,但是我看着还是比较难受.因此,我用下面的代码进行封装

```javascript
// ajax get json 方法
function getJson(url,func){
	$.ajax({
		type:'get',
		url:url,
		dataType: 'json',
		success: function(data){
			if (data.success){
				func(data);
			}else{
				alert("接口调用失败");
			}
		},
		error: function(data){
			alert(JSON.stringify(data));
		}
	});
}
```
如上,在需要的地方,我们只需要用 `getJson(url,func)` 这个函数就可以了.

### 引用 封装好的代码

```javascript
$(function(){
    var url = "http://cnodejs.org/api/v1/topics";
    getJson(url,function(data){
        console.log(data);
    });
});
```
修改成这样之后,我们再来看下,看看能不能打印出来我们所需要的数据?如下图所示:

![](https://raw.githubusercontent.com/fengcms/articles/master/image/d2/80275eb2128b610884f851043a54c7.jpg)
没有任何问题,我们依然获得了数据.我们在把这个回调的函数再封装一下,改成下面的代码

```javascript
$(function(){
    var url = "http://cnodejs.org/api/v1/topics";
    getJson(url,pushDom);
});
function pushDom(data){
	console.log(data);
}
```

好,如果没有出错的话,绝对还是能够打印出来接口数据的.这样操作后,我们的代码就无比的简练,并且可阅读性大大增加了.而我们下面要做的事情,就是在 `pushDom(data)` 这个函数里面去做就好了.

### vue 渲染代码

首先,我们需要在页面中用 vue 的方法写入我们要插入的数据.

**html代码部分**

```html
<li v-for="info in data">
    <i class="user_ico">
        <img src="{{ info.author.avatar_url }}" alt="{{ info.author.loginname }}">
        <span>{{ info.author.loginname }}</span>
    </i>
    <time class="time">{{ info.create_at }}</time>
    <a class="talk" href="content.html?{{ info.id }}">{{ info.title }}</a>
</li>
```
**vue知识点**
循环数据 http://vuejs.org.cn/api/#v-for

**JS代码部分**
```javascript
function pushDom(data){
	var vm = new Vue({
        el: '.list',
        data: data
    });
}
```

我们来看一下效果:

![](https://raw.githubusercontent.com/fengcms/articles/master/image/e2/b9c8814ba12b091632248832d993d9.jpg)
好,非常兴奋,短短的几行代码,我们就成功用vue将列表给渲染出来了.

##小结

1. ajax获取数据是关键
2. 了解一点点vue的内容,就可以上手了.
3. 构建项目时,代码和文件一定要清晰明了.


##附录

[VUE官方网站](http://vuejs.org.cn/)
[cNodeJs Api 详细介绍](http://cnodejs.org/api)
[本系列教程源码下载](https://github.com/fengcms/vue-cNodeJsOrgTest)

****
[VUEJS 实战教程第一章,构建基础并渲染出列表](http://blog.csdn.net/FungLeo/article/details/51649074)
[VUEJS 实战教程第二章,修复错误并且美化时间](http://blog.csdn.net/FungLeo/article/details/51647664)
[VUEJS 实战教程第三章,利用laypage插件实现分页](http://blog.csdn.net/FungLeo/article/details/51649359)

本文由FungLeo原创,允许转载.但转载必须署名作者,并保留文章首发链接.否则将追究法律责任. 
首发地址:http://blog.csdn.net/FungLeo/article/details/51649074