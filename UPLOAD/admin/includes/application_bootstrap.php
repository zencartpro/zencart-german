<?php
/**
 * Zen Cart German Specific
 * @package admin
 * @copyright Copyright 2003-2020 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license https://www.zen-cart-pro.at/license/3_0.txt GNU General Public License V3.0
 * @version $Id: application_bootstrap.php 2 2020-05-02 19:44:36Z webchills $
 */

/**
 * boolean if true the autoloader scripts will be parsed and their output shown. For debugging purposes only.
 */
if (!defined('DEBUG_AUTOLOAD')) define('DEBUG_AUTOLOAD', false);
/**
 * boolean used to see if we are in the admin script, obviously set to false here.
 * DO NOT REMOVE THE define BELOW. WILL BREAK ADMIN
 */
define('IS_ADMIN_FLAG', true);
/**
 * integer saves the time at which the script started.
 */
define('PAGE_PARSE_START_TIME', microtime());
// set php_self in the local scope
$serverScript = basename($_SERVER['SCRIPT_NAME']);
$PHP_SELF = isset($_SERVER['SCRIPT_NAME']) ? $serverScript : 'home.php';
$PHP_SELF = isset($_GET['cmd']) ? basename($_GET['cmd'] . '.php') : $PHP_SELF;
$PHP_SELF = htmlspecialchars($PHP_SELF);
$_SERVER['SCRIPT_NAME'] = str_replace($serverScript, '', $_SERVER['SCRIPT_NAME']) . $PHP_SELF;
// Suppress html from error messages
@ini_set("html_errors","0");
/*
 * Get time zone info from PHP config
*/
@date_default_timezone_set(date_default_timezone_get());

if (!defined('__DIR__')) define('__DIR__', dirname(__FILE__));
if (!defined('DIR_FS_ADMIN')) define('DIR_FS_ADMIN', preg_replace('#/includes/$#', '/', realpath(__DIR__ . '/../') . '/'));

/**
 * Set the local configuration parameters - mainly for developers
 */
if (file_exists('includes/local/configure.php')) {
    /**
     * load any local(user created) configure file.
     */
    include('includes/local/configure.php');
}
/**
 * check for and load application configuration parameters
 */
if (file_exists('includes/configure.php')) {
    /**
     * load the main configure file.
     */
    include('includes/configure.php');
}
/**
 * set the level of error reporting
 *
 * Note STRICT_ERROR_REPORTING should never be set to true on a production site. <br />
 * It is mainly there to show php warnings during testing/bug fixing phases.<br />
 * note for strict error reporting we also turn on show_errors as this may be disabled<br />
 * in php.ini. Otherwise we respect the php.ini setting
 *
 */
if (defined('STRICT_ERROR_REPORTING') && STRICT_ERROR_REPORTING == true) {
    @ini_set('display_errors', TRUE);
    error_reporting(E_ALL);
} else {
    error_reporting(0);
}
if (!defined('DIR_FS_CATALOG') || !is_dir(DIR_FS_CATALOG.'/includes/classes') || !defined('DB_TYPE') || DB_TYPE == '') {
    if (file_exists('../includes/templates/template_default/templates/tpl_zc_install_suggested_default.php')) {
        require('../includes/templates/template_default/templates/tpl_zc_install_suggested_default.php');
        exit;
    } elseif (file_exists('../zc_install/index.php')) {
        echo 'ERROR: Admin configure.php not found. Suggest running install? <a href="../zc_install/index.php">Click here for installation</a>';
    } else {
        die('ERROR: admin/includes/configure.php file not found. Suggest running zc_install/index.php?');
    }
}
/**
 * check for and load system defined path constants
 */
if (file_exists('includes/defined_paths.php')) {
    /**
     * load the system-defined path constants
     */
    require('includes/defined_paths.php');
} else {
    die('ERROR: /includes/defined_paths.php file not found. Cannot continue.');
    exit;
}
/**
 * ignore version-check if INI file setting has been set
 */
if (file_exists(DIR_FS_ADMIN . 'includes/local/skip_version_check.ini')) {
    $lines = @file(DIR_FS_ADMIN . 'includes/local/skip_version_check.ini');
    if (is_array($lines)) {
        foreach($lines as $line) {
            if (substr($line,0,14)=='admin_configure_php_check=') $check_cfg=substr(trim(strtolower(str_replace('admin_configure_php_check=','',$line))),0,3);
        }
    }
}
/*
// turned off for now
  if ($check_cfg != 'off') {
    // if the admin/includes/configure.php file doesn't contain admin-related content, throw error
    $zc_pagepath = str_replace(basename($PHP_SELF),'',__FILE__); //remove page name from full path of current page
    $zc_pagepath = str_replace(array('\\','\\\\'),'/',$zc_pagepath); // convert '\' marks to '/'
    $zc_pagepath = str_replace('//','/',$zc_pagepath); //convert doubles to single
    $zc_pagepath = str_replace(strrchr($zc_pagepath,'/'),'',$zc_pagepath); // remove trailing '/'
    $zc_adminpage = str_replace('\\','/',DIR_FS_ADMIN); //convert "\" to '/'
    $zc_adminpage = str_replace('//','/',$zc_adminpage); // remove doubles
    $zc_adminpage = str_replace(strrchr($zc_adminpage,'/'),'',$zc_adminpage); // remove trailing '/'
    if (!defined('DIR_WS_ADMIN') || $zc_pagepath != $zc_adminpage ) {
      echo ('ERROR: The admin/includes/configure.php file has invalid configuration. Please rebuild, or verify specified paths.');
      if (file_exists('../zc_install/index.php')) {
        echo '<br /><a href="../zc_install/index.php">Click here for installation</a>';
      }
      echo '<br /><br /><br /><br />['.$zc_pagepath.']&nbsp;&nbsp;&nbsp;&laquo;&raquo;&nbsp;&nbsp;&nbsp;[' .$zc_adminpage.']<br />';
    }
  }
*/
/**
 * include the list of extra configure files
 */
if ($za_dir = @dir(DIR_WS_INCLUDES . 'extra_configures')) {
    while ($zv_file = $za_dir->read()) {
        if (preg_match('~^[^\._].*\.php$~i', $zv_file) > 0) {
            /**
             * load any user/contribution specific configuration files.
             */
            include(DIR_WS_INCLUDES . 'extra_configures/' . $zv_file);
        }
    }
    $za_dir->close();
}
/**
 * init some vars
 */
$template_dir = '';
define('DIR_WS_TEMPLATES', DIR_WS_INCLUDES . 'templates/');
/**
 * autoloading
 */
require DIR_FS_CATALOG . DIR_WS_CLASSES . 'class.base.php';

require 'includes/classes/AdminRequestSanitizer.php';
require 'includes/init_includes/init_file_db_names.php';
require 'includes/init_includes/init_database.php';