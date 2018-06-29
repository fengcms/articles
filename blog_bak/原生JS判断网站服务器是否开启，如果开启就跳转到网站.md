title: 原生JS判断网站服务器是否开启，如果开启就跳转到网站
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -javascript
    -判断元素是否加载
---

#原生JS判断网站服务器是否开启，如果开启就跳转到网站

##前言

一个项目，移动端APP演示版。因为是演示版，所以没有任何功能。我用html+css3+jquery开发完成。为了代码共用、减少入口、实现loading效果等原因，我采用了大量的ajax效果。不装逼了，其实就是load异步加载-_-

项目完成后，交付安卓工程师封装成APP。这期间遇到了一个问题，就是，ajax是不支持本地访问的，必须在http服务下运行。为此，安卓工程师在APP内封装了一个http服务，具体实现方法未知。

现在产生了第二个问题，交给我来解决。那就是，在APP打开，到http服务启动，这中间是有时间差的。尤其是APP第一次启动，需要往内存上存储数据，需要的时间更多。因此，APP打开后需要一个loading效果。

##loading页面要求
1. 不能使用ajax
2. 不能使用jquery
3. 原生js判断服务器是否开启，如果开启则跳转，否则继续等待

##页面实现思路
1. 在页面中不断读取服务器的某一张图片
2. 在读取到图片后，跳转
3. 那就使用定时器
4. 为防止缓存影响图片，需要给图片地址后面加上时间戳

##实现代码
###html
```html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>正在加载，请耐心等待</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
</head>
<body>
<div class="loading"></div>
<img id="none" onload="window.location.href='http://127.0.0.1:9852/';">
</body>
</html>
```
###css
```css
.loading {
    width: 60px;
    height: 60px;
    background-color: #FE4B83;

    margin: 100px auto;
    -webkit-animation: rotateplane 1.2s infinite ease-in-out;
    animation: rotateplane 1.2s infinite ease-in-out;
}

@-webkit-keyframes rotateplane {
    0% { -webkit-transform: perspective(120px) }
    50% { -webkit-transform: perspective(120px) rotateY(180deg) }
    100% { -webkit-transform: perspective(120px) rotateY(180deg)  rotateX(180deg) }
}

@keyframes rotateplane {
    0% {
        transform: perspective(120px) rotateX(0deg) rotateY(0deg);
        -webkit-transform: perspective(120px) rotateX(0deg) rotateY(0deg)
    } 50% {
        transform: perspective(120px) rotateX(-180.1deg) rotateY(0deg);
        -webkit-transform: perspective(120px) rotateX(-180.1deg) rotateY(0deg)
    } 100% {
        transform: perspective(120px) rotateX(-180deg) rotateY(-179.9deg);
        -webkit-transform: perspective(120px) rotateX(-180deg) rotateY(-179.9deg);
    }
}

#none {display: none;}
```
###javascript
```javascript
var img = document.getElementById("none");
function load(){
	img.src="http://127.0.0.1:9852/image/banner1.jpg?"+new Date().getTime();
}
setInterval("load()",1000);
```
`PS:实际项目中所有代码在一个页面中`

##实践结果以及总结
完美。

看着代码很短，其实走了很多弯路。比如，一开始我在img中直接写上了src，导致了很多问题。由于对原生js不是很熟悉，也查阅了很多资料。

在高手的帮助下，终于实现了这个效果，并且代码大幅减少了。其实开始我写得很长的-_- |||

学习，继续学习！！！