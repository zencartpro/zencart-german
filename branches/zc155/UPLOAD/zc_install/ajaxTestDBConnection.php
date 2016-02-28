<?php
/**
 * ajaxTestDBConnection.php
 * @package Installer
 * @copyright Copyright 2003-2016 Zen Cart Development Team
 * @license http://www.zen-cart-pro.at/license/2_0.txt GNU Public License V2.0
 * @version $Id: ajaxTestDBConnection.php 1 2016-02-28 21:59:53Z webchills $
 */
define('IS_ADMIN_FLAG', false);
if (!defined('__DIR__')) define('__DIR__', dirname(__FILE__));
define('DIR_FS_INSTALL', __DIR__ . '/');
define('DIR_FS_ROOT', realpath(__DIR__ . '/../') . '/');

require(DIR_FS_INSTALL . 'includes/application_top.php');

$systemChecker = new systemChecker();

$error = TRUE;
if (isset($_POST['db_name']))
{
  zcRegistry::setValue('db_host', $_POST['db_host']);
  zcRegistry::setValue('db_user', $_POST['db_user']);
  zcRegistry::setValue('db_password', $_POST['db_password']);
  zcRegistry::setValue('db_name', $_POST['db_name']);
  zcRegistry::setValue('db_charset', $_POST['db_charset']);
  $errorList = $systemChecker -> runTests('database');
  if (count($errorList) != 0)
  {
    $errorList = $errorList['newDatabaseCheck'];
    $error = TRUE;
  } else
  {
    $error  = FALSE;
  }
}
echo json_encode(array('error'=>$error, 'errorList'=>$errorList));
