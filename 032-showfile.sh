#!/bin/sh
# showfile - show the contents of a file, including additional useful info

width=80

for input
do
  lines="$(wc -l < $input | sed 's/ //g')"
  chars="$(wc -c < $input | sed 's/ //g')"
  owner="$(ls -ld $input | awk '{print $3}')"
  
  echo "-----------------------------------------------------------------"
  echo "File $input ($lines lines, $chars characters, owned by $owner):"
  echo "-----------------------------------------------------------------"
  
  while read line 
    do
      if [ ${#line} -gt $width ] ; then # ${#line} ---> line's length
        echo "$line" | fmt | sed -e '1s/^/  /' -e '2,$s/^/+ /'
      else
        echo "  $line"
      fi
    done < $input

  echo "-----------------------------------------------------------------"

done | more

exit 0

#sed -e '/^$/d' 删除空行 ^代表行首， $代表行末
#sed -e '/^#/d' 删除#开头的行
#fmt 文本格式化命令
#${#line} line 的长度
#wc -l 行数统计
#wc -c 字符统计
