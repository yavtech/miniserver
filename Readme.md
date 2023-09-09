# push

    dokcer login
    docker build -t yavtech/miniserver .
    docker push yavtech/miniserver
    docker run -v $(pwd)/static:/wwwroot -p 8000:8000 yavtech/miniserver