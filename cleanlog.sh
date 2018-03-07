
. /root/workspace/su/setenv.sh 
#PM2 log

#dc log
find $DC_HOME/log/ -mtime 7 -name "*.log" -exec rm -rf {} \; >>  $DC_HOME/log/clean.log 2>&1 &
find $DC_HOME/log/ -mtime 7 -name "*.html" -exec rm -rf {} \;  >>  $DC_HOME/log/clean.log 2>&1 &
echo `date`>> $DC_HOME/log/clean.log
