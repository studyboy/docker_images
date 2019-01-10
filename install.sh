#!/bin/bash
#
# docker images install script
# 
# author:studyboy<johngao@qq.com>
# 
# verion 1 

if !  which docker ; then 

    yum -y install docker 

fi


echo "Install centos base images ...."

docker build --rm -t centos:base ./base_centos/

echo "[+] Install nginx images..."

docker build --rm -t nginx:1.14.2 ./nginx


echo "[+] Install php images ..."

docker build --rm -t php:7.3.0 ./php

echo "[+] Install mysql images ..."

docker build --rm -t mysql:5.7.24 ./mysql


