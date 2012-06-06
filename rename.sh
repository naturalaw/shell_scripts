#/bin/bash
# by Daniel Chow
begin=$1
end=$2
prefix=$3
if [ $# == 3 -a $1 -lt $2 -a -f $1.jpg -a -f $2.jpg ];then {
	total_pages=`expr $end - $begin + 1`
	echo -e "从第 $begin 到第 $end 重命名,共 $total_pages 个\n"

	for page in `seq $begin $end`;do 
			mv $page.jpg $prefix$page.jpg -v
	done
}
else 
	echo -e "使用方法:\n
	./re 开始页码 结束页码 前缀\n
	如 ./re 1 20 aa 表示从1到20页的文件名添加前缀aa\n
	注意：开始页码要小于结束页码"
fi
