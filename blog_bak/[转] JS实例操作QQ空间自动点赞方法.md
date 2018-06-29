title: [转] JS实例操作QQ空间自动点赞方法
date: 2016-01-03 23:53:26 +0800
update: 2016-01-03 23:53:26 +0800
author: fungleo
tags:
    -jquery
    -qq空间
---

做开法的小伙伴都知道我们在查找网络资源时，通常会通过 使用谷歌浏览器的 F12 对页面元素进行操作，且可以查看一些网络资源，当然火狐浏览器也有这种功能，不是IE就好了。

1. 打开QQ空间
2. 按下 F12 ，并选中 Console 节点
3. 将以下代码复制到打开的 Console 节点中，并回车，程序开始执行，并会发现已经开始自动点赞，代码如下
```
jQuery("a.qz_like_btn_v3[data-clicklog='like']").each(function(index,item){
   console.log(item);
   jQuery(item).trigger('click');
});
jQuery(window).scroll(function(){
   jQuery("a.qz_like_btn_v3[data-clicklog='like']").each(function(index,item){
       jQuery(item).trigger('click');
   });
   return true;
});

var t = 0;
setInterval(function(){
   jQuery('body,html').animate({'scrollTop':t+=2000},100);
},2000)
```
PS:测试有效
转载地址:http://blog.csdn.net/w_yunlong/article/details/50425534