CentOS 7.x Installation
=======================

Prerequisites
-------------

* Web server (Apache/Nginx/Lighttpd) with SSL enabled.
* MariaDB >= 10.1
* PHP >= 7.0 (7.1 or above recommended)
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

CentOS 7 package installation (https://www.softwarecollections.org/en/scls/rhscl/rh-php70/).

.. code:: bash

    $ sudo yum -y install centos-release-scl.noarch
    $ sudo yum -y install rh-php71 rh-php71-php rh-php71-php-fpm httpd rh-mariadb102 wget
    $ sudo yum -y install rh-php71-php-gd rh-php71-php-intl rh-php71-php-json rh-php71-php-ldap rh-php71-php-mbstring rh-php71-php-mysqlnd rh-php71-php-opcache rh-php71-php-pdo rh-php71-php-xml rh-php71-php-zip

Automated start/stop Apache web server and MariaDB server.

.. code:: bash

  $ sudo systemctl enable httpd.service
  $ sudo systemctl enable mariadb.service
  $ sudo systemctl start httpd.service
  $ sudo systemctl start mariadb.service

Setting up MariaDB.

.. code:: bash

  $ sudo /usr/bin/mysql_secure_installation

Enabling firewall ports.

.. code:: bash

  $ sudo firewall-cmd --permanent --zone=public --add-service=http
  $ sudo firewall-cmd --permanent --zone=public --add-service=https
  $ sudo firewall-cmd --reload

Optional for enabling SSL.

In order to increase your sysPass instance security, please consider to use SSL. See :doc:`/application/security` and the following resources for Debian:

* Sites only accessible from LAN: https://doc.debian.org/configuration/Self-Signed_Certificate
* Sites accessible from Internet, you could use Let's Encrypt, see https://certbot.eff.org/

Directories and permissions
---------------------------

Create a directory for sysPass within the web server root.

.. code:: bash

  $ sudo mkdir /var/www/html/syspass

Unpack sysPass files.

.. code:: bash

  $ sudo cd /var/www/html/syspass
  $ sudo tar xzf syspass.tar.gz

Setup directories permissions. The owner should match the web server running user.

.. code:: bash

  $ sudo chown apache -R /var/www/html/syspass
  $ sudo chmod 750 /var/www/html/syspass/app/config /var/www/html/syspass/app/backup

SELinux
-------

sysPass needs to be allowed to write its configuration and some other files (backup, cache, temp, etc). We have 2 choices:

.. note::

    Please, run only one of the choices

* Change SELinux's context and user:

.. code:: bash

  $ sudo setsebool -P httpd_can_connect_ldap 1
  $ sudo chcon -R -t httpd_sys_rw_content_t /var/www/html/syspass/app/{config,backup,cache,tmp}


* Disable SELinux by editing the file "/etc/sysconfig/selinux" and setting "SELINUX" variable's value to "permissive". You need to restart the system.

Installing dependencies
-----------------------

From sysPass root directory, download and install Composer (https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md)

Create a bash script called "install_composer.sh" and paste the following code in it:

.. code:: bash

  #!/bin/sh
  EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

  if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
  then
      >&2 echo 'ERROR: Invalid installer signature'
      rm composer-setup.php
      exit 1
  fi

  php composer-setup.php --quiet
  RESULT=$?
  rm composer-setup.php
  exit $RESULT

.. code:: bash

  $ chmod +x install_composer.sh
  $ ./install_composer.sh

Then install sysPass dependencies

.. code:: bash

  $ php composer.phar install --no-dev

Environment configuration
-------------------------

Please, point your web browser to the following URL and follow the installer steps

https://IP_OR_SERVER_ADDRESS/syspass/index.php


.. note::

  More information about how sysPass works on :doc:`/application/index`

.. warning::

  It's very advisable to take a look to security advices on :doc:`/application/security`
