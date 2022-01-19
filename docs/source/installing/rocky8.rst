Rocky 8 Installation
=======================

Prerequisites
-------------

* Web server (Apache/Nginx/Lighttpd) with SSL enabled.
* MariaDB >= 10.1
* PHP >= 7.0 (7.1 or above recommended)
* PHP modules
    * mysqlnd
    * curl (provided in php-common)
    * json
    * gd
    * xml
    * mbstring
    * intl
    * readline (provided in php-cli)
    * ldap (optional)
    * mcrypt (optional for importing older XML export files)
* Package with latest sysPass version https://github.com/nuxsmin/sysPass/releases/latest
* Or clone sysPass repository from GitHub https://github.com/nuxsmin/sysPass.git

Installation
------------

Rocky 8 package installation. First configure dnf modules to use php 7.4 then install all packages needed from a base server installation. This example uses httpd; swap for your prefered webserver.

.. code:: bash

    # Check php modules installed and used
    $ sudo dnf module list php
    # Disable php 7.2
    $ sudo dnf module disable php:7.2
    # Enable php 7.4
    $ sudo dnf module enable php:7.4
    # Install packages
    $ sudo dnf install httpd mariadb-server php php-mysqlnd php-json php-gd php-xml php-mbstring php-intl  php-common php-cli tar policycoreutils-python-utils


Start and enable MariaDB server.

.. code:: bash

  $ sudo systemctl enable --now mariadb.service

Setting up MariaDB. Change the password and follow the prompts.

.. code:: bash

  $ sudo mysql_secure_installation

Enabling firewall ports.

.. code:: bash

  $ sudo firewall-cmd --zone=public --add-service=http --add-service=https --permanent
  $ sudo firewall-cmd --reload

.. include:: _ssl.rst

.. include:: _directories.rst

.. include:: _dependencies.rst

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


HTTP
-------

After installation, enable and start your webserver. This example uses apache.

.. code:: bash

  $ sudo systemctl enable --now httpd

.. include:: _environment.rst
