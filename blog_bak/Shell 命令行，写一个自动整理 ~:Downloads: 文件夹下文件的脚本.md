title: Shell 命令行，写一个自动整理 ~:Downloads: 文件夹下文件的脚本
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -shell
    -脚本
    -自动整理文件
---

# Shell 命令行，写一个自动整理 ~/Downloads/ 文件夹下文件的脚本

在 `mac` 或者 `linux` 系统中，我们的浏览器或者其他下载软件下载的文件全部都下载再 `~/Downloads/` 文件夹下面。日积月累，我们的文件会越来越多。手工整理这些文件是比较繁琐的工作，于是，我就思考，我能不能用 `shell` 来自动整理这些下载的文件。

说干就干。

为了避免破坏我本地的文件，我自己搞了一个虚拟机跑了一个 `centos` 然后写下了如下的脚本。

## 第一版代码（处理文件名带空格的文件会出错）

```#
#!/bin/bash
# Name cleardown
# Description move you files in ~/Downloads to ~/Documents/OfficeFiles
# Author FungLeo
# WebSite http://blog.csdn.net/fungleo

# find .  -maxdepth 1 -type f
# Excel  Other  PDF  Photo  PPT  Word  Xmind  Zip

# 设定要整理的文件夹为下载目录
downFinder=~/Downloads/
# 看看下载目录根目录下有哪些文件
dfiles=$(ls -l $downFinder | grep ^- | sed 's/[ ][ ]*/,/g' | awk -F "," '{print $NF}')
# 准备将这些文件处理到哪里去
filesFinder=~/Documents/OfficeFiles/

# 分辨文件类型，并给出放到哪里去的建议。这里大家可以根据自己的需求完善 case 语句
function fileType() {
  case $1 in
    'jpg' | 'png' | 'gif' | 'jpeg' | 'bmp')
      echo 'Photo'
    ;;
    'doc' | 'docx')
      echo 'Word'
    ;;
    'xls' | 'xlsx')
      echo 'Excel'
    ;;
    'ppt' | 'pptx')
      echo 'PPT'
    ;;
    'zip' | '7z' | 'rar')
      echo 'Zip'
    ;;
    'xmind')
      echo 'Xmind'
    ;;
    'pdf')
      echo 'PDF'
    ;;
    *)
      echo 'Other'
    ;;
  esac
}

# 判断目标文件夹中是否包含这个文件
function hasfile() {
  if [ -f $1 ]; then
    echo 'has'
  else
    echo 'nohas'
  fi
}

# 给文件重新命个名字，我这里是在后面加了一个 1
function changeFileName() {
  local filename=$(basename $1)
  echo ${filename%.*}1.${filename##*.}
}

# 开始搬文件的函数
function mvFile() {
  # 这个函数需要传两个参数，一个是原文件名，一个是新文件名。
  local name=$1
  local newname=$2
  # 获取文件的后缀名，并且转化为小写
  local type=$(echo $1 | awk -F "." '{print $NF}' | tr "[:upper:]" "[:lower:]" )
  local classify=$(fileType $type)
  local file=$filesFinder$classify'/'$newname
  # 判断新文件名在目标地址是否有同名文件
  local hasf=$(echo $(hasfile $file))
  if [ $hasf = 'has' ]; then
    mvFile $name $(changeFileName $newname)
  else
    mv $downFinder$name $file
  fi
}

# 循环这些文件，并且进行处理
for i in $dfiles; do
  mvFile $i $i
done
```

## 小结

其中还是使用到了很多的知识点的。

1. `case` 语句。一开始用 `if` 判断，越写越丑。查了下 `case` 语句，果然清爽很多了。
2. 获取文件后缀名。本例中用了两种方法。
	1. `awk` 方法。`awk -F "." '{print $NF}'` 用`.` 分割取最后一个。
	2. `${filename##*.}` 取后缀名。`${filename%.*}` 取文件名
3. 函数的写法。其实不写 `function` 也是可以的。
4. 函数自己调自己，和 `js` 也没太大区别嘛。
5. 字符串大小写转换 `tr "[:upper:]" "[:lower:]"`


## 2017年08月08日补充，解决文件名中包含空格的问题

```#
#!/bin/bash
# Name cleardown
# Description move you files in ~/Downloads to ~/Documents/Office Files
# Author FungLeo
# WebSite http://blog.csdn.net/fungleo

# find .  -maxdepth 1 -type f
# Excel  Other  PDF  Photo  PPT  Word  Xmind  Zip

# 设定要整理的文件夹为下载目录
downFinder="${HOME}/Downloads/"
# 准备将这些文件处理到哪里去
filesFinder="${HOME}/Documents/Office Files/"

# 分辨文件类型，并给出放到哪里去的建议。这里大家可以根据自己的需求完善 case 语句
function fileType() {
  case $1 in
    'jpg' | 'png' | 'gif' | 'jpeg' | 'bmp')
      echo 'Photo'
    ;;
    'doc' | 'docx')
      echo 'Word'
    ;;
    'xls' | 'xlsx')
      echo 'Excel'
    ;;
    'ppt' | 'pptx')
      echo 'PPT'
    ;;
    'zip' | '7z' | 'rar')
      echo 'Zip'
    ;;
    'xmind')
      echo 'Xmind'
    ;;
    'pdf')
      echo 'PDF'
    ;;
    *)
      echo 'Other'
    ;;
  esac
}

# 判断目标文件夹中是否包含这个文件
function hasfile() {
  if [ -f $1 ]; then
    echo 'has'
  else
    echo 'nohas'
  fi
}

# 给文件重新命个名字，我这里是在后面加了一个 1
function changeFileName() {
  local filename=$(basename $1)
  echo ${filename%.*}1.${filename##*.}
}

# 开始搬文件的函数
function mvFile() {
  # 这个函数需要传两个参数，一个是原文件名，一个是新文件名。
  local name=$1
  local newname=$2
  # 获取文件的后缀名，并且转化为小写
  local type=$(echo $1 | awk -F "." '{print $NF}' | tr "[:upper:]" "[:lower:]" )
  local classify=$(fileType $type)
  local file="$filesFinder$classify/$newname"
  # 判断新文件名在目标地址是否有同名文件
  local hasf=$(echo $(hasfile $file))
  if [ $hasf = 'has' ]; then
    mvFile $name $(changeFileName $newname)
  else
    mv "$downFinder$name" "$file"
  fi
}

# 设置分隔符为换行
OLD_IFS=$IFS
IFS=$'\n'
# 循环这些文件，并且进行处理
for i in $(find "$downFinder" -maxdepth 1 -type f -not -name ".*" | awk -F "/" '{print $NF}'); do
  mvFile $i $i
done

# 将分隔符设置为默认，以免影响后面的程序
IFS=$OLD_IFS
```

## 补充小结

1.  我先前没有考虑文件夹或者文件包含空格的情况，导致很多问题。
	1. 当把路径用引号 `"` 引起来的时候，不会解析 `~` 所以要用 `${HOME}` 代替
	2. 在引用变量的时候，变量也要用引号引起来。注意，不能是单引号。
2. 默认分隔符为**空白**，包含：空格、制表符、回车符，用 `IFS` 表示。
3. `echo` 最终命令，和实际执行的结果不一定是一致的。
4. `find . -not -name ".*"` 表示不找隐藏文件


以上脚本均在 centos 和 MAC 下测试通过，在其他 linux 下可能会有稍许不同。
本文由 FungLeo 原创，允许转载，但转载必须保留首发链接。



