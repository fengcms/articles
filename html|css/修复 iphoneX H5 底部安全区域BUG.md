# 修复 iPhone X H5 底部安全区域定位按钮下内容穿透 BUG

今日，开发了一个 `h5` 项目，其中有部分页面使用了底部按钮，采用的是相对于浏览器窗口定位的样式制作的。

但是在 `iPhone X` 上面，出现了在按钮下方，居然有页面穿越的情况，这就尴尬了。对于我这种不用 `iPhone` 的人来说，说了一句 mmp 然后就得去解决这个问题。

## iPhone X 安全区域的问题

找到这张图片。一般来说，顶部的安全区域问题，可以交给浏览器解决，但是底部的，就需要我们自己来解决了。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/e9/d5e8e3fe5a0d19a06573d5029046e8.jpg)

首先，我尝试一种简单的解决方案，就是给底部的按钮，加一个向下的投影，类似这样的代码：

```css
.bottom_button {
  box-shadow: 0 34px #fff
}
```

天真的我以为，投影这种东西，是不占文档流的，因此，也就不影响其他的手机，在 `iPhong X` 有向下的区域，直接就遮盖上了不就可以了么？

哈哈，我实在是太天真了，事实无情的打了我的脸。

于是，我又尝试用一个伪元素去向下定位，妄想解决这个问题，又一次被现实给彻底的教育了。

哎，搜索了一下，找到了对应的解决方案，尝试一下，果然解决，但是说得有点啰嗦，下面直接给我的最终代码。

## 解决 iPhone X H5 安全区域的问题

首先，需要给网页设置 `meta`，如下设置：

```html
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no,viewport-fit=cover">
```

重点是 `viewport-fit` 这个参数，设置为 `cover` 表示，内容展示到安全区域外。

>contain: The viewport should fully contain the web content. 可视窗口完全包含网页内容

>cover: The web content should fully cover the viewport. 网页内容完全覆盖可视窗口

>auto: The default value, 同contain的作用

好，现在我们的按钮已经下去了，但是，其被屏幕下方的一个条条给挡住了，这当然不行。我们继续解决。

由于 `iPhone X` 是一个特殊的机型，其分辨率特别特殊，所以，我们可以用媒体查询来定位到我们的网页是否在 `iPhone X` 中运行，因此，我们代码如下：

```css
@media only screen and (device-width: 375px) and (device-height: 812px) and (-webkit-device-pixel-ratio: 3) {
    /* 这代表IPX */
    /* 目前这种设备像素比 和 尺寸是很“奇葩”、特殊的，基本可以确定是 IPX */
}

@media only screen and (width: 812px) and (height: 375px) and (-webkit-device-pixel-ratio: 3) {
    /* 这代表IPX的横屏模式 */
    /* 针对 IPX 横屏单独处理 */
}
```

好，我们就可以直接在这里写了。我们的页面不会出现横屏的状态，因为是内嵌，`App` 本身禁止横屏了。所以，只需要第一段代码。

如果我们的页面只有一个底部的按钮，自然现在问题就解决了，单独去写一下即可。但事实是，我们页面中可能有多处使用了这样的按钮，每个都需要写，还是感觉有点累。

因此，我写了这样的一个 `class`


```css
.fix_iphonex {
  @media only screen and (device-width: 375px) and (device-height: 812px) and (-webkit-device-pixel-ratio: 3) {
    padding-bottom: rem(34);
  }
}
```

然后，在需要解决的按钮内，这样调用：

```
@extend .fix_iphonex;
```

嗯，感谢 `sass`!

参考资料： https://segmentfault.com/q/1010000012293245?sort=created

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

