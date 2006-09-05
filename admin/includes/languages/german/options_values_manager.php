<?php
//
// +----------------------------------------------------------------------+
// |zen-cart Open Source E-commerce                                       |
// +----------------------------------------------------------------------+
// | Copyright (c) 2003 The zen-cart developers                           |
// |                                                                      |
// | http://www.zen-cart.com/index.php                                    |
// |                                                                      |
// | Portions Copyright (c) 2003 osCommerce                               |
// +----------------------------------------------------------------------+
// | This source file is subject to version 2.0 of the GPL license,       |
// | that is bundled with this package in the file LICENSE, and is        |
// | available through the world-wide-web at the following url:           |
// | http://www.zen-cart.com/license/2_0.txt.                             |
// | If you did not receive a copy of the zen-cart license and are unable |
// | to obtain it through the world-wide-web, please send a note to       |
// | license@zen-cart.com so we can mail you a copy immediately.          |
// +----------------------------------------------------------------------+
// | Translator:           cyaneo/hugo13                                  |
// | Date of Translation:  31.03.06                                       |
// | Homepage:             www.zen-cart.at                                |
// +----------------------------------------------------------------------+
//  $Id: options_values_manager.php 4 2006-03-31 16:38:40Z hugo13 $
//

define('HEADING_TITLE_OPT', 'Artikeloptionen');
define('HEADING_TITLE_VAL', 'Attributmerkmale');
define('HEADING_TITLE_ATRIB', 'Artikelattribute');

define('TABLE_HEADING_ID', 'ID');
define('TABLE_HEADING_PRODUCT', 'Artikelname');
define('TABLE_HEADING_OPT_NAME', 'Attributname');
define('TABLE_HEADING_OPT_VALUE', 'Attributmerkmal');
define('TABLE_HEADING_OPT_PRICE', 'Preis');
define('TABLE_HEADING_OPT_PRICE_PREFIX', 'Pr&auml;fix');
define('TABLE_HEADING_ACTION', 'Aktion');
define('TABLE_HEADING_DOWNLOAD', 'Download-Artikel');
define('TABLE_TEXT_FILENAME', 'Dateiname:');
define('TABLE_TEXT_MAX_DAYS', 'Ablauftage:');
define('TABLE_TEXT_MAX_COUNT', 'Maximale Download-Anzahl:');

define('TEXT_WARNING_OF_DELETE', 'Diese Option ist Artikel und Optionen zugewiesen - ein L&ouml;schen wird nicht empfohlen.');
define('TEXT_OK_TO_DELETE', 'Diese Option ist keinen Artikeln und keinen Optionen zugewiesen und kann gel&ouml;scht werden.');
define('TEXT_OPTION_ID', 'Option ID');
define('TEXT_OPTION_NAME', 'Attributname');
define('TABLE_HEADING_OPT_DISCOUNTED', 'erm&auml;&szlig;igt');

define('ATTRIBUTE_WARNING_DUPLICATE', 'Hinzuf&uuml;gen nicht m&ouml;glich - Attribut ist bereits vorhanden'); // attributes duplicate warning
define('ATTRIBUTE_WARNING_DUPLICATE_UPDATE', '�nderung nicht m&ouml;glich - Attribut ist bereits vorhanden'); // attributes duplicate warning
define('ATTRIBUTE_WARNING_INVALID_MATCH', 'Attribut konnte nicht erstellt werden - Attributoption und Attributmerkmal stimmen nicht &uuml;berein'); // miss matched option and options value
define('ATTRIBUTE_WARNING_INVALID_MATCH_UPDATE', 'Attribut konnte nicht ge&auml;ndert werden - Attributoption und Attributmerkmal stimmen nicht &uuml;berein'); // miss matched option and options value
define('ATTRIBUTE_POSSIBLE_OPTIONS_NAME_WARNING_DUPLICATE', 'M&ouml;glicherweise wurde ein doppelter Attributname hinzugef&uuml;gt'); // Options Name Duplicate warning
define('ATTRIBUTE_POSSIBLE_OPTIONS_VALUE_WARNING_DUPLICATE', 'M&ouml;glicherweise wurde ein doppeltes Attributmerkmal hinzugef&uuml;gt'); // Options Value Duplicate warning

