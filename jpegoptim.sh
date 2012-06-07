#!/bin/bash
# by Daniel Chow @speedup2010
# v2 2012年06月 2日 星期六  2:44:05
# v3 2012年06月 2日 21:41:57
# v5 2012年06月 3日 星期日 14:08:05
# v6 2012年06月 4日 星期一  1:58:48
# 以案数计,最少会处理两个案 可以多台机器同时处理
# 第五版和第六版的区别
# 第五版不能多台机器同时运行，但是可以不处理完一个案，可以指定处理多少个大图
# 第六版能多台机器同时运行，但是必须处理完一个案，不能指定处理多少张大图，可以指定处理多少个有大图的案
# chah_c 测绘案号
# 一次处理 n个大图

#bak_path=/cygdrive/b
#disk_x=/cygdrive/a
bak_path=/cygdrive/d/kingston/disk_b
disk_x=/cygdrive/d/kingston/disk_a
help(){
	echo -e "\033[31m\n\t大哥/大姐，不带这样玩的!!!\033[0m\n\t随便输入个正数吧"
	exit 0
}
if [ $# -eq 1 -a $1 -gt 0 ];then {
	echo -e "\n\t本次最多处理$1案"
	echo -ne "\033[31m
  \t欲终止，在显示\033[34mExif\033[31m时，按CTRL+C，\n
  \t并把最后处理的一个案从备份目录剪切到源目录\n\n"
	echo -ne "\033[32m\t源目录:$disk_x\n
  \t备份目录:$bak_path\n
  \t源目录文件\t->\t备份文件\n\n"
  	echo -ne "\033[0m"
	[ $PWD == $disk_x ] || cd $disk_x
	count=1
	chah_p=''
	count_c=1
	for large_img in `find ????????? -maxdepth 1 -iname "*.jpg" -size +6M -type f`;do {
		chah_c=${large_img%%/*} 
		chah_n=$chah_c
		[ ! $chah_p == $chah_n ] && count_c=`expr $count_c + 1 `
		while [ ! -d $bak_path/$chah_c ];do {
				# 只有创立目录成功才复制文件 保证了目录的唯一创立性，就保证了一个案的单一处理
				# 实现了多台机器互不干扰 ，
				# 缺点是 若处理一个案，就必须全程处理完
				mkdir -v $bak_path/$chah_c 2>/dev/null && cp $large_img $bak_path/$chah_c -v && jpegoptim --max=60 $large_img && count=`expr $count + 1 `
#[ $count -gt $1 ]  && break 2
			[ $count_c -gt $1 ]  && break 2
			}
		done
		chah_p=$chah_n
	}
			done; 
	total_m=`expr $count - 1` 
	echo -e "\n\t$count_c个案含有大于6M的图片,处理了$total_m个文件\n"
	}
else
	help
fi
