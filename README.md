# su
shell utils

按照以下顺序将内容添加.bashrc的文件末尾

#系统软件、应用软件的HOME目录、系统级的环境变量
. ./workspace/su/setenv.sh

#应用相关的敏感信息，如用户名、链接字符串、配置参数等
. ./workspace/su/setsecinfo.sh

#操作系统、中间件、应用软件有关的别名定义
. ./workspace/su/setalias.sh
