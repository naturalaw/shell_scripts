#!/bin/bash
# by Daniel Chow @speedup2010
# 批量命名文件
# v9 2012年05月24日 星期四 19:53:03
# 下一版本加入转化utf8,省去第二步
help(){
	script_name=$0
	script_name=`echo ${script_name##*/}`
	script_name=`echo ${script_name%%.sh}`
	# 这里的sql只是一个文件名的作用
	echo -e "\t用法: $script_name sql\n
	运行之前，先进行两步操作\n
	1、把数据库相应的表导出为excel，另存为以制表符为分隔的txt文档\n
	2、打开刚刚所保存的txt文档，另存为UTF-8的格式，sql为文件名，保存目录为pic\n"
}

if [ $# = 1 -a -f $1.txt ];then {
	_dir=~/pic
	sql=$1
	TMP=tmp.txt
	[ $PWD == $_dir ] || cd $_dir
	[ -f $TMP.txt ] && rm $TMP.txt
	grep -o '[0-9]\{8\}\.jpg.*是' $sql.txt | awk '$2!=0{print $2"\t"$1};$2==0{print $3"\t"$1}' | sort -g >>$TMP.txt
	count=0
	for var in *.jpg;do 
		page=${var%%.jpg}; 
		fn=`sed -n "/^$page\t/p" $TMP.txt | awk '{print $2}'`;
		mv $page.jpg $fn && count=`expr $count + 1`
		rm $TMP.txt $sql.txt
	done
echo "rename $count files ok"
}
elif [ ! -f $1.txt ];then
	echo -e "\nerror: $1.txt does no exist\n
	please do step 1 & step 2, and then run speed later. \n"
		help
else 
	help
fi
