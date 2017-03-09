.. _`patrón de observador`: https://en.wikipedia.org/wiki/Observer_pattern

Plugins
=======

sysPass permite el uso de plugins mediante una arquitectura que implementa el `patrón de observador`_ el cual se caracteriza por emitir un mensaje a todos los observadores registrados.

Los plugins se instalan en el directorio 'sysPass/inc/Plugins' y contienen la siguiente estructura básica:

.. code::

  Plugins/
  └── NombrePlugin (1)
      ├── ajax
      ├── js
      │   ├── plugin.js
      │   └── plugin.min.js
      ├── locales
      │   ├── en_US
      │   │   └── LC_MESSAGES
      │   │       ├── NombrePlugin.mo (2)
      │   │       └── NombrePlugin.po (2)
      ├── themes
      │   └── material-blue
      │       └── views
      │           ├── main
      │           │   └── login.inc
      │           └── userpreferences
      │               └── preferences.inc
      │
      └── NombrePluginPlugin.class.php (3)

Los nombres de los directorios y archivos deben de ser de la siguiente manera:

1. Nombre de directorio con el nombre del plugin. Ejemplo: **Authenticator**
2. Nombre de archivo con el numbre del plugin en minúscula. Ejemplo: **authenticator.po**
3. Nombre de archivo con el nombre del plugin seguido de "Plugin.class.php". Ejemplo: **AuthenticatorPlugin.class.php**

La clase principal se debe de llamar igual que el plugin y tiene que extender a la clase **PluginBase**. Esta clase tiene que implementar los siguientes métodos.

Métodos
-------

init
::::

Método que se llama cada vez que se ejecuta el plugin

.. code-block:: php

  /**
   * Inicialización
   */
  public function init() {}

updateEvent
:::::::::::

Método que se llama cuando se emite un evento

.. code-block:: php

  /**
   * Evento de actualización
   *
   * @param string $event Nombre del evento
   * @param mixed  $object
   */
  public function updateEvent($event, $object) {}

getEvents
:::::::::

Método que devuelve un array de strings con los eventos a los que se suscribe el plugin

.. code-block:: php

  /**
   * Devuelve los eventos que implementa el observador
   *
   * @return array
   */
  public function getEvents()
  {
      return ['user.preferences', 'main.prelogin.2fa', 'login.preferences'];
  }

getJsResources
::::::::::::::

Método que devuelve un array de strings con los recursos Javascript que necesita el plugin

.. code-block:: php

  /**
   * Devuelve los recursos JS y CSS necesarios para el plugin
   *
   * @return array
   */
  public function getJsResources()
  {
      return ['plugin.min.js'];
  }

getAuthor
:::::::::

Método que devuelve el nombre del autor del plugin

.. code-block:: php

    /**
     * Devuelve el autor del plugin
     *
     * @return string
     */
    public function getAuthor()
    {
        return 'Rubén D.';
    }

getVersion
::::::::::

Método que devuelve un array de integers con la versión del plugin

.. code-block:: php

  /**
   * Devuelve la versión del plugin
   *
   * @return array
   */
  public function getVersion()
  {
      return [1, 0];
  }

getCompatibleVersion
::::::::::::::::::::

Método que devuelve un array de integers con la versión mínima de sysPass compatible

.. code-block:: php

  /**
   * Devuelve la versión compatible de sysPass
   *
   * @return array
   */
  public function getCompatibleVersion()
  {
      return [2, 0];
  }

getCssResources
:::::::::::::::

Método que devuelve un array de strings con los recursos CSS que requiere el plugin

.. code-block:: php

  /**
   * Devuelve los recursos CSS necesarios para el plugin
   *
   * @return array
   */
  public function getCssResources()
  {
      return [];
  }

getName
:::::::

Método que devuelve el nombre del plugin

.. code-block:: php

  /**
   * Devuelve el nombre del plugin
   *
   * @return string
   */
  public function getName()
  {
      return self::PLUGIN_NAME;
  }

getData
:::::::

Método que devuelve los datos del plugin

.. code-block:: php

  /**
   * @return array|AuthenticatorData[]
   */
  public function getData()
  {
      return (array)parent::getData();
  }

Ejemplo
-------

.. code-block:: php

  <?php

  namespace Plugins\Authenticator;

  use SP\Core\DiFactory;
  use SP\Core\Plugin\PluginBase;
  use SplSubject;

  /**
  * Class Plugin
  *
  * @package Plugins\Authenticator
  */
  class AuthenticatorPlugin extends PluginBase
  {
    const PLUGIN_NAME = 'Authenticator';

    /**
     * Receive update from subject
     *
     * @link  http://php.net/manual/en/splobserver.update.php
     * @param SplSubject $subject <p>
     *                            The <b>SplSubject</b> notifying the observer of an update.
     *                            </p>
     * @return void
     * @since 5.1.0
     */
    public function update(SplSubject $subject)
    {
    }

    /**
     * Inicialización del plugin
     */
    public function init()
    {
        if (!is_array($this->data)) {
            $this->data = [];
        }

        $this->base = __DIR__;
        $this->themeDir = __DIR__ . DIRECTORY_SEPARATOR . 'themes' . DIRECTORY_SEPARATOR . DiFactory::getTheme()->getThemeName();

        $this->setLocales();
    }

    /**
     * Evento de actualización
     *
     * @param string $event Nombre del evento
     * @param mixed  $object
     * @throws \SP\Core\Exceptions\FileNotFoundException
     * @throws \SP\Core\Exceptions\SPException
     */
    public function updateEvent($event, $object)
    {
        switch ($event){
            case 'user.preferences':
                $Controller = new PreferencesController($object, $this);
                $Controller->getSecurityTab();
                break;
            case 'main.prelogin.2fa':
                $Controller = new LoginController($this);
                $Controller->get2FA($object);
                break;
            case 'login.preferences':
                $Controller = new LoginController($this);
                $Controller->checkLogin();
                break;
        }
    }

    /**
     * Devuelve los eventos que implementa el observador
     *
     * @return array
     */
    public function getEvents()
    {
        return ['user.preferences', 'main.prelogin.2fa', 'login.preferences'];
    }

    /**
     * Devuelve los recursos JS y CSS necesarios para el plugin
     *
     * @return array
     */
    public function getJsResources()
    {
        return ['plugin.min.js'];
    }

    /**
     * Devuelve el autor del plugin
     *
     * @return string
     */
    public function getAuthor()
    {
        return 'Rubén D.';
    }

    /**
     * Devuelve la versión del plugin
     *
     * @return array
     */
    public function getVersion()
    {
        return [1, 0];
    }

    /**
     * Devuelve la versión compatible de sysPass
     *
     * @return array
     */
    public function getCompatibleVersion()
    {
        return [2, 0];
    }

    /**
     * Devuelve los recursos CSS necesarios para el plugin
     *
     * @return array
     */
    public function getCssResources()
    {
        return [];
    }

    /**
     * Devuelve el nombre del plugin
     *
     * @return string
     */
    public function getName()
    {
        return self::PLUGIN_NAME;
    }

    /**
     * @return array|AuthenticatorData[]
     */
    public function getData()
    {
        return (array)parent::getData();
    }
  }
