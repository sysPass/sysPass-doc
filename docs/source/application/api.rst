.. _`JSON-RPC v2`: https://en.wikipedia.org/wiki/JSON-RPC

API
===

sysPass API relies on `JSON-RPC v2`_ schema for client-server communication.

The API access URL is "https://server_name/api.php"

Example of JSON-RPC payload:

.. code:: json

    {
      "jsonrpc": "2.0",
      "method": "account/search",
      "params": {
        "authToken": "auth_token_for_api"
      },
      "id": 1
    }

Methods
-------

Accounts
________

account/search
::::::::::::::

Search for accounts

.. cssclass:: table-bordered

==========  ======  ========  ===========
Parameter   Type    Required  Description
==========  ======  ========  ===========
authToken   string  yes       User's API token
text        string  no        Text to search for
count       int     no        Number of results to display
categoryId  int     no        Category's Id for filtering
clientId    int     no        Client's Id for filtering
tagsId      array   no        Tags' Id for filtering
op          string  no        Operator used for filtering. It can be either 'or' or 'and'
==========  ======  ========  ===========

account/view
::::::::::::

Get account's details

.. cssclass:: table-bordered

==========  ======  ========  ===========
Parameter   Type    Required  Description
==========  ======  ========  ===========
authToken   string  yes       User's API token
tokenPass   string  yes       API token's pass
id          int     yes       Account's Id
==========  ======  ========  ===========

account/viewPass
::::::::::::::::

Get account's password

.. cssclass:: table-bordered

==========  ======  ========  ===========
Parameter   Type    Required  Description
==========  ======  ========  ===========
authToken   string  yes       User's API token
tokenPass   string  yes       API token's pass
id          int     yes       Account's Id
details     int     no        Whether to return account's details within response
==========  ======  ========  ===========

account/editPass
::::::::::::::::

Edit account's password

.. cssclass:: table-bordered

==========  ======  ========  ===========
Parameter   Type    Required  Description
==========  ======  ========  ===========
authToken   string  yes       User's API token
tokenPass   string  yes       API token's pass
id          int     yes       Account's Id
pass        string  yes       Account's password
expireDate  int     no        Expire date in UNIX timestamp format
==========  ======  ========  ===========

account/create
::::::::::::::

Create account

.. cssclass:: table-bordered

============  ======  ========  ===========
Parameter     Type    Required  Description
============  ======  ========  ===========
authToken     string  yes       User's API token
tokenPass     string  yes       API token's pass
name          string  yes       Account's name
categoryId    int     yes       Account's category Id
clientId      int     yes       Account's client Id
pass          string  yes       Account's password
tagsId        array   no        Account's tags Id
userGroupId   int     no        Account's user group Id
parentId      int     no        Account's parent Id
login         string  no        Account's login
url           string  no        Account's access URL or IP
notes         string  no        Account's notes
private       int     no        Set account as private. It can be either 0 or 1
privateGroup  int     no        Set account as private for group. It can be either 0 or 1
expireDate    int     no        Expire date in UNIX timestamp format
============  ======  ========  ===========

account/edit
::::::::::::

Edit account

.. cssclass:: table-bordered

============  ======  ========  ===========
Parameter     Type    Required  Description
============  ======  ========  ===========
authToken     string  yes       User's API token
tokenPass     string  yes       API token's pass
id            int     yes       Account's Id
name          string  no        Account's name
categoryId    int     no        Account's category Id
clientId      int     no        Account's client Id
tagsId        array   no        Account's tags Id
userGroupId   int     no        Account's user group Id
parentId      int     no        Account's parent Id
login         string  no        Account's login
url           string  no        Account's access URL or IP
notes         string  no        Account's notes
private       int     no        Set account as private. It can be either 0 or 1
privateGroup  int     no        Set account as private for group. It can be either 0 or 1
expireDate    int     no        Expire date in UNIX timestamp format
============  ======  ========  ===========

account/delete
::::::::::::::

Delete an account

.. cssclass:: table-bordered

==========  ======  ========  ===========
Parameter   Type    Required  Description
==========  ======  ========  ===========
authToken   string  yes       User's API token
id          int     yes       Account's Id
==========  ======  ========  ===========

Categories
__________

category/search
:::::::::::::::

Search for categories

.. cssclass:: table-bordered

==========  ======  ========  ===========
Parameter   Type    Required  Description
==========  ======  ========  ===========
authToken   string  yes       User's API token
text        string  no        Text to search for
count       int     no        Number of results to display
==========  ======  ========  ===========

category/view
:::::::::::::

Get category's details

.. cssclass:: table-bordered

==========  ======  ========  ===========
Parameter   Type    Required  Description
==========  ======  ========  ===========
authToken   string  yes       User's API token
tokenPass   string  yes       API token's pass
id          int     yes       Category's Id
==========  ======  ========  ===========

category/create
:::::::::::::::

Create category

.. cssclass:: table-bordered

===========  ======  ========  ===========
Parameter    Type    Required  Description
===========  ======  ========  ===========
authToken    string  yes       User's API token
name         string  yes       Category's name
description  string  no        Category's description
===========  ======  ========  ===========

category/edit
:::::::::::::

Edit category

.. cssclass:: table-bordered

===========  ======  ========  ===========
Parameter    Type    Required  Description
===========  ======  ========  ===========
authToken    string  yes       User's API token
id           int     yes       Category's Id
name         string  yes       Category's name
description  string  no        Category's description
===========  ======  ========  ===========

category/delete
:::::::::::::::

Delete category

.. cssclass:: table-bordered

