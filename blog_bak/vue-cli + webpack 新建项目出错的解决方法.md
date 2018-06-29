title: vue-cli + webpack 新建项目出错的解决方法
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -vue-cli
    -webpack
    -vue init webpack
    -webpack-dev-server
    -vue 错误解决
---

# vue-cli + webpack 新建项目出错的解决方法

今日使用 `npm init webpack love` 创建一个新项目，然后执行 `npm run dev` 之后项目报错，提示错误如下：

```#
没有给这些选项指定值：config-name, context, entry, module-bind, module-bind-post, module-bind-pre, output-path, output-filename, output-chunk-filename, output-source-map-filename, output-public-path, output-jsonp-function, output-library, output-library-target, records-input-path, records-output-path, records-path, define, target, watch-aggregate-timeout, devtool, resolve-alias, resolve-extensions, resolve-loader-alias, optimize-max-chunks, optimize-min-chunk-size, prefetch, provide, plugin, open-page
npm ERR! code ELIFECYCLE
npm ERR! errno 1
npm ERR! love@1.0.0 dev: `webpack-dev-server --inline --progress --config build/webpack.dev.conf.js`
npm ERR! Exit status 1
npm ERR! 
npm ERR! Failed at the love@1.0.0 dev script.
npm ERR! This is probably not a problem with npm. There is likely additional logging output above.

npm ERR! A complete log of this run can be found in:
```

经过排查，发现是 `webpack` 的新版本的BUG，解决方法就是卸载新版本，安装老版本。

命令如下：

```#
npm remove webpack-dev-server
npm install webpack-dev-server@2.9.1
npm run dev
```

然后项目就正常了。目前确定是 `webpack-dev-server@2.10.0` 的 BUG。在其发布新版本解决问题之前，先安装老版本解决问题吧。

如果不能解决问题，请在评论中留言。

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。

