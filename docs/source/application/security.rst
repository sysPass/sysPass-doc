Security
========

sysPass has some security mechanisms to mitigate some kind of events and actions that could compromise the application security. Among them are:

* Security token generation for sending forms
* Removing of unwanted characters from received data
* Type casting of received data
* Hash generation for export and backup files name
* RSA (PKI) encryption is used for sending passwords within forms

Although these actions, it's needed to secure the web server components and communications by:

* Using HTTPS
* Limiting access to 'app/config' and 'app/backup' directories

In order to limit the access to the directories through Apache, '.htaccess' files could be used within the directories or by modifying the site configuration:

.. code:: Apache

  # Apache 2.4
  <Directory "/var/www/html/sysPass">
    Options -Indexes -FollowSymLinks -Includes -ExecCGI
    <RequireAny>
        Require expr "%{REQUEST_URI} =~ m#.*\/index\.php(\?r=)?#"
        Require expr "%{REQUEST_URI} =~ m#.*\/api\.php$#"
        Require expr "%{REQUEST_URI} =~ m#^$#"
    </RequireAny>
  </Directory>

  <Directory "/var/www/html/sysPass/public">
    Require all granted
  </Directory>

.. danger::
  'app/config' directory shouldn't be accessible through the web server, it could reveal private data.
