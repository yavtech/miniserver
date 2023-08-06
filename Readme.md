dokcer login
docker build -t miniserver .
docker run -v $(pwd)/static:/wwwroot -p 3030:8080 miniserver