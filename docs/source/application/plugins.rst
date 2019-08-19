Plugins
=======

sysPass allows to use plugins through an architecture that implements `observer pattern <https://en.wikipedia.org/wiki/Observer_pattern>`_ which is characterized by emitting a message to all subscribed observers.

Plugins must be installed in 'plugins' directory within the target module and they contain the following base structure:

.. only:: lang_es

  .. code::

    plugins/
    └── NombrePlugin (1)
        ├── base.php
        ├── CODE_OF_CONDUCT.md
        ├── composer.json
        ├── LICENSE
        ├── README.md
        ├── src
        │   ├── lib
        │   │   ├── Controllers
        │   │   ├── Models
        │   │   ├── Plugin.php
        │   │   ├── Services
        │   │   └── Util
        │   ├── locales
        │   │   ├── en_US
        │   │   │   └── LC_MESSAGES
        │   │   │       ├── NombrePlugin.mo (2)
        │   │   │       └── NombrePlugin.po (2)
        │   ├── public
        │   │   ├── css
        │   │   │   ├── plugin.css
        │   │   │   ├── plugin.css.map
        │   │   │   ├── plugin.min.css
        │   │   │   └── plugin.scss
        │   │   └── js
        │   │       ├── plugin.js
        │   │       └── plugin.min.js
        │   └── themes
        │       └── material-blue
        │           └── views (3)
        │               ├── login
        │               │   └── index.inc
        │               └── userpreferences
        │                   └── preferences-security.inc
        └── version.json (4)

.. only:: lang_en

  .. code::

    plugins/
    └── PluginName (1)
        ├── base.php
        ├── CODE_OF_CONDUCT.md
        ├── composer.json
        ├── LICENSE
        ├── README.md
        ├── src
        │   ├── lib
        │   │   ├── Controllers
        │   │   ├── Models
        │   │   ├── Plugin.php
        │   │   ├── Services
        │   │   └── Util
        │   ├── locales
        │   │   ├── en_US
        │   │   │   └── LC_MESSAGES
        │   │   │       ├── PluginName.mo (2)
        │   │   │       └── PluginName.po (2)
        │   ├── public
        │   │   ├── css
        │   │   │   ├── plugin.css
        │   │   │   ├── plugin.css.map
        │   │   │   ├── plugin.min.css
        │   │   │   └── plugin.scss
        │   │   └── js
        │   │       ├── plugin.js
        │   │       └── plugin.min.js
        │   └── themes
        │       └── material-blue
        │           └── views (3)
        │               ├── login
        │               │   └── index.inc
        │               └── userpreferences
        │                   └── preferences-security.inc
        └── version.json (4)


Directory and file names need to be set in the following way:

1. Directory name within the plugin name: Example: **Authenticator**
2. Filename within the plugin name in lowercase: Example: **authenticator.po**
3. View's name should match with the controller's name in MVC pattern. It could be overridden by setting the name of the view in the controller's code
4. 'version.json' file is used by JavaScript code for checking if the plugin is up-to-date.

`Plugin` (whithin 'Plugin.php' file) is the main class which will receive sysPass' events through the observer pattern. It must extends the abstract class 'SP\Plugin\PluginBase' which is responsible to make the plugin's data available.

Methods
-------

The following methods must be implemented in 'Plugin' class

init
::::

Method that is called every time the plugin is executed. The dependency injection container will be passed.

.. code-block:: php

  /**
   * Plugin initialization
   *
   * @param ContainerInterface $dic
   */
  public function init(ContainerInterface $dic)
  {
      $this->base = dirname(__DIR__);
      $this->themeDir = $this->base . DIRECTORY_SEPARATOR . 'themes' . DIRECTORY_SEPARATOR . $dic->get(ThemeInterface::class)->getThemeName();

      $this->setLocales();

      $this->dic = $dic;

      $this->session = $this->dic->get(ContextInterface::class);
  }

updateEvent
:::::::::::

Method that is called when an event is emitted

.. code-block:: php

  /**
   * Update event
   *
   * @param string $event Event's name
   * @param mixed  $object
   */
  public function updateEvent($event, $object) {}

getEvents
:::::::::

Method that returns an array of strings with the events that the plugin will be subscribed to

.. code-block:: php

  /**
   * Returns the events implemented by the observer
   *
   * @return array
   */
  public function getEvents()
  {
      return ['show.userSettings', 'login.finish'];
  }

getJsResources
::::::::::::::

Method that returns an array of strings with the Javascript resources required by the plugin

