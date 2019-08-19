Introduction
============

sysPass is a password management system written in PHP that allows a centralized and collaborative passwords management.

Features
--------

* Encrypted passwords using AES-256 CTR
* Interface based on Material Design Lite with HTML5 and AJAX
* Multiuser with users, groups and profiles management
* Advanced profile management with 29 access levels
* MySQL/MariaDB, OpenLDAP and Active Directory authentication
* Activity notifications by email and in-app
* Public links to accounts without login
* Accounts changes history and restore points
* Accounts associated files management with images preview
* Multilanguage
* Portable backup format and export to encrypted XML
* Actions and events audit with the ability to send messages to a remote Syslog in CEF format
* API for integrating with other applications
* Import from KeePass and CSV
* One step installation

What sysPass does not do
------------------------

* It does not store any **UNencrypted** keys in the server
* It does not send any data to an external service
* It does not encrypt the accounts' password individually, it uses a key protected by global master password for all instead
* It does not perform password changes on the servers
* It does not encrypt the accounts' data, only the password, custom fields' and plugins' data, because you wouldn't be able to perform searches
* It isn't like APT: doesn't have Super Cow Powers!!

.. toctree::
    :maxdepth: 2
    :name: mastertoc

    installing/index
    configuration/index
    application/index
    updating/index
    howtos/index
    faq
