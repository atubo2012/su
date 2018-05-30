#docker信息
alias dkv='docker version'
alias dki='docker info'

#镜像信息
alias dkli='docker image list '
alias dkri='docker image rm $1'

#容器管理常用命令
alias dkgo='docker container start $1'
alias dkls='docker container list -a'
alias dkex='docker container exec -it $1 $2'
alias dkst='docker container stats $1'
alias dkps='docker ps -as &'
alias dksd='docker container stop $1'
alias dkkl='docker container kill $1'
alias dkrc='docker container rm $1'

#stack与service常用命令
alias dkstdp='docker stack deploy -c docker-compose.yml $1'
alias dkstls='docker stack ls '
alias dksvls='docker service ls'
alias dkssls='docker stack services $1'
alias dkstps='docker stack ps $1'
alias dksvps='docker service ps $1'
alias dkstrm='docker stack rm $1'
alias dkswlv='docker swarm leave --force'

#node管理命令
alias dkndls='docker node ls'


#compose常用命令
alias dkcpup='docker-compose up $1'
alias dkcpdw='docker-compose down'
alias dkcpps='docker-compose ps'
alias dkcprn='docker-compose run $1'
alias dkcpsd='docker-compose stop'


#备用命令
#以后台模式执行容器中的一个命令
alias dked='docker container exec -d $1 $2'
#连接到ct中，退出时用CTRL+Q+P退出，exist会将ct退出
alias dkat='docker container attach $1'
#查看容器中所有执行的命令和输出
alias dklg='docker container logs $1'


#wechaty启动命令
alias wechatygo='cd /root/workspace/nodejs && nohup docker run -i --rm --volume="$(pwd)":/bot -v /etc/localtime:/etc/localtime:ro zixia/wechaty:0.14 wc.js  > wc.log &'
alias wechatygos='cd /root/workspace/nodejs nohup docker run -e WECHATY_LOG=silly -i --rm --volume="$(pwd)":/bot -v /etc/localtime:/etc/localtime:ro zixia/wechaty:0.14 wc.js  > wc.log &'
