#/bin/bash
# by Daniel Chow
unset small
unset big
ext=.jpg
begin=$1
end=$2
# 把所有大写转成小写
rename .JPG .jpg *.JPG
#for small in `seq $begin $end`;do 
#	#echo $small;
#	if [ -f $small.JPG ];then 
#	mv $small.JPG $small.jpg 
#	fi
#done
# md5sum will be in next ver
if [ $# == 2 -a $1 -lt $2 -a -f $1.jpg -a -f $2.jpg ];then {
	sum=`expr $end + $begin`
	pages=`expr $end - $begin + 1`
	mid=`expr $sum / 2`
	echo -e "第 $begin 页到第 $end 页反转命名,共 $pages 页\n"

	for small in `seq $begin $end`;do 
		big=`expr $sum - $small`
		#echo $big
		if [ $small -le $mid -a $small -ne $big ];then {
			mv $big$ext var$ext 
			echo $small' -->' $big 
			mv $small$ext $big$ext 
			echo $big' -->' $small
			mv var$ext $small$ext
		}
		else { 
			if [ $small == $big ];then
			echo -e "$small is in the middle, no need to rename"
			fi
		}
		fi
	done
#	md5sum *.jpg >big.txt
#	sed -i "s/ .*//g" small.txt big.txt
#	tac big.txt>mid.txt
#	cat mid.txt >big.txt
#	rm mid.txt old.txt new.txt -f 
#	diff small.txt big.txt && echo "重命名成功"
}
else 
	echo -e "使用方法:\n
	rename.sh 开始页码 结束页码\n
	如 rename.sh 1 20 表示反转命名1到20页的文件\n
	注意：开始页码要小于结束页码"
fi
