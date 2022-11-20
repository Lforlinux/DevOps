* Do you have sample code for the project?

```
Fork : https://github.com/Lforlinux/Docker-CICD.git
```

* Go to lab env 
```
git clone https://github.com/Lforlinux/Docker-CICD.git
cd Docker-Jenkins-Demo
ls and check for Dockerfile 
docker build -t projectdemo .
docker images ( Check for projectdemo image )
docker run -d -p 8000:8000 projectdemo
docker ps
```
* Go to browser and visit localhost:8000

* Lets clean up running containers and images 

* Run following commands :
```
docker rm -f $(docker ps -aq)  ---> Removing all running containers
docker rmi -f $(docker images -q) ---> Removing all the images
```


Jenkins Setup: 

* Make sure you have a running Jenkins and access jenkins via its IP:8080 
* Go to  Manage Jenkins ---> Manage Plugins ---> Search for “docker pipeline” -->  select it and install without restart
* visit https://hub.docker.com/ and create a dockerhub account
* Create Repository to push our docker image → Click on create repository, add name and click create.
* Go to home page of jenkins ---> Click Manage Jenkins ---> Click Manage Credentials 
 ---->  Click on Jenkins ( Scoped ) ---> Click on Global Credentials ----> Click Add Credentials on left side bar ---> Select Kind as username with password ---> Keep Scope as it is ----> Add your dockerhub username and password in the respective fields ---> Enter “docker-creds” value in Id field and Save. ( Shortcut : http://IP:8080/credentials/store/system/domain/_/ )
 * Go to your github repository and edit Jenkinsfile : Edit line number 4 **registry** with your own Dockerhub registry and edit line number 15 with your own GitHub Repo. 
 *  Go to jenkins home page ---> click new item → Enter your pipeline name ---> Select type as “Pipeline” and click ok
 * You will see pipeline configure window, Go to Triggers Section and Set Poll SCM to “*/5 * * * *"
 * Go below to Pipeline Section and select option as “Pipeline from SCM” ---> Select Git ---> Enter our project github repository url ---> Keep credentials as “None” as it is public repository and click save
* Click on Build Now. First build will fail as docker daemon does not have elevated privileges
* Go to terminal and run command : 
```
	# cd /
    # sudo chmod 777 /var/run/docker.sock
```

* Check for the latest build it should be success. 
* Now go back to Github repo and change “server.py” file to update the message and commit the changes. You will see automatically jenkins ci-cd pipeline triggers and latest changes are updated on http://ip:8000


