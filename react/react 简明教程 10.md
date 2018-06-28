# React + webpack 开发单页面应用简明中文文档教程（十）在 jsx 和 scss 中使用图片

## React 入门系列教程导航

[React + webpack 开发单页面应用简明中文文档教程（一）一些基础概念](http://blog.csdn.net/fungleo/article/details/80841159)
[React + webpack 开发单页面应用简明中文文档教程（二）创建项目](http://blog.csdn.net/fungleo/article/details/80841181)
[React + webpack 开发单页面应用简明中文文档教程（三）目录说明以及调整项目构架文件](http://blog.csdn.net/fungleo/article/details/80841200)
[React + webpack 开发单页面应用简明中文文档教程（四）调整项目文件以及项目配置](http://blog.csdn.net/fungleo/article/details/80841220)
[React + webpack 开发单页面应用简明中文文档教程（五）配置 api 接口请求文件](http://blog.csdn.net/fungleo/article/details/80841241)
[React + webpack 开发单页面应用简明中文文档教程（六）渲染一个列表，初识 jsx 文件](http://blog.csdn.net/fungleo/article/details/80841255)
[React + webpack 开发单页面应用简明中文文档教程（七）jsx 组件中调用组件、父组件给子组件传值](http://blog.csdn.net/fungleo/article/details/80841263)
[React + webpack 开发单页面应用简明中文文档教程（八）Link 跳转以及编写内容页面](http://blog.csdn.net/fungleo/article/details/80841274)
[React + webpack 开发单页面应用简明中文文档教程（九）子组件给父组件传值](http://blog.csdn.net/fungleo/article/details/80841290)
[React + webpack 开发单页面应用简明中文文档教程（十）在 jsx 和 scss 中使用图片](http://blog.csdn.net/fungleo/article/details/80841296)
[React + webpack 开发单页面应用简明中文文档教程（十一）将项目打包到子目录运行](http://blog.csdn.net/fungleo/article/details/80841308)

****

`react` 是一个非常自由的框架，如果没有强制的规范，每一个人都会发展出不同的编写风格。我遇到过很多 `react` 开发的项目，他们都把图片就进存放，简单说，就是存放在 `src` 目录下的某个地方，然后使用 `./xxx.jpg` 这样的方式引入。

这种写法对于我这种具有代码强迫症的人来说，简直是无法忍受的。因此，我主导的项目开发中，都强制要求将所有的图片存放在 `/public/image/` 文件夹中。根据不同的分类，建立不同的文件夹，然后存放好。

如果你看过我写的 `vue` 的博文，就知道，我是一个喜欢把同一类的东西放在一起的人。我是绝对忍受不了所谓的 `css in js` 这种狗屎解决方案的。有人说这样方便啊，我只需要引入一个 `jsx` 文件就解决了所有的问题啦！

针对这个问题，我的回答是：**你不能因为自己吃一勺烩的盒饭，就把自己的代码写成盒饭。我们需要菜是菜，汤是汤，饭是饭的午餐。** 用一个良好的代码整理方案，完全可以解决掉你说的这些问题。

也就是说，规矩，是TM最重要的。

好，我们将代码存放在 `/public/image/` 文件夹中，我们如何在 `jsx` 中使用图片呢？

## jsx 中使用图片

### 创建 @/page/other/imgshow.jsx 文件

我们创建一个 `@/page/other/imgshow.jsx` 这个文件，并写入以下内容：

```js
import React, { Component } from 'react'
import Path from '@/tool/path'
export default class ImgShow extends Component {
  render () {
    return (
      <div>
        <p>下面是插入的图片</p>
        <img src={Path('react.jpg')} alt='react' />
        <p>下面是在 scss 中使用的背景图片</p>
        <div className='use_bg_img'></div>
      </div>
    )
  }
}
```

如上，我们写入代码，然后，我们需要在路由中引用该文件。这里我不给全部代码了哈。

```js
// 引入代码
import OtherImgShow from '@/page/other/imgshow'
// 路由配置代码
<Route exact path='/imgshow' component={OtherImgShow} />
```

### 创建 @/tool/path.js 文件

我们在上面引入了一个 `@/tool/path` 文件，这里我有必要说明以下这个文件的作用。

我们在项目开发的时候，我们使用的一般都是根目录的开发模式。也就是说，我们是在 `http://localhost:3002/` 这个根域下执行的。但事实是，我们的项目在到生产环境的时候，往往是在二级目录下面，甚至是更深层级的目录下面。因此，当我们使用 `/image/react.jpg` 这种相对根目录调用图片的方式，到生产环境下，不能正确的读取到我们需要的图片。因为真实的路径可能是 `/love/image/react.jpg`。

为了使我们的代码兼容这两种请求方式，我们就需要一个函数方法来处理这两种的差异，因此，这个文件的主要作用就是，辨识我们的代码是在生产环境还是开发环境，然后返回不同的图片引用前缀。

除此之外，还有一个用处是更加重要的。

那就是，我们开发的项目中的静态资源，很有可能使用 `cdn` 加速，到时候这些图片的调用方式就变成了 `http://www.cdn.com/love/img/react.jpg` 这种格式了。而在开发环境下，我们是不会这么调用的。

所以，我们如果在 `jsx` 文件中使用图片地址，我们用一个函数来返回图片路径，就可以让我们更方便的替换这些路径地址。

好，上内容:

```js
const NODE_ENV = process.env.NODE_ENV
export default (src) => {
  let prod_fix = ''
  let img_fix = '/image/'
  return NODE_ENV === 'production' ? prod_fix + img_fix + src : img_fix + src
}
```

如上，当我们确定生产的图片调用前缀是什么的时候，只需要修改 `let prod_fix = ''` 这个变量即可。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/83/0bb9ef49607973ee04b8f8b7a57cb0.jpg)

好，我们现在已经可以在浏览器中访问到我们的想要的效果了。

## scss 中使用图片

我们在 `@/style/style.scss` 文件中，我们是怎么写的呢？

```css
//$res: "/erjimulu/image/"; // 打包时用此路径
$res: "/image/"; // 本地开发是用此路径
```

我们修改一下这个文件

```css
//$res: "/erjimulu/image/"; // 打包时用此路径
$res: "/image/"; // 本地开发是用此路径
.use_bg_img {
  width: 500px;height: 500px;
  background: url($res + 'react.jpg') 0 0;
}
```

效果如下：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/b9/c5fb0b4b73a6aae717528cd6190e5d.jpg)

这里，我们用变量加图片名的方式，引用图片。在开发环境中，我们用一个变量，在进行打包编译的时候，我们修改一下这个变量，修改为我们的生产地址。然后就可以了。

我暂时没有想到如何在 `scss` 中自动处理这部分的方法。只能每次打包的时候，手工修改一下了。

不过和批量修改所有的图片地址相比，修改一个变量，还是要简单很多的。

> 我不太清楚将图片存放在 `src` 目录中的各种注意事项。因为我一看到这样做就恶心，所以就没有去尝试了。

好，这一片博文我们学习了如何引入静态资源目录中的图片，其实引入其他内容也是如此。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


