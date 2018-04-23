#本脚本用来演示如何生成私钥、提取公钥、利用私钥加密文件、利用私钥解密文件
#参考:https://www.linuxidc.com/Linux/2015-01/112073.htm


#key归属的应用名字
appname=test
#key私钥文件名
prikeyfile=$appname.prikey
#key共钥文件名
pubkeyfile=$appname.pubkey
#秘钥长度
keylength=1024
#被加密的文件名
targetfile=hello.txt
#被加密后生成的文件名
encrypfile=$targetfile.en
#被解密后生成的文件名
decrypfile=$targetfile.de


#演示流程
echo "1、生成名为$priAndPubKeyName_pri.key的私钥,秘钥长度$keylength...."
openssl genrsa -out $prikeyfile $keylength


echo "2、从私钥中提取公钥$priAndPubKeyName_pub.key...."
openssl rsa -in $prikeyfile -pubout -out $pubkeyfile

echo "3、加密文件$targetfile，生成$encrypfile......"
echo "hehe哈喽"> $targetfile
openssl rsautl -encrypt -in $targetfile -inkey $pubkeyfile -pubin -out $encrypfile

echo "密文内容如下:"
cat $encrypfile


echo "4、解密文件$encrypfile，生成$decrypfile......"
openssl rsautl -decrypt -in $encrypfile -inkey $prikeyfile -out $decrypfile
echo "解密后的明文内容:"
cat $decrypfile

echo "done!"

#以下脚本用来演示openssl的其他能力
#参考：http://www.178linux.com/48764?utm_source=tuicool&utm_medium=referral

#
#openssl单向加密文件，可用的算法可通过openssl ciphers -v查看
#
destype=des3
openssl enc -e -$destype -a -salt -in $targetfile -out $targetfile.$destype
openssl enc -d -$destype -a -salt -in $targetfile.$destype -out $targetfile.d-$destype


#
#单向加密的工具有dgst、md5sum，sha1sum，sha224sum，sha256sum ，sha384sum，sha512sum
#
openssl dgst -md5 $targetfile  #除md5算法外，还有md4、md2、sha、mdc2等
openssl md5sum  $targetfile
echo "你好啊" |openssl dgst -md5 


#
#计算密码的hash值
#
#将文件中的内容作为密码计算hash值
openssl passwd -1 -in hello.txt -salt 5439
#将stdin输入的内容作为密码计算hash值，如不指定固定的salt值(最长8位)，则每次默认会默认使用不同的salt，如
openssl passwd -1  -salt 5439
#参考http://blog.51cto.com/wangenzhi/1674996


#
#生成随机数，可生成base32、base64、base16(即hex)格式的随机数
#参考：https://segmentfault.com/a/1190000010857971
openssl rand -hex 10
openssl rand -base64 10
openssl rand -base64 10 -out rand.b64

#
#签发证书
#参考：http://www.178linux.com/48764?utm_source=tuicool&utm_medium=referral
#
#一、创建自签证书：在CA服务器上操作以下步骤：
#1、查看配置文件(/etc/pki/tls/openssl.cnf )确认证书相关的配置信息，确认CA、证书、CA私钥的存放目录
#2、创建相关的目录
mkdir -pv /etc/pki/CA/{certs,crl,newcerts,private}
touch /etc/pki/CA/{serial,index.txt}
cd /etc/pki/CA && echo 01 >> serial
#3、生成CA私钥
openssl genrsa -out         /etc/pki/CA/private/cakey.pem 4096
#4、生成自签证书
openssl req -new -x509 -key /etc/pki/CA/private/cakey.pem -out /etc/pki/CA/cacert.pem -days 3650
#二、生成证书请求文件：在需要使用证书的服务器上做以下步骤：
#1、生成私钥
openssl genrsa -out httpd.key 4096
#2、基于私钥生成证书请求文件
openssl req -new -key httpd.key -out httpd.csr -days 365
#三、在CA服务器上颁发被请求的证书
openssl ca -in httpd.csr -out /etc/pki/CA/certs/httpd.crt -days 365
查看刚生成的证书
openssl x509 -in /etc/pki/CA/certs/httpd.crt -noout -serial -subject

#四、安装证书：在需要使用证书的服务器上做以下操作：
略

#五、吊销证书：在需要使用证书的服务器上做以下操作：
1、先在使用证书的服务器上，获得证书的信息：serial和subject
2、在CA服务器的index.txt文件中查看是否存储有与上述信息符合的记录
3、执行命令吊销证书
openssl ca -revoke /etc/pki/CA/newcerts/01.pem
4、生成吊销证书的吊销编号(仅在第一次吊销证书时执行)
echo 01 > /etc/pki/CA/crlnumber
5、更新吊销证书列表
openssl ca -gencrl -out /etc/pki/CA/crl/ca.crl
6、查看crl文件，确认吊销结果
openssl crl -in /etc/pki/CA/crl/ca.crl -noout -text
