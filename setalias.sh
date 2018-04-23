#/etc/bashrc末尾添加的内容，各类用户使用
#set -o vi
#alias l='ls -arlt '
#export PS1='[`date +%H:%M:%S`|\u@\H|`pwd` ]\$'
#export SVN_EDITOR=vi
#hostname www.qstarnet.com  #<-该域名应为互联网域名，便于识别



##############################################
#按照不同的项目，分别写出于项目标配alias
#goxx进入目录
#ecxx编辑配置
#lgxx查看日志
#stxx启动进程
#sdxx关闭进程
#cnxx连接进程
#clxx清理文件
#针对常用的命令，应该在secretcrt中设置为启动后自动执行，减少键盘输入量
#############################################
#在setenv.sh中设置环境变量
#XXHOME
#############################################

#系统命令
#找到大文件和大目录：https://www.cnblogs.com/iyoume2008/p/6105590.html
alias bigsize='du -h --max-depth=1 |sort'
alias bigsize2='find /  -type f -size +100M  -print0 | xargs -0 du -h | sort -nr '
#安全管理
alias elsc='vi /var/log/secure'
alias elms='vi /var/log/messages'
#定时任务
alias lgcr='tail -f /var/log/cron'
alias eccr='vi /etc/crontab'

#pm2起停命令
alias stpm='cd /root/workspace/zhaogong-be && pm2 start process.json'
alias sdpm='pm2 stop all'
alias lgpm='pm2 log'
alias lepm='tail -f $HOME/.pm2/logs/zhaogong-error.log'

#mongodb命令
export LANG=en_US.UTF-8
alias cnmg='echo "db.serverStatus().connections"  | mongo $SI_DC_DBURL'
alias clmg='echo "db.esf.remove({}); db.hrhis.remove({});"  | mongo $SI_DC_DBURL'
alias lgmg='tail -f /var/log/mongodb/mongod.log'
alias elmg='vi /var/log/mongodb/mongod.log'
alias stmg='service mongod start'
alias sdmg='service mongod stop'
alias ecmg='vi /etc/mongod.conf' 
alias stmg='mongostat -h $SI_DC_DBURL'
#alias slmg='echo "db.system.profile.find({millis:{$gt:500}})" |mongo $SI_DC_DBURL'

#安装mongod作为服务，设备重启后，可以自动启动进程
alias istmgsvc='chkconfig mongod on'
#卸载mongod作为服务
alias uistmgsvc='chkconfig mongod off'


#腾讯小程序demo
alias godemo='cd /data/release/node-weapp-demo/'

#找工小程序
alias gozg='cd /root/workspace/zhaogong-be'

#lj&zy数据采集
alias goc='cd /root/workspace/nodejs/cheerio'
#alias lgdc='tail -f /root/workspace/nodejs/cheerio/log/cron.log'
alias ldcq='tail -f /root/workspace/nodejs/cheerio/log/ljcq.log'
alias ldsh='tail -f /root/workspace/nodejs/cheerio/log/ljsh.log'
alias ldcd='tail -f /root/workspace/nodejs/cheerio/log/ljcd.log'
alias ldsz='tail -f /root/workspace/nodejs/cheerio/log/ljsz.log'
alias ldhz='tail -f /root/workspace/nodejs/cheerio/log/ljhz.log'

#shell utils
alias gosu='cd /root/workspace/su'

#wbot
alias gowc='cd /root/workspace/nodejs/wechaty'

#docker study
alias godk='cd /root/workspace/dockee'

#systemd相关
alias gosd='cd /usr/lib/systemd/system'
