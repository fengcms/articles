title: [FungLeo原创]CSS预编译技术之SASS学习经验小结
date: 2016-03-11 00:14:56 +0800
update: 2016-03-11 00:14:56 +0800
author: fungleo
tags:
    -css3
    -sass
    -scss
    -less
    -css预编译
---

#[FungLeo原创]CSS预编译技术之SASS学习经验小结

##前言

接触CSS是05年.使用xhtml+css开发是06年.但真正全面采用xhtml+css开发却是08年开始的.因为居于三线城市,比一线程序的前驱者还是晚了一些.

虽然现在已经发展到了html5+css3了.CSS也比以前强大太多了.但是这个语言却并没有什么本质性的改变,甚至,都不能算是一门编程语言.

这两年前端行业发展日新月异,大批后端工程师转前端,发现,我擦,这玩意儿真心不好用啊,于是,大量的CSS预编译技术出现了.比较知名的是less和sass.

我是先接触的less,用了一年多,感觉还好.一直没有研究得多深,但是写起来也确实方便.直到去年,来到目前这家公司,要求,全面转入sass.当我正是用sass书写css一个星期之后,我决定,忘记less,因为,实在是太强大了.

sass学习有一个网站很好 [sass入门 - sass教程](http://www.w3cplus.com/sassguide/) 这个网站全面的提供了sass的各种基础语法.如果想要学习和理解这些语法,去这个网站学习一下即可.

我的这篇博文不是重复上面的网站.那没有任何意义.我要写的,是那个网站没有,但是对你可能有莫大用处的,或者少让你走弯路的内容.感兴趣,那就往下看吧.

##sublime text 配置sass环境后,为什么不自动输出一个分号?

我的开发工具是 sublime text 我向大量前端都是使用的这个工具.所以就以这个工具来说.使用 sublime 安装好 sass 插件之后,你会发现,在输入一个属性之后,没有自动输出分号.
>默认已经安装了emmet插件了哈

举例:

```css
/* 我输入下面的代码 */
tac
/* 我期望输出的代码是 */
text-align: center;
/* 但是,编辑器输出的是 */
text-align: center
```
这让我很郁闷,以至于我都想要放弃SASS,因为每次都输入一个分号会让我崩溃的.后来我明白到底是为什么了.

>因为sass分为两个版本,一个是sass,其特点是使用严格的缩进来控制,省略掉了分号和花括号(肯定是Python程序员的主意-_-);
>另一个版本是scss,这个版本,是使用花括号和分号的,更接近我们这些本来就是前端工程师的人的使用习惯.
>两种版本是以后缀名来区别的.如 style.sass 和 style.scss

我的建议是,放弃sass格式,全面使用scss格式.于是,你的sublime配置插件,就不能配置 sass插件了,而应该去找　scss 插件.

装上这个插件之后,就一切整好了.

##@extend 清除浮动代码

清除浮动代码是在前段工作中需要大量使用的代码.其混入代码的编写如下:

```css
/* 清理浮动代码 */
.cf {
	zoom:1;
	&.cf:before, &.cf:after {content:"";display:table;}
	&.cf:after {clear:both;}
}
/* 调用 */
.nav {
	@extend .cf;
}
```
通过这样的代码,在需要清理浮动的地方写一下即可.

如果你看了上面的给出的入门教程,或者本身就会sass你可能会有一个疑问,为什么是`.cf` ,不应该是 `%cf` 吗?

你说的没错.

如果是`%cf` 这种方式,那么,如果文档中没有哪里调用了它,那么它是不会输出的.也就是说,那样更合理.

但是,像清理浮动这种重要的代码,用的地方特别多.而且可能在html里面也会直接的去写一个class来调用它,那么,使用`.cf` 就更加合适了,因为,这样的话,在输出的css中,是有`.cf`这个样式存在的.

我这段文字的意义就是告诉你:

`%cf`不仅仅有`%cf`这一种写法,还可以写成 `.cf` 具体用哪个,就看你在项目中的实际需求了!

##@mixin 混入代码如何使用 calc() 计算属性?

呵呵,如果你不清楚的话,会难死你...我曾经在这个问题上困扰了很久,可以参考我之前写的一篇博文:[scss\sass calc 的mixin&include 处理方法](http://blog.csdn.net/fungleo/article/details/50381720)

这里我直接把结果告诉大家

```css
/* 混入代码 */
@mixin calc($property, $expression) { 
  #{$property}: -webkit-calc(#{$expression}); 
  #{$property}: calc(#{$expression}); 
} 
/* 调用 */
.test {
  @include calc(width, "25% - 1em");
} 
```

>虽然现在CSS3在移动端的支持非常好,但是,还是不能滥用这个属性,因为安卓4.4以下不支持 calc\vw\vh 等属性,并且,即便你的手机是最新的系统,但如果你使用某些国产浏览器,还可能不支持这些东西.比如**猎豹**和某些微信版本自带的浏览器(不确定,但有这个情况),如果你使用的话,一定要做好降级处理.

##koala不支持中文注释的处理方法.

sass编译器有很多.我个人建议在windows平台开发的话,还是使用 koala 这款国人开发的软件.大家可以[点击这里](http://koala-app.com/index-zh.html)去官方网站下载.这款软件不仅仅可以编译sass,还可以编译less,或者压缩JS等各种功能.非常的好用.

但是,在默认情况下,它在编译sass文件的时候,是不能有中文注释的.怎么办呢?我之前也有一篇博文[[转]koala 编译scss不支持中文解决方案](http://blog.csdn.net/fungleo/article/details/49335365)特别介绍了处理方法,这里再次复述一遍.

进入到Koala 安装目录

D:\Koala\rubygems\gems\sass-3.4.9\lib\sass 
修改 engine.rb 文件

在require 最下面 加入以下代码 即可解决
```python
Encoding.default_external = Encoding.find('utf-8')
```

个人多次测试成功
>PS:在MAC下面也是一样,找到这个文件,最后追加就行了.手头暂时没有MAC,但亲测有效

##SASS\SCSS 避免运算的方法

sass是支持运算的,加减乘除都支持.但是某些情况下,我们只是要输出内容,并不是要它运算.这时候怎么处理呢?

举个例子

```css
@mixin ts($s1:1px,$s2:1px,$color:$cff){
    text-shadow:
    $s1 $s1 $s2 $color,
    -$s1 $s1 $s2 $color,
    $s1 -$s1 $s2 $color,
    -$s1 -$s1 $s2 $color;
}
```
这段混入,应该能理解是什么吧.但是,如果这样在混入的时候,得到的结果,就不是你想要的了.它会输出

```css
text-shadow: 1px 1px 1px #fff,-1px 1px 1px #fff,0px 1px #fff,-2px 1px #fff;
```

这样的东西,怎么办呢?这样写就好了.

```css
@mixin ts($s1:1px,$s2:1px,$color:$cff){
    text-shadow:
    $s1 $s1 $s2 $color,
    -$s1 $s1 $s2 $color,
    $s1 (-$s1) $s2 $color,
    -$s1 (-$s1) $s2 $color;
}
```
用括号来解决这个问题.
出处:[SASS\SCSS 避免运算的方法](http://blog.csdn.net/fungleo/article/details/49563817)

另外,由于CSS本身支持`/`号,因此,在使用除法运算的时候就要特别注意.括号,是解决这个问题的好方法.

##多文件SASS的规划整理

一个项目只需要一个css,但是,如果我们把全部的sass文件写在一个sass文件里,那么可能这个文件很长.这并不利于我们维护这些代码.

因此,我们需要将代码写在多个文件里,最后在整合在一起输出为一个CSS文件,怎么做呢?

首先,我们这样规划:

```
style.css	// 最终输出文件
style.scss  // 原始sass文件
scss		// 保存碎片sass的文件夹
	_header.scss	// 下面都为碎片文件
	_body.scss
    _footer.scss
```
注意,碎片文件夹里面的sass文件是不需要编译的,**只需要在文件名的前面加一个下划线**它就不会自动编译了.

style.scss 文件里面的写法

```css
@import "scss/header";
@import "scss/body";
@import "scss/footer";
```

看到了吗?当然,你写完整路径也没有问题,但是,下划线可以省略,后缀名也可以省略.

>2016年5月23日日补充:
>如果你的sass碎片文件名为` _love_baby.scss` 这样的话,koala不会自动编译.
>需要改成`_loveBaby.scss` 
>我还以为koala坏了呢...急死我了.

##小结

scss是非常非常好玩的,也可以大大提高的你编码效率.如果你问我,是less好,还是sass好,我不能给你准确答案,但是,现在越来越多的团队在使用sass.这是一个趋势.

如果你现在还在写原生的css文件,你真心OUT了.赶紧学习一门CSS预编译语言吧.我的推荐是——sass

如果本文有什么错漏,或者你有什么心得,欢迎给我留言,我期待你的指教!

FungLeo原创,转载请保留版权申明,并附带首发地址：[http://blog.csdn.net/FungLeo/article/details/50851192](http://blog.csdn.net/FungLeo/article/details/50851192)