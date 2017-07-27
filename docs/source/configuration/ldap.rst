Configuración de LDAP
=====================

Active Directory
----------------

Consejos
________

* Comprobar que el usuario de conexión es miembro del grupo "Operadores de Cuenta"

OpenLDAP
--------

Para configurar un servidor de OpenLDAP correctamente, puedes seguir el siguiente artículo en https://wiki.debian.org/LDAP/OpenLDAPSetup en el que se describen los pasos para configurar un servidor totalmente operativo en distribuciones Debian y derivadas.

En OpenLDAP, para usar la característica de pertenecia a grupo, es necesario añadir un 'overlay' llamado 'membeof'. Es un módulo que añade un atributo interno a los usuarios que son miembros de un grupo.

Estos son los pasos para configurar el módulo:

* Crear un archivo 'ldap_memberof_add.ldif' con este contenido: ::

    dn: cn=module,cn=config
    objectClass: olcModuleList
    cn: module
    olcModulePath: /usr/lib/ldap
    olcModuleLoad: memberof

* Crear un archivo 'ldap_memberof_config.ldif' con este contenido: ::

    dn: olcOverlay=memberof,olcDatabase={1}hdb,cn=config
    objectClass: olcMemberOf
    objectClass: olcOverlayConfig
    objectClass: olcConfig
    objectClass: top
    olcOverlay: memberof
    olcMemberOfDangling: ignore
    olcMemberOfRefInt: TRUE
    olcMemberOfGroupOC: groupOfNames
    olcMemberOfMemberAD: member
    olcMemberOfMemberOfAD: memberOf

* Modificar la configuración de LDAP con estos comandos: ::

    ldapadd -D cn=admin,cn=config -w "password" -H ldapi:/// -f memberof_add.ldif
    ldapadd -D cn=admin,cn=config -w "password" -H ldapi:/// -f memberof_config.ldif

Consejos
--------

* Comprobar que si el usuario 'admin' de sysPass coincide con el de LDAP, es necesario añadir este usuario al grupo de LDAP que tiene permisos de acceso a sysPass.
* El nombre y email de los usuarios de LDAP son obtenidos de los atributos 'displayname','fullname' y 'mail'.
* Es posible usar ldaps configurando la URI de conexión como 'ldaps:/ /mi_servidor_ldap'.
* Puedes instalar phpLDAPadmin_ para crear y administrar objetos de LDAP.

.. _phpLDAPadmin: http://phpldapadmin.sourceforge.net/wiki/index.php/Main_Page

Enlaces
-------

* Wiki de LDAP en Debian: https://wiki.debian.org/LDAP/OpenLDAPSetup
* Configuración de 'memberof': http://www.cbjck.de/2012/05/enabling-the-memberof-overlay-for-openldap/
