<?php
/**
 * @package languageDefines
 * @copyright Copyright 2003-2006 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @translator: cyaneo/hugo13/wflohr/maleborg	http://www.zen-cart.at	2007-01-03
 * @version $Id: paypal.php 5314 2006-12-21 02:23:06Z drbyte $
 */

  define('MODULE_PAYMENT_PAYPAL_TEXT_ADMIN_TITLE', 'PayPal Zahlungsbest&auml;tigung');
  if (IS_ADMIN_FLAG === true) {
define('MODULE_PAYMENT_PAYPAL_TEXT_DESCRIPTION', '<strong>PayPal</strong>');
  } else {

  }
  // to show the PayPal logo as the payment option name, use this:  https://www.paypal.com/en_US/i/logo/PayPal_mark_37x23.gif
  // to show CC icons with PayPal, use this instead:  https://www.paypal.com/en_US/i/bnr/horizontal_solution_PPeCheck.gif
define('MODULE_PAYMENT_PAYPALWPP_MARK_BUTTON_IMG', 'https://www.paypal.com/en_US/i/logo/PayPal_mark_37x23.gif' . ' !!!TRANSLATE!!! file: includes/languages/LANGUAGE/modules/payment/paypal.php at line 357');
define('MODULE_PAYMENT_PAYPALWPP_MARK_BUTTON_ALT', 'Checkout with PayPal' . ' !!!TRANSLATE!!! file: includes/languages/LANGUAGE/modules/payment/paypal.php at line 357');
define('MODULE_PAYMENT_PAYPAL_ACCEPTANCE_MARK_TEXT', 'Save time. Check out securely. <br />Pay without sharing your financial information.' . ' !!!TRANSLATE!!! file: includes/languages/LANGUAGE/modules/payment/paypal.php at line 357');
define('MODULE_PAYMENT_PAYPAL_TEXT_CATALOG_LOGO', '<img src="' . MODULE_PAYMENT_PAYPALWPP_MARK_BUTTON_IMG . '" alt="' . MODULE_PAYMENT_PAYPALWPP_MARK_BUTTON_ALT . '" title="' . MODULE_PAYMENT_PAYPALWPP_MARK_BUTTON_ALT . '" /> &nbsp;' .  '<span class="smallText">' . MODULE_PAYMENT_PAYPAL_ACCEPTANCE_MARK_TEXT . '</span>' . ' !!!TRANSLATE!!! file: includes/languages/LANGUAGE/modules/payment/paypal.php at line 357');
define('MODULE_PAYMENT_PAYPAL_ENTRY_FIRST_NAME', 'Vorname:');
define('MODULE_PAYMENT_PAYPAL_PURCHASE_DESCRIPTION_ITEMNUM', 'Store Receipt' . ' !!!TRANSLATE!!! file: includes/languages/LANGUAGE/modules/payment/paypal.php at line 357');



?>