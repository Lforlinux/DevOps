## Writing

### FROM
* Always use slim images instead of using images with whole OS in it example, use debian:stretch-slim instead of debian
* If possible, use official maintained images such as use node instead of debian
* Always give tags, example: node:10-alpine, if you dont provide tag or use latest, this might break image cache or even container image.

## Order Matters
* keep order of statements in such way that image can have cache and incremental build time.
for example,
```
FROM debian
COPY . /app
RUN apt-get update
RUN apt-get install nodejs
CMD ["npm", "start","--prefix","app"]
```
In above case, everytime you make changes to code and build the image, it will copy the content and run the commands to update & install nodejs which is not ideal.

Instead, what we can do is,
```
FROM debian
RUN apt-get update
RUN apt-get install nodejs
COPY . /app
CMD ["npm", "start","--prefix","app"]
```
In this scenario, once you build the image, it will have cache of first 3 layers. whenever you will rebuild the image, it will start from COPY statement and only copy your code into container, hence lesser the image build time.

### Chaining
each statement in Dockerfile introduces one extra layer in image, hence we should chain the statement wherever possible

for example, instead of,
```
RUN apt-get update
RUN apt-get -y install imagemagick curl software-properties-common gnupg vim ssh
RUN apt-get -y install nodejs 
```
we could write,
```
RUN apt-get update && apt-get -y install imagemagick curl software-properties-common gnupg vim ssh && apt-get -y install nodejs
```
This will reduce number of layers in image and hence the size.

### Remove Package manager cache
* We can also reduce the size of image by removing unneccessary package manager cache
```
RUN apt-get update apt-get -y install --no-install-recommends \
       imagemagick curl software-properties-common gnupg vim ssh nodejs \
    && rm -rf /var/lib/apt/lists/*
```
example of some commands for removing package manager cache:
```
* --no-cache in alpine
* --no-install-recommends && rm -rf /var/lib/apt/lists/* in debian
* yum clean all in CentOS/RedHat
```
### Be specific about COPY
* To make sure:
    * you are not invalidating cache
    * you might accidentally copy secrets or tokens into the image
Instead of copying the whole thing into the container,
```
COPY .  /app
```
only copy what is required
```
COPY package.json server.js /app
```

### USER
If we don’t specify any USER in Dockerfiles, it defaults to root user which can potentially access docker host system. Using container as non-root is one of the widespread best practice for security.

If service can run without privileges, use USER to change to a non-root user, you can create a user in Dockerfile or standard maintained project such as apache or node provides user readily.

* How to add?
```
RUN chown -R node:node /app
USER node
CMD ["npm", "start", "--prefix", "app"]
```

* Things to remember:

    * you cant use privileged ports(1-1023)
    * you need to provide proper file permissions to directories


### COPY instead of ADD
    * COPY copies local files recursively, given explicit source and destination files or directories. With COPY, you must declare the locations.
```
COPY /source/file/path  /destination/path
```

* ADD is lot more complex than COPY, it can do extra things. it copies local files recursively, implicitly creates the destination directory when it doesn’t exist, and accepts archives as local or remote URLs as its source, which it expands or downloads respectively into the destination directory.

* Copy local file into image
```
ADD /source/file/path  /destination/path
```

* Extract the content of compressed files in destination

```
ADD source.file.tar.gz /temp
```

* downloading file from URL and copy it to destination in image

```
ADD http://source.file/url  /destination/path
```

### Don’t Keep Secrets

* Never bundle secrets, tokens inside the images, instead rely on volumes, environment variables.

### Linting
You can find there are many Dockerfile linters are available. I liked the project called hadolint, it’s’ written in Haskell and fair easy to use.

```
$ hadolint Dockerfile

Dockerfile:1 DL3006 Always tag the version of an image explicitly
Dockerfile:3 DL3009 Delete the apt-get lists after installing something
Dockerfile:4 DL3008 Pin versions in apt get install. Instead of `apt-get install <package>` use `apt-get install <package>=<version>`
Dockerfile:4 DL3015 Avoid additional packages by specifying `--no-install-recommends`
Dockerfile:5 DL3008 Pin versions in apt get install. Instead of `apt-get install <package>` use `apt-get install <package>=<version>`
Dockerfile:5 DL3015 Avoid additional packages by specifying `--no-install-recommends`
Dockerfile:6 DL4006 Set the SHELL option -o pipefail before RUN with a pipe in it. If you are using /bin/sh in an alpine image or if your shell is symlinked to busybox then consider explicitly setting your SHELL to /bin/ash, or disable this check
```
* We can use --ignore flag in case you want to ignore some of the rules
* you can find the list of all rules here

### Building
When you build the image, also consider what tags you are providing.

* In this case, there’s no latest tag
```
# :latest doesn't care
$ docker build -t company/image_name:0.1 .
```

* if you don’t mention any tag, docker create the latest tag
```
# :latest was created
$ docker build -t company/image_name
```
if you again tag the image, it will not at all affect the latest
```
# :latest doesn't care
$ docker build -t company/image_name:0.2 .
```
* if you explicitly mention the latest tag then only it gets updated

```
# :latest was updated
$ docker build -t company/image_name:latest .
```