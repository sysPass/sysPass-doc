How to restore sysPass
======================

.. note::

  This procedure requires to have a database and application backup

1. Restore the database backup. It could be made either through the sysPass utility, MySQL workbench or mysqldump tool
2. Create the connection user (see '.../app/config/config.xml' file for current connection settings) and set the correct permissions on the restored database
3. Restore the application backup
4. Point the browser to the application URL
