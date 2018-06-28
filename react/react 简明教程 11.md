# React + webpack 开发单页面应用简明中文文档教程（十一）将项目打包到子目录运行

好，前面我们经过一系列的开发，已经掌握了一些内容了。这篇博文，我们要学习，如何将项目打包。

## 将项目打包到根目录运行

如果我们需要将项目打包到根目录运行，这个就非常非常简单了。我们只需要运行

```shell
npm run build
```

命令，然后，等待编译，过会儿就编译好，并将我们的文件寸在了 `build` 目录，我们将编译出来的文件交给运维去部署就可以了。

![](https://raw.githubusercontent.com/fengcms/articles/master/image/5a/2556a200a219753caf071e376bc726.jpg)


上图是编译过程，我们编译的文件如下：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/44/0f9f75ae28e51745da47462745545d.jpg)

很清楚，图片是图片，样式是样式，脚本是脚本。很合适。

问题是，我们如果要部署到子目录，怎么办？

## 将项目打包到子目录

将项目打包到子目录，我们需要经过若干配置。我这边以我们要打包到 `/love/` 这个目录下面为例，举例说明，我们需要怎么处理。 

### 在 package.json 中配置子目录

首先，我们打开 `package.json` 文件，在其中添加：

```json
"homepage": "/love/",
```

![](https://raw.githubusercontent.com/fengcms/articles/master/image/bb/d06edf602a1300cda73d2cd25bf75d.jpg)

`react` 的脚手架和 `vue` 的脚手架有所不同，就是，很多的设置，都是在 `package.json` 中进行配置的。没有什么优劣，习惯了就好。

### 配置路由文件

除了在上面的文件中配置，我们还需要调整路由，我们需要将 `Router` 中的 `basename` 参数修改 `/love/` 这样才可以。

如下图所示：

![](https://raw.githubusercontent.com/fengcms/articles/master/image/84/2c04cdec6bcde8a3584857bdccba17.jpg)

好，这样，我们就配置完成了。

### 修改 @/tool/path.js 文件

上一章中，我们学习了如何在 `react` 中引入图片，并且，我们使用了 `@/tool/path.js` 这个程序来处理生产环境和开发环境的图片不同前缀，这里，我们就需要来进行处理了。

```js
const NODE_ENV = process.env.NODE_ENV
export default (src) => {
  let prod_fix = '/love'
  let img_fix = '/image/'
  return NODE_ENV === 'production' ? prod_fix + img_fix + src : img_fix + src
}
```
如上，修改 `prod_fix` 的前缀为 `/love` ，然后就可以了。

### 修改 @/style/style.scss 文件

上一章中，我们也说了相关的内容，这里我们再来演示一下：

```scss
$res: "/love/image/"; // 打包时用此路径
// $res: "/image/"; // 本地开发是用此路径
```

调整为这样，即可。上面的三个，我们只需要处理一次，唯独这个 sass 文件，我们需要每次打包的时候都修改一下，开发的时候再修改回来。这样。

### 打包

经过上面的配置之后，我们就可以运行我们的打包命令了。`npm run build`，打包完成之后，将 `build` 中的文件，交给我们的运维部署。

## Nginx 配置补充说明

这部分是补充给运维同学看的，他也不一定能用到。但是如果访问出现了问题，可以让他看下下面的配置。希望对他有所帮助。具体内容我就不阐述了。

```shell
 location /marketing {
            index index.html;
            alias /srv/apps/huanqiu-marketing-h5-dist/build/;
            proxy_set_header X-Real-IP  $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $http_host;
            proxy_redirect off;
            if (!-e $request_filename) {
                      rewrite ^/(.*) /marketing/index.html last;
                      break;
                  }
      }      
```


## 其他补充

其实这个事情并不复杂，只是相关的资料都比较琐碎。希望大家跟着我敲了一遍代码之后，都已经入门了 `react` 开发了。祝大家愉快。

后面，我会随时补充一些其他的相关内容，大家有兴趣，希望可以关注这个系列的博文。

多多点赞呀！

本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。


