Instalación Debian 9
====================

.. warning::

  Trabajo en curso

Prerequisitos
-------------

* Servidor Web (Apache/Nginx/Lighttpd) con SSL habilitado.
* MariaDB >= 10.1
* PHP >= 5.6 <= 7.0
* Módulos PHP
    * mysql
    * Curl
    * Json
    * GD
    * XML
    * mbstring
    * ldap (opcional)
    * mcrypt (si actualiza desde <= 2.0)
* Última versión de sysPass https://github.com/nuxsmin/sysPass/releases

Instalación
-----------

Instalación de paquetes en Debian GNU/Linux

.. code:: bash

    apt install apache2 libapache2-mod-php php php-curl php-mysqlnd php-curl \
    php-gd php-json mariadb-server php-ldap php-mbstring
    
    service apache2 restart

Opcional para habilitar LDAP

.. code:: bash

    apt-get install php5-ldap
    service apache2 restart

Opcional para habilitar SSL

Para aumentar la seguridad de tu instalación de sysPass, considera usar SSL. Ver :doc:`/application/security` y los siguientes recursos para Debian:

* Para sitios sólo accesibles desde LAN o para usarn un certificado autofirmado:: https://doc.debian.org/configuration/Self-Signed_Certificate
* Para sitios accesibles desde internet es posible utilizar LetsEncrypt, ver https://certbot.eff.org/

Configuración de directorios y permisos
---------------------------------------

Crear un directorio para la aplicación en la raíz del servidor web

.. code:: bash

    mkdir /var/www/html/syspass

Copiar y descomprimir el archivo sysPass en el directorio creado

.. code:: bash

    cp sysPass.tar.gz /var/www/html/syspass
    cd /var/www/html/syspass
    tar xzf syspass.tar.gz

Cambiar el propietario del directorio 'syspass/config'. Ha de coincidir con el usuario del servidor web

.. code:: bash

    chown www-data /var/www/html/syspass/config
    chmod 750 /var/www/html/syspass/config

Crear y cambiar el propietario del directorio de copias de seguridad

.. code:: bash

    mkdir /var/www/html/syspass/backup
    chown www-data /var/www/html/syspass/backup

Configuración del entorno
-------------------------

Abir un navegador y escribir la URL

https://IP_O_NOMBRE_SERVIDOR/syspass/index.php

.. note::

  Seguir los pasos del instalador y tras la correcta finalización, ya es posible acceder a la aplicación

  Para saber cómo funciona sysPass ver :doc:`/application/index`

.. warning::

  Se recomienda leer las indicaciones de seguridad en :doc:`/application/security`
