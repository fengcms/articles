title: VUEJS 实战教程第二章,修复错误并且美化时间
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -vuejs
    -前端框架
    -v-bind
    -自定义过滤器
    -javascript
---

#VUEJS 实战教程第二章,修复错误并且美化时间
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

在上一章中,我们通过基础的搭建,成功的渲染了列表页面.但是,其中的问题是很多的.这一章,我们来解决这些问题.

##使用 v-bind 绑定数据.

上一章的代码,我们渲染出来了页面.但是如果打开了控制台,你会发现有错误.如下图所示:

![](https://raw.githubusercontent.com/fengcms/articles/master/image/67/fee10f7f5d74d8d3e616edb1c35a58.jpg)
这是因为页面进来的时候,会先执行我们的html代码,而此时,我们的vue还没开始工作.而我们的代码如下:

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
如上,页面去解析 `src="{{ info.author.avatar_url }}"`的时候,当然是找不到这个图片路径的.因此,自然而然会出错.因此,我们需要来处理一下这个代码.我们修改为

```html
<img v-bind:src="info.author.avatar_url" v-bind:alt="info.author.loginname">
```

好,我们刷新一下页面,这一次,就没有报错了.

**VUE知识点**

`v-bind` 绑定属性 http://vuejs.org.cn/api/#v-bind

补充:

其实,我们打开页面的时候,还是可以在一瞬间看到这些 `{{ ... }}` 的内容.虽然这个不会报错,但是还是影响了一点点用户体验.这个时候,我们可以用 `v-text` 来输出这些内容,如上,我们把代码修改为如下:

```html
<li v-for="info in data">
    <i class="user_ico">
        <img v-bind:src="info.author.avatar_url" v-bind:alt="info.author.loginname">
        <span v-text="info.author.loginname"></span>
    </i>
    <time class="time" v-text="info.create_at"></time>
    <a class="talk" href="content.html?{{ info.id }}" v-text="info.title"></a>
</li>
```

当我们把代码修改成这样之后,所有的问题就都解决了.

**VUE知识点**

`v-text` 输出文本 http://vuejs.org.cn/api/#v-text

##美化时间

我们从接口获取的时间格式是这样的`2016-06-12T06:17:35.453Z`,很显然,这不是我们想要的效果.我们想要的效果应该是这样的 `发表于2小时之前` 这样的效果.怎么做呢?

我们需要一个函数,这个函数的作用是给他一段原始的字符串,然后返回一个我们想要的字符串.

关于这个函数的原理,不是我们的重点,这里不解释,直接看代码如下:

```javascript
function goodTime(str){
	var now = new Date().getTime(),
		oldTime = new Date(str).getTime(),
		difference = now - oldTime,
		result='',
		minute = 1000 * 60,
		hour = minute * 60,
		day = hour * 24,
		halfamonth = day * 15,
		month = day * 30,
		year = month * 12,
		
		_year = difference/year,
		_month =difference/month,
		_week =difference/(7*day),
		_day =difference/day,
		_hour =difference/hour,
		_min =difference/minute;
		 if(_year>=1) {result= "发表于 " + ~~(_year) + " 年前"}
	else if(_month>=1) {result= "发表于 " + ~~(_month) + " 个月前"}
	else if(_week>=1) {result= "发表于 " + ~~(_week) + " 周前"}
	else if(_day>=1) {result= "发表于 " + ~~(_day) +" 天前"}
	else if(_hour>=1) {result= "发表于 " + ~~(_hour) +" 个小时前"}
	else if(_min>=1) {result= "发表于 " + ~~(_min) +" 分钟前"}
	else result="刚刚";
	return result;
}
```

代码有借鉴别人的代码的部分.

好,现在,我们可以通过一个`goodTime(str)`的方法函数,来将接口给我们的时间格式修改为我们想要的.现在的问题就是,我们怎么来用这个函数了.

###笨蛋方法,直接修改原始数据

首先,我们通过`ajax`拿到了数据,然后再把数据交给`vue`进行渲染.那我们在这个中间可以进行一个操作,把所有的数据全部处理一遍,然后把处理过的数据再交给`vue`去渲染.就可以解决这个问题了.

说干就干,我们看代码:

```javascript
function pushDom(data){
	// 先进行遍历,把数据中的所有时间全部修改一遍
    for (var i = 0; i < data.data.length; i++) {
        data.data[i].create_at = goodTime(data.data[i].create_at);
    };
    // 然后再交给 vue 进行渲染
	var vm = new Vue({
        el: '.list',
        data: data
    });
}
```

好,通过上面的处理,我们再来看一下最终的页面效果.如下:

![](https://raw.githubusercontent.com/fengcms/articles/master/image/67/d0d5f501fb7bb95e0def2a157a89a3.jpg)
成功了.

###VUE自定义过滤器方法

上面虽然我们成功了.但是,直接在`VUE`之前搞了一个`for`循环,实在是有点不太优雅.而且,我们要学习`VUE`啊,这算哪门子学习呢....

好,我们下面用`VUE`的自定义过滤器功能来进行处理.

> 官方教程,自定义过滤器 http://vuejs.org.cn/guide/custom-filter.html

```javascript
function pushDom(data){
	// 使用vue自定义过滤器把接口中传过来的时间进行整形
	Vue.filter('time', function (value) {
		return goodTime(value);
	})
	var vm = new Vue({
		el: '.list',
		data: data
	});
}
```
并且,我们需要修改我们的`html`部分,如下:

```html
<time class="time"  v-text="info.create_at | time"></time>
```

好,实现效果是一模一样的.但是代码看上去优雅了很多.关键是,我们在这个过程中,学习和掌握了自定义过滤器的使用.其实,在很多情况下,接口给我们的数据往往是不适合直接在页面中渲染的,所以这个功能就是非常重要并且非常常用的了.

##小结

1. v-bind 绑定元素属性方法
2. v-text 输出文本方法
3. vue 自定义过滤器的使用

##附录

[VUE官方网站](http://vuejs.org.cn/)
[cNodeJs Api 详细介绍](http://cnodejs.org/api)
[本系列教程源码下载](https://github.com/fengcms/vue-cNodeJsOrgTest)

****
[VUEJS 实战教程第一章,构建基础并渲染出列表](http://blog.csdn.net/FungLeo/article/details/51649074)
[VUEJS 实战教程第二章,修复错误并且美化时间](http://blog.csdn.net/FungLeo/article/details/51647664)
[VUEJS 实战教程第三章,利用laypage插件实现分页](http://blog.csdn.net/FungLeo/article/details/51649359)

本文由FungLeo原创,允许转载.但转载必须署名作者,并保留文章首发链接.否则将追究法律责任.
首发地址:http://blog.csdn.net/FungLeo/article/details/51647664
