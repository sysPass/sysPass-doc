CentOS 7 Installation
=====================

Prerequisites
-------------

* Web server (Apache/Nginx/Lighttpd) with SSL enabled.
* MariaDB >= 10.1
* PHP >= 7.0
* PHP modules
    * mysqlnd
    * curl
    * json
    * gd
    * xml
    * mbstring
    * intl
    * readline
    * ldap (optional)
    * mcrypt (optional for importing older XML export files)
* Latest sysPass version https://github.com/nuxsmin/sysPass/releases

Installation
------------

CentOS 7 package installation.

.. code:: bash

    yum install httpd php php-ldap php-mcrypt php-mbstring php-gd php-mysqlnd php-pdo php-json php-xml php-ldap php-xml mariadb-server wget

Automated start/stop Apache web server and MariaDB server.

.. code:: bash

    systemctl enable httpd.service
    systemctl enable mariadb.service
    systemctl start httpd.service
    systemctl start mariadb.service

Setting up MariaDB.

.. code:: bash

    /usr/bin/mysql_secure_installation

Enabling firewall ports.

.. code:: bash

    firewall-cmd --permanent --zone=public --add-service=http
    firewall-cmd --permanent --zone=public --add-service=https
    firewall-cmd --reload

Optional for enabling SSL.

In order to increase your sysPass instance security, please consider to use SSL. See :doc:`/application/security` and the following resources for Debian:

* Sites only accessible from LAN: https://doc.debian.org/configuration/Self-Signed_Certificate
* Sites accessible from Internet, you could use Let's Encrypt, see https://certbot.eff.org/

Directories and permissions
---------------------------

Create a directory for sysPass within the web server root.

.. code:: bash

    mkdir /var/www/html/syspass

Unpack sysPass files.

.. code:: bash

    cd /var/www/html/syspass
    tar xzf syspass.tar.gz

Setup directories permissions. The owner should match the web server running user.

.. code:: bash

    chown apache -R /var/www/html/syspass
    chmod 750 /var/www/html/syspass/app/config /var/www/html/syspass/app/backup

SELinux
-------

sysPass needs to be allowed to write its configuration and some other files (backup, cache, temp, etc). We have 2 choices:

.. note::

    Please, run only one of the choices

* Change SELinux's context and user:

.. code:: bash

    setsebool -P httpd_can_connect_ldap 1
    chcon -R -t httpd_sys_rw_content_t /var/www/html/syspass/app/{config,backup,cache,tmp}


* Disable SELinux by editing the file "/etc/sysconfig/selinux" and setting "SELINUX" variable's value to "permissive". You need to restart the system.

Installing dependencies
-----------------------

From sysPass root directory, download and install Composer (https://getcomposer.org/download/)

.. code:: bash

    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    php composer-setup.php
    php -r "unlink('composer-setup.php');"

Then install sysPass dependencies

.. code:: bash

    php composer.phar install --no-dev

Environment configuration
-------------------------

Please, point your web browser to the following URL and follow the installer steps

https://IP_OR_SERVER_ADDRESS/syspass/index.php


.. note::

  Seguir los pasos del instalador y tras la correcta finalización, ya es posible acceder a la aplicación

  Para saber cómo funciona sysPass ver :doc:`/application/index`

.. warning::

  Se recomienda leer las indicaciones de seguridad en :doc:`/application/security`
