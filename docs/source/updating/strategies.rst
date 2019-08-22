.. _Docker: https://docs.docker.com/engine/installation/
.. _Kubernetes: https://kubernetes.io/
.. _`Docker Compose`: https://docs.docker.com/compose/
.. _Helm: https://helm.sh/
.. _Git: https://git-scm.com/

Strategies
==========

Though it has been discussed a few times, I should mention that **sysPass does not provide an automated upgrading method for code files**. This is so because it would imply installing some kind of software libraries like Git_ and develop an UI interface within sysPass that will try to resolve many situations when dealing with CVS repositories (merge, conflicts, etc.).

Another question is about those installations on Docker_ or Kubernetes_, which don't rely (philosophically speaking) on such kind on rolling updates based on CVS, since it will break the philosophy of containers: immutable, reproducible, scalable and so on.

That being said, all-in-one apps are not a great deal for these days, so I think the best way to update is to be performed externally, that is either using Git_ or Docker_ tagged images (through `Docker Compose`_  or Helm_).

Normal
------

As described on release upgrading notes

Git
---

Install Git_, point your CLI on the webserver root and run the following command:


.. code-block:: bash

  $ git clone https://github.com/nuxsmin/sysPass.git

In order to get the latest updates:

.. code-block:: bash

  $ git pull

.. note::

	The "master" branch on Github holds the most recent stable version

After it, if database changes are required, you'll need to follow the steps through the web UI

.. warning::

  Perform a full database and application backup using external tools like "mysqldump" and "tar" before updating

Docker
------

The fine and easy way is installing :ref:`docker-compose` and every new version is released out, you only need to change the image tag on composer's YAML.

.. code-block:: yaml

  version: '2'
  services:
    app:
      container_name: syspass-app
      image: syspass/syspass:3.1.0 # Set this version tag to desired one
      restart: always
  ...

After changing the version tag, tun the following command:

.. code-block:: bash

  docker-compose -p syspass -f docker-compose.yml up -d

It will update the current sysPass container with the new version. If database changes are required, you'll need to follow the steps through the web UI

.. warning::

  Perform a full database and application backups before updating: :doc:`../application/backup`
