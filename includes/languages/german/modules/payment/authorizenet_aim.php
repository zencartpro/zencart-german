<?php
/**
 * Authorize.net AIM Payment Module V.1.0 created by Eric Stamper - 01/30/2004 Released under GPL
 *
  * @package languageDefines
 * @copyright Copyright 2003-2005 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @translator: cyaneo/hugo13/wflohr/maleborg	http://www.zen-cart.at	2007-01-03
 * @version $Id$
 */


// Admin Configuration Items
define('MODULE_PAYMENT_AUTHORIZENET_AIM_TEXT_ADMIN_TITLE', 'Authorize.net (AIM)');
define('MODULE_PAYMENT_AUTHORIZENET_AIM_TEXT_DESCRIPTION', (defined('MODULE_PAYMENT_AUTHORIZENET_AIM_TESTMODE') && MODULE_PAYMENT_AUTHORIZENET_AIM_TESTMODE == 'Produktion' ? '' : '<strong>Automatischer Kreditkartentest Info:</strong><br /><br />Visa#: 4007000000027<br />MC#: 5424000000000015<br />Discover#: 6011000000000012<br />AMEX#: 370000000000002<br /><br /><strong>Hinweis:</strong> Diese Kreditkartennummern bekommen eine Bestätigung für die Ablehnung in Echtzeit zurück und eine Überprüfung erfolgt im Testmodus. Als Ablaufdatum kann jedes beliebige Datum und als Kreditkarten Sicherheitscode jeder beliebige 3-Stellige bzw. 4-Stellige (AMEX) Code eingegeben werden.<br /><br /><strong>Automatisch abgelehnte Kreditkartennummer:</strong><br /><br />Nummer: 4222222222222<br /><br />Diese Kreditkartennummer kann für Testzwecke zum Erhalt der Ablehungsbestätigung verwendet werden.<br /><br />'));
// Catalog Items
define('MODULE_PAYMENT_AUTHORIZENET_AIM_TEXT_CATALOG_TITLE', 'Kreditkarte');  // Payment option title as displayed to the customer
define('MODULE_PAYMENT_AUTHORIZENET_AIM_TEXT_CREDIT_CARD_TYPE', 'Kreditkarte:');
define('MODULE_PAYMENT_AUTHORIZENET_AIM_TEXT_CREDIT_CARD_OWNER', 'Karteninhaber:');
define('MODULE_PAYMENT_AUTHORIZENET_AIM_TEXT_CREDIT_CARD_NUMBER', 'Kartennummer:');
define('MODULE_PAYMENT_AUTHORIZENET_AIM_TEXT_CREDIT_CARD_EXPIRES', 'Karte gültig bis:');
define('MODULE_PAYMENT_AUTHORIZENET_AIM_TEXT_CVV', 'Sicherheitscode (<a href="javascript:popupWindow(\'' . zen_href_link(FILENAME_POPUP_CVV_HELP) . '\')">' . 'Was ist das?' . '</a>');
define('MODULE_PAYMENT_AUTHORIZENET_AIM_TEXT_POPUP_CVV_LINK', 'Was ist das?');
define('MODULE_PAYMENT_AUTHORIZENET_AIM_TEXT_JS_CC_OWNER', '* Der Name des Karteninhabers muss aus mindestens ' . CC_OWNER_MIN_LENGTH . ' Zeichen bestehen.\n');
define('MODULE_PAYMENT_AUTHORIZENET_AIM_TEXT_JS_CC_NUMBER', '* Die Kreditkartennummer muss aus mindestens ' . CC_NUMBER_MIN_LENGTH . ' Zeichen bestehen.\n');
define('MODULE_PAYMENT_AUTHORIZENET_AIM_TEXT_JS_CC_CVV', '* Den 3 bzw. 4-Stelligen Sicherheitscode finden Sie auf der Rückseite Ihrer Kreditkarte.\n');
define('MODULE_PAYMENT_AUTHORIZENET_AIM_TEXT_DECLINED_MESSAGE', 'Diese Kreditkarte wurde abgelehnt. Bitte korrigieren Sie Ihre Eingaben und versuchen Sie es noch einmal oder kontaktieren Sie uns für weitere Instruktionen.');
define('MODULE_PAYMENT_AUTHORIZENET_AIM_TEXT_ERROR', 'Kreditkarten Fehler!');


?>