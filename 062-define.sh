#!/bin/sh

# define - given a word, return its definition from dictionary.com

url="http://www.cogsci.princeton.edu/cgi-bin/webwn2.0?stage=1&word="
url="https://www.merriam-webster.com/dictionary/xxx" #replace xxx to specific word.

if [ $# -ne 1 ] ; then
  echo "Usage: $0 word" >&2 
  exit 1
fi

lynx -source "$url$1" | \
  grep -E '(^[[:digit:]]+\.| has [[:digit:]]+$)' | \
  sed 's/<[^>]*>//g' |
( while read line 
  do 
    if [ "${line:0:3}" = "The" ] ; then
      part="$(echo $line | awk '{print $2}')"
      echo ""
      echo "The $part $1:"
    else
      echo "$line" | fmt | sed 's/^/  /g'
    fi
  done
)

exit 0

#lynx : a plain-text web browser.
#[[:digit:]] - 0~9
#[[:alpha:]] - 字符
#[[:alnum:]] - 字符数字
#----》 equal to : `[:digit:]'

#grep -E ; multi regex.
#${line:0:3} ---> 取最左边的3个字符
