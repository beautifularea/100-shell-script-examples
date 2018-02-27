#!/bin/sh

# spelldict - use the 'aspell' feature and some filtering to allow easy
#    command-line spell checking of a given input (file)

okaywords="$HOME/.okaywords" #$HOME home directory
tempout="/tmp/spell.tmp.$$" #$$ 进程ID
spell="virtual aspell"                  # tweak as needed aspell is a tool for check.

#当shell接收到signals指定的信号时，执行commands命令。
#trap "command" EXIT
trap "/bin/rm -f $tempout" EXIT
 
if [ -z "$1" ] ; then # -z $1 长度为0 则为真。
  echo "Usage: spell file|URL" >&2; exit 1
elif [ ! -f $okaywords ] ; then #-f 是普通文件则为真。
  echo "No personal dictionary found. Create one and rerun this command" >&2
  echo "Your dictionary file: $okaywords" >&2
  exit 1
fi #endif

for filename
do
  $spell -a < $filename | \
  grep -v '@(#)' | sed "s/\'//g" | \ #grep -v ->反向选择。 sed "s/\'//g" 替换掉'
     awk '{ if (length($0) > 15 && length($2) > 2) print $2 }' | \ 
   grep -vif $okaywords | \ #grep -i 忽略大小写 -f 过滤。
   grep '[[:lower:]]' | grep -v '[[:digit:]]' | sort -u | \
   sed 's/^/   /' > $tempout #行首加空格
 
   if [ -s $tempout ] ; then #-s 大小不为0 ，则为真
     sed "s/^/${filename}: /" $tempout  #行首格式为 ： filename: 
   fi
done

exit 0
