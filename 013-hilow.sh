#!/bin/sh
# hilow - a simple number guessing game

biggest=100                             # maximum number possible
guess=0                                 # guessed by player
guesses=0                               # number of guesses made
number=$(( $$ % $biggest ))             # random number, 1 .. $biggest

while [ $guess -ne $number ] ; do
  echo -n "Guess? " ; read guess
  if [ "$guess" -lt $number ] ; then
    echo "... bigger!"
  elif [ "$guess" -gt $number ] ; then
    echo "... smaller!"
  fi
  guesses=$(( $guesses + 1 ))
done

echo "Right!! Guessed $number in $guesses guesses."

exit 0

#$(( xx )) 整数计算
#-ne not euqal
#echo -n 输出，不换行
#echo -e 输出，并换行
#"$guess" ， 和 $guess的主要区别是，前者能把内容完整输出， 后者可能不会输出内容中的空格等特殊字符
#-gt greater
#-lt less

#while [ ] ; do
#done

#if [ ] ; then
#fi

#if [ ] ; then
#elif [ ] ; then
#fi

#$$ 当前进程ID
