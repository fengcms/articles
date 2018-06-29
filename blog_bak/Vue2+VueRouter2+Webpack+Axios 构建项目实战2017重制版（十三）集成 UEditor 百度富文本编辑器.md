title: Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（十三）集成 UEditor 百度富文本编辑器
date: 2017-09-06 15:57:21 +0800
update: 2017-09-06 15:57:21 +0800
author: fungleo
tags:
    -vue
    -ueditor
    -github
    -webpack
    -fungleo
---

# Vue2+VueRouter2+Webpack+Axios 构建项目实战2017重制版（十三）集成 UEditor 百度富文本编辑器

## 前情回顾

通过前面系统的学习，我相信大家都能够对 `vue` 项目有了一个基本的认知。现在是不是已经开始上手做自己的项目了呢？呵呵，当然这是极好的。但是我们一般用 `vue` 来制作管理后台，在制作管理后台的时候，不可避免的，我们需要用到富文本编辑器。

我尝试过 `github` 上的若干富文本编辑器，虽然能够实现一部分需求，但是还是不能充分满足我的需求。而百度推出的 `UEditor` 编辑器口碑不错，文档充分，还是很不错的选择（百度能有良心产品，不容易啊！）。但是 `UEditor` 没有 `npm` 安装，需要我们自己手工引入进来。这个到底怎么解决呢，我查找了一些资料，把这些给理顺了。今天出这个文章给遇到这个问题的朋友参考。

我还是在我先前的代码上加上这部分内容。源码参考：https://github.com/fengcms/vue-demo-cnodejs 

## 准备集成 UEditor 编辑器

### 下载 UEditor 编辑器 源码

首先，下载  `UEditor` 源码。我这边下载的是 **UEditor 1.4.3.3 PHP UTF-8版本** [下载地址](http://ueditor.baidu.com/build/build_down.php?n=ueditor&v=1_4_3_3-utf8-php)

下载之后，把资源放到 `/static/ue/` 目录下。文档结构如下：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/bb/3440d73512fce86249bc2c7bfa33e8.png)
### 编辑 UEditor 编辑器 配置文件

我们打开 `ueditor.config.js` 找到 `window.UEDITOR_HOME_UR` 将它设置为：

```js
window.UEDITOR_HOME_URL = "/static/ue/";
```

然后我们可以给一些默认的参数，比如编辑器的默认宽高等：

```json
,initialFrameWidth: null
,initialFrameHeight: 480
```
> 上面的编码风格也是满奇葩的，还好还好

其他的配置参数，请参考官方文档进行配置：http://fex.baidu.com/ueditor/

## 集成到 UEditor 编辑器到我们的系统中

### main.js 引用 UEditor

我们打开 `/src/main.js` 文件，在合适位置插入下面的代码：

```js
// 配置百度编辑器
import '../static/ue/ueditor.config.js'
import '../static/ue/ueditor.all.min.js'
import '../static/ue/lang/zh-cn/zh-cn.js'
import '../static/ue/ueditor.parse.min.js'
```

> 如果不知道合适位置是什么位置，可以参考我的 `github` 源码。我不能每次都解释，或者粘贴全部代码过来。

### 创建 UEditor VUE 组件

我们在 `/src/components/` 目录下创建 `ue.vue` 文件，作为我们的编辑器组件文件。

文件内容如下：

```html
<template>
  <div>
    <script id="editor" type="text/plain"></script>
  </div>
</template>
<script>
  export default {
    name: 'ue',
    data () {
      return {
        editor: null
      }
    },
    props: {
      value: '',
      config: {}
    },
    mounted () {
      const _this = this
      this.editor = window.UE.getEditor('editor', this.config)
      this.editor.addListener('ready', function () {
        _this.editor.setContent(_this.value)
      })
    },
    methods: {
      getUEContent () {
        return this.editor.getContent()
      }
    },
    destroyed () {
      this.editor.destroy()
    }
  }
</script>
```

好，这段代码不难，应该能够理解。如果不能够理解也没关系，只需要知道下面这段代码是接受我们的参数的就可以了。

```js
    props: {
      value: '',
      config: {}
    },
```

其中 `value` 是默认的编辑器的文字。一般我们留空即可，而 `config` 是编辑器的配置参数。这里就是上一节中讲的那些配置，这里可以接受个性配置参数。

好，这个文件扔这里不管了。

### 在其他页面引用该组件

我们创建一个页面，路由配置以及其他内容不表，不清楚看我 `github` 代码演示。

内容如下：

```html
<template>
  <div>
    <Uediter :value="ueditor.value" :config="ueditor.config" ref="ue"></Uediter>
    <input type="button" value="显示编辑器内容（从控制台查看）" @click="returnContent">
  </div>
</template>
<script>
  import Uediter from '@/components/ue.vue'
  export default {
    components: {Uediter},
    data () {
      return {
        dat: {
          content: ''
        },
        ueditor: {
          value: '编辑器默认文字',
          config: {}
        }
      }
    },
    methods: {
      returnContent () {
        this.dat.content = this.$refs.ue.getUEContent()
        console.log(this.dat.content)
      }
    }
  }
</script>
```

这里，我们将组件引用进来，并且可以配置一些参数。我不习惯把配置参数放在根下面，所以搞了一个：

```json
        ueditor: {
          value: '编辑器默认文字',
          config: {}
        }
```

亲测成功，我没有配置上传图片等接口对接，不过这是后端的工作。其他的，比如本地存储之类的，都是没有问题的。

**这里需要注意的是，编辑器的内容不能实时的保存进我们的 `dat.content` 里面，需要触发一下 `returnContent` 方法，才可以获取到这个数据，实际开发中，点击提交按钮时触发一下即可**

最终效果如下：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/80/637fa4d8bb59aeac1ef9f88c44632e.png)
参考了很多人的资料，在这里一一感谢：

1. [Vue.js结合Ueditor](http://blog.csdn.net/billll/article/details/53448183)
2. [vue2.0项目中使用Ueditor富文本编辑器示例](http://www.cnblogs.com/dmcl/p/7152711.html)

###2017年09月07日补充

`ueditor.value` 是可以接收 `html` 代码的。我们在编辑的时候，把拿到的数据，给灌到这里，就可以在编辑器正确的显示出来了。之前忘记说明这个事情了。

> 如果文章由于我学识浅薄，导致您发现有严重谬误的地方，请一定在评论中指出，我会在第一时间修正我的博文，以避免误人子弟。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。



