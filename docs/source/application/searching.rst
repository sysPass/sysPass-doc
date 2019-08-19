Accounts Searching
===================

The accounts searching performs a query for the entered text within the fields 'name', 'login', 'url' and 'notes'.

Results filtering could be done by selecting category, client or tags.

The tag filtering is cumulative ('OR'), so it will be included all the accounts with selected tags.

There are special filters that could be entered in the text field. You could use either one or several special parameters separated by blank spaces:

.. cssclass:: table-bordered

==========================  ============================================================================
Filter                      Description
==========================  ============================================================================
user\:"login"               Get the accounts in which the user with login 'login' has access
owner\:"login"              Get the accounts in which the user with login 'login' is the owner
group\:"group_name"         Search for accounts which 'group_name' has access rights
maingroup\:"group_name"     Get the accounts which have the main group with name 'group_name'
file\:"file_name"           Search for accounts which contain a file with the name 'file_name'
client\:"client_name"       Search for accounts by client name
category\:"category_name"   Search for accounts by category name
id\:"account_id"            Returns the account for the given ID
name_regex\:"regex"         Search for accounts name by regular expression
is|not\:expired             Search for accounts with expired password
is|not\:private             Get the private accounts for the current user
op\:and|or                  Operator used by special parameters
==========================  ============================================================================
