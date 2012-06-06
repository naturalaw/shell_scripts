#!/bin/bash
# by Daniel Chow @speedup2010
# v1 modified 2012-5-16 20:39
# v2 modified 2012-5-16 20:57
# v3 modified 2012-5-17 17:49
# v4 modified 2012-5-17 18:00
# v5 modified 2012-5-19 16:03
# v6 modified 2012-5-19 17:51
# v7 modified 2012-5-20 12:34
# v8 modified 2012-5-21 19:51
if [ $PWD != $HOME/pic ];then 
cd ~/pic
fi
begin=$1
end=$2
prefix=$3
minus=$4
ext=.jpg
if [ $1 -lt $2 -a -f $1$ext -a -f $2$ext ];then {
	total_pages=`expr $end - $begin + 1`
	echo -e "当前目录$PWD\n重命名:从 $begin 到 $end ,共 $total_pages 个\n"
	for page in `seq $begin $end`;do 
		if [ $# == 3 ];then
			mv $page$ext $prefix$page$ext -v
		elif [ $# == 4 ];then 
			new=`expr $page - $minus`
			mv $page$ext $prefix$new$ext -v
		elif [ $# == 5 -a $5 == p ];then 
			plus=$minus
			new=`expr $page + $plus`
			mv $page$ext $prefix$new$ext -v
		fi
	done
}
else 
	echo -e "
	re使用方法:\n
	re 开始页 结束页 前缀 [页码与后图件号几位之差] [p]\n
	如 re 9 20 aa 表示从9到20页的文件名添加前缀aa\n
	如 re 9 20 aa 4 表示从9到20页的文件名减4并添加前缀aa,故9.jpg改为aa5.jpg\n
	注意：1.没有p参数时，差<开始页<结束页\n\t      2.页码与图件号几位的差/和 及 p 是可选参数\n\t "    
fi