.. code-block:: php

  /**
   * Returns JS resources required by the plugin
   *
   * @return array
   */
  public function getJsResources()
  {
      return ['plugin.min.js'];
  }

getAuthor
:::::::::

Method that returns the plugin's author

.. code-block:: php

    /**
     * Returns the plugin's author
     *
     * @return string
     */
    public function getAuthor()
    {
        return 'Rubén D.';
    }

getVersion
::::::::::

Method that returns an array of integers with the plugin's version

.. code-block:: php

  /**
   * Returns the plugin's version
   *
   * @return array
   */
  public function getVersion()
  {
      return [1, 0];
  }

getCompatibleVersion
::::::::::::::::::::

Method that returns an array of integers with the minimum sysPass compatible version

.. code-block:: php

  /**
   * Returns the minimum sysPass compatible version
   *
   * @return array
   */
  public function getCompatibleVersion()
  {
      return [2, 0];
  }

getCssResources
:::::::::::::::

Method that returns an array of strings with the CSS resources required by the plugin

.. code-block:: php

  /**
   * Returns the CSS resources required by the plugin
   *
   * @return array
   */
  public function getCssResources()
  {
      return [];
  }

getName
:::::::

Method that returns the plugin's name

.. code-block:: php

  /**
   * Returns the plugin's name
   *
   * @return string
   */
  public function getName()
  {
      return self::PLUGIN_NAME;
  }

getData
:::::::

Method that returns the plugin's data

.. code-block:: php

  /**
   * @return AuthenticatorData
   */
  public function getData()
  {
      if ($this->data === null
          && $this->session->isLoggedIn()
          && $this->pluginOperation !== null
      ) {
          $this->loadData();
      }

      return parent::getData();
  }

onLoad
::::::

Method that will be called when the plugin is initialized

.. code-block:: php

  /**
   * onLoad
   */
  public function onLoad()
  {
      $this->loadData();
  }

upgrade
:::::::

Method that receives the current sysPass version and would run a task if it needs to upgrade.
This method will be called whenever a new sysPass version is detected.

.. code-block:: php

  /**
   * @param string          $version
   * @param PluginOperation $pluginOperation
   * @param mixed           $extra
   *
   * @throws Services\AuthenticatorException
   */
  public function upgrade(string $version, PluginOperation $pluginOperation, $extra = null)
  {
      switch ($version) {
          case '310.19012201':
              (new UpgradeService($pluginOperation))->upgrade_310_19012201($extra);
              break;
      }
  }


Example
-------

