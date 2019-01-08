Permissions
===========

sysPass permissions are set in users' profile. By default only accounts searching can be done.

There are 29 permission types:

* **Accounts**

  * Create - allows to create new accounts
  * View - allows to view the accounts' details [#f1]_
  * View Password - allows to view the accounts' password [#f1]_
  * Edit - allows to modify the accounts and its files [#f1]_
  * Edit Password - allows to modify the accounts' password [#f1]_
  * Delete - allows to delete accounts [#f1]_
  * Files - allows to view account's files
  * Share Link - allows to create public links
  * Private - allows to create private accounts
  * Private for Group - allows to create private accounts only accessible by the account's main group
  * Permissions - allows to view and modify the accounts' permissions [#f1]_
  * Global Search - allows to perform a searching in all the accounts except in the private ones [#f2]_

* **Management**

  * Users - allows full access to the users management [#f3]_
  * Groups - allows full access to the user groups management
  * Profiles - allows full access to the user profiles management
  * Categories - allows full access to categories management
  * Clients - allows full access to clients management
  * Custom Fields - allows full access to custom fields management
  * API Authorizations - allows full access to API authorizations management
  * Public Links - allows full access to the public links management
  * Accounts - allows full access to accounts management
  * Files- allows full access to files management
  * Tags - allows full access to the tags management

* **Configuration**

  * General - allows full access to the site, accounts, wiki, ldap and email configuration
  * Encryption - allows full access to the master password configuration
  * Backup - allows full access to perform backups [#f4]_
  * Import - allows full access to import XML and CSV files

* **Others**

  * Event Log - allows full access to the event log

ACL
---

Users and Groups
________________

  * User profiles allow to set which actions could be done by the user
  * An user can only display or modify accounts if:

    * Is the account's owner
    * Is member of account's primary group
    * Is member of account's secondary groups
    * Is listed as a secondary user of the account
    * His/Her main group is listed as a secondary group of the account
    * Is included through a group and the 'Secondary Groups Access' option is enabled

  * Private accounts can only be accessed by the owner
  * Private accounts for groups can only be accessed by the users of the main group
  * Application Admin: allows full access to all the application modules and accounts, except private ones
  * Accounts Admin: allows full access to all the accounts, except private ones

API
___

API's access permissions are complementary to the accounts access permissions, so users and groups ACLs will be applied when an account is either listed or accessed.

.. rubric:: Notes

.. [#f1] Only the accounts that the user and its group are granted
.. [#f2] When the account access is not granted, he/she will only be able to perform a 'Request for Account Modification'
.. [#f3] 'Application Admin' users cannot be modified by other users
.. [#f4] Only 'Application Admin' users can download the backup or XML files
