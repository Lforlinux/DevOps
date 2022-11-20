 1  useradd nagios
    2  groupadd nagcmd
    3  usermod -G nagcmd nagios
    4  usermod -G nagcmd apache
    5  mkdir /root/nagios
    6  cd /root/nagios
    7  wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.5.tar.gz
    8  wget https://nagios-plugins.org/download/nagios-plugins-2.2.1.tar.gz
    9  tar -xvf nagios-4.4.5.tar.gz
   10  tar -xvf nagios-plugins-2.2.1.tar.gz
   11  cd nagios-4.4.5/
   12  ./configure --with-command-group=nagcmd
   13  make all
   14  make install
   15  make install-init
   16  make install-commandmode
   17  cat Makefile
   18  make install-config
   19  cat /usr/local/nagios/etc/objects/contacts.cfg
   20   make install-webconf
   21  htpasswd -s -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
   22  htpasswd -s -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
   23  service httpd start
   24  systemctl start httpd.service
   25  cd /root/nagios
   26  cd nagios-plugins-2.2.1/
   27  ./configure --with-nagios-user=nagios --with-nagios-group=nagios
   28  make
   29  make install
   30  /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
   31  systemctl enable nagios
   32  systemctl enable httpd
   33  systemctl start nagios.service
   34  history