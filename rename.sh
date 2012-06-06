#/bin/bash
# by Daniel Chow
if [ $PWD != $HOME/pic ];then 
cd ~/pic
fi
begin=$1
end=$2
prefix=$3
minus=$4
ext=.jpg
if [ $# == 3 -o $# == 4 -a $1 -lt $2 -a -f $1$ext -a -f $2$ext ];then {
	total_pages=`expr $end - $begin + 1`
	echo -e "当前目录$PWD\n从 $begin 到 $end 重命名,共 $total_pages 个\n"
	for page in `seq $begin $end`;do 
		if [ $# == 3 ];then
			mv $page$ext $prefix$page$ext -v
		elif [ $# == 4 ];then 
			new=`expr $page - $minus`
			mv $page$ext $prefix$new$ext -v
		fi
	done
}
else 
	echo -e "使用方法:\n
	re 开始页 结束页 前缀 [页码-图件号的差]\n
	如 re 9 20 aa 表示从9到20页的文件名添加前缀aa\n
	如 re 9 20 aa 4 表示从9到20页的文件名减4并添加前缀aa,故9.jpg改为aa5.jpg\n
	注意：差<开始页<结束页,页码-图件号的差 是可选参数"
fi
