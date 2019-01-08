Backup Strategies
=================

.. note::

  Work in progress

Docker
------

Please perform backups regularly by using in-app tools or external ones (recommended). You need to copy the following data:

* "syspass-app-config" volume
* "syspass-app-backup" volume
* sysPass database

Example:

.. code:: bash

    docker run --rm \
    --volumes-from syspass-app \
    --volume $PWD:/backup \
    alpine sh -c "exec tar xzf /backup/syspass-app-backup.tar.gz /var/www/html/sysPass"

    docker run --rm \
    --network syspass-net \
    --volume $PWD:/backup \
    mariadb:10.2 sh -c 'exec mysqldump -h syspass-db -u root -p"syspass" syspass > /backup/syspass-db-dump.sql'

These commands will create "syspass-app-backup.tar.gz" and "syspass-db-dump.sql" files within the current directory
