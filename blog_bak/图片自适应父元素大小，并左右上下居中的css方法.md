title: 图片自适应父元素大小，并左右上下居中的css方法
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -css
    -图片垂直居中
    -图片自适应大小
---

#图片自适应父元素大小，并左右上下居中的css方法

## 前言

这种效果多见于矩形盒子里面调用不规则的图片，希望能够达到的效果。这个效果可以很简单的用css来实现，虽然已经烂熟于心，但是并未记录下来。今天看到又有这个需求，所以写了一个简单的demo，放在这里，便于自己记忆。

效果图：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/fb/7ab6fda20ae59bcb7a511d89ccfe52.png)
## 代码

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Document</title>
</head>
<body>
  <div class="pic"><img src="https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1438475101,354016904&fm=58" alt=""></div>
  <div class="pic"><img src="https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2201558756,12364836&fm=111&gp=0.jpg" alt=""></div>
</body>
</html>
<style>
.pic {
  width: 120px;height: 120px;margin: 40px auto;border: 1px solid #ccc;text-align: center;padding: 5px;
}
.pic:before {
  content: "";display: inline-block;height: 100%;vertical-align: middle;width: 0;
}
.pic img {
  max-width: 120px; max-height: 120px;vertical-align: middle;
}
</style>
```

**核心思想** 就是给父元素添加一个固定100%高度的伪元素撑开，并使用`vertical-align: middle;`使得内容垂直居中为中间，这样，图片就会垂直居中了。当然，图片也需要加上`vertical-align: middle;`

实际运行效果：http://runjs.cn/detail/wkpxpghm