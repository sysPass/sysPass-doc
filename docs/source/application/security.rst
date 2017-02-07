Seguridad
=========

sysPass dispone de mecanismos de seguridad para mitigar cierto tipo de eventos y acciones que pueden comprometer la seguridad de la aplicación. Entre ellos se encuentran:

* Generación de token de seguridad para envío de formularios
* Comprobación del tipo de petición para cada formulario
* Eliminación de carácteres no deseados en los datos recibidos
* Forzado de tipos (type casting) en los datos recibidos
* Generación de hashes para los nombres de archivos de exportación y copia de seguridad
* Uso de cifrado PKI para envío de claves en formularios

A pesar de estas medidas, es necesario asegurar los componentes del servidor web y las comunicaciones mediante:

* Uso de HTTPS
* Restricción de acceso a los directorios "config" y "backup"

Para restringir el acceso a los directorios en Apache es posible utilizar los archivos ".htaccess" en cada directorio o en la configuración del sitio:

.. code:: Apache

  # En Apache 2.2
  <Directory ~ "/var/www/html/sysPass/(config|backup)">
    <Limit GET HEAD POST>
      Order Deny,Allow
      Deny from all
    </Limit>
  </Directory>

  # En Apache 2.4
  <Directory ~ "/var/www/html/sysPass/(config|backup)">
    Require all denied
  </Directory>

.. danger:: Es importante que el directorio "config" no sea accesible desde el servicio web, ya que puede revelar información importante.
