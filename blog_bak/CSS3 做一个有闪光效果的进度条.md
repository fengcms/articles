title: CSS3 做一个有闪光效果的进度条
date: 2017-08-14 17:48:00 +0800
update: 2017-08-14 17:48:00 +0800
author: fungleo
tags:
    -css3
    -html
    -进度条
---

# CSS3 做一个有闪光效果的进度条

今天刚入职的小前端看到一个进度条的效果，想要实现，但是不知道如何下手，于是，我写了一个demo给它看下。

最终效果：[CSS3 实现闪光效果进图条](http://runjs.cn/detail/ykmswclh)

如上链接所示，不仅仅是有一个进度的效果，关键是，在进度效果上还有一个闪光效果。

## 开始实现

**HTML**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>做一个进度条</title>
</head>
<body>
  <div class="prog">
    <div class="prog_line" style="width:50%"></div>
  </div>
</body>
</html>
```

代码非常简单，就是外面一层`div`，实现进度条的背景颜色，里面一个`div`实现进图条的展示。

**CSS**

```css
.prog {
	width: 100%;height: 20px; border-radius: 5px; background: #f0f0f0;
	margin:20px auto;
}
.prog_line {
	transition: all 0.25s ease-in-out;
	height: 20px; background: #20A0FF;border-radius: 5px; position: relative;
}
.prog_line:after {
	display: block; content:"";height: 20px; background: #fff; border-radius: 5px;
	position: absolute; left: 0; top: 0;
	animation: progshow 1s infinite;
}
@keyframes progshow {
	0%   {width: 0; opacity: .3;}
	100% {width: 100%; opacity: 0.1;}
}
```

CSS部分也没什么复杂的。背景框和进度条颜色就不解释了，非常简单。

重点是利用给进度条颜色的伪元素 `after` 增加了一个动画效果，就最终实现了那个闪光了。

## 小结

有很多效果看上去很酷炫，但是我们只要静下心来仔细拆解分析一下，实现这些效果是非常简单的事情。问题是，很多新手经验积累欠缺，这个就没有办法了，只能是一步步的去积累，慢慢的来进步。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

