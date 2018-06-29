title: 让ATOM编辑器的EMMET插件支持VUE文件的方法
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -atom
    -emmet
    -vue
---

最近一直使用ATOM编辑器。因为这是免费的，并且和GIT配合非常好用。关键的是可以从sublime无缝的转换到这个编辑器来使用。

有一个问题就是，我们在编辑.vue这样的文件的时候，emmet语法得不到支持。这让我很憋屈。终于找到了解决方法。在这里分享给大家。

我的环境是MAC，但应该在windows和linux下是一样的才对。

进入终端编辑配置文件
```
vim ~/.atom/keymap.cson
```
这个文件默认有大段的注释。不用管，我们把光标放到最后一行，按 `o` 在最后一行后面再插入一行，将下面的代码粘贴进去

```
'atom-text-editor[data-grammar~="vue"]:not([mini])':
    'tab': 'emmet:expand-abbreviation-with-tab'
```

然后按 `esc`退出编辑模式，再输入`:wq`保存退出，然后重启atom。然后你就会发现，在`.vue`的文件下面，支持`emmet`语法啦

原资料出处：https://github.com/emmetio/emmet-atom/issues/364