### Docker Command
### Docker Build Image:    $ docker build -t mysql:8.0-custom . 
### Docker Image Name: mysql:8.0-custom 
### Docker Container Name: my-mysql-app
### Docker Run
##  $ docker run -dit --restart unless stop -p 3306 --name my-mysql-app -v mysql:/var/lib/mysql mysql:8.0-custom

### $ docker create volume mysql

#Docker File - create Mysql 8.0 DB
# Use this image, create a Bind Volume = mysql     - mysql:/var/libmysql
# $ docker create volume mysql

ARG CODE_VERSION=latest
ARG MYSQL_VER=8.0

FROM mysql:${MYSQL_VER}


### Install Essentail App
#RUN apt-get update && apt-get install -y cron unzip vim zip git

### Change Time Zone
RUN echo "Asia/Hong_Kong" > /etc/timezone 
RUN rm /etc/localtime -f && \
    ln -s /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime


### MySQL Root Password - for mysqldump
COPY .my.cnf /root/.my.cnf
RUN  chmod 700 /root/.my.cnf


### Clean Apt Data
RUN rm -rf /var/lib/apt/lists/*

## Image new = mysql:8.0-custom
## docker volume create mysql-data
## Password XXXXXX , YYYYYY to be filled by new Passwsord
## docker run --name test-mysql-container -e MYSQL_ROOT_PASSWORD=XXXXXXX -e MYSQL_DATABASE=octobercms -e MYSQL_USER=cmsaccess -e MYSQL_PASSWORD=YYYYYYY -v mysql-data:/var/lib/mysql -dit --restart unless-stopped mysql:8.0-custom --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci --default-authentication-plugin=mysql_native_password