.. code-block:: php

  namespace SP\Modules\Web\Plugins\Authenticator;

  use Psr\Container\ContainerInterface;
  use SP\Core\Context\ContextInterface;
  use SP\Core\Context\SessionContext;
  use SP\Core\Events\Event;
  use SP\Core\UI\ThemeInterface;
  use SP\Modules\Web\Plugins\Authenticator\Controllers\PreferencesController;
  use SP\Modules\Web\Plugins\Authenticator\Models\AuthenticatorData;
  use SP\Modules\Web\Plugins\Authenticator\Services\UpgradeService;
  use SP\Modules\Web\Plugins\Authenticator\Util\PluginContext;
  use SP\Mvc\Controller\ExtensibleTabControllerInterface;
  use SP\Plugin\PluginBase;
  use SP\Plugin\PluginOperation;
  use SplSubject;

  /**
   * Class Plugin
   *
   * @package SP\Modules\Web\Plugins\Authenticator
   * @property AuthenticatorData $data
   */
  class Plugin extends PluginBase
  {
      const PLUGIN_NAME = 'Authenticator';
      const VERSION_URL = 'https://raw.githubusercontent.com/sysPass/plugin-Authenticator/master/version.json';
      const RECOVERY_GRACE_TIME = 86400;
      /**
       * @var ContainerInterface
       */
      private $dic;
      /**
       * @var SessionContext
       */
      private $session;

      /**
       * Receive update from subject
       *
       * @link  http://php.net/manual/en/splobserver.update.php
       *
       * @param SplSubject $subject <p>
       *                            The <b>SplSubject</b> notifying the observer of an update.
       *                            </p>
       *
       * @return void
       * @since 5.1.0
       */
      public function update(SplSubject $subject)
      {
      }

      /**
       * Plugin initialization
       *
       * @param ContainerInterface $dic
       */
      public function init(ContainerInterface $dic)
      {
          $this->base = dirname(__DIR__);
          $this->themeDir = $this->base . DIRECTORY_SEPARATOR . 'themes' . DIRECTORY_SEPARATOR . $dic->get(ThemeInterface::class)->getThemeName();

          $this->setLocales();

          $this->dic = $dic;

          $this->session = $this->dic->get(ContextInterface::class);
      }

      /**
       * Updating event
       *
       * @param string $eventType Nombre del evento
       * @param Event  $event     Objeto del evento
       *
       * @throws \SP\Core\Exceptions\InvalidClassException
       * @throws \Exception
       */
      public function updateEvent($eventType, Event $event)
      {
          switch ($eventType) {
              case 'show.userSettings':
                  $this->loadData();
                  (new PreferencesController(
                      $event->getSource(ExtensibleTabControllerInterface::class),
                      $this,
                      $this->dic)
                  )->setUp();
                  break;
              case 'login.finish':
                  $this->loadData();
                  $this->checkLogin($event);
                  break;
          }
      }

      /**
       * Load plugin's data for current user
       */
      private function loadData()
      {
          try {
              $this->data = $this->pluginOperation->get(
                  $this->session->getUserData()->getId(),
                  AuthenticatorData::class
              );
          } catch (\Exception $e) {
              processException($e);
          }
      }

      /**
       * Check 2FA within log in
       *
       * @param Event $event
       *
       * @throws \SP\Core\Context\ContextException
       */
      private function checkLogin(Event $event)
      {
          $pluginContext = $this->dic->get(PluginContext::class);

          if ($this->data !== null
              && $this->data->isTwofaEnabled()
          ) {
              $pluginContext->setTwoFApass(false);
              $this->session->setAuthCompleted(false);

              $eventData = $event->getEventMessage()->getExtra();

              if (isset($eventData['redirect'][0])
                  && is_callable($eventData['redirect'][0])
              ) {
                  $this->session->setTrasientKey('redirect', $eventData['redirect'][0]('authenticatorLogin/index'));
              } else {
                  $this->session->setTrasientKey('redirect', 'index.php?r=authenticatorLogin/index');
              }
          } else {
              $pluginContext->setTwoFApass(true);
              $this->session->setAuthCompleted(true);
          }
      }

      /**
       * @return AuthenticatorData
       */
      public function getData()
      {
          if ($this->data === null
              && $this->session->isLoggedIn()
              && $this->pluginOperation !== null
          ) {
              $this->loadData();
          }

          return parent::getData();
      }

      /**
       * Returns the events implemented by the observer
       *
       * @return array
       */
      public function getEvents()
      {
          return ['show.userSettings', 'login.finish'];
      }

      /**
       * Returns the JS resources required by the plugin
       *
       * @return array
       */
      public function getJsResources()
      {
          return ['plugin.min.js'];
      }

      /**
       * Returns the plugin's author
       *
       * @return string
       */
      public function getAuthor()
      {
          return 'Rubén D.';
      }

      /**
       * Returns the plugin's version
       *
       * @return array
       */
      public function getVersion()
      {
          return [2, 1, 0];
      }

      /**
       * Returns the sysPass compatible version
       *
       * @return array
       */
      public function getCompatibleVersion()
      {
          return [3, 1];
      }

      /**
       * Returns the CSS resources required by the plugin
       *
       * @return array
       */
      public function getCssResources()
      {
          return ['plugin.min.css'];
      }

      /**
       * Returns the plugin's name
       *
       * @return string
       */
      public function getName()
      {
          return self::PLUGIN_NAME;
      }

      /**
       * Removes the data for the given item's Id
       *
       * @param $id
       *
       * @throws \SP\Core\Exceptions\ConstraintException
       * @throws \SP\Core\Exceptions\QueryException
       * @throws \SP\Repositories\NoSuchItemException
       */
      public function deleteDataForId($id)
      {
          $this->pluginOperation->delete((int)$id);
      }

      /**
       * onLoad
       */
      public function onLoad()
      {
          $this->loadData();
      }

      /**
       * @param string          $version
       * @param PluginOperation $pluginOperation
       * @param mixed           $extra
       *
       * @throws Services\AuthenticatorException
       */
      public function upgrade(string $version, PluginOperation $pluginOperation, $extra = null)
      {
          switch ($version) {
              case '310.19012201':
                  (new UpgradeService($pluginOperation))->upgrade_310_19012201($extra);
                  break;
          }
      }
  }

Events
-------

When an event is emitted the generating class instance is included as an argument, so it could be possible to access to the class events.

Events may include 'SP\Core\Events\EventMessage' class which may contain additional data to pass into the plugin.

Currently, the generated events are the following:

