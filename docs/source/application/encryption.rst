.. _AES-256: http://es.wikipedia.org/wiki/Advanced_Encryption_Standard
.. _CTR: https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#Counter_.28CTR.29
.. _Blowfish: `https://en.wikipedia.org/wiki/Blowfish_(cipher)`
.. _OpenSSL: http://php.net/manual/en/book.openssl.php
.. _openssl_random_pseudo_bytes: http://php.net/manual/en/function.openssl-random-pseudo-bytes.php
.. _PKI: https://en.wikipedia.org/wiki/Public_key_infrastructure
.. _`Defuse/php-encryption`: https://github.com/defuse/php-encryption/blob/master/docs/CryptoDetails.md

Encriptación
============

.. warning::

  Si aún utiliza versiones de sysPass <= 2.0 se recomienda actualizar a la versión 2.1 para implementar las mejoras de seguridad en la encriptación (CVE-2017-5999)

La encriptación de sysPass está basada en AES-256_ en modo CTR_  mediante el uso del módulo OpenSSL_ de PHP. Para el manejo de los módulos y funciones de encriptación se utiliza la librería `Defuse/php-encryption`_

Los datos encriptados (hasta versión 2.0) son:

* Claves de las cuentas
* Datos de campos personalizados
* Exportación en formato XML de sysPass

Para hacer uso de la aplicación, por primera vez, es necesario conocer la clave maestra o la clave maestra temporal (ver :ref:`temporarymasterkey`), ya que sólo se almacena un hash generado mediante Blowfish_ con un salt generado usando el generador de números aleatorios MCRYPT_DEV_URANDOM. Para la generación del hash en Blowfish_ se utiliza un coste de 10 para las iteraciones del algoritmo.

Tras hacer login con la clave maestra, ésta se almacena en los datos del usuario. Para su almacenamiento encriptado genera una llave segura usando la clave, el login del usuario y un salt generado con openssl_random_pseudo_bytes_ y almacenado en la configuración de sysPass bajo la etiqueta "passwordSalt".

En los siguientes inicios de sesión la clave maestra es recuperada desde los datos del usuario y desencriptada usando la clave, el login del usuario y el salt generado en la configuración de sysPass. Esta clave es almacenada en la sesión del usuario mediante la encriptación de la misma con una llave segura usando ID de sesión de PHP y la hora UNIX de inicio de la sesión.

.. note::  La llave de sesión regenerada cada 120 segundos.

En el caso de que la clave maestra sea cambiada se solicitará a todos los usuarios la nueva clave o una clave maestra temporal (ver :ref:`temporarymasterkey`).

Si un usuario canbia su clave de acceso, en el siguiente login, se le solicitará la clave anterior para poder obtener la clave maestra. Si no es posible obtener la clave maestra, se le solicitará.

.. _temporarymasterkey:

Clave Maestra Temporal
----------------------

Es posible generar una clave maestra temporal para su uso por los usuarios de la aplicación, así no es necesario conocer la clave maestra original.

Para la generación de la clave maestra temporal se utiliza la clave maestra original encriptada con una llave segura protegida con una clave generada usando openssl_random_pseudo_bytes_ cuyo hash Blowfish_ es almacenado en la tabla "config" de la base de datos.

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
     Se usa una llave segura protegida con la clave:
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
     Se usa una llave segura protegida con la clave:
     session_id  + sid_start_time
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
      Generated a secure key protected by a password using:
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
      Generated a secure key protected by a password using:
      session_id + sid_start_time
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
      Se genera una llave segura protegida con la clave:
      random_hash + config_salt
    end note

    :Guardar encriptada en BD;

    note right
     Se guarda en tabla config.
    end note

    :Generar hash Blowfish de la clave y guardar en BD;

    note right
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

    :Generate password protected key for
    encrypting the master key;

    note right
      Generated from a password using:
      random_hash + config_salt
    end note

    :Save encrypted in the DB;

    note right
     Saved in the config table.
    end note

    :Generate a Blowfish hash and save it in the BD;

    note right
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
