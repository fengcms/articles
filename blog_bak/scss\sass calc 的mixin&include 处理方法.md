title: scss\sass calc 的mixin&include 处理方法
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -calc
    -sass
    -mixin
    -include
---

#scss\sass calc 的mixin&include 处理方法
##前言
目前主流的浏览器对于`calc`属性已经支持得非常好了.所以,我准备在我们的新项目中全面启用这个属性,省得在布局方面还得用`js`去实现.经过详细的布局测试,总算做出来了一个`demo`页面.在各个pc浏览器上没有任何问题,甚至IE9都没有问题.

于是,拿在移动端上测试,结果发现,移动端大多数新款手机的支持度都是相当不错的.不过我还是崩溃了,因为,在安卓微信上,出现了不支持`calc`的情况.

这是一个很严重的问题.如果微信上不支持的话,那么在很多的微信推广中就不能使用我们做的这个项目了,这兼职是不能容忍的事情.所以,一定要兼容微信自带浏览器.

于是,我们尝试给`calc`加上`-webkit-`前缀.经过测试,微信是支持的.这是一个好消息,至少我不用推倒重来了.

好吧,每一个地方都需要写两个参数,这点确实是有点不爽.于是,我准备构造一个`scss\sass ` `mixin`,用来混入,这样就可以更方便的来解决问题了.

##错误的尝试

**scss\sass mixin**
```
@mixin wcalc ($exp) {
	width: -moz-calc($exp);
	width: -webkit-calc($exp);
	width: calc($exp);
}
```
**scss\sass include**
```
@include wcalc(100% * 2 / 3 - 6rem);
```
编译报错,一直报错~

于是还是各种google资料,但是要么是英文的我看不懂,要么完全不是一回事儿.在群里问朋友,有一个朋友给了一个`less`的解决方法,我尝试了一下,完全不起作用.

但是最终经过尝试,还是解决了这个问题

##正确的方法

**scss\sass mixin**
```
@mixin wcalc ($exp) {
	width: -moz-$exp;
	width: -webkit-$exp;
	width: $exp;
}
```
**scss\sass include**
```
@include wcalc(calc(100% * 2 / 3 - 6rem));
```

误打误撞找到了这个方法,因为在`scss\sass`中,他会自动的去运算.我能够理解上面错误的尝试中的方法为什么报错,因为他运算了.

而我在正常的`scss\sass`中去写 `calc(表达式)`的时候,它没有运算,也许`scss\sass`的编译,就是判断这个表达式是不是在`calc`中,如果在,那就不运算,如果不在,就运算(纯属猜测).于是尝试这样写,结果问题解决了.

现在就一个问题,就是这样写很不优雅,不知道有没有更好的解决方法.

如果没有更好的解决方法的话,至少我这个方法是可以用的方法.

---
PS:
[calc兼容性列表](http://caniuse.sinaapp.com/html/item/calc/index.html)
[css3的calc()使用](http://www.w3cplus.com/css3/how-to-use-css3-calc-function.html)

FungLeo by FengCMS 版权所有
2015.12.22

##2015年12月23日补充

今天对于这个问题还是耿耿于怀,于是,再次谷歌,终于找到了最优雅的解决方法
```
@mixin calc($property, $expression) { 
  #{$property}: -webkit-calc(#{$expression}); 
  #{$property}: calc(#{$expression}); 
} 

.test {
  @include calc(width, "25% - 1em");
} 
```
原文地址:http://stackoverflow.com/questions/10826064/calc-element-in-sass-css