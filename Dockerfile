

FROM php:5.4-apache


RUN apt-get update
RUN apt-get upgrade -y --force-yes

#Change HKT Time Zone
RUN ln -sf /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime

#Self Sign Cert
RUN apt-get install openssl -y --force-yes
RUN mkdir /tmp/ssl && cd /tmp/ssl
RUN openssl req -x509 -sha256 -days 3560 -nodes -newkey rsa:2048 -subj "/C=CA/ST=QC/O=Company, Inc./CN=selfsigned.local" -keyout /tmp/ssl/server.key -out /tmp/ssl/server.crt

COPY ./default-ssl.conf /etc/apache2/sites-available/
RUN a2ensite default-ssl
RUN a2enmod ssl
RUN a2enmod rewrite

# mysqli pdo pdo_mysql
RUN apt-get install libxml2-dev -y --force-yes
RUN apt-get install -y --force-yes libbz2-dev libcurl4-openssl-dev libgd-dev libgmp-dev libldap2-dev libmcrypt-dev libmhash-dev libmysqlclient-dev libodbc1 libodbc1 libpng12-dev libpspell-dev libsnmp-dev libsqlite3-dev libtidy-dev libxml2-dev libxslt1-dev
RUN apt-get install -y --force-yes mysql-client
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-enable mysqli pdo pdo_mysql

# XML Dependency
RUN apt-get install libxml2-dev -y --force-yes
RUN docker-php-ext-install xml
RUN docker-php-ext-enable xml

# gd Dependency
 RUN apt-get install libfreetype6-dev libjpeg62-turbo-dev libpng-dev -y --force-yes \
  && docker-php-ext-install gd
RUN docker-php-ext-configure gd
RUN docker-php-ext-configure gd --with-jpeg-dir=/usr/include/

#exif
RUN docker-php-ext-install exif
RUN docker-php-ext-enable exif

#pdo_pgsql Dependency
RUN apt-get install -y apt-transport-https libpq-dev --force-yes

#pgsql, pdo_pgsql, pdo
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql
RUN docker-php-ext-install pgsql
RUn docker-php-ext-install pdo_pgsql
RUN docker-php-ext-install pdo
RUN docker-php-ext-enable pgsql pdo_pgsql pdo

#mbstring, bcmath, jason
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install json
RUN docker-php-ext-enable mbstring bcmath json

#Zip dependency
RUN apt-get install libzip-dev -y --force-yes
RUN docker-php-ext-install zip
RUN docker-php-ext-enable zip


#bz2 calendaer
RUN docker-php-ext-install bz2 calendar
RUN docker-php-ext-enable bz2 calendar

#getttext
RUN docker-php-ext-install gettext
RUN docker-php-ext-enable gettext


# cleanup
RUN apt-get autoremove -y
RUN rm -rf /var/lib/apt/lists/*

#customized php.ini
COPY php.ini /usr/local/etc/php/

EXPOSE 80/tcp
EXPOSE 443/tcp
