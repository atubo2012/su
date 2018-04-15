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

