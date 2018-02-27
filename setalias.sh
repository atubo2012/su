#/etc/bashrc末尾添加的内容，各类用户使用
#set -o vi
#alias l='ls -arlt '
#export PS1='[`date +%H:%M:%S`|\u|`pwd` ]\$'
#export SVN_EDITOR=vi


#应用维护命令
#腾讯小程序demo
alias godemo='cd /data/release/node-weapp-demo/'

#找工小程序
alias gozg='cd /root/workspace/zhaogong-be'

#lj&zy数据采集
alias goc='cd /root/workspace/nodejs/cheerio'

#shell utils
alias gosu='cd /root/workspace/su'

#pm2起停命令
alias pstart='cd workspace/zhaogong-be && pm2 start process.json'
alias pstop='pm2 stop all'
alias plog='pm2 log'
alias pelg='tail -f $HOME/.pm2/logs/zhaogong-error.log'
alias lcron='tail -f /var/log/cron'

#mongodb命令
export LANG=en_US.UTF-8
alias mgcon='echo "db.serverStatus().connections"  | mongo 100td:27117'
alias mgclr='echo "db.esf.remove({}); db.hrhis.remove({});"  | mongo 100td:27117'
