#/bin/bash
unset old
unset new
ext=.jpg
# 当全部图片要改名时才能使用这样的MD5计算
md5sum *.jpg >old.txt
if [ $# == 2 -a $1 -lt $2 ];then {
	begin=$1
	end=$2
	sum=`expr $end + $begin`
	pages=`expr $end - $begin + 1`
	mid=`expr $sum / 2`
	echo -e "第 $begin 页到第 $end 页反转命名,共 $pages 页\n"

	for old in `seq $begin $end`;do 
		#echo $old;
		new=`expr $sum - $old`
		#echo $new
		if [ $old -le $mid -a $old -ne $new ];then
			echo $old' -->' $new 
			mv $new$ext var$ext -v
			mv $old$ext $new$ext -v
			mv var$ext $old$ext -v
		else
			echo -e "$old = $new 文件无需重命名" 
		fi
	done
	md5sum *.jpg >new.txt
	cat old.txt
	echo -e "\n"
	cat new.txt
	sed -i "s/ .*//g" old.txt new.txt
	tac new.txt>mid.txt
	cat mid.txt >new.txt
	rm mid.txt -f
	diff old.txt new.txt && echo "重命名成功"
}
else 
echo -e "使用方法:\n
rename.sh 开始页码 结束页码\n
如 rename.sh 1 20 表示反转命名1到20页的文件\n
注意：开始页码要小于结束页码"
fi