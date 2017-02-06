Búsqueda de Cuentas
===================

La búsqueda de cuentas realiza una consulta del texto introducido en los campos "nombre", "login", "url" y "notas".

Es posible fltrar los resultados mediante la selección de categoría, cliente o etiquetas.

El filtrado mediante etiquetas es acumulativo ("OR"), por lo que se incluirán las cuentas con las etiquetas seleccionadas.

Existen filtros especiales que son introducidos en el campo de texto:

.. cssclass:: table-bordered

=====================  ============================================================================
Filtro                 Descripción
=====================  ============================================================================
user\:login            Devolver las cuentas a las que el usuario con login "login" tenga acceso
owner\:login           Devolver las cuentas en las que "login" es propietario
maingroup\:group_name  Devolver las cuentas con grupo principal "group_name"
group\:group_name      Devolver las cuentas a las que el grupo con nombre "group_name" tenga acceso
file\:file_name        Devolver las cuentas que contengan el archivo con nombre "file_name"
expired\:              Devolver las cuentas con clave caducada
private\:              Devolver las cuentas privadas del usuario actual
=====================  ============================================================================
