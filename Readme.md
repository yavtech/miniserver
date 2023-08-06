# push

    dokcer login
    docker build -t yavtech/miniserver .
    docker push yavtech/miniserver
    docker run -v $(pwd)/static:/wwwroot -p 3030:8000 miniserver