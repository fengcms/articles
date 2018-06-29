title: SASS\SCSS 避免运算的方法
date: 2015-11-01 23:17:39 +0800
update: 2015-11-01 23:17:39 +0800
author: fungleo
tags:
    -scss
    -sass
    -避免运算
---

今天用`sass`写一个样式，文字描边。因为其代码比较长，所以就用@mixin 混入。但是发现，我这样写有问题。
```
@mixin ts($s1:1px,$s2:1px,$color:$cff){
	text-shadow:
	$s1 $s1 $s2 $color,
	-$s1 $s1 $s2 $color,
	$s1 -$s1 $s2 $color,
	-$s1 -$s1 $s2 $color;
}
```
这样输出的代码，后面的两行，他运算了。得到的结果如下：
```
#sometext {text-shadow: 1px 1px 1px #fff,-1px 1px 1px #fff,0px 1px #fff,-2px 1px #fff;}
```
有点小郁闷，百度了一下没找到相关的资料。于是尝试用`\`来解决，结果是扯淡的。
再尝试加个括号，问题解决了~
代码如下：
```
@mixin ts($s1:1px,$s2:1px,$color:$cff){
	text-shadow:
	$s1 $s1 $s2 $color,
	-$s1 $s1 $s2 $color,
	$s1 (-$s1) $s2 $color,
	-$s1 (-$s1) $s2 $color;
}
```
哈，可爱的sass