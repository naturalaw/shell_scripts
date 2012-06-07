#!/bin/bash
# by Daniel Chow @speedup2010
# v2 2012年06月 2日 星期六  2:44:05
# v3 2012年06月 2日 21:41:57
# v5 2012年06月 3日 星期日 14:08:05
# chah 测绘案号
# 一次处理 n个大图

#bak_path=/cygdrive/b
#disk_x=/cygdrive/a
bak_path=/cygdrive/d/kingston/disk_b
disk_x=/cygdrive/d/kingston/disk_a
rate=60
size=500k
help(){
	echo -e "\033[31m\n\t大哥/大姐，不带这样玩的!!!\033[0m\n\t随便输入个正数吧"
	exit 0
}
if [ $# -eq 1 -a $1 -gt 0 ];then {
	echo -e "\n\t本次最多处理\033[31m$1个\033[0m文件"
	echo -ne "\033[31m
  \t欲终止，在显示\033[34mExif\033[31m时，按CTRL+C，\n
  \t并把最后处理的一个文件从备份目录剪切到源目录\n\n"
	echo -ne "\033[32m\t处理体积大于\033[31m$size\033[32m的图片，比率设定为\033[31m$rate\033[32m(范围是1~100)\n
  \t源目录:$disk_x\n
  \t备份目录:$bak_path\n
  \t源目录文件\t->\t备份文件\n\n"
  	echo -ne "\033[0m"
	[ $PWD == $disk_x ] || cd $disk_x
	count=1
	for large_img in `find 1???????? -iname "*.jpg" -size +$size -type f`;do {
		while [ ! -f $bak_path/$large_img ];do {
			chah=${large_img%%/*} 
		 	[ ! -d $bak_path/$chah ] && mkdir -v $bak_path/$chah 
			cp $large_img $bak_path/$chah -v && jpegoptim --max=$rate $large_img && count=`expr $count + 1 `
			[ $count -gt $1 ]  && break 2
			}
		done
	}
			done; 
	total_m=`expr $count - 1` 
	echo -e "\n\t\033[32m处理了\033[31m$total_m个\033[32m文件\n"
	}
else
	help
fi
