.. _Docker: https://docs.docker.com/engine/installation/
.. _`contenedores Docker`: https://en.wikipedia.org/wiki/Docker_%28software%29
.. _`Docker Hub`: https://hub.docker.com/r/nuxsmin/docker-syspass/
.. _`Docker Compose`: https://docs.docker.com/compose/
.. _`Debian 8`: https://www.debian.org/

Instalación con Docker
======================

La instalación con Docker_ permite mantener la aplicación aislada del sistema así como probar diferentes versiones sin tener que instalar ningún paquete adicional.

sysPass es posible ejecutarlo en `contenedores Docker <https://en.wikipedia.org/wiki/Docker_%28software%29>`_ los cuales han sido preparados con `Debian 8`_ y comprobados para su correcto funcionamiento, sin **realizar compilaciones de paquetes**.

Las imágenes Docker se pueden obtener desde `Docker Hub`_ las cuales son compiladas automáticamente desde los archivos Docker en https://github.com/nuxsmin/docker-syspass

Hay dos opciones para la instalación:

* Con `Docker Compose`_, el cual permite el despliegue completo de sysPass y la base de datos.
* Con Docker_, es necesario desplegar sysPass y la base de datos por separado.

Docker Compose
--------------

Crear el archivo "docker-compose.yml" y ejecutar docker-compose:

.. literalinclude:: ../_src/docker-compose.yml
  :language: yaml

.. code:: bash

  docker-compose -p syspass -f docker-compose.yml up -d

Esto descargará la imagen de versión estable de sysPass y de la base de datos MySQL.

.. note::
  Al utilizar Docker Compose, se crea automáticamente una red independiente para los contenedores de sysPass y es posible utilizar resolución DNS.

  El contenedor de sysPass contiene dos volúmenes: uno para el directorio "config" y otro para "backup"

.. warning:: El contenedor de sysPass publicará los puertos 80 y 443 del host

Docker
------

Para obtener las imágenes independientes es necesario ejecutar los siguientes comandos:

.. code:: bash

  docker run -d --name syspass-db -h syspass-db nuxsmin/docker-syspass:mysql
  docker run -d --name syspass-app -h syspass-app --link syspass-db nuxsmin/docker-syspass:latest

Acceso
------

Los datos de acceso a la base de datos son:

* Host: syspass-db
* Usuario: root
* Clave: syspass

.. container:: alert alert-success

  Es posible instalar otras imágenes de sysPass en `Docker Hub`_

.. note::

  Seguir los pasos del instalador y tras la correcta finalización, ya es posible acceder a la aplicación

  Para saber cómo funciona sysPass ver :doc:`/application/index`

.. warning::

  Se recomienda leer las indicaciones de seguridad en :doc:`/application/security`
