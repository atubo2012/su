export dateymd=`date '+%Y%m%d'`
export lastdate=`date -d last-day '+%Y%m%d'`

#设置环境变量
. /root/workspace/su/setenv.sh
. /root/workspace/su/setsecinfo.sh


#生成当天的各类运行状态信息
/root/workspace/su/sysinfo.sh > $SYSMONITOR_HOME/sysmonitor-$dateymd.log
/root/workspace/su/chksec.sh >> $SYSMONITOR_HOME/sysmonitor-$dateymd.log

#生成与前一天相比运行状态的差异信息
diff  $SYSMONITOR_HOME/sysmonitor-$dateymd.log $SYSMONITOR_HOME/sysmonitor-$lastdate.log > $SYSMONITOR_HOME/sysmonitor-$dateymd.diff.log

#发送到监控管理员邮箱中
mail -s "sysmonitor-$dateymd" $SI_PARM_MAILUSERS_SYSMONITOR <  $SYSMONITOR_HOME/sysmonitor-$dateymd.diff.log 
