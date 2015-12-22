<?php
/**
 * document_general header_php.php 
 *
 * @package page
 * @copyright Copyright 2003-2016 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart-pro.at/license/2_0.txt GNU Public License V2.0
 * @version $Id: header_php.php 729 2011-08-09 15:49:16Z hugo13 $
 */

  // This should be first line of the script:
  $zco_notifier->notify('NOTIFY_HEADER_START_DOCUMENT_GENERAL_INFO');

  require(DIR_WS_MODULES . zen_get_module_directory('require_languages.php'));

  // This should be last line of the script:
  $zco_notifier->notify('NOTIFY_HEADER_END_DOCUMENT_GENERAL_INFO');
?>