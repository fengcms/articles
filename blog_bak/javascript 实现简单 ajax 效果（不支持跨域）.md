title: javascript 实现简单 ajax 效果（不支持跨域）
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -javascript
    -ajax
    -异步
---

##javascript 实现简单 ajax 效果（不支持跨域）
一般情况下，这些效果我都是用JQ实现。但是，某些不能用JQ的项目，还是研究一下原生比较好。

以下内容是转载的。对我甚有助益。

----------

##什么是 ajax
ajax 即“Asynchronous JavaScript and XML”（异步 JavaScript 和 XML），也就是无刷新数据读取。

##http 请求
首先需要了解 http 请求的方法（GET 和 POST）。

GET 用于获取数据。GET 是在 URL 中传递数据，它的安全性低，容量低。

POST 用于上传数据。POST 安全性一般，容量几乎无限。

##ajax 请求
ajax 请求一般分成 4 个步骤。

###1、创建 ajax 对象
在创建对象时，有兼容问题：
```
var oAjax = new XMLHttpRequest();   //for ie6 以上
var oAjax = new ActiveXObject('Microsoft.XMLHTTP'); //for ie6
```
合并上面的代码：
```
var oAjax = null;
if(window.XMLHttpRequest){
    oAjax = new XMLHttpRequest();
}else{
    oAjax = new ActiveXObject('Microsoft.XMLHTTP');
}
```

###2、连接服务器
在这里会用到 open() 方法。open() 方法有三个参数，第一个参数是连接方法即 GET 和 POST，第二个参数是 URL 即所要读取数据的地址，第三个参数是否异步，它是个布尔值，true 为异步，false 为同步。
```
oAjax.open('GET', url, true);
```
###3、发送请求
send() 方法。
```
oAjax.send();
```
###4、接收返回值
onreadystatechange 事件。当请求被发送到服务器时，我们需要执行一些基于响应的任务。每当 readyState 改变时，就会触发 onreadystatechange 事件。

readyState：请求状态，返回的是整数（0-4）。

0（未初始化）：还没有调用 open() 方法。

1（载入）：已调用 send() 方法，正在发送请求。

2（载入完成）：send() 方法完成，已收到全部响应内容。

3（解析）：正在解析响应内容。

4（完成）：响应内容解析完成，可以在客户端调用。

status：请求结果，返回 200 或者 404。

200 => 成功。

404 => 失败。

responseText：返回内容，即我们所需要读取的数据。需要注意的是：responseText 返回的是字符串。

```
oAjax.onreadystatechange=function(){
    if(oAjax.readyState==4){
        if(oAjax.status==200){
            fnSucc(oAjax.responseText);
        }else{
            if(fnFaild){
                fnFaild();
            }
        }
    }
};
```
将以上代码进行封装：

```
function ajax(url, fnSucc, fnFaild){
    //1.创建对象
    var oAjax = null;
    if(window.XMLHttpRequest){
        oAjax = new XMLHttpRequest();
    }else{
        oAjax = new ActiveXObject("Microsoft.XMLHTTP");
    }
      
    //2.连接服务器  
    oAjax.open('GET', url, true);   //open(方法, url, 是否异步)
      
    //3.发送请求  
    oAjax.send();
      
    //4.接收返回
    oAjax.onreadystatechange = function(){  //OnReadyStateChange事件
        if(oAjax.readyState == 4){  //4为完成
            if(oAjax.status == 200){    //200为成功
                fnSucc(oAjax.responseText) 
            }else{
                if(fnFaild){
                    fnFaild();
                }
            }
        }
    };
}
```
####最后附上实例：
```
<!DOCTYPE HTML>
<html lang="en-US">
<head>
    <meta charset="UTF-8">
    <title>ajax基础</title>
</head>
<body>
    点击按钮的时候，读取abc.txt<input id="btn" type="button" value="读取"/><br/>
    <div id="con"></div>
</body>
</html>
<script type="text/javascript" src="ajax.js"></script>
<script type="text/javascript">
window.onload = function(){
    var oBtn = document.getElementById('btn');
    var oCon = document.getElementById('con');
    oBtn.onclick = function(){
        ajax('abc.txt',function(str){
            oCon.innerHTML = str;
        });
    }
}
</script>
```
原文链接：http://www.cnblogs.com/yjzhu/archive/2013/01/28/2879542.html 

经过测试，不支持跨域，并且必须在服务器环境下运行才能成功。直接打开html文件的形式，会提示错误的。