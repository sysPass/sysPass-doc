.. _rijndael-256: http://es.wikipedia.org/wiki/Advanced_Encryption_Standard
.. _CBC: http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation#Cipher-block_chaining_.28CBC.29
.. _Blowfish: `https://en.wikipedia.org/wiki/Blowfish_(cipher)`
.. _mcrypt: http://php.net/manual/en/book.mcrypt.php
.. _openssl_random_pseudo_bytes: http://php.net/manual/en/function.openssl-random-pseudo-bytes.php
.. _PKI: https://en.wikipedia.org/wiki/Public_key_infrastructure

Encriptación
============

La encriptación de sysPass está basada en rijndael-256_ en modo CBC_  mediante el uso del módulo mcrypt_ de PHP.

Los datos encriptados (hasta versión 2.0) son:

* Claves de las cuentas
* Datos de campos personalizados
* Exportación en formato XML de sysPass

Para hacer uso de la aplicación, por primera vez, es necesario conocer la clave maestra o la clave maestra temporal (ver :ref:`temporarymasterkey`), ya que sólo se almacena un hash generado mediante Blowfish_ con un salt generado usando el generador de números aleatorios MCRYPT_DEV_URANDOM. Para la generación del hash en Blowfish_ se utiliza un coste de 7 para las iteraciones del algoritmo.

Tras hacer login con la clave maestra, ésta se almacena en los datos del usuario. Para su almacenamiento encriptado con rijndael-256_ se utiliza una llave de 32 bytes generada con Blowfish_ usando la clave, el login del usuario y un salt generado con openssl_random_pseudo_bytes_ y almacenado en la configuración de sysPass bajo la etiqueta "passwordSalt".

En los siguientes inicios de sesión la clave maestra es recuperada desde los datos del usuario y desencriptada usando la clave, el login del usuario y el salt generado en la configuración de sysPass. Esta clave es almacenada en la sesión del usuario mediante la encriptación de la misma con una llave generada con Blowfish_ usando el ID de sesión de PHP y el salt de la aplicación.

.. note:: El ID de sesión de PHP es regenerado cada tiempo_máximo_sesion/2

En el caso de que la clave maestra sea cambiada se solicitará a todos los usuarios la nueva clave o una clave maestra temporal (ver :ref:`temporarymasterkey`).

Si un usuario canbia su clave de acceso, en el siguiente login, se le solicitará la clave anterior para poder obtener la clave maestra. Si no es posible obtener la clave maestra, se le solicitará.

.. _temporarymasterkey:

Clave Maestra Temporal
----------------------

Es posible generar una clave maestra temporal para su uso por los usuarios de la aplicación, así no es necesario conocer la clave maestra original.

Para la generación de la clave maestra temporal se utiliza la clave maestra original encriptada con rijndael-256_ y una llave de 32 bytes generada usando openssl_random_pseudo_bytes_ cuyo hash Blowfish_ es almacenado en la tabla "config" de la base de datos.

.. note:: Para la comprobación de la clave maestra temporal **sólo** se utiliza el hash generado con Blowfish_

PKI
---

Para mejorar la seguridad de los datos enviados, se hace uso de PKI_ para la encriptación de las claves que son enviadas desde los formularios de la aplicación.

Las claves pública y privada son generadas en el directorio "config" de la aplicación.


.. warning::

  Tener en cuenta que el mayor riesgo de seguridad está en los propios usuarios, ya que una clave comprometida puede causar una brecha de seguridad.

  Un servidor de sysPass comprometido puede ser peligroso si la base de datos está junto al servidor web, debido a que los datos de red pueden ser obtenidos por lo que las claves serían reveladas.
