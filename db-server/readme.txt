docker stop MYSQL
docker rm MYSQL
docker build -t mysql8 .
docker run --name DB -p 13306:3306 -d mysql8

## Connect to Docker
docker exec -it NEW mysql8
