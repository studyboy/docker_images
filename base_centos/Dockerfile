# base centos 7
# install lnmp denpendicies
# version 1

FROM centos:latest

MAINTAINER studyboy <johngao@qq.com>


RUN echo "Install base dependencies...." && \
    yum -y update && \
    yum -y install gcc gcc-c++ pcre-devel openssl openssl-devel zlib-devel zlib make wget net-tools sysvinit-tools && \
    yum install -y lsof libxml2-devel curl curl-devel freetype-devel libicu-devel libxslt-devel perl perl-devel && \
    yum install -y  libpng libjpeg libpng-devel libjpeg-devel giflib giflib-devel autoconf bison automake libaio-devel ncurses-devel cmake re2c


#append ssh service later ....


# RUN yum install -y openssl-server && \ 

