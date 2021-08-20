
    2  git clone https://github.com/dockersamples/example-voting-app.git
    3  cd example-voting-app/
    4  ls
    5  cd vote/
    6  docker build . -t voting-app
    7  docker run -d -p 5000:80 voting-app
   13  docker run -d --name=redis redis
   14  docker ps
   15  docker run -d -p 5000:80 --link redis:redis voting-app
   24  docker ps
   25  cd ..
   26  cd worker/
   42  docker build -t worker-app .
   48  docker run -d --name=db -e POSTGRES_PASSWORD=postgres  postgres:9.4
   52  docker run -d --link redis:redis --link db:db worker-app
   60  cd example-voting-app/
   61  ls
   62  cd result/
   63  ls
   64  docker build -t result-app .
   68  docker run -d -p 5001:80 --link db:db result-app 
   69  history