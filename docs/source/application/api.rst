.. _`JSON-RPC v2`: https://en.wikipedia.org/wiki/JSON-RPC

API
===

La API de sysPass utiliza `JSON-RPC v2`_ para el intercambio de mensajes entre cliente-servidor.

La URL de acceso a la API es "https://servidor/sysPass/api.php".

Métodos
-------

getAccountSearch
````````````````
Realiza una búsqueda de cuentas

.. cssclass:: table-bordered

==========  ==============================
Parámetro   Descripción
==========  ==============================
authToken   Token API del usuario
text        Texto a buscar
count       Número de resultados a mostrar
categoryId  Id de categoría a filtrar
customerId  Id de cliente a filtrar
==========  ==============================

getAccountData
``````````````
Obtiene los detalles de una cuenta

.. cssclass:: table-bordered

==========  ==============================
Parámetro   Descripción
==========  ==============================
authToken   Token API del usuario
id          Id de la cuenta
userPass    Clave del usuario asociado al token
==========  ==============================

getAccountPassword
``````````````````
Obtiene la clave de una cuenta

.. cssclass:: table-bordered

==========  ==============================
Parámetro   Descripción
==========  ==============================
authToken   Token API del usuario
id          Id de la cuenta
tokenPass   Clave del token API
details     Devolver detalles en la respuesta
==========  ==============================

addAccount
``````````
Crea una cuenta

.. cssclass:: table-bordered

==========  ==============================
Parámetro   Descripción
==========  ==============================
authToken   Token API del usuario
tokenPass   Clave del token API
name        Nombre de cuenta
categoryId  Id de categoría
customerId  Id de cliente
pass        Clave
login       Usuario de acceso
url         URL o IP de acceso
notes       Notas sobre la cuenta
==========  ==============================

deleteAccount
`````````````
Elimina una cuenta

.. cssclass:: table-bordered

==========  ==============================
Parámetro   Descripción
==========  ==============================
authToken   Token API del usuario
id          Id de la cuenta
==========  ==============================

getCategories
`````````````
Realiza una búsqueda de categorías

.. cssclass:: table-bordered

==========  ==============================
Parámetro   Descripción
==========  ==============================
authToken   Token API del usuario
name        Nombre a buscar
count       Número de resultados a mostrar
==========  ==============================

addCategory
```````````
Crea una categoría

.. cssclass:: table-bordered

=========== ==============================
Parámetro   Descripción
=========== ==============================
authToken   Token API del usuario
name        Nombre de la categoría
description Descripción
=========== ==============================

deleteCategory
``````````````
Elimina una categoría

.. cssclass:: table-bordered

=========== ==============================
Parámetro   Descripción
=========== ==============================
authToken   Token API del usuario
id          Id de la categoría
=========== ==============================

getCustomers
````````````
Realiza una búsqueda de clientes

.. cssclass:: table-bordered

==========  ==============================
Parámetro   Descripción
==========  ==============================
authToken   Token API del usuario
name        Nombre a buscar
count       Número de resultados a mostrar
==========  ==============================

addCustomer
```````````
Crea un cliente

.. cssclass:: table-bordered

=========== ==============================
Parámetro   Descripción
=========== ==============================
authToken   Token API del usuario
name        Nombre del cliente
description Descripción
=========== ==============================

deleteCustomer
``````````````
Elimina un cliente

=========== ==============================
Parámetro   Descripción
=========== ==============================
authToken   Token API del usuario
id          Id del cliente
=========== ==============================

backup
``````
Realiza una copia de seguridad de la aplicación

=========== ==============================
Parámetro   Descripción
=========== ==============================
authToken   Token API del usuario
=========== ==============================
