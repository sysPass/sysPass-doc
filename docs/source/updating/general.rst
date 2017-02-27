General
=======

Para la actualización de sysPass son necesarios los siguientes pasos:

1. Descargar la aplicación desde https://github.com/nuxsmin/sysPass/releases y descomprimir los archivos
2. Establecer el propietario y permisos del directorio de sysPass
3. Copiar los archivos ("config.xml", "key.pem" y "pubkey.pem") del directorio "config" de la versión actual a la nueva
4. Acceder desde un navegador a la aplicación

Si la aplicación requiere de actualización de la base de datos:

1. **Realizar una copia de seguridad de la base de datos**
2. Introducir el código de actualización que se encuentra en el archivo "config/config.xml" con la etiqueta "upgradeKey"

.. note:: Tras la actualización, se mostrará un mensaje y en el registro de eventos se pueden revisar los detalles de la actualización
