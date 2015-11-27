<?php
/**
 * ajax front controller
 *
 * @package core
 * @copyright Copyright 2003-2015 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version GIT: $Id: Author: Ian Wilson   Modified in v1.5.5 $
 */
require ('includes/application_top.php');
$language_page_directory = DIR_WS_LANGUAGES.$_SESSION['language'].'/';
if (isset ($_GET['act'])&&isset ($_GET['method'])) {
  $className = 'zc'.ucfirst ($_GET['act']);
  $classFile = $className.'.php';
  $basePath = DIR_FS_CATALOG.DIR_WS_CLASSES;
  if (file_exists (basename(realpath($basePath. 'ajax/'  .$classFile)))) {
    require basename(realpath($basePath .'ajax/'  . $classFile));
    $class = new $className ();
    if (method_exists ($class, $_GET['method'])) {
      $result = call_user_func (array(
          $class,
          $_GET['method']
      ));
      $result = htmlentities((string)$result, ENT_QUOTES, 'utf-8', FALSE);
      echo json_encode ($result);exit();
    } else {
      echo 'method error';
    }
  }
}