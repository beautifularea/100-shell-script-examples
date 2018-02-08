#!/bin/sh

# nfmt - A version of fmt, using nroff. Adds two useful flags: -w X for 
# line width and -h to enable hyphenation for better fills.

while getopts "hw:" opt; do
  case $opt in
    h ) hyph=1    	    ;;
    w ) width="$OPTARG"    ;;
  esac
done
shift $(($OPTIND - 1))

nroff << EOF
.ll ${width:-72}
.na
.hy ${hyph:-0}
.pl 1
$(cat "$@")
EOF

exit 0

#http://blog.csdn.net/henriezhang/article/details/8548206

#getopts 获取参数
#:a: 表示a后带有数据
#./ss -a xxx   
#使用$OPTARG 获取。
#OPTIND 表示下一个要处理的参数index, index 从1 开始

#case xx in
#h ) xxx
#    yyy
#    ;; 这是一个语句块

#位置参数可以用shift命令左移。
#比如shift 3表示原来的$4现在变成$1，原来的$5现在变成$2等等，原来的$1、$2、$3丢弃，$0不移动。不带参数的shift命令相当于shift 1。

#由于 $OPTIND 总是存储原始$*中下一个要处理的元素位置，程序运行到这句话的时候，指针后面的参数还都是没有处理过的，而指针前的参数已经全部处理过了。
#通过 shift $(($OPTIND - 1)) 的处理，$*中就只保留了除去选项内容的参数（未处理过的参数），可以在其后进行正常的shell编程处理了。

#$@ == $* 传递的所有参数






