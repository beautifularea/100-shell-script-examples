#!/bin/sh

# getstock - given a stock ticker symbol, return its current value
#    from the Lycos web site

url="http://finance.lycos.com/qc/stocks/quotes.aspx?symbols="

if [ $# -ne 1 ] ; then #not equal
  echo "Usage: $(basename $0) stocksymbol" >&2 
  exit 1
fi

#lynx www.baidu.com 文本浏览器，不支持多媒体
value="$(lynx -dump "$url$1" | grep 'Last price:' | \ #lynx 
  awk -F: 'NF > 1 && $(NF) != "N/A" { print $(NF) }')" #awk -F 

#awk -F 设置分隔符。

if [ -z $value ] ; then #-z 长度为0 ， 则为真
  echo "error: no value found for ticker symbol $1." >&2
  exit 1
fi

echo $value

exit 0