define('PRODUCTS_ATTRIBUTES_EDITING', 'BEARBEITE'); // title
define('PRODUCTS_ATTRIBUTES_DELETE', 'L�SCHE'); // title
define('PRODUCTS_ATTRIBUTES_ADDING', 'F�GE NEUES ATTRIBUT HINZU'); // title
define('TEXT_DOWNLOADS_DISABLED', 'Hinweis: Downloads sind deaktiviert');

define('TABLE_TEXT_MAX_DAYS_SHORT', 'Tage:');
define('TABLE_TEXT_MAX_COUNT_SHORT', 'Maximal:');

define('TABLE_HEADING_OPTION_SORT_ORDER', 'Sortierreihenfolge');
define('TABLE_HEADING_OPTION_VALUE_SORT_ORDER', 'Standardsortierung');
define('TEXT_SORT', 'Sortierung:');

define('TABLE_HEADING_OPT_WEIGHT_PREFIX', 'Pr&auml;fix');
define('TABLE_HEADING_OPT_WEIGHT', 'Gewicht');
define('TABLE_HEADING_OPT_SORT_ORDER', 'Sortierung');
define('TABLE_HEADING_OPT_DEFAULT', 'Standard');

define('TABLE_HEADING_YES', 'Ja');
define('TABLE_HEADING_NO', 'Nein');

define('TABLE_HEADING_OPT_TYPE', 'Optionsart'); //CLR 031203 add option type column
define('TABLE_HEADING_OPTION_VALUE_SIZE', 'Gr&ouml;&szlig;e');
define('TABLE_HEADING_OPTION_VALUE_MAX', 'Maximal');
define('TABLE_HEADING_OPTION_VALUE_ROWS', 'Reihen');
define('TABLE_HEADING_OPTION_VALUE_COMMENTS', 'Kommentare');

define('TEXT_OPTION_VALUE_COMMENTS', 'Kommentare:');
define('TEXT_OPTION_VALUE_SIZE', 'Darstellungsgr&ouml;&szlig;e:');
define('TEXT_OPTION_VALUE_MAX', 'Maximale L&auml;nge:');

define('TEXT_ATTRIBUTES_IMAGE', 'Muster des Attributsbildes:');
define('TEXT_ATTRIBUTES_IMAGE_DIR', 'Verzeichnis des Attributsbildes:');

define('TEXT_ATTRIBUTES_FLAGS', 'Attributs-<br />kennzeichen:');
define('TEXT_ATTRIBUTES_DISPLAY_ONLY', 'Nur zur<br />Darstellung ben&ouml;tigt:');
define('TEXT_ATTRIBUTES_IS_FREE', 'Attribut ist kostenlos<br />wenn der Artikel kostenlos ist:');
define('TEXT_ATTRIBUTES_DEFAULT', 'Attribut, welches standardm&auml;&szlig;ig<br />markiert werden soll:');
define('TEXT_ATTRIBUTE_IS_DISCOUNTED', 'Rabatte verwenden die vom<br />Artikel verwendet werden:');
define('TEXT_ATTRIBUTE_PRICE_BASE_INCLUDED', 'inklusive Grundpreis<br />wenn Preis durch Attribute bestimmt wird:');

define('TEXT_PRODUCT_OPTIONS_INFO', 'F&uuml;r weitere Einstellungen bitte Artikeloptionen bearbeiten');

// Option Names/Values copier from one to another
define('TEXT_OPTION_VALUE_COPY_ALL', '<strong>ALLE Attribute kopieren, bei denen Optionsname und Wert...</strong>');
define('TEXT_INFO_OPTION_VALUE_COPY_ALL', 'W&auml;hlen Sie einen Optionsnamen und einen Wert aus, der bereits in einem (oder mehreren Artikel) existiert, &uuml;ber den Sie dann einen anderen Optionsnamen und Wert auf ALLEN Artikel mit dem vorhandenen Optionsnamen und Wert kopieren m&ouml;chten');
define('TEXT_SELECT_OPTION_FROM', 'Abzugleichender Optionsname:');
define('TEXT_SELECT_OPTION_VALUES_FROM', 'Abzugleichender Optionswert:');
define('TEXT_SELECT_OPTION_TO', 'Hinzuzuf&uuml;gender Optionsname:');
define('TEXT_SELECT_OPTION_VALUES_TO', 'Hinzuzuf&uuml;gender Optionswert:');
define('TEXT_SELECT_OPTION_VALUES_TO_CATEGORIES_ID', 'leeres Feld = ALLE Artikel, oder<br />geben Sie eine Kategorie ID f&uuml;r die zu aktualisierenden Artikel an');

