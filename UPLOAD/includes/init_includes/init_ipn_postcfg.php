<?php
/**
 * Load the IPN checkout-language data 
 * see {@link  http://www.zen-cart.com/wiki/index.php/Developers_API_Tutorials#InitSystem wikitutorials} for more details.
 *
 * @package initSystem
 * @copyright Copyright 2003-2019 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart-pro.at/license/2_0.txt GNU Public License V2.0
 * @version $Id: init_ipn_postcfg.php 730 2019-06-15 17:49:16Z webchills $
 */
if (!defined('IS_ADMIN_FLAG')) {
  die('Illegal Access');
}

/**
 * require language defines
 * require('includes/languages/english/checkout_process.php');
 */
if (!isset($_SESSION['language'])) $_SESSION['language'] = 'english';

require(zen_get_file_directory(DIR_FS_CATALOG . DIR_WS_LANGUAGES . $_SESSION['language'], 'checkout_process.php', 'false'));

?>
