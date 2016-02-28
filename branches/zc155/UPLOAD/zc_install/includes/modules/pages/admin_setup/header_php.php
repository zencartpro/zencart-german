<?php
/**
 * @package Installer
 * @copyright Copyright 2003-2016 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart-pro.at/license/2_0.txt GNU Public License V2.0
 * @version $Id: header_php.php 743 2016-02-28 16:21:39Z webchills $
 */

  @unlink(DEBUG_LOG_FOLDER . '/progress.json');
  require (DIR_FS_INSTALL . 'includes/classes/class.zcDatabaseInstaller.php');
  $changedDir = (bool)$_POST['changedDir'];
  $adminDir = $_POST['adminDir'];
  $adminNewDir = $_POST['adminNewDir'];
  if (defined('DEVELOPER_MODE') && DEVELOPER_MODE === true)
  {
    $admin_password = 'developer1';
  } else {
    $admin_password = zen_create_PADSS_password();
  }
  if (isset($_POST['upgrade_mode']) && $_POST['upgrade_mode'] == 'yes')
  {
    $isUpgrade = TRUE;
  } else if (isset($_POST['http_server_catalog']))
  {
    $isUpgrade = FALSE;
    require (DIR_FS_INSTALL . 'includes/classes/class.zcConfigureFileWriter.php');
    $result = new zcConfigureFileWriter($_POST);

    $errors = $result->errors;
  }
