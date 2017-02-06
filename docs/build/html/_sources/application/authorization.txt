.. _`Auth Basic`: https://en.wikipedia.org/wiki/Basic_access_authentication
.. _2FA: https://en.wikipedia.org/wiki/Multi-factor_authentication
.. _OTP: https://en.wikipedia.org/wiki/One-time_password
.. _`Google Authenticator`: https://en.wikipedia.org/wiki/Google_Authenticator

Autorización
============

Para la autorización de sysPass es posible utilizar varios métodos:

* `Auth Basic`_ (por defecto)
* Doble Factor 2FA_ (plugin Authenticator)

La autorización del tipo `Auth Basic`_ siempre es comprobada, por lo que si se reciben las cabeceras HTTP con los datos del usuario, se comprobará si el login del usuario de sysPass es igual al de `Auth Basic`_.

La autorización 2FA_ mediante el plugin Authenticator es realizada mediante la generarión de un token OTP_ desde la aplicación `Google Authenticator`_. Esta autorización es posible activarla desde las preferencias de cada usuario.
