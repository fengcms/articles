title: VUEJS 实战教程第三章,利用laypage插件实现分页
date: 2016-06-12 22:05:09 +0800
update: 2016-06-12 22:05:09 +0800
author: fungleo
tags:
    -分页
    -前端框架
    -vue
    -laypage
---

#VUEJS 实战教程第三章,利用laypage插件实现分页
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

在上两章的工作中,我们顺利的实现了首页的渲染,但是,只是渲染了一页数据而已.我们可能需要渲染更多的数据,这时候,我们就有必要考虑分页了.

分页有很多种方式,比如异步加载的分页方式.然而对于没有太多使用前端模版框架的朋友来说,一上来就使用这种方式,可能稍微有点难度.因此,我们这章的分页实现,是基于普通的链接分页的方式完成的.

在我们有了更多的前端框架的使用经验之后,我们可以使用更加丰富的分页方法.

事实上,我们自己构建一个分页组件也不是不可以,在移动端我都是自己的代码实现的.但是,我这里要推荐的是使用 `laypage` 这个分页插件,其官方网址是 (http://laypage.layui.com/).

##分页规则制订

首先,我们来看一下接口说明

![](https://raw.githubusercontent.com/fengcms/articles/master/image/cf/8e1c969a4742f97638679cdd2431d3.jpg)
这里是get接口,因此,如上图所示,正确的请求方式就是,直接在接口的`Url`后面追加参数.

```
http://cnodejs.org/api/v1/topics?page=1
```

好,那我们的url地址就可以是 `//xxx/index.shtml?1` 因为我不准备用其他的参数,只要把分页给完成就可以了.因此,可以直接在后面加上分页id,然后通过一个函数获取url中的这个id,追加到接口上面,那么就可以实现我们的需求了.

##写代码实现!

###获取URL中的ID
如上面所想,我们需要一个函数,这个函数可以正确的获得我们追加在`url`地址问候好眠的id.

```javascript
function getUrlId(){
	var host = window.location.href;
	var id = host.substring(host.indexOf("?")+1,host.length);
	return id;
}
```

如上代码,通过这个函数方法,就可以获得我们追加在url后面的ID了,测试一下

```javascript
$(function(){
    var id = getUrlId();
    console.log(id);
    var url = "http://cnodejs.org/api/v1/topics";
    getJson(url,pushDom);
});
```

如下图所示:

![](https://raw.githubusercontent.com/fengcms/articles/master/image/c3/0d3a11989bdec6c9c25562ecb2e3a2.jpg)
###通过ID我们来获取不同的数据

```javascript
$(function(){
    var id = getUrlId();
    var url = "http://cnodejs.org/api/v1/topics?page="+id;
    getJson(url,pushDom);
});
```

如上,就可以根据不同的`url`来获取不同的数据了.

###使用 laypage 实现分页

首先当然是引用文件了.
```html
<script src="res/js/plugins/laypage/laypage.js"></script>
```
在html适当的部分,加上分页组件的盒子,如下:
```html
<div class="page"></div>
```
然后,我们在官方网站上把代码给复制过来.适当修改,代码如下
```javascript
$(function(){
	var id = getUrlId();
	var url = "http://cnodejs.org/api/v1/topics?page="+id;
	getJson(url,pushDom);
	laypage({
		cont: $(".page"),
		pages: 100,
		curr: id,
		jump: function(e, first){
			if(!first){
				location.href = '?'+e.curr;
			}
		}
	});
})
```

最终效果如下图所示:

![](https://raw.githubusercontent.com/fengcms/articles/master/image/1b/daffc6a865287fb8f84262117fcc0d.jpg)
##小结

在本章,我们的内容其实和VUE的关系不大.但是,无论是使用什么内容,最终都是以完成项目为目的的.用已经开发好的插件来实现,可以大大提高我们的效率.

##附录

[VUE官方网站](http://vuejs.org.cn/)
[cNodeJs Api 详细介绍](http://cnodejs.org/api)
[本系列教程源码下载](https://github.com/fengcms/vue-cNodeJsOrgTest)

****
[VUEJS 实战教程第一章,构建基础并渲染出列表](http://blog.csdn.net/FungLeo/article/details/51649074)
[VUEJS 实战教程第二章,修复错误并且美化时间](http://blog.csdn.net/FungLeo/article/details/51647664)
[VUEJS 实战教程第三章,利用laypage插件实现分页](http://blog.csdn.net/FungLeo/article/details/51649359)

本文由FungLeo原创,允许转载.但转载必须署名作者,并保留文章首发链接.否则将追究法律责任.
首发地址:http://blog.csdn.net/FungLeo/article/details/51649359

