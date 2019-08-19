.. _application:

Application
===========

sysPass is an application that uses a MySQL/MariaDB database to store the data of all its components except for the configuration, which is stored in an XML file within 'app/config' directory.

.. warning::
  It's important that '.../app/config' directory is not accessible from the web service, because it could reveal important information.

.. toctree::
    :maxdepth: 2
    :name: applicationtocs

    encryption
    security
    authentication
    authorization
    permissions
    searching
    api
    features
    plugins
    backup
