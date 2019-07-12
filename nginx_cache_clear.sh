#!/bin/bash
header()
{
printf "
###################################################################
#                                                                 #
#  For more information please visit https://blog.whsir.com       #
#                                                                 #
###################################################################

"
}
NGINX_CACHE(){
echo -n "请输入nginx的cache目录(可以使用tab补全)："
read -e ngx_cache_path
}
IMPORT(){
echo -n -e "输入删除的动作\n1.按文件类型删除\n2.按网站目录删除\n:"
read ngx_cache
}
FILE_TYPE()
{
echo -n -e "请输入需要清除缓存文件的类型:"
read -a file_type
for i in $file_type
do
grep -r -a \.$i $ngx_cache_path | awk -F":" '{print $1}' | uniq  > /tmp/cache_list.txt
done
for j in `cat /tmp/cache_list.txt`  
do  
    rm -f $j  
    echo "$i $j 删除成功!"  
done
}
FILE_DIR()
{
echo -e "清除缓存的目录，例：blog.whsir.com/demo/" 
echo -n -e "输入需要删除缓存的网站目录:"
read -a file_dir
for i in $file_dir
do
grep -r -a $i ${ngx_cache_path} | awk -F":" '{print $1}' > /tmp/cache_list.txt
done
for j in `cat /tmp/cache_list.txt`
do
    rm -f $j
    echo "$i $j 删除成功!"
done
}
CASE(){
case $ngx_cache in
1)
FILE_TYPE
;;
2)
FILE_DIR
;;
*)
IMPORT
CASE
;;
esac
}
NGINX_CACHE
IMPORT
CASE