// Option Name/Value to Option Name for Category with Product defaults
define('TEXT_OPTION_VALUE_COPY_OPTIONS_TO', '<strong>Kopiere Optionsname u. Wert zu Artikel mit einem bestimmten Optionsnamen ...</strong>');
define('TEXT_INFO_OPTION_VALUE_COPY_OPTIONS_TO', 'Selektieren Sie einen Optionsnamen und Wert der aktuell einem Produkt/Produkte zugeordnet ist, damit sie diese Information einer Kategorie od. allen Artikeln zuweisen k�nnen die einen bestimmten Optionsnamen besitzen.
                                                 <br /><strong>z.B.:</strong> Hinzuf&uuml;gen Optionsname: Color, Optionswert: Red, zu allen Artikeln mit dem Optionsnamen: Size
                                                 <br /><strong>z.B.:</strong> Hinzuf&uuml;gen Optionsname: Color, Optionswert: Red, mit default Werten von Artikel-ID: 34 zu allen Artikeln mit dem Optionsnamen: Size
                                                 <br /><strong>z.B.:</strong> Hinzuf&uuml;gen Optionsname: Color, Optionswert: Red, mit default Werten von Artikel-ID: 34 zu allen Artikeln mit dem Optionsnamen: Size f&uuml; Kategorie ID: 65
      ');
define('TEXT_SELECT_OPTION_TO_ADD_TO', 'mit Optionsname:');
define('TEXT_SELECT_OPTION_FROM_ADD', 'Optionsname hinzuf�gen:');
define('TEXT_SELECT_OPTION_VALUES_FROM_ADD', 'Optionswert hinzuf�gen:');
define('TEXT_SELECT_OPTION_FROM_PRODUCTS_ID', 'Default Optionswerte von Artikel ID# nehmen oder Feld leer lassen:');
define('TEXT_COPY_ATTRIBUTES_CONDITIONS', '<strong>Wie soll mit bereits existierenden Artikelattributen verfahren werden?</strong>');
define('TEXT_COPY_ATTRIBUTES_DELETE', 'Existierende Attribute <strong>l�schen</strong>, und dann kopieren');
define('TEXT_COPY_ATTRIBUTES_UPDATE', 'Existierende Attribute mit neuen Werten <strong>aktualisieren</strong>');
define('TEXT_COPY_ATTRIBUTES_IGNORE', 'Existierende Attribute <strong>ignorieren</strong> und neue hinzuf&uuml;gen');

define('TEXT_INFO_FROM', ' von: ');
define('TEXT_INFO_TO', ' nach: ');
define('ERROR_OPTION_VALUES_COPIED', 'Fehler: Doppelter Optionsname und Optionswert');
define('ERROR_OPTION_VALUES_COPIED_MISMATCH', 'Fehler: Ausgew&auml;hlter Optionsmane und Optionswert stimmen nicht &uuml;berein');
define('ERROR_OPTION_VALUES_NONE', 'Fehler: Nichts zum Kopieren gefunden');
define('SUCCESS_OPTION_VALUES_COPIED', 'Kopieren erfolgreich! ');
define('ERROR_OPTION_VALUES_COPIED_MISMATCH_PRODUCTS_ID', 'Fehler: kein Optionsname/-wert f�r Artikel-Nr:');

define('TEXT_OPTION_VALUE_DELETE_ALL', '<strong>ALLE Attribute l&ouml;schen, bei denen Optionsname und Wert...</strong>');
define('TEXT_INFO_OPTION_VALUE_DELETE_ALL', 'W&auml;hlen Sie einen Optionsnamen und einen Wert aus, der bereits in einem (oder mehreren Artikel) existiert, den Sie aus ALLEN Artikel bzw. aus ALLEN Artikel einer Kategorie l&ouml;schen m&ouml;chten');
define('TEXT_SELECT_DELETE_OPTION_FROM', 'Abzugleichender Optionsname:');
define('TEXT_SELECT_DELETE_OPTION_VALUES_FROM', 'Abzugleichender Optionswert:');

define('ERROR_OPTION_VALUES_DELETE_MISMATCH', 'Fehler: Ausgew&auml;hlter Optionsname und Optionswert stimmen nicht &uuml;berein');

define('SUCCESS_OPTION_VALUES_DELETE', 'Erfolgreich gel&ouml;scht: ');
?>
