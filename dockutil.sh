echo "==docker版本=="
docker version
echo "==docker信息=="
docker info
echo "==docker服务状态=="
service docker status

#启动docker服务
#service docker start
#启动docker进程
#systemctl start docker


echo "==已有的image=="
docker image ls

#下载一个image
#docker image pull library/hello-world

#帮助命令
#docker --help
#docker image --help
#docker container --help

#创建并运行一个新的container ，每次run都会新建一个同一个image下的container
#docker container run hello-world

# -it表示交互模式运行
#docker container run -it centos bash

#查看所有的container，包括运行中的和未运行中的
#docker container list -all
#查看ct的状态
#docker container stats youthful_golick

#启动ct，youthful_golick是容器的名字
#docker container start -i youthful_golick #启动后进入ct的命令行
#docker container start    youthful_golick #启动后不进入ct的命令行
#docker container exec -it youthful_golick bash #连接到已经启动的命令行上，exit不会退出ct
#docker container attach   youthful_golick #连接到已经启动的命令行上，exit会退出ct
#Ctrl+P+Q attach到ct后，如需要退出ct，要先按下P再按下Q，顺序不能错。从已连上ct中退出，ct进程不退出

#关闭ct
#docker container stop  youthful_golick #优雅的关闭容器
#docker container kill  youthful_golick #立即关闭容器

#删除ct
#docker container rm kind_mccarthy

#Docker文件制作
获取koa-demo项目内容: git clone https://github.com/ruanyf/koa-demos.git
cd koa-demos
创建 .dockerignore,增加以下内容
.git
node_modules
npm-debug.log

#新建Dockerfile文件，增加以下内容
FROM node:8.4 #安装node8.4版本
COPY . /app   #将项目目录中的文件复制到容器的/app目录中
WORKDIR /app  #工作路径为/app
RUN npm install --registry=https://registry.npm.taobao.org #在工作目录中安装项目依赖的包
EXPOSE 3000   #将容器3000端口暴露出来，允许外部连接这个端口

#执行以下命令，生成image，版本号0.0.1（可选），注意，最后一个.表示将当前目录中的所有内容打包到image中
#docker image build -t koa-demo:0.0.1 .
#启动创建的image
#docker container run -p 8000:3000 -it koa-demo:0.0.1 /bin/bash
#以下启动方式将在退出后自动删除ct
#docker container run --rm -p 8000:3000 -it koa-demo:0.0.1 /bin/bash
#进入ct后启动实例程序
#/app# node demos/01.js
#在浏览器中输入127.0.0.1:8000验证是否登录成功

#复制host某个目录到ct中
#docker cp ../su youthful_mirzakhani:/app/
#docker cp youthful_mirzakhani:/app/README.md ./
#以上是阮一峰的手册参考：http://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html

##
#Docker官文案例：https://docs.docker.com/get-started/#images-and-containers


#前台模式启动ct
docker run -p 8000:80 friendlyhello
#后台模式启动ct
docker run -d -p 8000:80 friendlyhello
#打标签
docker tag friendlyhello atubo2012/get-started:0.0.1
#push到dockhub上
docker push atubo2012/get-started:0.0.1
#在任何一台服务器上可以从dockhub上下载运行
docker run -p 8000:80 atubo2012/get-started:0.0.1

##############
#在service中部署多个node
##############
#service是一个应用中的不同部分(如db、文件内容服务器、视频传输服务器等），一类service可以由多个container构成。
#service用docker-compose.yml文件定义，如下所示：
version: "3"
services:
  web:
    # replace username/repo:tag with your name and image details
    image: atubo2012/get-started:0.0.1
    deploy:
      replicas:3 
      resources:
        limits:
          cpus: "0.1"
          memory: 50M
      restart_policy:
        condition: on-failure
    ports:
      - "8000:80"
    networks:
      - webnet
networks:
  webnet:

#使当前node变为swarm manager，如需使当前node不成为swarm manager，可以用 docker stack leave
docker swarm init

#将多个ct部署到service中
docker stack deploy -c docker-compose.yml getstartedlab

#列出stack
docker stack ls

#列出特定stack中的service
docker stack services getstartedlab

#列出service
docker service ls

#删除指定的stack
docker stack rm getstartedlab

#将当前node从warm中撤出
docker stack leave --force


#######
#Swarm 
# Swarm是一组运行了Docker并加入到cluster的machine。
# 对cluster的操作，只能通过swarm manager(SM)。有若干中运行策略：
#   emptiest node：将容器装入到最少使用的machine中。
#   global：让每个machine上有一个特定的ct实例。
#  只能在有SM的机器上执行对swarm操作的命令和认证其他的Worker。worker是不能发出swarm的操作指令的。
#Docker 也能被切换成swarm mode，自被启用swarm模式后，当前machine会变成swarm mananger，随后的命令都是针对swarm发生作用，而不是仅针对当前machine>
#######

#案例:
在machine1启用swarm，并成为sm，启动成功后，将包含token的命令行复制，在machine2上执行
$docker swarm init

以上命令将输出：
Swarm initialized: current node (944n1w7id1qni2rlrmrr5ruap) is now a manager.
To add a worker to this swarm, run the following command:

    docker swarm join \
    --token SWMTKN-1-1shbg6dxnlp97o5jzcx4vqghcigxykwzrrncf66a3r16hr508l-dfclmgii7rqpv421i5ik3kvas \
    10.105.70.204:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.

#在machine2上执行以上命令
$docker swarm join --token SWMTKN-1-1shbg6dxnlp97o5jzcx4vqghcigxykwzrrncf66a3r16hr508l-dfclmgii7rqpv421i5ik3kvas  10.105.70.204:2377

#查看节点运行情况
$docker node ls

#在machine1上部署stack
docker stack deploy -c docker-compose.yml getstartedlab

#如image在私有的服务器上，则使用私有服务器的地址
docker login registry.example.com
docker stack deploy --with-registry-auth -c docker-compose.yml getstartedlab

#分别访问machine1和machine2的Http://ip:8000验证是否可以连通
可以根据需要再次优化docker-compose.yml，更新后重新执行
docker stack deploy -c docker-compose.yml getstartedlab

#删除一个stack
docker stack rm getstartedlab

#参考
1、在修改完代码、测试、打包、发布后，参考以下链接，重新build后发布到dockerhub上
https://docs.docker.com/get-started/part2/#build-the-app

#Trouble Shooting
1、如果一个machine2重启了，worker会迁移到machine1上。如需worker分布到不同的machine上，则需要重启stack，先rm 然后再deploy
2、安装radis时，会报错No such image: redis:latest，需要在yml文件中增加个host服务器到container之间的/tmp:/tmp路径映射。
3、container的时间与host时间不同步。在yml文件中的volume下，增加一条记录：- "/etc/localtime:/etc/localtime:ro"
https://yq.aliyun.com/articles/30987

