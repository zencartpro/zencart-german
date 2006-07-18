<?php
/**
* @package languageDefines
* @copyright Copyright 2003-2006 Zen Cart Development Team
* @copyright Portions Copyright 2003 osCommerce
* @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
* @version $Id: create_account.php 2 2006-03-31 09:55:33Z rainer $
*/

define('NAVBAR_TITLE', 'Neues Konto erstellen');

define('HEADING_TITLE', 'Meine Kontoinformationen');

define('TEXT_ORIGIN_LOGIN', '<strong class="note">Achtung:</strong> Sollten Sie bereits bei uns registriert sind, melden Sie sich bitte <a href="%s">hier an</a>.');

// greeting salutation
define('EMAIL_SUBJECT', 'Herzlich Willkommen bei ' . STORE_NAME . '!');
define('EMAIL_GREET_MR', 'Sehr geehrter Herr %s,' . "\n\n");
define('EMAIL_GREET_MS', 'Sehr geehrte Frau %s,' . "\n\n");
define('EMAIL_GREET_NONE', 'Sehr geehrte(r) Frau/Herr %s' . "\n\n");

// First line of the greeting
define('EMAIL_WELCOME', 'Herzlich Willkommen bei <strong>' . STORE_NAME . '</strong>.');
define('EMAIL_SEPARATOR', '--------------------');
define('EMAIL_COUPON_INCENTIVE_HEADER', 'Herzlichen Gl�ckwunsch! Um Ihren n�chsten Besuch in unserem Online Shop zu belohnen, haben wir f�r Sie einen Geschenkgutschein reserviert!' . "\n\n");
// your Discount Coupon Description will be inserted before this next define
define('EMAIL_COUPON_REDEEM', 'Diesen Geschenkgutschein k�nnen Sie bei Ihrem n�chsten Einkauf einl�sen. Geben Sie dazu die ' . TEXT_GV_REDEEM . ':<br /> %s w�hrend des Bestellvorgangs ein' . "\n\n");

define('EMAIL_GV_INCENTIVE_HEADER', 'Wenn Sie heute bei uns einkaufen, erhalten Sie den ' . TEXT_GV_NAME . ' f�r %s!' . "\n\n");
define('EMAIL_GV_REDEEM', 'Ihr ' . TEXT_GV_NAME . ' ' . TEXT_GV_REDEEM . ' im Wert von: %s ' . "\n\n" . 'Geben Sie dazu bitte den ' . TEXT_GV_REDEEM . ' w�hrend des Bestellvorgangs ein, nachdem Sie Ihre Artikel ausgesucht haben.' . "\n\n");
define('EMAIL_GV_LINK', 'Oder l�sen Sie den Gutschein mithilfe des folgenden Links ein: ' . "\n\n");
// GV link will automatically be included before this line
define('EMAIL_GV_LINK_OTHER', 'Einmal angegeben, k�nnen Sie den ' . TEXT_GV_NAME . ' verwenden. Oder machen Sie mit dem ' . TEXT_GV_NAME . ' doch anderen eine Freude und schenken Ihn an Ihre Freunde weiter!' . "\n\n");

define('EMAIL_TEXT', 'Sie k�nnen ab sofort unsere umfangreichen Dienstleistungen in Anspruch nehmen, die wir f�r Sie bereit gestellt haben.' . "\n\n" . '
Einige unserer Highlights:' . "\n\n" . '
<strong>Ihr permanenter Warenkorb:' . "\n" . '</strong>Artikel, die Sie in Ihren Warenkorb gelegt haben, bleiben so lange darin erhalten,' . "\n" . 'bis Sie diese kaufen oder wieder aus dem Warenkorb entfernen.' . "\n\n" . '
<strong>Ihr pers�nliches Adressbuch:</strong>' . "\n" . 'Mit Ihrem pers�nlichen Adressbuch k�nnen Sie Ihre Eink�ufe sofort und unkompliziert an eine andere Person senden.' . "\n" . 'Optimal, um z.B. Ihren Freunden ein Geburtstagsgeschenk zu machen!' . "\n\n" . '
<strong>Ihre pers�nliche Bestellhistorie:</strong>' . "\n" . 'Betrachten Sie in Ruhe Ihre gesamten Bestellvorg�nge, die Sie hier in unseren Shop gemacht haben!' . "\n" . 'Ideal, um z.B. Rechnungskopien auszudrucken, oder um sich einfach einen �berblick zu verschaffen!' . "\n\n" . '
<strong>Bewertungen:</strong>' . "\n" . 'Teilen Sie uns und anderen Kunden Ihre Erfahrungen mit unseren Dienstleistungen und Artikeln mit!' . "\n\n\n" . '
');
define('EMAIL_CONTACT', 'Sollten Sie einmal Hilfe zu unseren Diensten und Artikeln ben�tigen, kontaktieren Sie uns unter: <a href="mailto:' . STORE_OWNER_EMAIL_ADDRESS . '">' . STORE_OWNER_EMAIL_ADDRESS . '</a>' . "\n\n\n" . '');
define('EMAIL_GV_CLOSURE', 'Mit freundlichen Gr�ssen,' . "\n\n" . STORE_OWNER . "\nShopinhaber\n\n" . '<a href="' . HTTP_SERVER . DIR_WS_CATALOG . '">' . HTTP_SERVER . DIR_WS_CATALOG . "</a>\n\n");


// email disclaimer - this disclaimer is seperate from all other email disclaimers
define('EMAIL_DISCLAIMER_NEW_CUSTOMER', 'Diese e-Mail Adresse haben wir von Ihnen oder einer unserer Kunden erhalten. Sollten Sie dieses Nachricht zu Unrecht erhalten haben, kontaktieren Sie uns bitte unter %s');

//moved definitions to english.php
//define('TABLE_HEADING_PRIVACY_CONDITIONS', 'Privacy Statement');
//define('TEXT_PRIVACY_CONDITIONS_DESCRIPTION', 'Please acknowledge you agree with our privacy statement by ticking the following box. The privacy statement can be read <a href="' . zen_href_link(FILENAME_PRIVACY, '', 'SSL') . '"><span class="pseudolink">here</span></a>.');
//define('TEXT_PRIVACY_CONDITIONS_CONFIRM', 'I have read and agreed to your privacy statement.');
define('TABLE_HEADING_ADDRESS_DETAILS', 'xxAddress Details');
//define('TABLE_HEADING_PHONE_FAX_DETAILS', 'Additional Contact Details');
//define('TABLE_HEADING_DATE_OF_BIRTH', 'Verify Your Age');
//define('TABLE_HEADING_LOGIN_DETAILS', 'Login Details');
//define('TABLE_HEADING_REFERRAL_DETAILS', 'Were You Referred to Us?');
?>
