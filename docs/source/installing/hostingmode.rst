Modo Hosting
------------

El modo hosting es para aquellas instalaciones que se ejecutan en un hosting externo en las que no es posible crear la base de datos ni el usuario de conexión a la misma.

.. note:: **No se creará la base de datos (sí las tablas) ni el usuario de conexión**

Los pasos para realizar la instalación son los siguientes:

* Crear un usuario/clave en el panel del hosting.
* Crear la base de datos de sysPass (no crear tablas) y dar permisos al usuario anterior.
* Iniciar la instalación de sysPass (borrar el archivo "config/config.xml" si existe) y utilizar el usuario/clave creados como usuario de sysPass (los dos primeros campos).
* Indicar el usuario con permisos de administración de MySQL/MariaDB (puede ser el mismo de antes si tiene suficientes permisos), para realizar la creación de tablas en la base de datos de sysPass. Este usuario es sólo para la instalación y normalmente en los hostings suele ser el usuario/clave de gestión.
* Si hay conexión con la base de datos y los permisos son correctos, la instalación debe de finalizar correctamente.

.. note:: En caso de errores, verificar el archivo de registro del servidor web.
