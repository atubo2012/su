
##功能:将本地指定的目录，打包文件并发送到远程的sftp服务器上
##
##


#备份文件被发送到的服务器和远程的目录
bkupsver=dev.qstarnet.com
#sftp服务器上的用户名
bkupsveruser=root
#sftp服务器上的保存文件的目录
rbkuppath=$HOME/rbkup


#本分文件在本地保存的目录
lbkuppath=$HOME/bkup
#备份后生成的文件名
filename=bkup.tz.`date '+%Y%m%d_%H%M%S'`


#需备份的目录列表,用空格分隔
#应备份的目录：home /root /etc /var/log
ndbkpath="/root/workspace /etc --exclude=/root/workspace/nodejs/cheerio/data --exclude=/root/workspace/nodejs/cheerio/log --exclude=node_modules"

##for test 
#ndbkpath="/tmp/aaa /tmp/bbb"


#执行本地打包，并保存到本地的目录
#tar参数说明： p：保留文件的属性，如权限等;

echo "开始打包!"
tar -cvzpf $lbkuppath/$filename $ndbkpath
echo "打包完成!"

#将备份文件发送到远程服务器异地备份
echo "连接SFTP服务器......"
sftp $bkupsveruser@$bkupsver<<EOF
dir
cd $rbkuppath
put $lbkuppath/$filename
dir 
quit
EOF

echo "发送完成！本地的备份文件名为:"
ls -alrt $lbkuppath
