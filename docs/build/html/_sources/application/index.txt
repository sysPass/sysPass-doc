.. _application:

Aplicación
===========

sysPass es una aplicación que utiliza una base de datos MySQL/MariaDB para almacenar los datos de todos sus componentes excepto la configuración, que es almacenada en un archivo XML dentro del directorio "config".

.. warning:: Es importante que el directorio "config" no sea accesible desde el servicio web, ya que puede revelar información importante.

.. toctree::
    :maxdepth: 2
    :caption: Cómo funciona

    encryption
    authentication
    authorization
    permissions
    searching
    api
