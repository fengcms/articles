title: 巧用box-shadow实现布局区域间隔变色
date: 2016-06-13 22:50:02 +0800
update: 2016-06-13 22:50:02 +0800
author: fungleo
tags:
    -box-shadow
    -css
    -间隔变色
---

#巧用box-shadow实现布局区域间隔变色

##前言

之前给客户做了一个网站,整体是`1200px`宽.因此,网页整体是放在一个 `1200px`的盒子里的.但是今天,客户突然要求实现这样的变色效果,一个区域是灰色的,一个区域是白色的.

**原布局效果图**

![](https://raw.githubusercontent.com/fengcms/articles/master/image/01/2399acebf5ffe4c2037295ba1b3472.jpg)
**想要达到的效果**

![](https://raw.githubusercontent.com/fengcms/articles/master/image/72/77dfb9028140f27c235e39b7985d01.jpg)
我了个擦擦...这是要更换原有的`html`布局的呀....

##思路

首先,我是拒绝更换`html`布局结构的.我真心不愿意去修改`html`的布局,因为牵扯到的地方会比较多,所以,如何在不改变`html`结构的情况下,实现这样的需求呢?

###背景图片法

我们可以做一张背景图片,是灰色和白色间隔的,让他在整个网页间平铺.以实现伪装的间隔变色.

优点:不改变DOM结构.

缺点:
1. 要求所有版块高度一致.
2. 不能兼顾头尾.因为不修改`html`结构,就必然是在`body`或者`html`上面加背景图片,这样不能坚固头尾
3. 如果兼顾头尾,则必然还是要修改`html`结构,必须在所有需要变色的板块外面加上一个`100%`宽的盒子

好了,综合分析,背景图片貌似不能完美解决我的问题.没关系,我CSS很强大.猛然间我想到了一个牛逼的`CSS`属性`box-shadow`.

###`box-shadow`投影法

首先,看下我们现有的html结构

```html
<div class="home">
	<section class="floor"></section>
	<section class="floor"></section>
	<section class="floor"></section>
	<section class="floor"></section>
	<section class="floor"></section>
</div>
```
默认css如下

```css
.home {width: 1200px;margin: 0 auto;}
	.floor {padding: 20px 0;height: 500px;width: 1200px;}
```

其他不想干的内容就不写了,主要就是这些参数.

我的解决方案就是,利用`box-shadow`属性,向左和向右分别加上相当于自身宽度的灰色投影,并且给自己加上灰色背景,这样就实现了整体的变色.代码如下:

```css
.home {width: 1200px;margin: 0 auto;}
	.floor {
		padding: 20px 0;height: 500px;width: 1200px;
		box-shadow: 1200px 0 #fafafa,-1200px 0 #fafafa;
		background: #fafafa;
	}
```
如上,果不其然,实现了灰色背景的平铺.但是,所有的盒子都有了这个平铺的灰色背景.我们需要实现的是间隔变色,而不是全部变成灰色的背景.

怎么办?难道我需要去给`.floor`再加上一个样式????

**不需要**,强大的`css`再一次雄起了!!

我把代码改成了如下:

```css
.home {width: 1200px;margin: 0 auto;}
	.floor {padding: 20px 0;height: 500px;width: 1200px;}
	.floor:nth-child(2n){
		box-shadow: 1200px 0 #fafafa,-1200px 0 #fafafa;
		background: #fafafa;
	}
```

OK,完美实现效果.

##思考

这个不是100%的平铺的,而是宽度是有限的.这样,在足够高的分辨率下面,可能会产生问题哦.

但是,以我的例子来说,`1200*3 = 3600` 这样的宽度,足够胜任目前99.999%的显示器了.剩下部分用4K的土豪,我相信也不会在这样高分辨率的显示器上全屏看网页.所以,这样写是没有问题的呀!!

但是,我们是讲求完美的么.哪怕是百万份之一的人会这样做,也不能露怯呀.但是,我们的`box-shadow`是万能的呀...我们再来改一下代码:

```css
.home {width: 1200px;margin: 0 auto;}
	.floor {padding: 20px 0;height: 500px;width: 1200px;}
	.floor:nth-child(2n){
		box-shadow: 1200px 0 #fafafa,2400px 0 #fafafa,-1200px 0 #fafafa,-2400px 0 #fafafa;
		background: #fafafa;
	}
```

改成这样之后,就是 `1200*5 = 6000` 这样的宽度,足够再战10年~~~

##小结

CSS,真TM强大!!

本文由FungLeo原创,允许转载.但转载必须署名作者,并保留文章首发链接.否则将追究法律责任.
首发地址:http://blog.csdn.net/FungLeo/article/details/51661222