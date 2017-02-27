.. _Blowfish: `https://en.wikipedia.org/wiki/Blowfish_(cipher)`

Autentificación
===============

Para la autentificación de sysPass es posible utilizar varios métodos:

* Base de datos MySQL/MariaDB (por defecto)
* Directorio LDAP (OpenLDAP, eDirectory, Active Directory, freeIPA, etc)

.. note::

  Si está activada la opción de LDAP, la autentificación con base de datos es utilizada cuando el servicio de LDAP no está accesible o el usuario no existe.

Para la autentificación con base de datos se comprueba un hash generado con Blowfish_ de la clave del usuario, por lo que la clave **nunca** se almacena.

Si se utiliza LDAP:

* Se almacena el hash de la clave del usuario generado con Blowfish_ para comprobarlo en caso de fallo del servicio de LDAP.
* No es posible editar el login, nombre e email del usuario.
