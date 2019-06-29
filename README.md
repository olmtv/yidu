# 易读宝塔快捷安装 仅限CentOS
这个为方便易读和宝塔结合，请先安装宝塔控制面板，安装后再安装Nginx+php+mysql的一键推荐安装后。

新建一个网站，域名为小说站域名，路径随便选，其他参数可不管。提交。

网站设置，选择反向代理，目标URL输入  http://127.0.0.1:8080，请勿输入错误

选择  启用反向代理

下载本脚本，解压，增加脚本权限。

CentOS6 

wget -c https://raw.githubusercontent.com/olmtv/yidu/master/installbt.sh

chmod +x installbt.sh

./installbt.sh

CentOS7

wget -c https://raw.githubusercontent.com/olmtv/yidu/master/installbt7.sh

chmod +x installbt7.sh

./installbt7.sh


网站路径/www/wwwroot/webapps/

日志路径/www/wwwlogs/yidu/