==========  ======  ========  ===========
Parameter   Type    Required  Description
==========  ======  ========  ===========
authToken   string  yes       User's API token
id          int     yes       Category's Id
==========  ======  ========  ===========

Clients
__________

client/search
:::::::::::::

Search for clients

.. cssclass:: table-bordered

==========  ======  ========  ===========
Parameter   Type    Required  Description
==========  ======  ========  ===========
authToken   string  yes       User's API token
text        string  no        Text to search for
count       int     no        Number of results to display
==========  ======  ========  ===========

client/view
:::::::::::

Get client's details

.. cssclass:: table-bordered

==========  ======  ========  ===========
Parameter   Type    Required  Description
==========  ======  ========  ===========
authToken   string  yes       User's API token
tokenPass   string  yes       API token's pass
id          int     yes       Client's Id
==========  ======  ========  ===========

client/create
:::::::::::::

Create client

.. cssclass:: table-bordered

===========  ======  ========  ===========
Parameter    Type    Required  Description
===========  ======  ========  ===========
authToken    string  yes       User's API token
name         string  yes       Client's name
description  string  no        Client's description
global       int     no        Set client as global. It can be either 0 or 1
===========  ======  ========  ===========

client/edit
:::::::::::

Edit client

.. cssclass:: table-bordered

===========  ======  ========  ===========
Parameter    Type    Required  Description
===========  ======  ========  ===========
authToken    string  yes       User's API token
id           int     yes       Client's Id
name         string  yes       Client's name
description  string  no        Client's description
global       int     no        Set client as global. It can be either 0 or 1
===========  ======  ========  ===========

client/delete
:::::::::::::

Delete client

.. cssclass:: table-bordered

==========  ======  ========  ===========
Parameter   Type    Required  Description
==========  ======  ========  ===========
authToken   string  yes       User's API token
id          int     yes       Client's Id
==========  ======  ========  ===========

Tags
__________

tag/search
::::::::::

Search for tags

.. cssclass:: table-bordered

==========  ======  ========  ===========
Parameter   Type    Required  Description
==========  ======  ========  ===========
authToken   string  yes       User's API token
text        string  no        Text to search for
count       int     no        Number of results to display
==========  ======  ========  ===========

tag/view
::::::::

Get tag's details

.. cssclass:: table-bordered

==========  ======  ========  ===========
Parameter   Type    Required  Description
==========  ======  ========  ===========
authToken   string  yes       User's API token
tokenPass   string  yes       API token's pass
id          int     yes       Tag's Id
==========  ======  ========  ===========

tag/create
::::::::::

Create tag

.. cssclass:: table-bordered

==========  ======  ========  ===========
Parameter   Type    Required  Description
==========  ======  ========  ===========
authToken   string  yes       User's API token
name        string  yes       Tag's name
==========  ======  ========  ===========

tag/edit
::::::::

Edit tag

.. cssclass:: table-bordered

==========  ======  ========  ===========
Parameter   Type    Required  Description
==========  ======  ========  ===========
authToken   string  yes       User's API token
id          int     yes       Tag's Id
name        string  yes       Tag's name
==========  ======  ========  ===========

tag/delete
::::::::::

Delete tag

.. cssclass:: table-bordered

==========  ======  ========  ===========
Parameter   Type    Required  Description
==========  ======  ========  ===========
authToken   string  yes       User's API token
id          int     yes       Tag's Id
==========  ======  ========  ===========

User Groups
___________

userGroup/search
::::::::::::::::

Search for user groups

.. cssclass:: table-bordered

==========  ======  ========  ===========
Parameter   Type    Required  Description
==========  ======  ========  ===========
authToken   string  yes       User's API token
text        string  no        Text to search for
count       int     no        Number of results to display
==========  ======  ========  ===========

userGroup/view
::::::::::::::

Get user group's details

.. cssclass:: table-bordered

==========  ======  ========  ===========
Parameter   Type    Required  Description
==========  ======  ========  ===========
authToken   string  yes       User's API token
tokenPass   string  yes       API token's pass
id          int     yes       User group's Id
==========  ======  ========  ===========

userGroup/create
::::::::::::::::

Create user group

.. cssclass:: table-bordered

===========  ======  ========  ===========
Parameter    Type    Required  Description
===========  ======  ========  ===========
authToken    string  yes       User's API token
name         string  yes       User group's name
description  string  no        User group's description
usersId      array   no        User group's users Id
===========  ======  ========  ===========

userGroup/edit
::::::::::::::

Edit user group

.. cssclass:: table-bordered

===========  ======  ========  ===========
Parameter    Type    Required  Description
===========  ======  ========  ===========
authToken    string  yes       User's API token
id           int     yes       User group's Id
name         string  yes       User group's name
description  string  no        User group's description
usersId      array   no        User group's users Id
===========  ======  ========  ===========

userGroup/delete
::::::::::::::::

Delete user group

.. cssclass:: table-bordered

==========  ======  ========  ===========
Parameter   Type    Required  Description
==========  ======  ========  ===========
authToken   string  yes       User's API token
id          int     yes       User group's Id
==========  ======  ========  ===========

Configuration
_____________

config/backup
:::::::::::::

Perform an application and database backup

==========  ======  ========  ===========
Parameter   Type    Required  Description
==========  ======  ========  ===========
authToken   string  yes       User's API token
path        string  no        Server path to store the application and database backup
==========  ======  ========  ===========

config/export
:::::::::::::

Export application data in XML format

==========  ======  ========  ===========
Parameter   Type    Required  Description
==========  ======  ========  ===========
authToken   string  yes       User's API token
path        string  no        Server path to store the XML file
password    string  no        Password used to encrypt the exported data
==========  ======  ========  ===========
