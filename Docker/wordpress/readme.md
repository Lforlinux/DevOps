create a directory structure for WordPress on your server:
```
mkdir ~/wordpress
mkdir -p ~/wordpress/database
mkdir -p ~/wordpress/html
```

Next, create a MariaDB container with name wordpressdb by running the following command:

```
docker run -e MYSQL_ROOT_PASSWORD=root-password -e MYSQL_USER=wpuser -e MYSQL_PASSWORD=password -e MYSQL_DATABASE=wpdb -v /root/wordpress/database:/var/lib/mysql --name wordpressdb -d mariadb
```

In the above command, here are the variables defined:

MYSQL_ROOT_PASSWORD: This option will configure MariaDB root password.
MYSQL_USER: This will create a new wpuser for WordPress.
MYSQL_PASSWORD: This will set the password for wpuser.
MYSQL_DATABASE: This will create a new database named wpdb for WordPress.
-v /root/wordpress/database:/varlib/mysql: This will link the database directory to the mysql directory.


Next, check the IP address of MariaDB container with the following command:
```
docker inspect -f '{{ .NetworkSettings.IPAddress }}' wordpressdb
```
Now, connect to your MariaDB container using the database user and password:

```
mysql -u wpuser -h 172.17.0.2 -p
Enter password:
```

Create a WordPress

```
docker run -e WORDPRESS_DB_USER=wpuser -e WORDPRESS_DB_PASSWORD=password -e WORDPRESS_DB_NAME=wpdb -p 8081:80 -v /root/wordpress/html:/var/www/html --link wordpressdb:mysql --name wpcontainer -d wordpress
```

Now browse the wordpress using pip:8081

