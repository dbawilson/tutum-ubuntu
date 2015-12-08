FROM ubuntu:latest
MAINTAINER Honglin Feng <hfeng@tutum.co> 

# Install packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server pwgen
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
# 添加商业软件源
#deb http://archive.ubuntu.com/ubuntu trusty multiverse
#deb http://archive.ubuntu.com/ubuntu trusty-updates multiverse

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty multiverse" >> /etc/apt/sources.list
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty-updates multiverse" >> /etc/apt/sources.list

# 先更新apt-get
RUN apt-get upgrade -y

# 安装unrar
RUN apt-get install unrar -y
RUN apt-get install p7zip-full p7zip-rar -y
#RUN apt-get install p7zip-rar -y

# 安装PHP和Apache
RUN apt-get install apache2 -y
RUN apt-get install php5 libapache2-mod-php5 php5-mcrypt php5-cli php5-curl php5-gd -y


# 安装WebApp
RUN rm -Rf /var/www/html

RUN apt-get install git-core -y
RUN git clone https://github.com/easychen/KODExplorer.git  /var/www/html


# 安装aria2
RUN apt-get install aria2 -y 
#install ss
RUN apt-get install python-setuptools && easy_install pip
RUN apt-get install  m2crypto gitLoaded plugins: fastestmirror
RUN pip install shadowsocks

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

ENV AUTHORIZED_KEYS **None**
 
EXPOSE 22 80 6800
CMD ["/run.sh"]
