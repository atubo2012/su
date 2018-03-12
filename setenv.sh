#设置环境变量的专用脚本，不要在.bashrc中设置，目的是复用脚本
#顺序:系统软件的HOME、应用的HOME

#export NODE_HOME=$HOME/download/node-v8.9.1-linux-x64
export NODE_HOME=$HOME/download/node-v6.11.0-linux-x64
export PATH=$NODE_HOME/bin:$PATH


export DC_HOME=$HOME/workspace/nodejs/cheerio
export ZH_HOME=$HOME/workspace/zhaogong-be

export LANG=en_US.UTF-8
export IP=`/sbin/ifconfig eth0 2>/dev/null | awk '/inet/ {print $2}' | sed 's/addr://'`
