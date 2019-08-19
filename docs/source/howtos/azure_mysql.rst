Azure MySQL
===========

In order to install sysPass database on Azure MySQL you'll need to change the database engine used in DDL statements that create the database views. This will replace the "MyISAM" engine with "InnoDB", which does not take any effect in database views.

.. code:: bash

  $ sed -i "s/MyISAM/InnoDB/g" /var/www/html/sysPass/schemas/dbstructure.sql

.. note::

  Thanks to @shocker70 for this contribution
