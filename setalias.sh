#/etc/bashrc末尾添加的内容，各类用户使用
#set -o vi
#alias l='ls -arlt '
#export PS1='[`date +%H:%M:%S`|\u|`pwd` ]\$'
#export SVN_EDITOR=vi


##############################################
#按照不同的项目，分别写出于项目标配alias
#goxx进入目录
#ecxx编辑配置
#lgxx查看日志
#stxx启动进程
#sdxx关闭进程
#cnxx连接进程
#clxx清理文件
#############################################
#在setenv.sh中设置环境变量
#XXHOME
#############################################

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
alias cnmg='echo "db.serverStatus().connections"  | mongo 100td:27117'
alias clmg='echo "db.esf.remove({}); db.hrhis.remove({});"  | mongo 100td:27117'
alias lgmg='tail -f /var/log/mongodb/mongod.log'
alias stmg='service mongod start'
alias sdmg='service mongod stop'
alias ecmg='vi /etc/mongod.conf' 
#安装mongod作为服务，设备重启后，可以自动启动进程
alias istmgsvc='chkconfig mongod on'
#卸载mongod作为服务
alias istmgsvc='chkconfig mongod off'


#腾讯小程序demo
alias godemo='cd /data/release/node-weapp-demo/'

#找工小程序
alias gozg='cd /root/workspace/zhaogong-be'

#lj&zy数据采集
alias goc='cd /root/workspace/nodejs/cheerio'
alias lgdc='tail -f /root/workspace/nodejs/cheerio/log/cron.log'

#shell utils
alias gosu='cd /root/workspace/su'



#systemd相关
alias gosd='cd /usr/lib/systemd/system'
