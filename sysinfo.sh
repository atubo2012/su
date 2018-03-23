#Print Machine Information
echo "====第一行内网IP、第二行公网IP。===="
ifconfig 

echo "====第一行应用服务器、第二行数据服务器===="
cat /etc/hosts  

echo "====操作系统信息===="
#lsb_release -a
cat /proc/version
echo "====内核配置信息===="
uname -r
echo "====系统字长信息===="
getconf LONG_BIT


echo "====CPU配置信息===="
more /proc/cpuinfo | grep "model name" |cut -f2 -d:
echo "====内存配置信息===="
more /proc/meminfo | grep "MemTotal"   |cut -f2 -d:
more /proc/meminfo | grep "MemFree"   |cut -f2 -d:
echo "====磁盘空间信息===="
df -h

echo "====JAVA版本信息===="
java -version

echo "====node版本信息===="
node --version

echo "====服务信息===="
#systemctl list-units --type=service
#systemctl list-units --type=target
#systemctl list-units --type=socket

ps -ef|grep node
