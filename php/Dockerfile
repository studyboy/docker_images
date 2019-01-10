# php base on centos 7 
#
# Version 1

FROM centos:base

MAINTAINER studyboy <johngao@qq.com>

WORKDIR /home

#ADD http://cn2.php.net/get/php-7.3.0.tar.gz/from/this/mirror .

COPY ./src/php-7.3.0.tar.gz .
COPY ./src/redis-4.2.0.tgz .
COPY ./src/libzip-1.2.0.tar.gz .
COPY ./src/swoole-4.2.9.tgz .

RUN echo "Install base dependencies...." && \

#    yum -y update && yum -y install gcc gcc-c++ pcre-devel openssl openssl-devel zlib-devel zlib make wget net-tools sysvinit-tools && \
#    yum install -y lsof libxml2-devel curl curl-devel freetype-devel libicu-devel libxslt-devel perl perl-devel && \
#    yum install -y  libpng libjpeg libpng-devel libjpeg-devel autoconf bison && \
#    yum remove -y libzip-devel libzip

     yum install -y openssl openssl-devel 

RUN groupadd www && useradd -s /sbin/nologin -M -g www www && mkdir -p /home/www/default && mkdir -p /home/wwwlogs/php/olddir && \

    echo "Strating install libzip extension...\n" && \

    tar -zxvf libzip-1.2.0.tar.gz && cd libzip-1.2.0 && ./configure && make && make install && \

    echo '/usr/local/lib' >>  /etc/ld.so.conf.d/libzip.conf && ldconfig && ln -s  /usr/local/lib/libzip/include/zipconf.h /usr/local/include/ && \

    echo "Start install php ..."&& cd /home && \

    tar -zxvf php-7.3.0.tar.gz && cd php-7.3.0 && \
    ./configure '--prefix=/usr/local/php' \
    '--with-config-file-path=/usr/local/php/etc' \
    '--with-config-file-scan-dir=/usr/local/php/conf.d' \
    '--enable-fpm' '--with-fpm-user=www' \
    '--with-fpm-group=www' \
    '--enable-mysqlnd' \
    '--with-mysqli=mysqlnd' \
    '--with-pdo-mysql=mysqlnd'\
    '--with-iconv-dir' \
    '--with-jpeg-dir' \
    '--with-png-dir' \
    '--with-zlib' \
    '--with-libxml-dir' \
    '--enable-xml' \
    '--disable-rpath' \
    '--enable-bcmath' \
    '--enable-shmop' \
    '--enable-sysvsem' \
    '--enable-inline-optimization' \
    '--with-curl' \
    '--enable-mbregex' \
    '--enable-mbstring' \
    '--enable-intl' \
    '--enable-ftp' \
    '--with-gd' \
    '--with-openssl' \
    '--with-mhash' \
    '--enable-pcntl' \
    '--enable-sockets' \
    '--with-xmlrpc' \
    '--enable-zip' \
    '--enable-soap' \
    '--with-gettext' \
    '--disable-fileinfo' \
    '--enable-opcache' \
    '--with-xsl' \
    '--with-freetype-dir=/usr' && \

    make -j $(grep processor /proc/cpuinfo | wc -l) && make install && \
    cp php.ini-production /usr/local/php/etc/php.ini &&  cd /home && \

    echo "Starting install redis extension..." && \

    tar -zxvf redis-4.2.0.tgz && cd redis-4.2.0 && /usr/local/php/bin/phpize ./ && ./configure --with-php-config=/usr/local/php/bin/php-config && \
    make && make install  && cd /home && \

    echo "Starting install swoole extension..." && \

    tar -zxvf swoole-4.2.9.tgz && cd swoole-4.2.9 && /usr/local/php/bin/phpize ./ && \
    ./configure --with-php-config=/usr/local/php/bin/php-config &&  make && make install  && cd /home && \

    #echo "Modify php.ini and append extentions..." && \

    #sed -i 's#;extension_dir = "./"#extension_dir = "/usr/local/php/lib/php/extensions/no-debug-non-zts-20180731/'  /usr/local/php/etc/php.ini && \
    #sed -i 's#short_open_tag.*#short_open_tag = on#' /usr/local/php/etc/php.ini && \
    #sed -i 's#max_execution_time.*#max_execution_time = 100#' /usr/local/php/etc/php.ini && \
    #sed -i 's#post_max_size.*#post_max_size = 50M#' /usr/local/php/etc/php.ini && \
    #sed -i 's#upload_max_filesize.*#upload_max_filesize = 50M#' /usr/local/php/etc/php.ini && \
    #sed -i 's#;extension=fileinfo#extension=fileinfo#' /usr/local/php/etc/php.ini && \
    #sed -i 's#;extension=mbstrin#extension=mbstrin#' /usr/local/php/etc/php.ini && \
    #sed -i 's#;extension=openssl#extension=openssl#' /usr/local/php/etc/php.ini && \
    #sed -i 's#;extension=pdo_mysql#extension=pdo_mysql#' /usr/local/php/etc/php.ini && \
    #sed -i 's#extension=openssl#i extension=redis.so#' /usr/local/php/etc/php.ini && \
    #sed -i 's#extension=openssl#i extension=swoole.so#' /usr/local/php/etc/php.ini && \
    #sed -i 's#;error_log = php_errors.log#error_log=/home/wwwlogs/php/php_errors.log#' && \

    #echo "Modify php-fpm.conf file ..." && \
    #cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf && \

    #sed -i 's#;pid = run/php-fpm.pid#pid = /usr/local/php/var/run/php-fpm.pid#' &&\
    #sed -i 's#;error_log = log/php-fpm.log#error_log = /home/wwwlogs/php/php-fpm.log#' &&\
    #sed -i 's#;log_level = notice#log_level = notice#' && \
    #sed -i 's#;daemonize = yes#daemonize = no#' && \

    echo "Create php-fpm manage script ..." && \

    cp -f /home/php-7.3.0/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm && \

    echo "Starting modify config files php.ini php-fpm.conf files ...."


COPY ./conf/www.conf /usr/local/php/etc/php-fpm.d/
COPY ./conf/php.ini /usr/local/php/etc/
COPY ./conf/php-fpm.conf /usr/local/php/etc/
#COPY ./init/init.d.php-fpm  /etc/init.d/php-fpm

   
RUN ln -s /usr/local/php/bin/php /usr/bin/ && \
 
     echo "Removing install soft packages file ...." && \

     cd /home && echo $(pwd) && \
     rm -rf /home/php-7.3.0*  /home/swoole-4.2.9*  /home/libzip-1.2.0* /home/redis-4.2.0* 
     

#VOLUME ["/data"]

EXPOSE 80 443

ENTRYPOINT ["/etc/init.d/php-fpm", "start"]

