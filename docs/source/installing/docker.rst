.. _Docker: https://docs.docker.com/engine/installation/
.. _`contenedores Docker`: https://en.wikipedia.org/wiki/Docker_%28software%29
.. _`Docker Hub`: https://hub.docker.com/r/nuxsmin/docker-syspass/
.. _`Docker Compose`: https://docs.docker.com/compose/

Instalación con Docker
======================

La instalación con Docker_ permite mantener la aplicación aislada del sistema así como probar diferentes versiones sin tener que instalar ningún paquete adicional.

sysPass es posible ejecutarlo en `contenedores Docker`_ los cuales han sido preparados y comprobados para su correcto funcionamiento.

Las imágenes Docker se pueden obtenr desde `Docker Hub`_ las cuales son compiladas automáticamente desde los archivos Docker en https://github.com/nuxsmin/docker-syspass

Hay dos opciones para la instalación:

* Con `Docker Compose`_, el cual permite el despliegue completo de sysPass y la base de datos.
* Con Docker, es necesario desplegar sysPass y la base de datos por separado.

Docker Compose
--------------

Descargar el archivo
