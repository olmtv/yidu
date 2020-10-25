#!/bin/bash

#原版下载
wget -c http://www.51yd.org/YiDuInstaller-Nginx-V1.2.0Beta.zip
unzip  YiDuInstaller-Nginx-V1.2.0Beta.zip
wget -c https://github.com/olmtv/yidu/archive/master.zip
unzip master.zip
\cp  yidu-master/conf/server.xml  YiDuInstaller-Nginx-V1.2.0Beta/YiDuInstaller-Nginx/conf/
\cp  yidu-master/ROOT/WEB-INF/classes/log4j.properties    YiDuInstaller-Nginx-V1.2.0Beta/YiDuInstaller-Nginx/ROOT/WEB-INF/classes/
cd YiDuInstaller-Nginx-V1.2.0Beta/YiDuInstaller-Nginx/
#wget -c http://167.114.210.150/jdk-8u191-linux-x64.rpm
wget -c  https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm

rm -rf  spider
wget -c https://www.51yd.org/spider20200622.zip
unzip  spider20200622.zip

#安装JDK
chmod +x jdk-8u201-linux-x64.rpm
rpm -ivh jdk-8u201-linux-x64.rpm


#安装TOMCAT
tar zxvf apache-tomcat-7.0.55.tar.gz
mv apache-tomcat-7.0.55 /usr/local/tomcat
\cp -rpf  conf/server.xml /usr/local/tomcat/conf/   #文件有修改
\cp -rpf  sh/tomcat.sh /etc/profile.d/tomcat.sh
\cp -rpf sh/tomcat /etc/rc.d/init.d/tomcat
chmod +x /etc/rc.d/init.d/tomcat

#设置自动启动
chkconfig --add tomcat
chkconfig tomcat on

#rm -rf /www/wwwroot/webapps/ROOT/*  #移除原有文件 ，避免有文件，或者有人建立了这个目录
mkdir -p /www/wwwroot/webapps/ROOT/
mv ROOT/* /www/wwwroot/webapps/ROOT/

#安装数据库
yum -y install ./pgdg-redhat-repo-latest.noarch.rpm
yum -y install postgresql11 
yum -y install postgresql11-server
/usr/pgsql-11/bin/postgresql-11-setup initdb



#设置开机自动启动
chkconfig postgresql-11 on
\cp -rpf  conf/pg_hba.conf /var/lib/pgsql/11/data/pg_hba.conf  #需要覆盖命令

#启动Postgresql
service postgresql-11 start

#启动tomcat
service tomcat start
