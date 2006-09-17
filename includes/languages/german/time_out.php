<?php
/**
* @package languageDefines
* @copyright Copyright 2003-2006 Zen Cart Development Team
* @copyright Portions Copyright 2003 osCommerce
* @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: time_out.php 3027 2006-02-13 17:15:51Z drbyte $
*/

define('NAVBAR_TITLE','Anmeldezeit &uuml;berschritten');
define('HEADING_TITLE','Anmeldezeit &uuml;berschritten');
define('HEADING_TITLE_LOGGED_IN', 'Tut uns leid!, aber Sie d�rfen diese T�tigkeit nicht ausf�hren. '); // new 1.3.0  
define('TEXT_INFORMATION','Es tut uns leid, aber aus Sicherheitsgr&uuml;nden mussten wir Ihre Verbindung unterbrechen,
um Unbefugten nicht die M&ouml;glichkeit zu bieten, an Ihre Zugangsdaten zu gelangen.
  <a href="' . zen_href_link(FILENAME_LOGIN, '', 'SSL') . '">Anmeldung</a>
  Ihr Warenkorb wird wiederhergestellt'.
  (DOWNLOAD_ENABLED == 'true' ? ', Sie hatten Download-Artikel und m&ouml;chte diese(n) erhalten' : '') . ',
  Gehen Sie bitte zu <a href="' . zen_href_link(FILENAME_ACCOUNT, '', 'SSL') . '">Mein Konto</a> um Ihre Bestellung anzusehen.');
define('TEXT_INFORMATION_LOGGED_IN', 'Sie sind bei Ihrem Konto angemeldet und k�nnen nun weiter einkaufen. W�hlen Sie einen Men�punk aus.'); // new 1.3.0  
define('HEADING_RETURNING_CUSTOMER', 'Anmelden'); // new 1.3.0  
define('TEXT_PASSWORD_FORGOTTEN', 'Password vergessen?');
?>