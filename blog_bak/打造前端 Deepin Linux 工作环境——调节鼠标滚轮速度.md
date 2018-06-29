title: 打造前端 Deepin Linux 工作环境——调节鼠标滚轮速度
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -deepin
    -鼠标滚轮速度
    -imwheel
    -linux
    -鼠标
---

#打造前端 Deepin Linux 工作环境——调节鼠标滚轮速度

在 `deepin` 的系统设置里面，没有找到鼠标滚轮速度调节的选项。但是默认情况下，其滚轮的速度又特别的慢。经过一番搜索，终于解决了这个问题。

## 安装 imwheel

首先执行

```#
sudo apt-get install imwheel -y
```
安装 imwheel 软件。

## 创建调整脚本

```#
# 创建自定义脚本目录
mkdir ~/.bin/
# 创建并编辑我们的脚本文件
vim ~/.bin/setwheel
```

然后在文件中粘贴进去以下代码：

```#
#!/bin/bash
# Version 0.1 Tuesday, 07 May 2013
# Comments and complaints http://www.nicknorton.net
# GUI for mouse wheel speed using imwheel in Gnome
# imwheel needs to be installed for this script to work
# sudo apt-get install imwheel
# Pretty much hard wired to only use a mouse with
# left, right and wheel in the middle.
# If you have a mouse with complications or special needs,
# use the command xev to find what your wheel does.
#
### see if imwheel config exists, if not create it ###
if [ ! -f ~/.imwheelrc ]
then

cat >~/.imwheelrc<<EOF
".*"
None,      Up,   Button4, 1
None,      Down, Button5, 1
Control_L, Up,   Control_L|Button4
Control_L, Down, Control_L|Button5
Shift_L,   Up,   Shift_L|Button4
Shift_L,   Down, Shift_L|Button5
EOF

fi
##########################################################

CURRENT_VALUE=$(awk -F 'Button4,' '{print $2}' ~/.imwheelrc)

NEW_VALUE=$(zenity --scale --window-icon=info --ok-label=Apply --title="Wheelies" --text "Mouse wheel speed:" --min-value=1 --max-value=100 --value="$CURRENT_VALUE" --step 1)

if [ "$NEW_VALUE" == "" ];
then exit 0
fi

sed -i "s/\($TARGET_KEY *Button4, *\).*/\1$NEW_VALUE/" ~/.imwheelrc # find the string Button4, and write new value.
sed -i "s/\($TARGET_KEY *Button5, *\).*/\1$NEW_VALUE/" ~/.imwheelrc # find the string Button5, and write new value.

cat ~/.imwheelrc
imwheel -kill

# END OF SCRIPT FILE
```

粘贴进去以上代码之后，再运行下面的命令：

```#
# 给运行权限
chmod +x ~/.bin/setwheel
# 将 ~/.bin/ 目录加入系统程序执行目录并立即生效
echo 'export PATH="$PATH:~/.bin"' >> ~/.bash_profile && . ~/.bash_profile
# 运行脚本
setwheel
```
然后就会打开如下图的设置面板

![](https://raw.githubusercontent.com/fengcms/articles/master/image/c2/7fc721102bdb69eb72470275bf2288.png)
我设置到3，你可以根据自己的情况进行设置。

参考资料：http://www.nicknorton.net/

本文由FungLeo原创，允许转载，但转载必须附注首发链接。谢谢。