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

Diagramas
=========

Proceso de Login
----------------

.. only:: lang_es

  .. uml::

    @startuml

    start

    :Login;

    :Leer datos usuario;

    :Recuperar clave maestra encriptada;

    note right
     Se usa una clave de 32 bytes AES de:
     clave + login + salt
    end note

    if (Tiene la clave guardada?) then (Sí)
      :Desencriptar clave maestra;
    else (No)
      :Login;

      :Solicitar clave maestra;

      if (Es clave maestra temporal?) then (Sí)
        :Verificar;
      else (No)
        :Verificar clave maestra;
      endif
    endif

    :Encriptar y guardar en la sesión del usuario;

    note right
     Se usa una clave de 32 bytes AES de:
     session_id  + salt
    end note

    stop

    @enduml

.. only:: lang_en

  .. uml::

    @startuml

    start

    :Login;

    :Get user data;

    :Retrieve the encrypted master key;

    note right
      Generated from a 32 bytes AES key using:
      password + login + hash
    end note

    if (Does it have the key saved?) then (Yes)
      :Decrypt the master key;
    else (No)
      :Login;

      :Request master key;

      if (Is it a temporary master key?) then (Yes)
        :Verify;
      else (No)
        :Verify master key;
      endif
    endif

    :Encrypt and save in the user's session;

    note right
      Generated from a 32 bytes AES key using:
      session_id + salt
    end note

    stop

    @enduml

Proceso de Clave Maestra
------------------------

.. only:: lang_es

  .. uml::

    @startuml

    start

    :Nueva clave maestra;

    :Iniciar transacción SQL;

    :Desencriptar cuentas
    y volver a encriptar;

    :Desencriptar cuentas del histórico
    y volver a encriptar;

    :Desencriptar campos personalizados
    y volver a encriptar;

    if (Han habido errores?) then (Sí)
      :Deshacer transacción;

      :Mostrar error y finalizar;
    else (No)
      :Finalizar transacción SQL;

      :Generar hash Blowfish y guardar en BD;

      note right
       Se genera:
       salt + hash (con salt)
       Se guarda en tabla config.
      end note

      :Actualizar fecha de generación en BD;

      note right
       Fuerza que los usuarios cambien la clave
      end note

      :Enviar correo;
    endif

    stop

    @enduml

.. only:: lang_en

  .. uml::

    @startuml

    start

    :New master key;

    :Begin SQL transaction;

    :Decrypt accounts
    and encrypt them again;

    :Decrypt accounts history
    and encrypt them again;

    :Decrypt custom fields
    and encrypt them again;

    if (Is there any error?) then (Yes)
      :Rollback transaction;

      :Display error and finalize;
    else (No)
      :Finalize SQL transaction;

      :Generate a Blowfish hash an save it in the DB;

      note right
        Generated using:
        salt + hash (with salt)
        Saved in the config table.
      end note

      :Update generation date in the DB;

      note right
       It forces to all users to change the master key
      end note

      :Send email;
    endif
    stop

    @enduml

Proceso de Clave Maestra Temporal
---------------------------------

.. only:: lang_es

  .. uml::

    @startuml

    start

    :Recuperar clave maestra en sesión;

    :Generar clave para
    encriptar la clave maestra;

    note right
      Se genera una clave AES de 32 bytes:
      session_id + salt
    end note

    :Guardar encriptada en BD;

    note right
     Se guarda en tabla config.
    end note

    :Generar hash Blowfish y guardar en BD;

    note right
     Se genera:
     salt + hash (con salt)
     Se guarda en tabla config.
    end note

    :Mostar clave de encriptación
    en la sesión actual.;

    note right
     Se elimina al salir
    end note

    :Enviar correo;

    stop

    @enduml

.. only:: lang_en

  .. uml::

    @startuml

    start

    :Retrieve the master key from the session;

    :Generate a 32 bytes key for
    encrypting the master key;

    note right
      Generated from a 32 bytes AES key using:
      session_id + salt
    end note

    :Save encrypted in the DB;

    note right
     Saved in the config table.
    end note

    :Generate a Blowfish hash and save it in the BD;

    note right
     Generated using:
     salt + hash (with salt)
     Saved in the config table.
    end note

    :Display the encryption key
    in the current session;

    note right
     It's deleted on log out
    end note

    :Send email;

    stop

    @enduml

Proceso PKI
-----------

.. only:: lang_es

  .. uml::

    @startuml

    == Inicialización ==
    Cliente -> Servidor: Solicita los datos de entorno con PKI
    Servidor --> Cliente: Envía la clave pública

    note right
      El par de claves (publica y privada)
      es creado si no existen
    end note

    == Enviando datos de formulario ==

    Cliente -> Servidor: Envia la clave encriptada

    note left: Usando la clave pública en Javascript

    Servidor --> Cliente: Desencripta la clave, la guarda y envía la respuesta

    @enduml

.. only:: lang_en

  .. uml::

    @startuml

    == Initialization ==
    Client -> Server: Requests environment data within PKI
    Server --> Client: Sends the public key

    note right
      Key pairs (public and private)
      are created if not exists
    end note

    == Sending form data ==

    Client -> Server: Sends password data encrypted

    note left: Using public key within Javascript

    Server --> Client: Decrypts the password, stores it and sends response

    @enduml

.. warning::

  Tener en cuenta que el mayor riesgo de seguridad está en los propios usuarios, ya que una clave comprometida puede causar una brecha de seguridad.

  Un servidor de sysPass comprometido puede ser peligroso si la base de datos está junto al servidor web, debido a que los datos de red pueden ser obtenidos por lo que las claves serían reveladas.
