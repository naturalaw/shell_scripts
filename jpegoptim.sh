#!/bin/bash
# by Daniel Chow @speedup2010
# v2 2012年06月 2日 星期六  2:44:05
# v3 2012年06月 2日 21:41:57
# chah 测绘案号
# 一次处理 1000个大图

bak_path=/cygdrive/b
disk_x=/cygdrive/a
#[ ! -f count.txt ] && echo '0' >$bak_path/count.txt 
#count=`cat $bak_path/count.txt`

help(){
	echo -e "随便输入个数吧"
	exit 0
}
if [ $# -eq 1 ];then {
	[ $PWD == $disk_x ] || cd $disk_x
	value=0
	for chah in ?????????;do { 
#while [ $count -le $1 ];do {
			[ -d $chah ] && cd $chah;
# 应该是有大图才创立目录
			[ ! -d $bak_path/$chah ] && mkdir -v $bak_path/$chah;  	
			for large_img in `find -iname "*.jpg" -size +6M -type f`;do {
				bak_img=$chah/${large_img##*/} 
				[ -f $bak_path/$bak_img ] || ( cp $large_img $bak_path/$chah -v && jpegoptim --max=60 $large_img >>$bak_path/jpegoptim.log && echo -e "$large_img\t$chah" >>$bak_path/optimed_chah.log && value=1 );
			}
			done; 
#	}
		cd ..;
#		[ $value -eq 1 ] && count=`expr $count + 1`
#		echo $count>$bak_path/count.txt
#		done
	}
	done
		for dir in $bak_path/?????????;do {
			ls $dir/*.jpg 2>/dev/null || rm $dir -rfv						  
		}
done

}
else
	help
fi
