.. _`Auth Basic`: https://en.wikipedia.org/wiki/Basic_access_authentication
.. _2FA: https://en.wikipedia.org/wiki/Multi-factor_authentication
.. _OTP: https://en.wikipedia.org/wiki/One-time_password
.. _`Google Authenticator`: https://en.wikipedia.org/wiki/Google_Authenticator
.. _`Authenticator Plugin`: https://github.com/sysPass/plugin-Authenticator

Authorization
=============

For sysPass authorization it could be possible to use several methods:

* `Auth Basic`_ (by default)
* Two Factor 2FA_ (`Authenticator Plugin`_)

The `Auth Basic`_ authorization could be enabled through the configuration module, so if the HTTP authorization header with the user's data is sent, it will be checked whether the sysPass user's login matches against the `Auth Basic`_ one.

The 2FA_ authorization, through the `Authenticator Plugin`_, is done by generating an OTP_ token from `Google Authenticator`_  or similar applications. This authorization could be enabled from the user's preferences.
