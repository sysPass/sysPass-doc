Preguntas Frecuentes
====================

¿Para qué sirve sysPass?
------------------------

sysPass un gestor de claves que permite almacenarlas de forma segura mediante encriptación de doble sentido con clave maestra. Las claves están asociadas a cuentas, las cuales tienen información detallada del propósito de la misma como: cliente, categoría, notas, archivos, etc.

La idea inicial era la de hacer accesible las claves de cuentas de acceso a servidores y servicios en un entorno multiusuario, de forma segura y que pudiera ser exportable a una memoria externa.

¿Dónde se puede instalar sysPass?
---------------------------------

La aplicación pueder ser instalada en cualquier sistema que disponga de Apache, PHP y MySQL.

¿Cómo se instala sysPass?
-------------------------

Bajar la aplicación desde https://github.com/nuxsmin/sysPass/releases/latest y seguir los pasos de :doc:`/installing/index`

¿Qué métodos de autentificación utiliza?
----------------------------------------

sysPass utiliza MySQL/MariaDB o LDAP como “backends” de autentificación.

En caso de utilizar LDAP, si no es posible conectar con el servidor de LDAP, se utilizará MySQL como “backend” utilizando los datos de acceso de la última sesión iniciada en LDAP.

Para más información ver: :doc:`/application/authentication`

¿Para qué sirve la encriptación?
--------------------------------

La encriptación de las claves en la base de datos permite que, en caso de que alguien tenga acceso a ésta o si se realiza una exportación de la misma, no sea legible sin la clave maestra.

Esta solución es muy conveniente para ejecutar la aplicación desde un pendrive, para casos en los que no es posible acceder al servidor donde se almacena la aplicación.
¿Qué tipo de encriptación utiliza?

El esquema de cifrado utilizado es rijndael-256_ en modo CBC_.

Para más información ver: :doc:`/application/encryption`

.. _rijndael-256: http://es.wikipedia.org/wiki/Advanced_Encryption_Standard
.. _CBC: http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation#Cipher-block_chaining_.28CBC.29

¿Qué quiere decir “portable”?
-----------------------------

Este término se refiere a aquellas aplicaciones que pueden ser ejecutadas sin realizar la instalación de componentes en el sistema operativo que la ejecuta.

Esta aplicación es posible hacerla “portable” mediante la instalación de apache, php y mysql en una unidad externa. Para ello, es posible utilizar cualquiera de los paquetes LAMP_ disponibles como WAMP, XAMPP, etc.

.. _LAMP: http://es.wikipedia.org/wiki/LAMP

La herramienta de backup permite realizar una copia de todo el entorno (aplicación y base de datos), para poder instalarlo en la unidad externa. La encriptación de los datos de las cuentas, hace que la seguridad sea muy alta en caso de pérdida de la unidad extraíble.

¿Hay una clave maestra por cada cuenta/usuario?
-----------------------------------------------

La clave maestra es global para todas las cuentas y usuarios.

Cada vez que un usuario se dé de alta, cambie su clave personal o se reestablezca la clave maestra, será necesario que éste la introduzca en el siguiente inicio de sesión.

Cada vez que se produzca un cambio de clave maestra, los usuarios que tengan iniciada la sesión, sólo podrán visualizar las cuentas hasta que introduzca la nueva clave.

Para más información ver: :doc:`/application/encryption`

¿Qué son los enlaces a Wiki?
----------------------------

Nos permiten enlazar las cuentas con un determinado patrón de nombre, a una Wiki externa que permita pasar el nombre de la cuenta como parámetro en la URL.

Hay dos tipos de enlaces, uno que enlaza con la página de búsqueda de la Wiki y pasa como parámetro el nombre del cliente, y otro, que enlaza directamente con la página de la cuenta.

¿Para qué sirven las categorías?
--------------------------------

Las categorías tienen como objetivo el clasificar las cuentas para poder realizar búsquedas más precisas.

¿Para qué sirven los grupos de usuarios?
----------------------------------------

Estos grupos se utilizan para dar acceso a los usuarios a las cuentas que tengan dicho grupo como principal o secundario.

¿Para qué sirve el campo cliente?
---------------------------------

Al igual que las categorías, es posible hacer búsquedas basadas en el cliente. Este campo se puede tratar de forma genérica como departamento, empresa, división, etc.

En futuras versiones se podrán asociar usuarios a clientes.

¿Existe un histórico de cuentas?
--------------------------------

Sí, cada vez que se realiza una modificación de una cuenta, se realiza una copia del estado anterior de la misma.

En los detalles de la cuenta se puede visualizar cada registro del histórico de una cuenta. Si la clave maestra con la que fue guardada la cuenta en dicho punto no conincide con la actual, no se podrá mostrar.

¿Para qué sirven los perfiles?
------------------------------

Los perfiles son usados para definir las acciones que pueden realizar los usuarios.

Existen 29 niveles de acceso que pueden ser activados de forma conjunta, permitiendo así definir a qué partes de la aplicación pueden acceder los usuarios con dicho perfil.

¿Qué es el modo mantenimiento?
------------------------------

Este modo se utiliza para impedir que los usuarios utilicen la aplicación en las ocasiones en las que se estén realizando operaciones sobre la Base de Datos, actualizaciones, etc.

El usuario que active el modo matenimiento será el único que puede utilizar la aplicación hasta el cierre de sesión. Después de ello es necesario desactivarlo en el archivo "config/config.xml" bajo la etiqueta "maintenance"

¿Puedo cambiar la Clave Maestra?
--------------------------------

Sí, para ello es necesario conocer la actual. Se recomienda realizar una copia de seguridad de la Base de Datos.

No recuerdo la Clave Maestra, ¿Puedo desencriptar las claves?
-------------------------------------------------------------

No, no es posible visualizar una clave sin la Clave Maestra.

¿Funciona el backup en Windows?
-------------------------------

Sí, desde la versión 1.1 se utiliza la librería PHAR de PHP para realizar los backups.

El lenguaje no cambia
---------------------

Revisa las locales instaladas en tu sistema (servidor), porque sysPass usa el sistema de internacionalización `GNU gettext`_.

.. _`GNU gettext`: https://en.wikipedia.org/wiki/Gettext

Las locales deben de ser de la variante UTF-8.

What are these strange characters in password fields?
-----------------------------------------------------

Don't worry about them, your password is okay. It's a security mechanism by which the passwords entered in a form field are automatically encrypted using RSA encryption before sending over the HTTP channel. Then, on server side, they are decrypted and stored/used as they were entered.

Further info on: :doc:`/application/encryption`
