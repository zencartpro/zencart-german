<?php
/**
 * @package languageDefines
 * @copyright Copyright 2003-2006 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @translator: cyaneo/hugo13/wflohr/maleborg	http://www.zen-cart.at	2007-01-03
 * @version $Id: checkout_success.php 5407 2006-12-27 01:35:37Z drbyte $
 */

define('NAVBAR_TITLE_1','Bestellbest&auml;tigung');
define('NAVBAR_TITLE_2','Erfolgreich - Vielen Dank!');

define('HEADING_TITLE','Vielen Dank! Wir haben Ihre Bestellung erhalten.');

define('TEXT_SUCCESS','Ihre Bestellung wird sofort nach Zahlungseingang versendet, sofern Sie nicht per Nachnahme bestellt haben. Bei Nachnahmebestellungen verl&auml;sst die Sendung in der Regel nach 2-3 Werktagen unser Haus.');
define('TEXT_NOTIFY_PRODUCTS','Bitte informieren Sie mich &uuml;ber &Auml;nderungen zu diesem Artikel:');
define('TEXT_SEE_ORDERS','Sie k&ouml;nnen Ihre Bestellhistorie unter <a href="' . zen_href_link(FILENAME_ACCOUNT, '', 'SSL') . '">\'Mein Konto\'</a> ansehen.');
define('TEXT_CONTACT_STORE_OWNER','Sollten Sie Fragen haben, wenden Sie sich bitte an unseren  <a href="' . zen_href_link(FILENAME_CONTACT_US) . '">Service</a>.');
define('TEXT_THANKS_FOR_SHOPPING','<strong>Vielen Dank f&uuml;r Ihre Onlinebestellung!</strong>');

define('TABLE_HEADING_COMMENTS', '');

define('FOOTER_DOWNLOAD','Sie k&ouml;nnen Ihre Artikel auch zu einem sp&auml;teren Zeitpunkt unter \'%s\' downloaden.');

define('TEXT_YOUR_ORDER_NUMBER', '<strong>Ihre Bestellnummer lautet:</strong> ');

define('TEXT_CHECKOUT_LOGOFF_GUEST', 'ANMERKUNG: Um Ihren Auftrag durchzuf&uuml;hren, wurde ein tempor&auml;res Konto erstellt. Sie k&ouml;nnen dieses Konto schlie&szlig;en, indem Sie auf Abmelden klicken. Das Abmelden stellt auch sicher, da&szlig; die Informationen &uuml;ber Ihren Aufenhalt in unserem Shop nicht der n&auml;chsten Person sichtbar sind, die diesen Computer verwendet. Wenn Sie mit Ihrem Einkauf fortfahren m&�uml;chten, denken Sie bitte daran, vor dem Verlassen unseres Shops auf Abmelden zu klicken.');
define('TEXT_CHECKOUT_LOGOFF_CUSTOMER', 'Vielen Dank f&uuml;r Ihren Einkauf! Bitte melden Sie sich vor Verlassen des Shop ab, um sicherzugehen, da&szlig; Informationen &uuml;ber Ihren Aufenthalt in unserem Shop nicht f&uuml;r die n&auml;chste Person sichtbar sind, die diesen Computer verwendet.');
?>