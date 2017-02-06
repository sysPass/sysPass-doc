Permisos
========

Los permisos en sysPass se establecen en los perfiles de los usuarios. Por defecto sólo se puede realizar una búsqueda de cuentas.

Existen 29 tipos de permisos:

* **Cuentas**

  * Crear - permite crear cuentas
  * Ver - permite ver los detalles de las cuentas [#f1]_
  * Ver Clave - permite visualizar las clave de las cuentas [#f1]_
  * Editar - permite modificar las cuentas y sus archivos [#f1]_
  * Editar Clave - permite modificar las claves de las cuentas [#f1]_
  * Eliminar - permite eliminar las cuentas [#f1]_
  * Archivos - permite visualizar los archivos de las cuentas
  * Compartir Enlace - permite crear enlaces públicos
  * Privada - permite crear cuentas privadas
  * Privada para Grupo - permite crear cuentas privadas sólo para el grupo principal
  * Permisos - permite ver y modificar los permisos de las cuentas [#f1]_
  * Búsqueda Global - permite realizar una búsqueda en todas las cuentas excepto las privadas [#f2]_

* **Gestión**

  * Usuarios - permite acceso total a la gestión de usuarios [#f3]_
  * Grupos - permite acceso total a la gestión de grupos
  * Perfiles - permite acceso total a la gestión de perfiles
  * Categorías - permite acceso total a la gestión de categorías
  * Clientes - permite acceso total a la gestión de clientes
  * Campos Personalizados - permite acceso total a la gestión de campos personalizados
  * Autorizaciones API - permite acceso total a la gestión de autorizaciones API
  * Enlaces Públicos - permite acceso total a la gestión de enlaces públicos
  * Cuentas - permite acceso total a la gestión de cuentas
  * Archivos - permite acceso total a la gestión de archivos
  * Etiquetas - permite acceso total a la gestión de etiquetas

* **Configuración**

  * General - permite acceso total a la configuración del sitio, cuentas, wiki, ldap y correo
  * Encriptación - permite acceso total a la configuración de la clave maestra
  * Copia de Seguridad - permite acceso total a la realización de copias de seguridad [#f4]_
  * Importación - permite acceso total a la importación de archivos XML y CSV

* **Otros**

  * Registro de Eventos - permite acceso total al registro de eventos

A nivel de usuario es posible establecer los siguientes permisos:

* Admin Aplicacion: permite acceso total a todos los módulos de la aplicación
* Admin Cuentas: permite acceso total a todas las cuentas excepto las privadas

ACL
---

* Un usuario sólo puede visualizar o modificar las cuentas propias, de su grupo principal y las que tienen establecido el usuario o grupo secundario
* Un grupo puede contener varios usuarios, los cuales tendrán acceso a las cuentas de dicho grupo
* Una cuenta sólo puede ser modificada por los usuarios o grupos principales y los secundarios si está establecido el permiso de modificación en los accesos de la cuenta
* Las cuentas privadas sólo son accesibles por el propietario
* Las cuentas privadas para grupo sólo son accesibles por los usuarios el grupo principal

.. rubric:: Notas

.. [#f1] Sólo a las cuentas a las que el usuario y su grupo tienen acceso
.. [#f2] En caso de no tener acceso a la cuenta, sólo es posible realizar una "Solicitud de Modificación"
.. [#f3] Los usuarios "Admin Aplicación" no pueden ser modificados por otros usuarios
.. [#f4] Sólo los usuarios "Admin Aplicación" pueden descargar archivos de copia de seguridad o XML
