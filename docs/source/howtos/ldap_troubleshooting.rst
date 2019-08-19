LDAP Troubleshooting
====================

PHP 7.2 now includes openssl directly compiled in.

You may just check that with:

.. code:: bash

  $ /bin/php -r 'phpinfo();' | grep ssl

or if you're like me using CentOS 7 and php via SCL:

.. code:: bash

  $ /opt/rh/rh-php72/root/bin/php -r 'phpinfo();' | grep ssl

You may then also check if your linux box connects to your ldaps server with:

.. code:: bash

  $ openssl s_client -connect yourldapsserver.domain.local:636

or ldap server using TLS

.. code:: bash

  $ openssl s_client -connect yourldapsserver.domain.loca:389 -tls1_2

If those work, you may use ldapsearch to manually bind to your LDAP server and see what the problem might be.
On CentOS, install it via:

.. code:: bash

  $ sudo yum install openldap-clients

Simple LDAP Query

.. code:: bash

  $ ldapseach -h yourldapserver.domain.local -p 389 -b \"dc=domain,dc=local\" -D \"CN=YourBindAccount,DC=domain,DC=local\" -W

Add -Z to the ldapsearch line to switch to TLS.

If you get

.. code::

  ldap_start_tls: Connect error (-11)
  additional info: error:14090086:SSL routines:ssl3_get_server_certificate:certificate verify failed (unable to get local issuer certificate)
  ldap_result: Can't contact LDAP server (-1)

Your certificate might be bad.
You can override certificate checking in "/etc/openldap/ldap.conf" by adding line:

.. code::

  TLS_REQCERT     allow

Don't forget to restart php-fpm (or apache if using mod_php) for those settings to take effect.

.. note::

  Thanks to @deajan for this contribution
