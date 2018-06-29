title: javascript 快速获取图片实际大小的宽高
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -javascript
    -获取图片大小
---

# javascript 快速获取图片实际大小的宽高

## 简陋的获取图片实际宽高的方式

```js
// 图片地址
var img_url = '13643608813441.jpg'

// 创建对象
var img = new Image()

// 改变图片的src
img.src = img_url

// 打印
alert('width:'+img.width+',height:'+img.height);
```

结果如下：

![](http://upload-images.jianshu.io/upload_images/4645892-0ef46ab2f2df29c1.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


宽高都是0的这个结果很正常，因为图片的相关数据都没有被加载前它的宽高默认就是0，我们需要它加载完所有的相关数据再获取宽和高。

## onload加载所有的相关数据后，取宽高

```js
// 图片地址
var img_url = '13643608813441.jpg'

// 创建对象
var img = new Image()

// 改变图片的src
img.src = img_url

// 加载完成执行
img.onload = function(){
    // 打印
    alert('width:'+img.width+',height:'+img.height)
}
```

结果如下:

![](http://upload-images.jianshu.io/upload_images/4645892-6900614bacd4d4ba.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


通过onload就能获取到图片的宽高了。但onload大一点的图通常都比较慢，不实用，但只要图片被浏览器缓存，那么图片加载几乎就不用等待即可触发onload，我们要的是占位符。所以有些人通过缓存获取也可以这么写。

## 通过complete与onload一起混合使用

```js
// 图片地址
var img_url = '13643608813441.jpg'

// 创建对象
var img = new Image()

// 改变图片的src
img.src = img_url

// 判断是否有缓存
if(img.complete){
    // 打印
    alert('from:complete : width:'+img.width+',height:'+img.height)
}else{
    // 加载完成执行
    img.onload = function(){
        // 打印
        alert('width:'+img.width+',height:'+img.height)
    }
}
```

第一次执行，永远是onload触发，你再刷新，几乎都是缓存触发了。

从缓存里读取图片的宽高不用说，非常方便快捷，今天我们要解决的是没有缓存而又快速的相比onload更快的方式去获取图片的宽高。我们常常知道有些图片虽然没有完全down下来，但是已经先有占位符，然后一点一点的加载。既然有占位符那应该是请求图片资源服务器响应后返回的。可服务器什么时候响应并返回宽高的数据没有触发事件，比如onload事件。于是催生了第四种方法。

## 通过定时循环检测获取

这个方法可以很快获取图片相关信息：

```js
// 记录当前时间戳
var start_time = new Date().getTime()
// 图片地址 后面加时间戳是为了避免缓存
var img_url = 'http://b.zol-img.com.cn/desk/bizhi/image/2/2560x1600/1365477614755.jpg?'+start_time
// 创建对象
var img = new Image()
// 改变图片的src
img.src = img_url
// 定时执行获取宽高
var check = function(){
 // 只要任何一方大于0
 // 表示已经服务器已经返回宽高
    if (img.width>0 || img.height>0) {
        var diff = new Date().getTime() - start_time;
        document.body.innerHTML += '
        from:check : width:'+img.width+',height:'+img.height+', time:'+diff+'ms';
        clearInterval(set);
    }
}
var set = setInterval(check,40)
// 加载完成获取宽高
img.onload = function(){
    var diff = new Date().getTime() - start_time;
    document.body.innerHTML += 'from:onload : width:'+img.width+',height:'+img.height+', time:'+diff+'ms';
};
```

结果如下：

![](http://upload-images.jianshu.io/upload_images/4645892-c76e38f4e13a093a.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这是一张2560 * 1600大小的图片，各浏览器执行结果都能看到通过快速获取图片大小的方法几乎都在200毫秒以内，而onload至少五秒以上，这差别之大说明快速获取图片宽高非常实用。

当然现在浏览器随着性能的提升也许这一差距不是那么的大，甚至与onload有时还会更快些。

作者：言墨儿
链接：http://www.jianshu.com/p/41ff1d103d3f


