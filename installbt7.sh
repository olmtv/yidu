#!/bin/bash

#原版下载
wget -c http://www.51yd.org/YiDuInstaller-Nginx-V1.2.0Beta.zip
unzip  YiDuInstaller-Nginx-V1.2.0Beta.zip
wget -c https://github.com/olmtv/yidu/archive/master.zip
unzip master.zip
\cp  yidu-master/conf/server.xml  YiDuInstaller-Nginx-V1.2.0Beta/YiDuInstaller-Nginx/conf/
\cp  yidu-master/ROOT/WEB-INF/classes/log4j.properties    YiDuInstaller-Nginx-V1.2.0Beta/YiDuInstaller-Nginx/ROOT/WEB-INF/classes/
cd YiDuInstaller-Nginx-V1.2.0Beta/YiDuInstaller-Nginx/
#wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.rpm
#wget -c http://167.114.210.150/jdk-8u191-linux-x64.rpm
#wget -c https://download.postgresql.org/pub/repos/yum/11/redhat/rhel-7-x86_64/pgdg-centos11-11-2.noarch.rpm修改下载链接
wget -c  https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm

rm -rf  spider
#wget -c https://www.51yd.org/spider20200622.zip
#unzip  spider20200622.zip
wget -c  https://www.51yd.org/attach-download-fid-9-aid-1774.htm
mv attach-download-fid-9-aid-1774.htm spider20201228.zip
unzip spider20201228.zip


#安装JDK
chmod +x jdk-8u201-linux-x64.rpm
rpm -ivh jdk-8u201-linux-x64.rpm
#如果有java错误，查看下 java –version是否安装成功

#安装TOMCAT
tar zxvf apache-tomcat-7.0.55.tar.gz
mv apache-tomcat-7.0.55 /usr/local/tomcat
\cp -rpf  conf/server.xml /usr/local/tomcat/conf/
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
##去掉原有9.3版本数据库安装
yum -y install ./pgdg-redhat-repo-latest.noarch.rpm
yum -y install postgresql11 
yum -y install postgresql11-server
/usr/pgsql-11/bin/postgresql-11-setup initdb

\cp -rpf conf/pg_hba.conf /var/lib/pgsql/11/data/pg_hba.conf   #需要覆盖命令


#设置开机自动启动
systemctl enable postgresql-11.service

#启动Postgresql
systemctl start postgresql-11.service

#启动tomcat
systemctl restart  tomcat


#install spider
mv  spider20201228 /www/spider
\cp -rpf sh/spider /etc/rc.d/init.d/spider
chmod +x /etc/rc.d/init.d/spider
chmod +x /www/spider/start.sh
chmod +x /www/spider/stop.sh
chkconfig --add spider
chkconfig spider on

