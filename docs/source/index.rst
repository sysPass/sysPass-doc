.. warning:: Esta es una versión en desarrollo de la documentación de sysPass 2.1

.. container:: logo

  .. image:: _static/logo.png
      :width: 500px
      :alt: Logo sysPass
      :align: left

Introducción
============

sysPass es un gestor de claves web escrito en PHP que permite la gestión centralizada de claves en un entorno multiusuario.

Características
---------------

* Interfaz con Material Design Lite en HTML5 y Ajax
* Claves encriptadas con AES-256 CTR
* Multiusuario con gestión de usuarios, grupos y perfiles
* Gestión avanzada de perfiles con 29 niveles de acceso
* Autentificación con MySQL/MariaDB, OpenLDAP y Active Directory
* Notificaciones por email e in-app de actividad
* Enlaces públicos a cuentas sin necesidad de login
* Historial de cambios en cuentas
* Gestión de archivos asociados a cuentas con previsualización de imágenes
* Multilenguaje, con traducciones en Inglés, Catalán, Alemán, Polaco, Ruso, Francés y Holandés
* Enlace a Wiki externa e integración con API de DokuWiki
* Backup en formato portable y exportación en XML encriptado
* Registro de acciones y eventos con posibilidad de enviar a Syslog remoto en formato CEF
* Configurable y extensible mediante temas y plugins
* API para integración con otras aplicaciones
* Importación desde KeePass, KeePassX y CSV
* Instalación en un solo paso

Qué no hace sysPass
-------------------

* No guarda la clave maestra en el servidor
* No envía datos a ningún servicio externo
* No encripta las claves de las cuentas individualmente, se utiliza una clave maestra para todas
* No realiza cambios de clave en los servidores
* No encripta los datos de las cuentas, sólo la clave y los campos personalizados ya que no se podrían realizar búsquedas
* No es como APT: NO tiene poderes de super vaca!!

.. toctree::
    :maxdepth: 2
    :name: mastertoc

    installing/index
    configuration/index
    application/index
    updating/index
    faq
