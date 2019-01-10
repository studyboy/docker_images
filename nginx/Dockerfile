# nginx base on centos 7 
#
# Version 1

FROM centos:base

MAINTAINER studyboy <johngao@qq.com>

WORKDIR /home

#ADD http://nginx.org/download/nginx-1.14.2.tar.gz .

COPY ./src/nginx-1.14.2.tar.gz .

RUN yum -y update && yum -y install gcc gc-c++ pcre-devel openssl openssl-devel zlib-devel zlib make wget net-tools sysvinit-tools lsof

RUN groupadd www && useradd -s /sbin/nologin -M -g www www && mkdir -p /home/www/default && mkdir -p /home/wwwlogs/nginx/olddir

RUN echo "Start install nginx ..." && tar -zxvf nginx-1.14.2.tar.gz && cd nginx-1.14.2 && ./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_v2_module --with-http_gzip_static_module --with-http_sub_module --with-stream --with-stream_ssl_module && make -j $(grep processor /proc/cpuinfo | wc -l) && make install && mkdir /usr/local/nginx/conf/vhost

RUN ln -s /usr/local/nginx/sbin/* /usr/local/sbin/ && cp /usr/local/nginx/html/*  /home/www/default/ && \
     echo "Rmoving nginx srouce package ..." &&  \
     cd ../ && echo $(pwd) && \
     rm -rf /home/nginx-1.14.2.tar.gz /home/nginx-1.14.2

COPY ./conf/nginx.conf /usr/local/nginx/conf/
COPY ./conf/enable-php.conf /usr/local/nginx/conf/
COPY ./init/init.d.nginx  /etc/init.d/nginx

#VOLUME ["/data"]

EXPOSE 80 443

ENTRYPOINT ["/etc/init.d/nginx", "start"]

