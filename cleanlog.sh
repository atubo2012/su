
. /root/workspace/su/setenv.sh 
. /root/workspace/su/setsecinfo.sh 
#PM2 log

#dc log
find $DC_HOME/log/  -mtime +$SI_PARM_DATAKEEPDAYS -name  "*.log" -exec rm -rf {} \;  >>  $DC_HOME/log/clean.log  &
find $DC_HOME/log/  -mtime +$SI_PARM_DATAKEEPDAYS -name "*.html" -exec rm -rf {} \;  >>  $DC_HOME/log/clean.log  &
find $DC_HOME/data/ -mtime +$SI_PARM_DATAKEEPDAYS -name "*.xlsx" -exec rm -rf {} \;  >>  $DC_HOME/log/clean.log 2>&1 &
echo `date`>> $DC_HOME/log/clean.log

#mongodb log
echo "" > /var/log/mongodb/mongod.log
