Directories and permissions
---------------------------

Create a directory for sysPass within the web server root.

.. code:: bash

  $ sudo mkdir /var/www/html/syspass


If you go with the packaged version, download and unpack sysPass files.

.. code:: bash

  $ cd /var/www/html/syspass
  # Strip version directory and extract contents to current directory.
  $ sudo tar xzf syspass.tar.gz --strip-components=1
  # If using the vendors package
  $ sudo tar xzf vendors.tar.gz

If you go with Git cloned version, clone sysPass GitHub repository.

.. code:: bash

  $ sudo git clone https://github.com/nuxsmin/sysPass.git  /var/www/html/syspass

Setup directories permissions. The owner should match the web server running user.

.. code:: bash

  $ sudo chown apache -R /var/www/html/syspass
  $ sudo chmod 750 /var/www/html/syspass/app/config /var/www/html/syspass/app/backup
