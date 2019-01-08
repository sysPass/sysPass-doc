.. _Blowfish: `https://en.wikipedia.org/wiki/Blowfish_(cipher)`

Authentication
==============

For sysPass authentication it could be possible to use several methods:

* MySQL/MariaDB database (by default)
* LDAP directory (OpenLDAP, eDirectory, Active Directory, freeIPA, etc)

.. note::

  If LDAP option is enabled, the database authentication is used when the LDAP service is unavailable or the user doesn't exist.

For the database authentication, a generated Blowfish_ hash from user's password is checked, so the password is **never** stored.

If LDAP is enabled:

* The user's Blowfish_ generated hash is stored in order to check it, if the LDAP service is unavailable.
* Neither the user's login nor name nor email can be modified.
