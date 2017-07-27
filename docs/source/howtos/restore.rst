Cómo restaurar sysPass
======================

.. note::

  Este procedimiento requiere disponer de una copia de seguridad de la base de datos y de la aplicación

1. Restaurar la copia de la base de datos. Se puede realizar mediante la utilidad de copia de sysPass, usando MySQL Workbench o con la utilidad mysqldump
2. Crear el usuario de conexión (ver archivo "config.xml") y asignar permisos sobre la base de datos restaurada
3. Restaurar la copia de la aplicación
4. Acceder desde un navegador a la aplicación
