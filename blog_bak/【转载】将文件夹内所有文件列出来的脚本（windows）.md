title: 【转载】将文件夹内所有文件列出来的脚本（windows）
date: 2015-11-15 10:28:36 +0800
update: 2015-11-15 10:28:36 +0800
author: fungleo
tags:
    -windows
    -脚本
    -列出所有文件
---

#将文件夹内所有文件列出来的脚本

我们在工作中，有时候需要将文件夹内所有的文件全部列出来。如果这个工作手工去做，文件少还好，文件多的话，就得累死个人了。所以，这样一个脚本，可以大大方便我们的工作。

##脚本内容

```
@echo off 
set startDir = %CD% 
if(%1)==('help') GOTO USAGE 
IF (%1)==() ( 
set work_dir=%cd% 
) ELSE ( 
set work_dir=%1 
) 
cd /d %1 
SET counter=0 
REM * 
dir /B /A:-D %1 > filelist.txt 
REM * 
FOR /F %%i IN (dirs.txt) DO ( 
set /A Counter += 1 
) 
echo %Counter% 
```

##使用方法

在要列出来文件的文件夹内新建一个txt文本文件，然后将上面的代码复制进去。保存后，重命名为"整理文件.bat"。然后双击执行。就可以在文件夹内生成一个**filelist.txt**的文件了。这个文件里就列出来所有的文件名。

##注意

1、是将文本文件的 .txt 后缀改成 .bat 而不是直接修改文件名。不明白，请看：http://jingyan.baidu.com/article/3d69c551a631dbf0ce02d75b.html

2、生成的 filelist.txt 文件中会包含 filelist.txt 和 整理文件.bat 两个文件名。（因为这两个文件也在文件夹中。）

转载于：http://www.jb51.net/article/24161.htm