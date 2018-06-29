title: 【转载】CSS3 常用四个动画（旋转、放大、旋转放大、移动）
date: 2015-11-15 14:24:25 +0800
update: 2015-11-15 14:24:25 +0800
author: fungleo
tags:
    -css3
    -动画
    -scss
    -sass
    -css3动画
---

#CSS3 常用四个动画（旋转、放大、旋转放大、移动）

在页面设计中，给一些图标或者图片加上一些动画效果，会给人非常舒服的感觉。这里收集了四个常用动画效果，以便不时之需。

##转载原文

**效果一：360°旋转 修改rotate(旋转度数)**
```
* {
	transition:All 0.4s ease-in-out;
	-webkit-transition:All 0.4s ease-in-out;
	-moz-transition:All 0.4s ease-in-out;
	-o-transition:All 0.4s ease-in-out;
}
*:hover {
	transform:rotate(360deg);
	-webkit-transform:rotate(360deg);
	-moz-transform:rotate(360deg);
	-o-transform:rotate(360deg);
	-ms-transform:rotate(360deg);
}

```
**效果二：放大 修改scale(放大的值)**
```
* {
	transition:All 0.4s ease-in-out;
	-webkit-transition:All 0.4s ease-in-out;
	-moz-transition:All 0.4s ease-in-out;
	-o-transition:All 0.4s ease-in-out;
}
*:hover {
	transform:scale(1.2);
	-webkit-transform:scale(1.2);
	-moz-transform:scale(1.2);
	-o-transform:scale(1.2);
	-ms-transform:scale(1.2);
}
```
**效果三：旋转放大 修改rotate(旋转度数) scale(放大值) **
```
* {
	transition:All 0.4s ease-in-out;
	-webkit-transition:All 0.4s ease-in-out;
	-moz-transition:All 0.4s ease-in-out;
	-o-transition:All 0.4s ease-in-out;
}
*:hover {
	transform:rotate(360deg) scale(1.2);
	-webkit-transform:rotate(360deg) scale(1.2);
	-moz-transform:rotate(360deg) scale(1.2);
	-o-transform:rotate(360deg) scale(1.2);
	-ms-transform:rotate(360deg) scale(1.2);
}

```
**效果四：上下左右移动 修改translate(x轴,y轴) **
```
* {
	transition:All 0.4s ease-in-out;
	-webkit-transition:All 0.4s ease-in-out;
	-moz-transition:All 0.4s ease-in-out;
	-o-transition:All 0.4s ease-in-out;
}
*:hover {
	transform:translate(0,-10px);
	-webkit-transform:translate(0,-10px);
	-moz-transform:translate(0,-10px);
	-o-transform:translate(0,-10px);
	-ms-transform:translate(0,-10px);
}

```
转载原文地址：http://www.jq-school.com/Show.aspx?id=281

*下为我的补充*

##SCSS改造

这样的代码不利于我们在工作中的使用。这里我强烈推荐大家使用`scss`来书写`css`样式。

```
// 执行动画以及执行时间设定
@mixin dz($time:0.25s){
    -webkit-transition: all $time ease-in-out;
    -moz-transition: all $time ease-in-out;
    -o-transition: all $time ease-in-out;
    -ms-transition: all $time ease-in-out;
    transition: all $time ease-in-out;
}
// 宣传动画调用
@mixin xz($deg:360){
	transform:rotate($deg+deg);
    -webkit-transform:rotate($deg+deg);
    -moz-transform:rotate($deg+deg);
    -o-transform:rotate($deg+deg);
    -ms-transform:rotate($deg+deg);
}
// 放大动画
@minxin fd($s1:1.2){
	transform:scale($s1);
	-webkit-transform:scale($s1);
	-moz-transform:scale($s1);
	-o-transform:scale($s1);
	-ms-transform:scale($s1);
}
// 旋转放大动画
@mixin xzfd($deg:360,$s1:1.2){
	transform:rotate($deg+deg) scale($s1);
	-webkit-transform:rotate($deg+deg) scale($s1);
	-moz-transform:rotate($deg+deg) scale($s1);
	-o-transform:rotate($deg+deg) scale($s1);
	-ms-transform:rotate($deg+deg) scale($s1);
}
// 移动动画
@mixin yd($s1:0,$s2:0){
	transform:translate($s1,$s2);
	-webkit-transform:translate($s1,$s2);
	-moz-transform:translate($s1,$s2);
	-o-transform:translate($s1,$s2);
	-ms-transform:translate($s1,$s2);
} 
```
**使用方法**
```
#somebox{
	@include dz();
	&:hover {
		@include yd(-10px,-10px);
	}
}
```

更多SCSS使用方法，请百度“SASS”

> SASS 是无花括号的纯缩进写法，不利于前端人员熟悉。因此，推出了有花括号版本的SCSS两者的语法是一致的。只是有没有花括号的差别。我们在工作中，一般都使用SCSS来书写CSS，但是，在查找SCSS问题的时候，一般搜索SASS

