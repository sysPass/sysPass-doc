Hosting Mode
------------

The hosting mode is for those installations that are running on a external hosting, where is not possible to create neither database nor connection user for it.

Though hosting mode is about the database creation tasks, you would find useful to download the dependencies bundle when there isn't SSH access to the web server. The bundle will be attached to every release on GitHub as "vendor.tar.gz". It should be unpacked within sysPass directory.

.. note::
  **It won't create neither database (except tables) nor connection user**

The steps to perform the installation are the following:

* Create an user/password for sysPass connection at the hosting panel
* Create the sysPass database (not tables) and give permissions to the previous user on it
* Start the sysPass installation and use the user/password that was previously created for sysPass (the two first fields in the installation page)
* Provide a MySQL/MariaDB user with administration rights (it could be the same as previous if it has enough permissions), in order to create sysPass database tables. This user is used only for the installation process and it often would be the user/password for the hosting management
* If database connection and permissions are right, the installation should finish successfully

.. note::
  In case of errors, you could take a look to the web server error logs or ".../app/config/syspass.log".
