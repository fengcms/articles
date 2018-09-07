#!/bin/bash
files=$(ls)

all=0
for i in $files; do
  if [ $i != 'wc.sh' ]; then
    title=$(head -n1 $i)
    t=$(wc -m $i | sed 's/^[ \t]*//g' | cut -d ' ' -f1)
    all=$(($all+$t))
    echo $title'    统计字数: '$t
  fi
done

echo '共计字数: '$all