==================================  ========================  =========================================================================
Event                               Class                     Description
==================================  ========================  =========================================================================
acl.deny
check.notification
check.tempMasterPassword
clear.eventlog
clear.track
copy.account.pass
create.account
create.authToken
create.category
create.client
create.customField
create.itemPreset
create.notification
create.plugin
create.publicLink
create.publicLink.account
create.tag
create.tempMasterPassword
create.user
create.userGroup
create.userProfile
database.query
database.rollback
database.transaction.begin
database.transaction.end
database.transaction.rollback
delete.account
delete.account.selection
delete.accountFile
delete.accountFile.selection
delete.accountHistory
delete.accountHistory.selection
delete.authToken
delete.authToken.selection
delete.category
delete.client
delete.client.selection
delete.customField
delete.customField.selection
delete.itemPreset
delete.notification
delete.notification.selection
delete.plugin
delete.plugin.selection
delete.publicLink
delete.publicLink.selection
delete.tag
delete.tag.selection
delete.user
delete.user.selection
delete.userGroup
delete.userGroup.selection
delete.userProfile
delete.userProfile.selection
download.accountFile
download.backupAppFile
download.backupDbFile
download.configBackupFile
download.exportFile
download.logFile
edit.account
edit.account.bulk
edit.account.pass
edit.account.restore
edit.authToken
edit.category
edit.client
edit.customField
edit.itemPreset
edit.notification
edit.plugin.available
edit.plugin.disable
edit.plugin.enable
edit.plugin.reset
edit.plugin.unavailable
edit.publicLink.refresh
edit.tag
edit.user
edit.user.pass
edit.user.password
edit.userGroup
edit.userProfile
expire.tempMasterPassword
import.ldap.end
import.ldap.groups
import.ldap.start
import.ldap.users
ldap.bind
ldap.check.connection
ldap.check.group
ldap.check.params
ldap.connect
ldap.connect.tls
ldap.getAttributes
ldap.search
ldap.search.group
ldap.unbind
list.accountFile
login.auth.browser
login.auth.database
login.auth.ldap
login.checkUser.changePass
login.checkUser.disabled
login.finish
login.info
login.masterPass
login.masterPass.temporary
login.preferences.load
login.session.load
plugin.load
plugin.load.error
refresh.authToken
refresh.masterPassword
refresh.masterPassword.hash
request.account
request.user.passReset
reset.min.css
restore.accountHistory
run.backup.end
run.backup.process
run.backup.start
run.export.end
run.export.start
run.export.verify
run.import.csv
run.import.end
run.import.keepass
run.import.start
run.import.syspass
save.config.account
save.config.dokuwiki
save.config.general
save.config.ldap
save.config.mail
save.config.wiki
search.category
search.client
search.tag
search.userGroup
send.mail
send.mail.check
session.cookie_httponly
session.gc_maxlifetime
session.save_handler
session.timeout
show.account
show.account.bulkEdit
show.account.copy
show.account.create
show.account.delete
show.account.edit
show.account.editpass
show.account.history
show.account.link
show.account.pass
show.account.request
show.account.search
show.accountFile
show.authToken
show.authToken.create
show.authToken.edit
show.category
show.category.create
show.category.edit
show.client
show.client.create
show.client.edit
show.config
show.customField
show.customField.create
show.customField.edit
show.itemPreset
show.itemPreset.create
show.itemPreset.edit
show.itemlist.accesses
show.itemlist.items
show.itemlist.security
show.notification
show.notification.create
show.notification.edit
show.plugin
show.publicLink
show.publicLink.create
show.publicLink.edit
show.tag
show.tag.create
show.tag.edit
show.user
show.user.create
show.user.edit
show.user.editPass
show.userGroup
show.userGroup.create
show.userGroup.edit
show.userProfile
show.userProfile.create
show.userProfile.edit
show.userSettings
track.add
track.delay
unlock.track
update.masterPassword.customFields
update.masterPassword.end
update.masterPassword.hash
update.masterPassword.start
upgrade.app.end
upgrade.app.start
upgrade.authToken.end
upgrade.authToken.process
upgrade.authToken.start
upgrade.config.end
upgrade.config.process
upgrade.config.start
upgrade.customField.end
upgrade.customField.process
upgrade.customField.start
upgrade.db.end
upgrade.db.process
upgrade.db.start
upgrade.publicLink.end
upgrade.publicLink.process
upgrade.publicLink.start
upload.accountFile
wiki.aclCheck
wiki.getPage
wiki.getPageHTML
wiki.getPageInfo
==================================  ========================  =========================================================================
