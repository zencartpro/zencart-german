<?php
/**
 * @package admin
 * @copyright Copyright 2003-2016 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart-pro.at/license/2_0.txt GNU Public License V2.0
 * @version $Id: password_forgotten.php 730 2014-02-09 15:25:16Z webchills $
 */

define('HEADING_TITLE', 'Reset Password');

define('TEXT_ADMIN_EMAIL', 'Admin Email Address: ');
define('TEXT_BUTTON_REQUEST_RESET', 'request reset');
define('TEXT_BUTTON_LOGIN', 'login');
define('TEXT_BUTTON_CANCEL', 'cancel');

define('ERROR_WRONG_EMAIL', 'You entered the wrong email address.');
define('ERROR_WRONG_EMAIL_NULL', 'Go away gooberbrain :-P');
define('MESSAGE_PASSWORD_SENT', 'Thank you. If the email address you entered matches an admin account in our database, then a new password will be sent to that email address.<br />Please read that email and then click "login" below to login with the new temporary password.');

define('TEXT_EMAIL_SUBJECT_PWD_RESET', 'Your Requested change');
define('TEXT_EMAIL_MESSAGE_PWD_RESET', 'A new password was requested from %s.' . "\n\n" . 'Your new temporary password is:' . "\n\n   %s\n\nYou will be asked to choose a new password before logging in.\n\nThis temporary password expires in 24 hours.\n\n\n");

