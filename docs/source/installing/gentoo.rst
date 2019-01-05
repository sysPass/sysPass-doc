Instalación Gentoo
==================

.. warning::

  Only 2.0
  
Prerequisitos
-------------
* Servidor Web (Apache/Nginx/Lighttpd) con SSL habilitado.
* MariaDB o MySQL >= 5
* PHP >= 5.6 <= 7.0
* Módulos PHP
    * mysql
    * pdo
    * mcrypt
    * ldap (opcional)
    * XML
    * SimpleXML
    * Curl
    * Json
    * GD
    * intl
* Última versión de sysPass https://github.com/nuxsmin/sysPass/releases

Instalación de paquetes
-----------------------

.. code:: bash

    emerge --ask dev-db/mysql
    emerge --ask www-servers/apache

    PHP_TARGETS="php5-6"
    USE="apache2 pdo curl simplexml xml zlib crypt gd intl json opcache"
    emerge --ask dev-lang/php

Si se quiere habilitar LDAP es necesario compilar PHP con soporte para ldap:

.. code:: bash

    PHP_TARGETS="php5-6"
    USE="apache2 pdo curl ldap minimal simplexml xml zlib crypt gd intl json opcache"
    emerge --ask dev-lang/php

En los siguientes enlaces hay disponible documentación más extensa de cómo instalar y configurar dichos paquetes:

https://wiki.gentoo.org/wiki/Apache

https://wiki.gentoo.org/wiki/PHP

https://wiki.gentoo.org/wiki/MySQL

Configuración de Apache
-----------------------

Es necesario habilitar el módulo de PHP en Apache, por lo que editamos el archivo /etc/conf.d/apache2 y modificamos la variable APACHE2_OPTS añadiendo "-D PHP5":

.. code:: bash

  APACHE2_OPTS="... -D PHP5"

Iniciamos y establecemos el auto-inicio de Apache:

.. code:: bash

    rc-update add apached default
    rc-service apache2 start

Configuración de MySQL
----------------------

Establecemos la clave de root de MySQL:

.. code:: bash

    emerge --config dev-db/mysql

Iniciamos y establecemos el auto-inicio de MySQL:

.. code:: bash

    rc-update add mysql default
    rc-service mysql start

Securizamos la instalación de Mysql:

.. code:: bash

    mysql_secure_installation

Configuración de directorios y permisos
---------------------------------------

Crear un directorio para la aplicación en la raíz del servidor web:

.. code:: bash

    mkdir /var/www/localhost/syspass

Copiar y descomprimir el archivo sysPass en el directorio creado:

.. code:: bash

    cp sysPass.tar.gz /var/www/localhost/syspass
    cd /var/www/localhost/syspass
    tar xzf syspass.tar.gz

Cambiar el propietario del directorio 'syspass/config'. Ha de coincidir con el usuario del servidor web:

.. code:: bash

    chown apache /var/www/localhost/syspass/config
    chmod 750 /var/www/localhost/syspass/config

Crear y cambiar el propietario del directorio de copias de seguridad:

.. code:: bash

    mkdir var/www/localhost/syspass/backup
    chown apache /var/www/localhost/syspass/backup

Configuración del entorno
-------------------------

Abir un navegador y escribir la URL:

https://IP_O_NOMBRE_SERVIDOR/syspass/index.php

.. note::

  Seguir los pasos del instalador y tras la correcta finalización, ya es posible acceder a la aplicación

  Para saber cómo funciona sysPass ver :doc:`/application/index`

.. warning::

  Se recomienda leer las indicaciones de seguridad en :doc:`/application/security`
