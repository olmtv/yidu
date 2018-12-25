#!/bin/bash

#原版下载
wget -c http://www.51yd.org/YiDuInstaller-Nginx-V1.1.9Beta.zip
unzip  YiDuInstaller-Nginx-V1.1.9Beta.zip
wget -c https://github.com/olmtv/yidu/archive/master.zip
unzip master.zip
\cp  yidu-master/conf/server.xml  YiDuInstaller-Nginx/conf/
\cp  yidu-master/ROOT/WEB-INF/classes/log4j.properties    YiDuInstaller-Nginx/ROOT/WEB-INF/classes/
cd YiDuInstaller-Nginx
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.rpm
rm -rf  spider
wget -c https://www.51yd.org/spider20181129.zip
unzip  spider20181129.zip


#安装JDK
chmod +x jdk-8u191-linux-x64.rpm
rpm -ivh jdk-8u191-linux-x64.rpm
#如果有java错误，查看下 java –version是否安装成功

#安装TOMCAT
tar zxvf apache-tomcat-7.0.55.tar.gz
mv apache-tomcat-7.0.55 /usr/local/tomcat
\cp -rpf  conf/server.xml /usr/local/tomcat/conf/   #文件有修改
\cp -rpf sh/tomcat.sh /etc/profile.d/tomcat.sh
\cp -rpf sh/tomcat /etc/rc.d/init.d/tomcat
chmod +x /etc/rc.d/init.d/tomcat

#设置自动启动
chkconfig --add tomcat
chkconfig tomcat on

#rm -rf /www/wwwroot/webapps/ROOT/*  #移除原有文件 ，避免有文件，或者有人建立了这个目录
mkdir -p /www/wwwroot/webapps/ROOT/
mv ROOT/* /www/wwwroot/webapps/ROOT/

#安装数据库
yum -y install ./pgdg-redhat93-9.3-1.noarch.rpm
yum -y install postgresql93-server postgresql93-contrib    
/usr/pgsql-9.3/bin/postgresql93-setup initdb 

\cp -rpf conf/pg_hba.conf /var/lib/pgsql/9.3/data/pg_hba.conf   #需要覆盖命令

#设置开机自动启动
systemctl enable postgresql-9.3.service


#启动Postgresql
systemctl start postgresql-9.3 

#启动tomcat
systemctl restart  tomcat


#install spider
mv spider /www/
\cp -rpf sh/spider /etc/rc.d/init.d/spider
chmod +x /etc/rc.d/init.d/spider
chmod +x /www/spider/start.sh
chmod +x /www/spider/stop.sh
chkconfig --add spider
chkconfig spider on


