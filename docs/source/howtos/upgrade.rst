Cómo probar una actualización de sysPass
========================================

.. note::

  Este procedimiento indica los pasos a seguir para probar una actualización de sysPass sin modificar la instalación actual

1. Realizar una copia de la base de datos. Se puede realizar mediante la utilidad de copia de sysPass, usando MySQL Workbench o con la utilidad mysqldump
2. Crear una nueva base de datos (ej. syspass21)
3. Crear un usuario (ej. sp_admin21) y asignar permisos sobre la base de datos creada
4. Importar la copia de la base de datos en la nueva. Es posible utilizar las utilidades mencionadas
5. Crear un nuevo directorio y descomprimir la nueva versión [#f1]_
6. Copiar todos los archivos del directorio "config" a la nueva ruta y comprobar los permisos [#f1]_
7. Modificar el archivo "config/config.xml" para cambiar los datos de acceso a la base de datos ("dbname", "dbuser" y "dbpass"). Comprobar que "dbHost" es correcto
8. Acceder desde un navegador a la aplicación y seguir los pasos de actualización

.. rubric:: Notas

.. [#f1] Ver :doc:`/installing/index` para más detalles
