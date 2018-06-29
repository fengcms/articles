title: 移动换H5 の 纯CSS3实现大转盘抽奖布局 by FungLeo
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -css3
    -布局
    -大转盘
    -移动端H5
    -FungLeo
---

#移动换H5 の 纯CSS3实现大转盘抽奖布局 by FungLeo

##前言

本教程不涉及JS控制旋转部分,也不涉及后端输出抽奖结果部分.这篇教程讲的是如何去实现大转盘抽奖的布局.

在制作大转盘抽奖的时候,一般使用到的插件是`jQueryRotate`这款插件.网上有很多可以参考的教程.不再赘述.

这篇博文的意义是,一般情况下,这些奖项它都是直接做到图片上去了.当然,这样也没有什么不行,只是如果要修改奖项的话,还需要去修改一下图片,甚是繁琐.

所以,本文,是讲,如何实现CSS布一个大转盘的局.

##所要的效果.以及对应的图片资源

![](https://raw.githubusercontent.com/fengcms/articles/master/image/6f/578f65f6476ee300b480f5b2080390.jpg)
如上图所示,我们要实现这样的一个大转盘效果.顶上的标题栏和滚动文字,以及下面的提示,不是本文的重点,请自动忽略.

我们需要两个素材,一个是下面的转盘背景图片,一个是指针图片.图片素材如下:

![](https://raw.githubusercontent.com/fengcms/articles/master/image/65/22dfc9400820bd8ddd9507531187be.jpg)转盘背景

![](https://raw.githubusercontent.com/fengcms/articles/master/image/8c/d467426ca650379a3118d46cfb5b36.jpg)转盘指针

上面的两张素材被微博图床自动转换为了JPG图片.我们在做的时候,可以管设计要两个类似的设计.图片的格式为24位透明

##html结构

```html
<div class="turntable">
    <div class="pointer"></div>
    <div class="rotate" id="rotate">
        <div class="prize prize_1"><strong>苹果6s</strong><span>手机一部</span></div>
        <div class="prize prize_2"><strong>未中奖</strong><span>谢谢参与</span></div>
        <div class="prize prize_3"><strong>充电宝</strong><span>1部</span></div>
        <div class="prize prize_4"><strong>未中奖</strong><span>谢谢参与</span></div>
        <div class="prize prize_5"><strong>U盘</strong><span>4G 1个</span></div>
        <div class="prize prize_6"><strong>未中奖</strong><span>谢谢参与</span></div>
        <div class="prize prize_7"><strong>15元</strong><span>手机话费</span></div>
        <div class="prize prize_8"><strong>未中奖</strong><span>谢谢参与</span></div>
    </div>
</div>
```
这个结构,还是比较简单的`.turntable`为总的盒子,`.pointer`是指针,`.rotate`为大转盘旋转的部分.而`.rotate`里面的,则就是奖项了.`strong`和`span`则分别是如上面的演示,大的文字和小的文字而已.

结构没什么复杂的.下面我们来写css.

##sass代码

**注意:**
1. 本文CSS部分使用SASS撰写.如果你对SASS不了解,请参考我的博文《[CSS预编译技术之SASS学习经验小结](http://blog.csdn.net/fungleo/article/details/50851192)》,
2. 本文默认引用我之前写的`resert.scss`和`mixin.scss`两个文件.一个是浏览器重置代码,一个是常用代码片混入代码.请在此获取《[移动端系列博文基础reset.scss和mixin.scss](http://blog.csdn.net/fungleo/article/details/50877720)》
3. 为了便于大家理解,我将布局和表现,拆开来写.实际项目中,应该是整合在一起的.

###SASS布局部分

```css
.turntable {
    width: 28rem;height: 28rem;margin: 0 auto;position: relative;
    .pointer {
        position: absolute;z-index: 3;width: 9rem;height:12.17rem;left: 9.5rem;bottom: 9.5rem;
    }
    .rotate {
        width: 28rem;height: 28rem;position: absolute;left: 0;top: 0;z-index: 2;
        .prize {
            width: 8.45rem;height: 28rem;position: absolute;top: 0;left: 9.775rem;
            strong {display: block;margin-top: 4.4rem;}
            span {display: block;margin-top: 0.5rem;}
        }
    }
}
```

如上,在移动端的分辨率,最小是iphone5s的320宽.而最大,一般是iphone6plus的414宽.如果将大转盘做成自适应的,也不是不可以,只是稍嫌麻烦.因此,我决定做成固定宽度,在最小的上面也可以,在最大的上面,也不过分.

>在reset.scss中,我们规定 `html{font-size: 62.5%;}`也就是说,1rem 相当于 10px

因此,我将总的宽度,设置为`280px` 因此,`.turntable`则为一个280*280的矩形,并且居中.

`.pointer`是指针,但是,它不是一个正方形,而是一个长方形,我们需要把在图形中圆形的部分放到居中,因此,其定位,就需要仔细算一下.我这边用的图片的最终结果,如上.

`.rotate`是转盘中的旋转部分.本身没什么说的.和父盒子一样大,`left: 0;top: 0;`即可.关键是里面的奖项

`.prize`是里面的奖项.我们宽度设定为转盘一格的宽度,而高度设置为和父元素一样高.左右的位置为居中.它的情况,如下图所示:

![](https://raw.githubusercontent.com/fengcms/articles/master/image/8b/7558ffc6366b7f4ea627ca24cd1692.jpg)布局示例图

如上图所示,我们的8个`.prize`就都是那个黑色半透明的区域.全部定位到这里了.重叠显示.

里面的文字就不解释了,合适就行.

###SASS表现部分

```css
.turntable {
    .pointer {
        background:url("../image/dzp_zz.png") center no-repeat;
        background-size:contain;
    }
    .rotate {
        background:url("../image/dzp_zp.png") center no-repeat;
        background-size:contain;
        .prize {
            color:###;text-align: center;
            strong {font-size:1.5rem}
            span {font-size:.9rem}

            @for $i from 1 through 8 {
                &.prize_#{$i} { @include xz(45 * $i - 45);}
            }
        }
    }
}
```

在表现部分,指针和转盘的背景图片的运用就不说了.着重两点:

1. sass循环的时间.如上,使用 for 循环.
2. 引用mixin代码片段中的 旋转 代码.设定了8个旋转角度.

然后,八个奖项就会根据设定好的旋转角度,最终实现了本文第一张图片的那种我们所需要实现的效果.

##总结

我们不要局限于文档流布局和方方正正的盒子模型,CSS3赋予了我们大量的好玩的新的属性.定位布局,旋转,放大,晃动等各种动画效果,让我们无往而不利.

改变一个思路,其实很多事情都是很简单的.至少,下回要修改大转盘奖品的时候,我们不需要去单独的做一张图片了.

本文FungLeo原创,转载请保留版权申明,以及首发地址:[http://blog.csdn.net/FungLeo/article/details/50911888](http://blog.csdn.net/FungLeo/article/details/50911888)