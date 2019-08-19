How to install and configure Nginx
==================================

Install required repositories and packages

.. code:: bash

  $ sudo yum -y install epel-release.noarch centos-release-scl centos-release-scl-rh scl-utils

  $ sudo yum -y install nginx rh-php70 rh-php70-php rh-php70-php-fpm rh-php70-php-ldap rh-php70-php-xml rh-php70-php-json rh-php70-php-gd rh-php70-php-pdo rh-php70-php-mbstring rh-php70-php-cli rh-php70-php-mysqlnd mod_ssl

Configure Nginx "/etc/nginx/conf.d/syspass.conf" file

.. code::

  server {
    listen 80;

    #server_name: This is the domain you will be using for your site. Instead of localhost, we will use the public facing domain and www version of the domain you want to use.
    server_name syspass.foo.bar;

    location / {
      #root: This is the root directory for the site files.
      root /var/www/syspass;
      index index.html index.php;

      #try_files: What we are doing here is telling the server to display a 404 error when a given file is not found.
      try_files $uri $uri/ =404;
    }

    error_page 500 502 503 504 /50x.html;

    location = /50x.html {
      root html;
    }

    location ~ .php$ {
      #root: This is the root directory for the site files.
      root /var/www/syspass;
      fastcgi_pass 127.0.0.1:9000;
      fastcgi_index index.php;
      include fastcgi_params;
      fastcgi_param SCRIPT_NAME $fastcgi_script_name;
      fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }
  }

Configure PHP

.. code:: bash

  $ sudo sed -i 's/user = apache/user = nginx/g; s/group = apache/group = nginx/g;' /etc/opt/rh/rh-php70/php-fpm.d/www.conf
  $ sudo usermod -aG nginx apache


Enable and start services

.. code:: bash

  $ sudo systemctl enable rh-php70-php-fpm
  $ sudo service rh-php70-php-fpm start
  $ sudo systemctl enable nginx
  $ sudo service nginx start


.. note::
  Thanks to @M1k13 for this contribution
