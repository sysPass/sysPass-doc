.. _Docker: https://docs.docker.com/engine/installation/
.. _`Docker containers`: https://en.wikipedia.org/wiki/Docker_%28software%29
.. _`Docker Hub`: https://hub.docker.com/r/syspass/syspass/tags
.. _`Docker Compose`: https://docs.docker.com/compose/
.. _Debian: https://www.debian.org/

Docker Installation
===================

Docker_ based installations allow to run the application in an isolated environment besides try out multiple versions without installing any package on the host system.

sysPass can be ran in `Docker containers <https://en.wikipedia.org/wiki/Docker_%28software%29>`_ which has been compiled on top of latest Debian_ stable version (Stretch) and avoiding any **package compilation**.

Docker images can be got from `Docker Hub`_ and they are complied automatically from Docker source files on  https://github.com/nuxsmin/docker-syspass

There are two ways for installing:

* Using `Docker Compose`_ (recommended): deploys a fully working sysPass environment including application and database services.
* Using Docker_: deploys each service (application and database) separately.

.. _docker-compose:

Docker Compose
--------------

In order to deploy using this method, you need to issue the following steps:

1. Install Docker engine from https://docs.docker.com/install/
2. Install Docker Compose from https://docs.docker.com/compose/install/
3. Download "docker-compose.yml" sysPass' file from https://raw.githubusercontent.com/nuxsmin/docker-syspass/master/docker-compose.yml or use the following one:

.. literalinclude:: ../_src/docker-compose.yml
  :language: yaml

4. Run "docker-compose" tool for setting up the environment:

.. code:: bash

  docker-compose -p syspass -f docker-compose.yml up -d

This will download the latest sysPass stable image and the database (MariaDB) one.

5. Take a look to deployment's logs:

.. code:: bash

  docker-compose -p syspass -f docker-compose.yml logs -f

.. note::

  Docker Compose will create an isolated network for all sysPass services making possible to use DNS resolution between containers. You can use "syspass-db" for setting up the database hostname in sysPass installation page.

  It will create two fixed volumes for sysPass application, one for ".../app/config" directory and the other for ".../app/backup" directory. An additional fixed volume will be created for the database container's data.

.. warning::

  sysPass container will publish 80 and 443 host's ports to the outside. You could change this behavior by tweaking the Docker Compose's file.

.. tip::

  You can disable HTTPS redirection by setting "USE_SSL=no" within "docker-compose.yml" file. This will offload the SSL encryption to a LB or reverse proxy.

Docker
------

By this way all the services need to be deployed manually. The following steps are needed:

1. Install Docker engine from https://docs.docker.com/install/
2. Create network for sysPass services:

.. code:: bash

  docker network create syspass-net

3. Create fixed volunes for sysPass services:

.. code:: bash

  docker volume create syspass-app-config
  docker volume create syspass-app-backup
  docker volume create syspass-db-data

4. Setup sysPass database container:

.. code:: bash

  docker run --name syspass-db \
  --network syspass-net \
  --restart unless-stopped \
  --env MYSQL_ROOT_PASSWORD=syspass \
  --volume syspass-db-data:/var/lib/mysql \
  --detach mariadb:10.2

5. Setup sysPass application container:

.. code:: bash

  docker run --name syspass-app \
  --network syspass-net \
  --publish 80:80 \
  --restart unless-stopped \
  --volume syspass-app-config:/var/www/html/sysPass/app/config \
  --volume syspass-app-backup:/var/www/html/sysPass/app/backup \
  --detach syspass/syspass:3.1.0

6. Connection data will be displayed in application container's console:

.. code:: bash

  docker logs -f syspass-app

.. tip::

  You can install sysPass extensions (plugins) by setting "COMPOSER_EXTENSIONS" environment variable when deploying the sysPass application container. Example: "--env COMPOSER_EXTENSIONS='syspass/plugin-authenticator'"


Database Access
---------------

You can get access to the database using the following connection data:

* User: root
* Password: syspass


.. container:: alert alert-success

  You may install other sysPass images from `Docker Hub`_

.. note::

  Please follow the installer steps in order to setup the sysPass application instance.

  More information about how sysPass works on :doc:`/application/index`

.. warning::

  It's very advisable to take a look to security advices on :doc:`/application/security`
