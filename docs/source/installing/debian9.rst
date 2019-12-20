Debian 9 Installation
=====================

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
* Package with latest sysPass version https://github.com/nuxsmin/sysPass/releases/latest
* Or clone sysPass repository from GitHub https://github.com/nuxsmin/sysPass.git

Installation
------------

Debian GNU/Linux package installation.

.. code:: bash

  $ sudo apt install locales apache2 libapache2-mod-php7.0 php-pear php7.0 php7.0-cgi php7.0-cli php7.0-common php7.0-fpm php7.0-gd php7.0-json php7.0-mysql php7.0-readline php7.0 curl php7.0-intl php7.0-ldap php7.0-mcrypt php7.0-xml php7.0-mbstring
  $ sudo service apache2 restart

.. include:: _ssl.rst

.. include:: _directories.rst

.. include:: _dependencies.rst

.. include:: _environment.rst
