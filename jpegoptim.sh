#!/bin/bash
# by Daniel Chow @speedup2010
# v2 2012年06月 2日 星期六  2:44:05
# chah 测绘案号
# 一次处理 1000个大图

bak_path=/cygdrive/t
disk_x=/cygdrive/x
[ ! -f count.txt ] && echo '0' >$bak_path/count.txt 
count=`cat count.txt`
echo -e "上次处理到第$count个\n"

help(){
	echo -e "输入一个比 $count 大的数\n比 $count 大多少，就处理多少个案\n"
	exit 0
}
if [ $# -eq 1 ];then {
	[ $PWD == $disk_x ] || cd $disk_x
	for chah in ?????????;do { 
		value=0
		while [ $count -le $1 ];do {
			[ -d $chah ] && cd $chah;
			[ ! -d $bak_path/$chah ] && mkdir -v $bak_path/$chah;  	
			for large_img in `find -iname "*.jpg" -size +6M -type f`;do {
				bak_img=$chah/${large_img##*/} 
				[ -f $bak_path/$bak_img ] || ( cp $large_img $bak_path/$chah -v && jpegoptim --max=60 $large_img >>$bak_path/jpegoptim.log && echo $chah >>$bak_path/optimed_chah.log && value=1 );
			}
			done; 
		}
		cd ..;
		[ $value -eq 1 ] && count=`expr $count + 1`
		echo $count>$bak_path/count.txt
		done
	}
	done
}
else
	help
fi
