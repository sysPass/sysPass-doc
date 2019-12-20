Installing dependencies
-----------------------

PHP Composer is needed to keep up-to-date dependencies and an easy way to apply security or functional patches to them.

You can either download the dependencies using Composer itself or by getting the latest "vendor.tar.gz" package from the release page.

.. note::

  If you don't have any Internet access from the server, the vendor package will provide all the release dependencies and you don't need to deal with composer commands.

Using PHP Composer
__________________

From sysPass root directory, download and install Composer (https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md)

Create a bash script called "install_composer.sh" and paste this code in it:

.. code:: bash

  #!/bin/sh
  EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

  if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
  then
      >&2 echo 'ERROR: Invalid installer signature'
      rm composer-setup.php
      exit 1
  fi

  php composer-setup.php --quiet
  RESULT=$?
  rm composer-setup.php
  exit $RESULT

.. code:: bash

  $ chmod +x install_composer.sh
  $ ./install_composer.sh

Then install sysPass dependencies

.. code:: bash

  $ php composer.phar install --no-dev
