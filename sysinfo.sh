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

echo "====JAVA版本===="
java -version

echo "====Python版本===="
python --version

echo "====node版本===="
node --version

echo "====npm版本===="
npm -v

echo "====openssl版本===="
openssl version


echo "====mongodb版本===="
echo "db.version()" | mongo 100td:27117

echo "====服务信息===="
#systemctl list-units --type=service
#systemctl list-units --type=target
#systemctl list-units --type=socket

ps -ef|grep node
