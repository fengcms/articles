title: HTML5+CSS3 做一个灵动的动画 TAB 切换效果
date: 2017-09-15 11:58:40 +0800
update: 2017-09-15 11:58:40 +0800
author: fungleo
tags:
    -html5
    -css3
    -tab
    -css3动画
---

# HTML5+CSS3 做一个灵动的动画 TAB 切换效果

设计师给了一个 `tab` 切换的效果图。虽然是一个很小的功能，但是前端工程师在实现的时候还是有很多细节需要注意。我写了一个 `demo` 给大家参考。

最终实现效果如下：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/49/098b5df4b7883f58024e710d833078.gif)
> 为了 `gif` 动画能够展示细节，我将动画时间延长到了 3 秒

代码分享地址：http://runjs.cn/detail/h2dqt3td

## 实现思路

1. 间隔竖线，因为不是顶天立地的，所以不能用边框。我准备用伪元素实现。
2. 只有 3 个竖线，但是有 4 个 `li` ，这个简单，可以用 `:not(:first-child)` 选择器来选择。
3. 切换的背景颜色变化，因为想要有从小到大的效果，因此，也不能直接使用背景颜色实现，我也准备用伪元素实现。
4. 如果用伪元素的大小来控制，计算会比较复杂，因此，我想用 `box-shadow` 阴影来实现。

好，大体就是如此了，下面开始写代码，如下：

## HTML 代码

```html
  <div class="m">
    <ul class="tab">
      <li><a href="">导航1</a></li>
      <li><a href="">导航2</a></li>
      <li><a href="">导航3</a></li>
      <li><a href="">导航4</a></li>
    </ul>
  </div>
```

上面的代码结构是之前已经写好的，我看可以，就不做任何调整了。没有什么累赘的代码。

## CSS 代码

```css
.m { margin: 100px; }

.tab { width: 400px; margin: 0 auto; border: 1px solid #ddd; height: 40px; text-align: center; line-height: 40px; background: #fff; border-radius: 10px; overflow: hidden; }
.tab li { float: left; width: 100px; position: relative; overflow: hidden; }
.tab li:before, .tab li:after, .tab li a { -webkit-transition: all 0.25s ease-in-out; transition: all 0.25s ease-in-out; }
.tab li:before, .tab li:after { content: ""; display: block; }
.tab li:not(:first-child):after { background: #ddd; height: 20px; width: 1px; left: 0; top: 10px; position: absolute; }
.tab li a { display: block; position: relative; z-index: 2; color: #000; font-size: 14px; }
.tab li:before { width: 0; height: 0; top: 50%; left: 50%; z-index: 1; position: absolute; }
.tab li:hover a { color: #fff; }
.tab li:hover:before { box-shadow: 0 0 0 100px #36bc99; }
.tab li:hover + li:after, .tab li:hover:after { height: 0; top: 20px; }
```

代码分析：

1. 动画实现非常简单，只要使用 `transition` 属性即可。
2. 控制自己的伪元素和下一个同级元素的伪元素，只需要使用 `+` 选择器即可。

其他代码都比较清晰简单，自己分析即可。

实现这个效果还是非常简单的，重点是平时的积累，以及各种参数的灵活搭配。想到实现方法，最终写代码是很快的事情。而且没有什么知识高点在里面。

> CSS 之所以难，不是你不会，而是不不会去搭配。

其实，还是只还原了99%的设计效果，两条线一个在背景里面，一个在背景外面，想要把两条分割线都放到背景里面来，应该如何实现呢？可以思考一下。

安利一下 `scss` 。上面的 `css` 是编译出来的。其实用 `scss` 实现非常方便快捷，代码可读性也更高。

演示如下：

```css
.m {
  margin: 100px;
}

.tab {
  width: 400px;margin: 0 auto;border: 1px solid $cdd;height: 40px;text-align: center;line-height: 40px;
  background: $cff;border-radius: 10px;overflow: hidden;
  li {
    float: left;width: 100px;position: relative;overflow: hidden;
    &:before,&:after,a {@include dz();}
    &:before,&:after {
      content: "";display: block;
    }
    &:not(:first-child) {
      &:after {
        background: $cdd;height: 20px;width: 1px;left: 0;top: 10px;position: absolute;
      }
    }
    a {
      display: block;position: relative;z-index: 2;color: $c00;font-size: 14px;
    }
    &:before {
      width: 0;height: 0;top: 50%;left: 50%;z-index: 1;position: absolute;
    }
    &:hover {
      a {color: $cff;}
      &:before {
        box-shadow: 0 0 0 100px $cyan;
      }
      & + li:after,&:after {
        height: 0;top: 20px;
      }
    }
  }
}
```
当然，这段代码中我用了颜色变量以及 `mixin` 混入代码。你不能直接使用。

更多有关 `scss` 的内容，可以查看这个网站 [sass入门 - sass教程](http://www.w3cplus.com/sassguide/)

> 如果文章由于我学识浅薄，导致您发现有严重谬误的地方，请一定在评论中指出，我会在第一时间修正我的博文，以避免误人子弟。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


