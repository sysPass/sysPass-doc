Instalación Debian 9
====================

.. warning::

  Work in progress

Prerequisites
-------------

* Web server (Apache/Nginx/Lighttpd) with SSL enabled.
* MariaDB >= 10.1
* PHP >= 7.0
* PHP modules
    * mysql
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

Debian GNU/Linux package installation

.. code:: bash

    apt install locales apache2 libapache2-mod-php7.0 php-pear php7.0 php7.0-cgi php7.0-cli \
    php7.0-common php7.0-fpm php7.0-gd php7.0-json php7.0-mysql php7.0-readline \
    php7.0-curl php7.0-intl php7.0-ldap php7.0-mcrypt php7.0-xml php7.0-mbstring

    service apache2 restart

Optional for enabling SSL

In order to increase your sysPass instance security, please consider to use SSL. See :doc:`/application/security` and the following resources for Debian:

* Sites only accessible from LAN: https://doc.debian.org/configuration/Self-Signed_Certificate
* Sites accessible from Internet, you could use Let's Encrypt, see https://certbot.eff.org/

Directories and permissions
---------------------------

Create a directory for the application in the web server root directory

.. code:: bash

    mkdir /var/www/html/syspass

Copy and unpackage sysPass file in the created directory

.. code:: bash

    cp sysPass.tar.gz /var/www/html/syspass
    cd /var/www/html/syspass
    tar xzf syspass.tar.gz

Change the owner of 'syspass/app/config' and 'syspass/app/backup'. It should match with the web server user

.. code:: bash

    chown www-data /var/www/html/syspass/app/config /var/www/html/syspass/app/backup
    chmod 750 /var/www/html/syspass/app/config /var/www/html/syspass/app/backup

Installing dependencies
-----------------------

From sysPass root directory, download and install Composer (https://getcomposer.org/download/)

.. code:: bash

    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php -r "if (hash_file('sha384', 'composer-setup.php') === '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    php composer-setup.php
    php -r "unlink('composer-setup.php');"

Then install sysPass dependencies

.. code:: bash

    php composer.phar install --no-dev


Environment configuration
-------------------------

Please, point your web browser to the following URL and follow the installer steps

https://IP_O_NOMBRE_SERVIDOR/syspass/index.php

.. note::

  More about how sysPass works on :doc:`/application/index`

.. warning::

  Please check out the security notices on :doc:`/application/security`
