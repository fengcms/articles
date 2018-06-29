title: [FungLeo原创]移动端系列博文基础reset.scss和mixin.scss
date: 2016-03-13 14:26:51 +0800
update: 2016-03-13 14:26:51 +0800
author: fungleo
tags:
    -reset
    -mixin
    -scss
    -sass
---

#移动端系列博文基础reset.scss和mixin.scss

下面我将写一系列的关于移动端的博文,如果每次都需要在博文前面引用这样一段reset.scss和mixin.scss,那将是一件相当恶心的事情,所以,我将这一段独立出来,发表一篇总的引用博文.以后的博文,只需要引用一个链接就可以了.算是当成一个@mixin,可以随时@include的一段博文片段吧.

>**我的CSS部分将全部使用sass来进行书写**,如果您不会sass,请阅读我这篇博文[CSS预编译技术之SASS学习经验小结](http://blog.csdn.net/fungleo/article/details/50851192)

##基本reset.scss\mixin.scss

我将使用下面的reset.scss来重置浏览器的默认属性.
###reset
```css
@charset "UTF-8";
html {font-size: 62.5%;font-family:tahoma,Helvetica, Arial,"\5FAE\8F6F\96C5\9ED1";}
body,ul,ol,dl,dd,h1,h2,h3,h4,h5,h6,pre,form,fieldset,legend,input,button,textarea,p,blockquote,table,th,td,menu{margin:0;padding:0;box-sizing:content-box;}
table{border-collapse:collapse;border-spacing:0;}
ul,ol,menu{list-style:none}
fieldset,img{border:none}
img,object,select,input,textarea,button{vertical-align:middle}
input,textarea,select,address,caption,cite,code,dfn,em,i,b,strong,small,th,var,abbr{font-size:100%;font-style:normal}
caption,th {text-align: left;}
article,aside,footer,header,hgroup,nav,section,figure,figcaption {display: block;}
code, kbd, pre, samp, tt { font-family: Consolas,"Courier New", Courier, monospace;}
address, cite, dfn, em, var,i {font-style: normal;}
blockquote, q {quotes: none;}
blockquote:before, blockquote:after,q:before, q:after {content:"";content: none;}
a { 
    color:#06f; text-decoration:none;cursor: pointer;
    &:link,&:visited, &:active{color: #06f;}
    &:hover, &:focus {color:#f60; text-decoration:underline;outline:none;}
}

```
###mixin混入代码
这些代码,将会提供一些代码块给我在在后面的制作中随时调用.
```css
//清理浮动
.cf{
	zoom:1;
	&:before,&:after {content:"";display:table;}
	&:after {clear:both;}
}
// 链接动画
@mixin dz($time:0.25s){
    -webkit-transition: all $time ease-in-out;
    transition: all $time ease-in-out;
}
// 文字描边
@mixin ts($s1:1px,$s2:1px,$color:#fff){
	text-shadow:
	$s1 $s1 $s2 $color,
	-$s1 $s1 $s2 $color,
	$s1 (-$s1) $s2 $color,
	-$s1 (-$s1) $s2 $color;
}
// 旋转
@mixin xz($deg:360){
    -webkit-transform:rotate($deg+deg);
	transform:rotate($deg+deg);
}
// 旋转放大
@mixin xzfd($deg:360,$s1:1.2){
	-webkit-transform:rotate($deg+deg) scale($s1);
	transform:rotate($deg+deg) scale($s1);
}
// 移动动画
@mixin yd($s1:0,$s2:0){
	-webkit-transform:translate($s1,$s2);
	transform:translate($s1,$s2);
} 
// 禁止选中
@mixin ns{
	-webkit-touch-callout: none;
	-webkit-user-select: none;
	-khtml-user-select: none;
	user-select: none;
}
// 一行文字标题超出显示省略号
@mixin online($s1) {
	overflow: hidden;
	line-height: $s1;
	height: $s1;
	white-space: nowrap;
	text-overflow: ellipsis;
}
// 计算(基本不会采用)
@mixin calc($property, $expression) { 
	#{$property}: -webkit-calc(#{$expression}); 
	#{$property}: calc(#{$expression}); 
}
// 一行文字垂直居中,并隐藏溢出
@mixin hlh($s1) {
	height: $s1;
	line-height: $s1;
	overflow: hidden;
}
// 列表中更多显示右键头的图片处理
@mixin goto($s1:1.2rem){
	background:url("../image/icon_goto.png") right center no-repeat;
	background-size: auto $s1;
}
```

本文FungLeo原创,转载请著名作者,并保留首发链接[http://blog.csdn.net/FungLeo/article/details/50877720](http://blog.csdn.net/FungLeo/article/details/50877720)


