title: nth-child 的一些小尝试
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -css3
    -nth-child
---

#nth-child 的一些小尝试
##前言
对于 first-child 或者  last-child 等,还算比较常用.但是 nth-child 一般也就用隔行变色.一直不认为其有多强大的功能,甚至认为其比较鸡肋.

但是今天深入研究了一下,发现这货不是一点半星的强大啊!!!!不废话,直接上代码

##code
```
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>nth-child test</title>
</head>
<body>
	<ul>
		<li>this is title 1</li>
		<li>this is title 2</li>
		<li>this is title 3</li>
		<li>this is title 4</li>
		<li>this is title 5</li>
		<li>this is title 6</li>
		<li>this is title 7</li>
		<li>this is title 8</li>
		<li>this is title 9</li>
		<li>this is title 10</li>
		<li>this is title 11</li>
		<li>this is title 12</li>
		<li>this is title 13</li>
		<li>this is title 14</li>
		<li>this is title 15</li>
		<li>this is title 16</li>
		<li>this is title 17</li>
		<li>this is title 18</li>
		<li>this is title 19</li>
		<li>this is title 20</li>
	</ul>
</body>
</html>
<style>
	li:nth-child(1){background: #fda;}
	li:nth-child(3n){background: #daf;}
	li:nth-child(-n+4) {font-weight: bold;}
	li:nth-child(5n){border-bottom: 1px solid #ddd;padding-bottom: 20px;margin-bottom: 20px;}
	li:nth-child(n+5) {text-indent: 10px;}
	li:nth-child(3n+1) {color: #f00;}
	li:nth-child(3n-1) {color: #00f;}
</style>
```
太TM灵活了,以后这种地方,根本就不需要加上 class啦!!!!

##更多内容阅读

[精通:nth-child](http://www.webhek.com/misc/mastering-nth-child)
[关于nth-child的疑惑](http://blog.cssforest.org/2015/04/20/%E5%85%B3%E4%BA%8Enth-child%E7%9A%84%E7%96%91%E6%83%91.html)
[w3school:CSS3 :nth-child() 选择器](http://www.w3school.com.cn/cssref/selector_nth-child.asp)我就是看了这个才认为这玩意儿鸡肋的,W3S害死人啊!!!