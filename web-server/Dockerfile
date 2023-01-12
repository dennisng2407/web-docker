
ARG CODE_VERSION=latest
ARG PHP_VER=8.0
ARG WEB_SERVICE=apache   

FROM ubuntu:${CODE_VERSION} AS BUILD_IMAGE
RUN apt-get update -y && apt-get install openssl -y
RUN mkdir /tmp/ssl && cd /tmp/ssl 
RUN openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout /tmp/ssl/server.key -out /tmp/ssl/server.crt -subj "/C=CA/ST=QC/O=Company, Inc./CN=selfsigned.local" -addext "subjectAltName=DNS:selfsigned.local"
RUN ls /tmp/ssl

#FROM httpd:latest

##Copy Self-signed Certificate
#COPY --from=BUILD_IMAGE /tmp/ssl /usr/local/apache2/conf/

##Copy HTML Source File
#COPY ./public-html /usr/local/apache2/htdocs/

#RUN apt update -y && apt upgrade -y && apt clean all

##Updated httpd.conf File 
#COPY ./my_httpd.conf /usr/local/apache2/conf/httpd.conf

##Update SSL Conf File
#COPY ./my_httpd-ssl.conf /usr/local/apache2/conf/extra/httpd-ssl.conf

##Overwrite Ordered SSL Certificate
#COPY ./ssl /usr/local/apache2/conf/

#Base Web Server Image
FROM php:$PHP_VER-$WEB_SERVICE

#Copy Self-signed Certificate
COPY --from=BUILD_IMAGE /tmp/ssl /etc/ssl
#Copy New SSL Virutal Host Config File
COPY ./apache-conf/apache2/default-ssl.conf /etc/apache2/sites-available/
RUN a2ensite default-ssl
#COPY SSL Parameter config (TLS1.2, TLS1.3, SSL Cipher Suite)
COPY ./apache-conf/apache2/ssl-params.conf /etc/apache2/conf-available/
RUN a2enmod ssl

#Change HKT Time Zone
RUN ln -sf /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime

##Overwrite Ordered SSL Certificate
COPY ./ssl /usr/local/apache2/conf/

##Copy HTML Source File
COPY ./public-html /var/www/html/

##Install PHP Plug in
#Possible Know Plugin -  
#bcmath bz2 calendar ctype curl dba dom enchant exif ffi fileinfo filter ftp gd gettext gmp hash iconv imap intl json ldap mbstring mysqli oci8 odbc opcache pcntl pdo pdo_dblib pdo_firebird pdo_mysql pdo_oci pdo_odbc pdo_pgsql pdo_sqlite pgsql phar posix pspell readline reflection session shmop simplexml snmp soap sockets sodium spl standard sysvmsg sysvsem sysvshm tidy tokenizer xml xmlreader xmlwriter xsl zend_test zip

RUN apt-get update 
RUN apt-get install libxml2-dev -y
RUN docker-php-ext-install mysqli 
RUN docker-php-ext-install pdo 
RUN docker-php-ext-install pdo_mysql 
# XML Dependency
RUN apt-get install libxml2-dev -y
RUN docker-php-ext-install xml 
# gd Dependency
 RUN apt-get install libfreetype6-dev libjpeg62-turbo-dev libpng-dev -y \
  && docker-php-ext-configure gd \
  && docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-install exif

#pdo_pgsql Dependency
RUN apt-get install -y apt-transport-https libpq-dev
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql
RUN docker-php-ext-install pgsql
RUn docker-php-ext-install pdo_pgsql

RUN docker-php-ext-install pdo

RUN docker-php-ext-install gd 
##RUN docker-php-ext-install mbstring 
RUN docker-php-ext-install bcmath 
##RUN docker-php-ext-install json 
RUN docker-php-ext-install opcache 

##ldap dependency
RUN apt-get install libldap2-dev -y
RUN docker-php-ext-install ldap 

#Zip dependency
RUN apt-get install libzip-dev -y
RUN docker-php-ext-install zip


RUN docker-php-ext-enable mysqli 
RUN docker-php-ext-enable pdo 
RUN docker-php-ext-enable pdo_mysql 
RUN docker-php-ext-enable xml 
RUN docker-php-ext-enable gd 
#RUN docker-php-ext-enable mysqli mbstring 
RUN docker-php-ext-enable bcmath 
#RUN docker-php-ext-enable mysqli json 
RUN docker-php-ext-enable opcache 
RUN docker-php-ext-enable ldap 
RUN docker-php-ext-enable zip
RUN docker-php-ext-enable pdo


##Export HTTP & HTTPS
EXPOSE 80/tcp
EXPOSE 443/tcp


