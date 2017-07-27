Instalación CentOS 7
====================

Prerequisitos
-------------

* Servidor Web (Apache/Nginx/Lighttpd) con SSL habilitado.
* MariaDB o MySQL >= 5
* PHP >= 5.6 <= 7.0
* Módulos PHP
    * Mysql
    * mcrypt
    * ldap (opcional)
    * SimpleXML
    * XML
    * Curl
    * Json
    * GD
    * PDO
    * mbstring
* Última versión de sysPass https://github.com/nuxsmin/sysPass/releases

Instalación
-----------

Instalación de paquetes

.. code:: bash

    yum install httpd php-mysql php-pdo php-ldap php-gd php-pdo php-xml php-mbstring mariadb-server mariadb wget

Para iniciar y auto-iniciar el servidor web Apache:

.. code:: bash

    systemctl enable httpd.service
    systemctl start httpd.service

Para iniciar y auto-iniciar el servidor MariaDB:

.. code:: bash

    systemctl enable mariadb.service
    systemctl start mariadb.service

Necesitamos securizar el servidor MariaDB:

.. code:: bash

    /usr/bin/mysql_secure_installation


Instalación del repositorio EPEL para módulo de encriptación
------------------------------------------------------------

Descargar e instalar el RPM para el repositorio de EPEL:

.. code:: bash

    wget http://dl.fedoraproject.org/pub/epel/beta/7/x86_64/epel-release-7-0.2.noarch.rpm
    yum install epel-release-7-0.2.noarch.rpm
    yum install php-mcrypt
    systemctl restart httpd.service

Habilitar los puertos en el firewall
------------------------------------
Añadir reglas en el firewall:

.. code:: bash

    firewall-cmd --permanent --zone=public --add-service=http
    firewall-cmd --permanent --zone=public --add-service=https
    firewall-cmd --reload

Configuración de directorios y permisos
---------------------------------------

Crear un directorio para la aplicación en la raíz del servidor web:

.. code:: bash

    mkdir /var/www/html/syspass

Copiar y descomprimir el archivo sysPass en el directorio creado:

.. code:: bash

    cp sysPass.tar.gz /var/www/html/syspass
    cd /var/www/html/syspass
    tar xzf syspass.tar.gz

Cambiar el propietario del directorio 'syspass/config'. Ha de coincidir con el usuario del servidor web:

.. code:: bash

    chown apache /var/www/html/syspass/config
    chmod 750 /var/www/html/syspass/config

Crear y cambiar el propietario del directorio de copias de seguridad:

.. code:: bash

    mkdir var/www/html/syspass/backup
    chown apache /var/www/html/syspass/backup

Modificando SELinux
-------------------

Para permitir a sysPass escribir su configuración y backups, tenemos dos opciones:

.. note::

    Elegir una de las dos opciones

* Cambiar el usuario y contexto de SELinux para hacer escribibles los directorios de config y backups:

.. code:: bash

    chcon -R -t httpd_sys_rw_content_t /var/www/html/sysPass/config/
    chcon -R -t httpd_sys_rw_content_t /var/www/html/sysPass/backup/
    mkdir /var/www/html/sysPass/tmp && chcon -R -t httpd_sys_rw_content_t /var/www/html/sysPass/tmp

* Deshabilitar SELinux editando el archivo '/etc/sysconfig/selinux' y cambiar el valor de la variable "SELINUX" a "permissive" y reiniciar el sistema.

Configuración del entorno
-------------------------

Abir un navegador y escribir la URL:

https://IP_O_NOMBRE_SERVIDOR/syspass/index.php

.. note::

  Seguir los pasos del instalador y tras la correcta finalización, ya es posible acceder a la aplicación

  Para saber cómo funciona sysPass ver :doc:`/application/index`

.. warning::

  Se recomienda leer las indicaciones de seguridad en :doc:`/application/security`
