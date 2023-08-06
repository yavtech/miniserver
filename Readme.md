# push

    dokcer login
    docker build -t yavtech/miniserver .
    dokcer push 
    docker run -v $(pwd)/static:/wwwroot -p 3030:8080 miniserver