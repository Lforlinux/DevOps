Install Docker

```
$ yum install docker
```

Start the service

```
$ sudo systemctl start docker
```

Create the docker group if it does not exist

```
$ sudo groupadd docker

```

Add your user to the docker group.

```
$ sudo usermod -aG docker $USER

```

Check if docker can be run without root

```
$ docker run hello-world

```

Trouble shoot 

change the current group ID during a login session

```
$ newgrp docker
```


