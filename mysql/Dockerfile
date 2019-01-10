# mysql5.7 base on centos 7 
#
# Version 1

FROM centos:base

MAINTAINER studyboy <johngao@qq.com>

WORKDIR /home


COPY ./src/mysql-boost-5.7.24.tar.gz .
COPY ./init/run.sh /run.sh 


Run groupadd mysql && useradd -r -s /sbin/nologin -M -g mysql mysql && \

    echo "Starting install mysql ....." && \

    tar -zxvf mysql-boost-5.7.24.tar.gz && cd mysql-5.7.24 && mkdir bld && cd bld && \

    cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DWITH_BOOST=../boost .. && \

    make -j $(grep processor /proc/cpuinfo | wc -l ) && make install \

    cd /usr/local/mysql && \
    
    mkdir data && chown mysql.mysql && chmod 750 data && \

    mkdir -p /home/wwwlogs/mysql  && \

    echo "Starting initialize mysql database with no password.... " && \

    bin/mysqld --initialize-insecure --user=mysql &&  bin/mysql_ssl_rsa_setup  && \

    ln -sf /usr/local/mysql/bin/mysql /usr/bin/mysql  && \
    ln -sf /usr/local/mysql/bin/mysqldump /usr/bin/mysqldump && \
    ln -sf /usr/local/mysql/bin/myisamchk /usr/bin/myisamchk && \
    ln -sf /usr/local/mysql/bin/mysqld_safe /usr/bin/mysqld_safe && \
    ln -sf /usr/local/mysql/bin/mysqlcheck /usr/bin/mysqlcheck && \

    echo "Preparing mysqld manager script ...." && cp  support-files/mysql.server /etc/init.d/mysqld && chmod +x /etc/init.d/mysqld && \

    echo "Starting mysql server now ...." && \

    /etc/init.d/mysqld start && \

    echo "Create replication user rplproxy@% with pwd =123456 && user webproxy....." && \

    /usr/local/mysql/bin/mysql -u root -e "create user rplproxy@'%' identified by '123123';grant replication slave on *.* to rplproxy@'%'; " && \

    /usr/local/mysql/bin/mysql -u root -e "create user webproxy@'%' identified by '123123';grant select,insert,update,delete,create temporary tables,show view on t8891.'*' to webproxy@'%'  " && \

    /usr/local/mysql/bin/mysql -u root -e "grant select,insert,update,delete,create temporary tables,show view on test.'*' to webproxy@'%'  " && \

    echo "Modify root pwd ...." && \

    /usr/local/mysql/bin/mysqladmin -u root password '123123' && \

    /etc/init.d/mysqld stop  && \

    echo "Rmoving install package ..."  && \
    
    rm -rf /home/mysql-boost-5.7.24.tar.gz  && rm -rf mysql-5.7.24 && \

    echo "Copy mysql config file .... " &&  chmode +x /run.sh 


COPY ./conf/my.cnf /etc/

EXPOSE 3306

ENTRYPOINT ["/run.sh"]





