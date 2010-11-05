<?php

/* Default Messages */
define('MODULE_PAYMENT_BILLPAY_TEXT_TITLE', 'Kauf auf Rechnung (Billpay)');
define('MODULE_PAYMENT_BILLPAY_TEXT_DESCRIPTION', 'Kauf auf Rechnung (Billpay)');
define('MODULE_PAYMENT_BILLPAY_TEXT_ERROR_MESSAGE', 'BillPay Error Message');
define('MODULE_PAYMENT_BILLPAY_TEXT_INFO', '<img src="https://www.billpay.de/sites/all/themes/billpay/images/header_logo.png"  alt="billpay" title="billpay" width="190px" /><br /><br />');

// config msg dummies
//define('MODULE_PAYMENT_BILLPAY_*_TITLE' , 'BILLPAY_X_TITLE');
//define('MODULE_PAYMENT_BILLPAY_*_DESC' , 'BILLPAY_X_DESC');

/* Configuration Messages | Alphabetic order */

define('MODULE_PAYMENT_BILLPAY_ALLOWED_TITLE' , 'Erlaubte Zonen');
define('MODULE_PAYMENT_BILLPAY_ALLOWED_DESC' , 'Geben Sie einzeln die Zonen an, welche f�r dieses Modul erlaubt sein sollen. (z.B. AT,DE (wenn leer, werden alle Zonen erlaubt))');

define('MODULE_PAYMENT_BILLPAY_LOGGING_TITLE' , 'Absoluter Pfad zur Logdatei');
define('MODULE_PAYMENT_BILLPAY_LOGGING_DESC' , 'Wenn kein Wert eingestellt ist, wird standardm&auml;ssig in das Verzeichnis includes/billpay/log geschrieben (Schreibrechte m&uuml;ssen verf&uuml;gbar sein).');

define('MODULE_PAYMENT_BILLPAY_MERCHANT_ID_TITLE' , 'Verk&auml;ufer ID');
define('MODULE_PAYMENT_BILLPAY_MERCHANT_ID_DESC' , 'Diese Daten erhalten Sie von Billpay');

define('MODULE_PAYMENT_BILLPAY_ORDER_STATUS_TITLE' , 'Bestellstatus festlegen');
define('MODULE_PAYMENT_BILLPAY_ORDER_STATUS_DESC' , 'Bestellungen, welche mit diesem Modul gemacht werden, auf diesen Status setzen');

define('MODULE_PAYMENT_BILLPAY_PORTAL_ID_TITLE' , 'Portal ID');
define('MODULE_PAYMENT_BILLPAY_PORTAL_ID_DESC' , 'Diese Daten erhalten Sie von Billpay');

define('MODULE_PAYMENT_BILLPAY_SECURE_TITLE' , 'Security Key');
define('MODULE_PAYMENT_BILLPAY_SECURE_DESC' , 'Diese Daten erhalten Sie von Billpay');

define('MODULE_PAYMENT_BILLPAY_SORT_ORDER_TITLE' , 'Anzeigereihenfolge');
define('MODULE_PAYMENT_BILLPAY_SORT_ORDER_DESC' , 'Reihenfolge der Anzeige. Kleinste Ziffer wird zuerst angezeigt.');

define('MODULE_PAYMENT_BILLPAY_STATUS_TITLE' , 'Aktiviert');
define('MODULE_PAYMENT_BILLPAY_STATUS_DESC' , 'M&ouml;chten Sie den Rechnungskauf mit Billpay erlauben?');

define('MODULE_PAYMENT_BILLPAY_TESTMODE_TITLE' , 'Transaktionsmodus');
define('MODULE_PAYMENT_BILLPAY_TESTMODE_DESC' , 'Im Testmodus werden detailierte Fehlermeldungen angezeigt. F&uuml;r den Produktivbetrieb muss der Livemodus aktiviert werden.');

define('MODULE_PAYMENT_BILLPAY_ZONE_TITLE' , 'Steuerzone');
define('MODULE_PAYMENT_BILLPAY_ZONE_DESC' , '');

define('MODULE_PAYMENT_BILLPAY_API_URL_BASE_TITLE' , 'API url base');
define('MODULE_PAYMENT_BILLPAY_API_URL_BASE_DESC' , 'Diese Daten erhalten Sie von Billpay (Achtung! Die URLs f&uuml; das Test- bzw. das Livesystem unterscheiden sich!)');

define('MODULE_PAYMENT_BILLPAY_LOGGING_ENABLE_TITLE' , 'Logging aktiviert');
define('MODULE_PAYMENT_BILLPAY_LOGGING_ENABLE_DESC' , 'Sollen Anfragen an die Billpay-Zahlungsschnittstelle in die Logdatei geschrieben werden?');

define('MODULE_PAYMENT_BILLPAY_LOGPATH_TITLE', 'Logging Pfad');
define('MODULE_PAYMENT_BILLPAY_LOGPATH_DESC', '');

