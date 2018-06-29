title: css3 做一个会动的菜单 menu 按钮动画效果
date: 2017-09-11 11:45:06 +0800
update: 2017-09-11 11:45:06 +0800
author: fungleo
tags:
    -css3
    -动画
---

# css3 做一个会动的菜单 menu 按钮动画效果

需要做一个会的动画按钮效果，小前端部知道如何实现，我看了一眼需要的效果，给他写了一个简单的 `demo`。

设计师给了俩图片，一个是 `三` 这样的菜单图标，另一个是点击时，变成 `X` 的图标。希望在这两个图标之间，有动画切换效果。

效果演示地址：http://runjs.cn/detail/al9vgagm

因为图标非常简单，我们可以用 `css` 把这俩图标画出来，然后做一个动画的过度效果就可以了。代码如下：

## html代码

```html
  <div class="box">
    <div class="menu"></div>
  </div>
```
外面的 `.box` 只是为了撑开页面，没有实际作用。有用的，就是一个 `.menu`。

## CSS 代码

```css
.box { margin: 200px; }

.menu { width: 100px; height: 100px; position: relative; }
.menu:before, .menu:after { content: ""; display: block; width: 100px; height: 16px; background: #000; border-radius: 8px; position: absolute; left: 0; -webkit-transition: all 0.15s ease-in-out; transition: all 0.15s ease-in-out; }
.menu:before { top: 5px; box-shadow: 0 37px #000; }
.menu:after { bottom: 5px; }
.menu:hover:before { top: 42px; box-shadow: none; -webkit-transform: rotate(225deg); transform: rotate(225deg); }
.menu:hover:after { bottom: 42px; -webkit-transform: rotate(135deg); transform: rotate(135deg); }

```

重点解释：

一个元素给加上了 `transition: all 0.15s ease-in-out;` 这样的代码，那么当他的任何属性发生变化的时候，都会有切换效果。更多内容请参考 [CSS3 transition 属性](http://www.w3school.com.cn/cssref/pr_transition.asp)

因为有三个横线，所以 `:before` 和 `:after` 两个伪元素还不够。我不愿意再去额外添加一个元素，使有更多的东西可以控制。所以，我用了一个 `box-shadow: 0 37px #000;` 阴影的方式，实现中间的那个横线的效果。 `:before` 和 `:after` 分别放在上面和下面。

切换 `X` 的时候，只有两个元素，我只要把上面添加的阴影给去掉即可 `box-shadow: none;`。

然后就是位置的变化，和添加旋转了。位置变化不表。旋转使用了 `transform: rotate(225deg);` 这个属性来实现。更多内容，请参考 [CSS3 transform 属性](http://www.w3school.com.cn/cssref/pr_transform.asp)

最终实现效果如下：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/dc/c1ccd34b16f5c59b20f285b5d7f940.gif)
好，效果就实现了。上面的动画我是放到切换实现3秒，为的是看清楚动画细节效果。

其实，会了这个思路，我们可以做很多简单的动画效果的。

> 如果文章由于我学识浅薄，导致您发现有严重谬误的地方，请一定在评论中指出，我会在第一时间修正我的博文，以避免误人子弟。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


