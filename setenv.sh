export NODE_HOME=$HOME/download/node-v6.11.0-linux-x64
export PATH=$NODE_HOME/bin:$PATH


export SYSMONITOR_HOME=/var/log/sysmonitor

export LANG=en_US.UTF-8
export IP=`/sbin/ifconfig eth0 2>/dev/null | awk '/inet/ {print $2}' | sed 's/addr://'`
