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
* Package with latest sysPass version https://github.com/nuxsmin/sysPass/releases/latest
* Or clone sysPass repository from GitHub https://github.com/nuxsmin/sysPass.git

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

.. include:: _ssl.rst

.. include:: _directories.rst

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

.. include:: _dependencies.rst

.. include:: _environment.rst
