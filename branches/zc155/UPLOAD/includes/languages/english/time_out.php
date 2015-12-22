<?php
/**
 * @package languageDefines
 * @copyright Copyright 2003-2016 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart-pro.at/license/2_0.txt GNU Public License V2.0
 * @version $Id: time_out.php 729 2011-08-09 15:49:16Z hugo13 $
 */

define('NAVBAR_TITLE', 'Login Time Out');
define('HEADING_TITLE', 'Whoops! Your session has expired.');
define('HEADING_TITLE_LOGGED_IN', 'Whoops! Sorry, but you are not allowed to perform the action requested. ');
define('TEXT_INFORMATION', '<p>If you were placing an order, please login and your shopping cart will be restored. You may then go back to the checkout and complete your final purchases.</p><p>If you had completed an order and wish to review it' . (DOWNLOAD_ENABLED == 'true' ? ', or had a download and wish to retrieve it' : '') . ', please go to your <a href="' . zen_href_link(FILENAME_ACCOUNT, '', 'SSL') . '">My Account</a> page to view your order.</p>');

define('TEXT_INFORMATION_LOGGED_IN', 'You are still logged in to your account and may continue shopping. Please choose a destination from a menu.');

define('HEADING_RETURNING_CUSTOMER', 'Login');
define('TEXT_PASSWORD_FORGOTTEN', 'Forgot Your Password?')