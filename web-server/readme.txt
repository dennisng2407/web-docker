## renmove old Container
docker stop WEB
docker rm WEB

## Build
docker build -t apache2 .

## Run
docker run --name WEB -p 8000:80 -p 8001:443 -d apache2

## Connect to Docker
docker exec -it WEB sh

## Test Within Docker
curl http://localhost/
curl -k https://localhost/

## Test in Host
curl http://localhost:8000/
curl -k  https://localhost:8001/
