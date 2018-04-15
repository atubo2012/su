#!/bin/bash

#本sh是基于腾讯云提供的安全检查指引，将安全检查相关的脚本统一保存
#定期执行后通过邮件发送到指定邮箱，用于维护管理
#https://cloud.tencent.com/document/product/296/9604

echo "最近10次登录的用户"
last -n 10


echo "请确认是否有可疑IP"
less /var/log/secure|grep 'Accepted'

cat /var/log/secure | tail -n 1000 | grep 'Failed password'|awk '$11~/\./ { print $11} $9~/invalid/{print $13}' | sort |uniq|sed 's/$/,/g'|tr -d "\n" |sed 's/^/sshd : /g'|sed 's/,$/\n/g' 

#修改后执行/etc/init.d/sshd restart，重新生效"
echo "ssh开启端口，建议不使用默认端口23"
cat /etc/ssh/sshd_config |grep Port


echo "IP黑名单"
cat /etc/hosts.deny
echo "IP白名单"
cat /etc/hosts.allow
echo "异常登录情况"
lastb | awk '{ print $3}' | sort | uniq -c | sort -n 

#如有非授权账户或可以账户，可以使用命令usermod -L 用户名禁用用户或者使用命令userdel -r 用户名删除用户
echo "请确认是否有非授权账户"
cat /etc/passwd

#若发先有非授权进程，运行ls -l /proc/$PID/exe或file /proc/$PID/exe（$PID 为对应的pid 号），查看下 pid 所对应的进程文件路径。
echo -e "\n查看下服务器是否有未被授权的端口被监听，查看下对应的 pid"
netstat  -antlp


echo -e "\n是否有异常启动项"
cat /etc/rc.local