// Payment selection texts
define('MODULE_PAYMENT_BILLPAY_TEXT_BIRTHDATE', 'Geburtsdatum');
define('MODULE_PAYMENT_BILLPAY_TEXT_EULA_CHECK', '<label for="billpay_eula">Hiermit best�tige ich die <a href="http://www.billpay.de/kunden/agb" target="_blank">AGB</a> und die <a href="http://www.billpay.de/kunden/agb#datenschutz" target="_blank">Datenschutzbestimmungen</a> der Billpay GmbH </label> <br />');
define('MODULE_PAYMENT_BILLPAY_TEXT_ENTER_BIRTHDATE', 'Bitte geben Sie Ihr Geburtsdatum ein');
define('MODULE_PAYMENT_BILLPAY_TEXT_ENTER_GENDER', 'Bitte geben Sie Ihr Geschlecht ein');
define('MODULE_PAYMENT_BILLPAY_TEXT_ENTER_BIRTHDATE_AND_GENDER', 'Bitte geben Sie Ihr Geburtsdatum und Ihr Geschlecht ein');
define('MODULE_PAYMENT_BILLPAY_TEXT_NOTE', '');
define('MODULE_PAYMENT_BILLPAY_TEXT_REQ', '');
define('MODULE_PAYMENT_BILLPAY_TEXT_GENDER', 'Geschlecht');
define('MODULE_PAYMENT_BILLPAY_TEXT_MALE', 'm&auml;nnlich');
define('MODULE_PAYMENT_BILLPAY_TEXT_FEMALE', 'weiblich');
//define('MODULE_PAYMENT_BILLPAY_TEXT', '');

define('JS_BILLPAY_EULA', '* Bitte best�tigen Sie die Billpay AGB!\n\n');
define('JS_BILLPAY_DOBDAY', '* Bitte geben Sie Ihr Geburtstag ein.\n\n');
define('JS_BILLPAY_DOBMONTH', '* Bitte geben Sie Ihr Geburtsmonat.\n\n');
define('JS_BILLPAY_DOBYEAR', '* Bitte geben Sie Ihr Geburtsjahr ein.\n\n');
define('JS_BILLPAY_GENDER', '* Bitte geben Sie Ihr Geschlecht ein.\n\n');

define('MODULE_PAYMENT_BILLPAY_TEXT_ERROR_EULA', '* Bitte best�tigen Sie die Billpay AGB!');
define('MODULE_PAYMENT_BILLPAY_TEXT_ERROR_BOD' ,'You have entered an incorrect date of birth!');
define('MODULE_PAYMENT_BILLPAY_TEXT_ERROR_DEFAULT', 'Es ist ein interner Fehler aufgetreten. Bitte w&auml;hlen Sie eine andere Zahlart');
define('MODULE_PAYMENT_BILLPAY_TEXT_ERROR_SHORT', 'Es ist ein interner Fehler aufgetreten!');
define('MODULE_PAYMENT_BILLPAY_TEXT_INVOICE_CREATED_COMMENT', 'Das Zahlungsziel f�r die Bestellung wurde erfolgreich bei Billpay aktiviert');
define('MODULE_PAYMENT_BILLPAY_TEXT_CANCEL_COMMENT', 'Die Bestellung wurde erfolgreich bei Billpay stoniert');
define('MODULE_PAYMENT_BILLPAY_TEXT_ERROR_DUEDATE', 'Das Zahlungsziel konnte nicht aktiviert werden, weil das F�lligkeitsdatum leer ist!');

define('MODULE_PAYMENT_BILLPAY_TEXT_CREATE_INVOICE', 'Billpay Zahlungsziel jetzt aktivieren?');
define('MODULE_PAYMENT_BILLPAY_TEXT_CANCEL_ORDER', 'Billpay Bestellung jetzt stornieren?');

define('MODULE_PAYMENT_BILLPAY_TEXT_ACCOUNT_HOLDER', 'Kontoinhaber');
define('MODULE_PAYMENT_BILLPAY_TEXT_ACCOUNT_NUMBER', 'Kontonummer');
define('MODULE_PAYMENT_BILLPAY_TEXT_BANK_CODE', 'Bankleitzahl');
define('MODULE_PAYMENT_BILLPAY_TEXT_BANK_NAME', 'Bank');
define('MODULE_PAYMENT_BILLPAY_TEXT_INVOICE_REFERENCE', 'Rechnungsnummer');

define('MODULE_PAYMENT_BILLPAY_TEXT_INVOICE_INFO1', 'Sie haben sich f�r den Kauf auf Rechnung mit Billpay entschieden. Bitte �berweisen Sie den Gesamtbetrag bis zum ');
define('MODULE_PAYMENT_BILLPAY_TEXT_INVOICE_INFO2', ' auf folgendes Konto: ');

define('MODULE_PAYMENT_BILLPAY_DUEDATE_TITLE', 'F&auml;lligkeitsdatum');

define('MODULE_PAYMENT_BILLPAY_TEXT_PURPOSE', 'Verwendungszweck');
define('MODULE_PAYMENT_BILLPAY_TEXT_ADD', 'zzgl.');
define('MODULE_PAYMENT_BILLPAY_TEXT_FEE', 'Geb�hr');
define('MODULE_PAYMENT_BILLPAY_TEXT_FEE_INFO1', 'F�r diese Bestellung per Rechnung wird eine Geb�hr von ');
define('MODULE_PAYMENT_BILLPAY_TEXT_FEE_INFO2', ' erhoben');
define('MODULE_ORDER_TOTAL_BILLPAY_FEE_FROM_TOTAL', 'vom Rechnungsbetrag');
?>