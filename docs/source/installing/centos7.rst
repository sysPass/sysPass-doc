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

CentOS 7 package installation (http://wiki.centos.org/SpecialInterestGroup/SCLo).

.. code:: bash

    $ sudo yum -y install centos-release-scl.noarch
    $ sudo yum -y install rh-php73 rh-php73-php rh-php73-php-fpm httpd rh-mariadb103 wget
    $ sudo yum -y install rh-php73-php-gd rh-php73-php-intl rh-php73-php-json rh-php73-php-ldap rh-php73-php-mbstring rh-php73-php-mysqlnd rh-php73-php-opcache rh-php73-php-pdo rh-php73-php-xml rh-php73-php-zip

Automated start/stop Apache web server and MariaDB server.

.. code:: bash

  $ sudo systemctl enable --now httpd24-httpd.service rh-mariadb103-mariadb.service

Setting up MariaDB.

.. code:: bash

  $ sudo scl enable rh-mariadb103 mysql_secure_installation

Enabling firewall ports.

.. code:: bash

  $ sudo firewall-cmd --zone=public --add-service=http --add-service=https
  $ sudo firewall-cmd --runtime-to-permanent

.. include:: _ssl.rst

.. include:: _directories.rst

SELinux
-------

sysPass needs to be allowed to write its configuration and some other files (backup, cache, temp, etc). We have 2 choices:

.. note::

    Please, run only one of the choices

* Change the SELinux context of files:

.. code:: bash

  $ sudo setsebool -P httpd_can_connect_ldap 1
  $ sudo semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/html/syspass/app/(config|backup|cache|temp)(/.*)?"
  $ sudo restorecon -R -v /var/www/html/syspass


* Disable SELinux by editing the file "/etc/sysconfig/selinux" and setting "SELINUX" variable's value to "disabled". You need to restart the system. Until then you can use permissive mode which won't enforce the policies:

.. code:: bash

  $ sudo setenforce 0

.. include:: _dependencies.rst

.. include:: _environment.rst
