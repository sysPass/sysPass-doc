Security
========

sysPass has some security mechanisms to mitigate some kind of events and actions that could compromise the application security. Among them are:

* Security token generation for sending forms
* Removing of unwanted characters from received data
* Type casting of received data
* Hash generation for export and backup files name
* RSA (PKI) encryption is used for sending passwords within forms

Although these actions, some other task should be performed in order to secure the web server components and communications by:

* Using HTTPS
* Limiting access to '.../app/config' and '.../app/backup' directories
* Enforcing web server access policies

In order to limit the access to the directories through Apache, '.htaccess' files could be used within the directories or by modifying the site configuration:

.. code:: Apache

  # Apache 2.4 (after 2.4.16)
  <Directory "/var/www/html/sysPass">
    Options -Indexes -FollowSymLinks -Includes -ExecCGI
    <RequireAny>
        Require expr "%{REQUEST_URI} =~ m#.*/index\.php(\?r=)?#"
        Require expr "%{REQUEST_URI} =~ m#.*/api\.php$#"
        Require expr "%{REQUEST_URI} =~ m#^/?$#"
    </RequireAny>
  </Directory>

  <Directory "/var/www/html/sysPass/public">
    Require all granted
  </Directory>

  <FilesMatch "\.(png|jpg|js|css|ttf|otf|eot|woff|woff2|ico)$">
    Require all granted
  </FilesMatch>


.. code:: Apache

  # Apache 2.4 (before 2.4.16)
  <Directory "/var/www/html/sysPass">
    Options -Indexes -FollowSymLinks -Includes -ExecCGI
    <RequireAny>
        Require expr %{REQUEST_URI} =~ m#.*/index\.php(\?r=)?#
        Require expr %{REQUEST_URI} =~ m#.*/api\.php$#
        Require expr %{REQUEST_URI} =~ m#^/?$#
    </RequireAny>
  </Directory>

  <Directory "/var/www/html/sysPass/public">
    Require all granted
  </Directory>

  <FilesMatch "\.(png|jpg|js|css|ttf|otf|eot|woff|woff2|ico)$">
    Require all granted
  </FilesMatch>



.. danger::
  '.../app/config' directory shouldn't be accessible through the web server, it could reveal private data.
