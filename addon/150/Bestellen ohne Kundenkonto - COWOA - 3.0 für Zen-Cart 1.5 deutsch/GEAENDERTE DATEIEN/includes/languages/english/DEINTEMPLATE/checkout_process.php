<?php
/**
 * @package languageDefines
 * @copyright Copyright 2003-2011 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: login.php for COWOA 3.0 ZC150 2011-09-17 10:10:40Z webchills $
 */

define('EMAIL_TEXT_SUBJECT', 'Order Confirmation');
define('EMAIL_TEXT_HEADER', 'Order Confirmation');
define('EMAIL_TEXT_FROM',' from ');  //added to the EMAIL_TEXT_HEADER, above on text-only emails
define('EMAIL_THANKS_FOR_SHOPPING','Thanks for shopping with us today!');
define('EMAIL_DETAILS_FOLLOW','The following are the details of your order.');
define('EMAIL_TEXT_ORDER_NUMBER', 'Order Number:');
if($_SESSION['COWOA']) $COWOA=TRUE;

if($COWOA)
define('EMAIL_TEXT_INVOICE_URL', 'Check order status:');
else
define('EMAIL_TEXT_INVOICE_URL', 'Detailed Invoice:');

if($COWOA)
define('EMAIL_TEXT_INVOICE_URL_CLICK', 'Click here to check the status of your order');
else
define('EMAIL_TEXT_INVOICE_URL_CLICK', 'Click here for a Detailed Invoice');

define('EMAIL_TEXT_DATE_ORDERED', 'Date Ordered:');
define('EMAIL_TEXT_PRODUCTS', 'Products');
define('EMAIL_TEXT_SUBTOTAL', 'Sub-Total:');
define('EMAIL_TEXT_TAX', 'Tax:');
define('EMAIL_TEXT_SHIPPING', 'Shipping: ');
define('EMAIL_TEXT_TOTAL', 'Total:');
define('EMAIL_TEXT_DELIVERY_ADDRESS', 'Delivery Address');
define('EMAIL_TEXT_BILLING_ADDRESS', 'Billing Address');
define('EMAIL_TEXT_PAYMENT_METHOD', 'Payment Method');

define('EMAIL_SEPARATOR', '------------------------------------------------------');
define('TEXT_EMAIL_VIA', 'via');

// suggest not using # vs No as some spamm protection block emails with these subjects
define('EMAIL_ORDER_NUMBER_SUBJECT', ' No: ');
define('HEADING_ADDRESS_INFORMATION','Address Information');
define('HEADING_SHIPPING_METHOD','Shipping Method');