<?php
/**
 * @package languageDefines
 * @copyright Copyright 2003-2008 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.at/license/2_0.txt GNU Public License V2.0
 * @translator: cyaneo/hugo13/wflohr    http://www.zen-cart.at    
 * @version $Id$
 */

define('HEADING_TITLE_OPT', 'Artikeloptionen');
define('HEADING_TITLE_VAL', 'Attributmerkmale');
define('HEADING_TITLE_ATRIB', 'Artikelattribute');
define('TABLE_HEADING_ID', 'ID');
define('TABLE_HEADING_PRODUCT', 'Artikelname');
define('TABLE_HEADING_OPT_NAME', 'Attributname');
define('TABLE_HEADING_OPT_VALUE', 'Attributmerkmal');
define('TABLE_HEADING_OPT_PRICE', 'Preis');
define('TABLE_HEADING_OPT_PRICE_PREFIX', 'Pr�fix');
define('TABLE_HEADING_ACTION', 'Aktion');
define('TABLE_HEADING_DOWNLOAD', 'Downloadartikel:');
define('TABLE_TEXT_FILENAME', 'Dateiname:');
define('TABLE_TEXT_MAX_DAYS', 'Ablaufdatum:');
define('TABLE_TEXT_MAX_COUNT', 'Maximale Downloads:');
define('TEXT_WARNING_OF_DELETE', 'Diese Option hat verlinkte Artikel und Werte - es ist nicht sicher, diese zu l�schen.');
define('TEXT_OK_TO_DELETE', 'Diese Option hat keine verlinkte Artikel und Werte und kann gel�scht werden.');
define('TEXT_OPTION_ID', 'Option ID');
define('TEXT_OPTION_NAME', 'Attributname');
define('TABLE_HEADING_OPT_DISCOUNTED','Erm�&szlig;igt');
define('ATTRIBUTE_WARNING_DUPLICATE','Doppeltes Attribut - Attribut wurde nicht hinzugef�gt');
// attributes duplicate warning
define('ATTRIBUTE_WARNING_DUPLICATE_UPDATE','Doppeltes Attribut existiert - Attribut wurde nicht ge�ndert');
// attributes duplicate warning
define('ATTRIBUTE_WARNING_INVALID_MATCH','Attributoption und Attributmerkmal stimmen NICHT �berein - Attribut wurde nicht hinzugef�gt');
// miss matched option and options value
define('ATTRIBUTE_WARNING_INVALID_MATCH_UPDATE','Attributoption und Attributmerkmal stimmen NICHT �berein - Attribut wurde nicht ge�ndert');
// miss matched option and options value
define('ATTRIBUTE_POSSIBLE_OPTIONS_NAME_WARNING_DUPLICATE','M�glicherweise doppelter Attributname hinzugef�gt');
// Options Name Duplicate warning
define('ATTRIBUTE_POSSIBLE_OPTIONS_VALUE_WARNING_DUPLICATE','M�glicherweise doppeltes Attributmerkmal hinzugef�gt');
// Options Value Duplicate warning

define('PRODUCTS_ATTRIBUTES_EDITING','BEARBEITE');
// title
define('PRODUCTS_ATTRIBUTES_DELETE','L�SCHE');
// title
define('PRODUCTS_ATTRIBUTES_ADDING','F�GE NEUE ATTRIBUTE HINZU');
// title
define('TEXT_DOWNLOADS_DISABLED','HINWEIS: Downloads sind deaktiviert');
define('TABLE_TEXT_MAX_DAYS_SHORT', 'Tage:');
define('TABLE_TEXT_MAX_COUNT_SHORT', 'Max:');
define('TABLE_HEADING_OPTION_SORT_ORDER','Sortierung');
define('TABLE_HEADING_OPTION_VALUE_SORT_ORDER','Standardsortierung');
define('TEXT_SORT',' Sortierung: ');
define('TABLE_HEADING_OPT_WEIGHT_PREFIX','Pr�fix');
define('TABLE_HEADING_OPT_WEIGHT','Gewicht');
define('TABLE_HEADING_OPT_SORT_ORDER','Sortierung');
define('TABLE_HEADING_OPT_DEFAULT','Standard');
define('TABLE_HEADING_YES','Ja');
define('TABLE_HEADING_NO','Nein');
define('TABLE_HEADING_OPT_TYPE', 'Attributtyp');
//CLR 031203 add option type column
define('TABLE_HEADING_OPTION_VALUE_SIZE','Gr�&szlig;e');
define('TABLE_HEADING_OPTION_VALUE_MAX','Maximal');
define('TABLE_HEADING_OPTION_VALUE_ROWS','Reihen');
define('TABLE_HEADING_OPTION_VALUE_COMMENTS','Kommentare');
define('TEXT_OPTION_VALUE_COMMENTS','Kommentare: ');
define('TEXT_OPTION_VALUE_ROWS', 'Zeilen: ');
define('TEXT_OPTION_VALUE_SIZE','Anzeigegr�&szlig;e: ');
define('TEXT_OPTION_VALUE_MAX','Maximale L�nge: ');
define('TEXT_ATTRIBUTES_IMAGE','Attributbild Muster:');
define('TEXT_ATTRIBUTES_IMAGE_DIR','Attributbild Verzeichnis:');
define('TEXT_ATTRIBUTES_FLAGS','Attribut<br />Kennzeichen:');
define('TEXT_ATTRIBUTES_DISPLAY_ONLY', 'Nur zur<br />Ansicht verwendet:');
define('TEXT_ATTRIBUTES_IS_FREE', 'Attribut ist kostenlos<br />wenn Artikel kostenlos ist:');
define('TEXT_ATTRIBUTES_DEFAULT', 'Standard Attribute<br />zur Auswahl markiert:');
define('TEXT_ATTRIBUTE_IS_DISCOUNTED', 'Verwende selben Preisnachlass<br />wie von Artikel:');
define('TEXT_ATTRIBUTE_PRICE_BASE_INCLUDED','Inkludiert im Grundpreis<br />wenn Preis durch Attribute bestimmt');
define('TEXT_PRODUCT_OPTIONS_INFO','Artikeloptionen f�r erweiterte Einstellungen bearbeiten');

// updates
define('ERROR_PRODUCTS_OPTIONS_VALUES', 'WARNUNG: Keine Artikel gefunden... es wurde nichts aktualisiert');
define('TEXT_SELECT_PRODUCT', ' W�hlen Sie einen Artikel');
define('TEXT_SELECT_CATEGORY', ' W�hlen Sie eine Kategorie');
define('TEXT_SELECT_OPTION', 'W�hlen Sie einen Attributnamen');

// add
define('TEXT_OPTION_VALUE_ADD_ALL', '<br /><strong>ALLE Attributmerkmale f�r ALLE Artikel f�r Attributnamen ausw�hlen</strong>');
define('TEXT_INFO_OPTION_VALUE_ADD_ALL', 'ALLE existierende Artikel mit mindestens EINEM Attributmerkmal und ALLE Attributmerkmale einem Attributnamen hinzuf�gen');
define('SUCCESS_PRODUCTS_OPTIONS_VALUES', 'Optionen erfolgreich aktualisiert');
define('TEXT_OPTION_VALUE_ADD_PRODUCT', '<br /><strong>ALLE Attributmerkmale zu einem Artikel f�r Attributnamen hinzuf�gen</strong>');
define('TEXT_INFO_OPTION_VALUE_ADD_PRODUCT', 'EINEN Artikel mit mindestens EINEM Attributmerkmal aktualisieren und ALLE Attributmerkmale einem Attributname hinzuf�gen');
define('TEXT_OPTION_VALUE_ADD_CATEGORY', '<br /><strong>ALLE Attributmerkmale zu EINER Kategorie von Artikel f�r Attributnamen hinzuf�gen</strong>');
define('TEXT_INFO_OPTION_VALUE_ADD_CATEGORY', 'EINE Kategorie von Artikel aktualisieren, wenn der Artikel mindestens EINEN Attributmerkmal hat und ALLE Attributmerkmale einem Attributnamen hinzuf�gen');
define('TEXT_COMMENT_OPTION_VALUE_ADD_ALL', '<strong>HINWEIS:</strong> Die Sortierung wird f�r diese Artikel auf die Standard Sortierung f�r Attributmerkmale gesetzt');

// delete
define('TEXT_OPTION_VALUE_DELETE_ALL', '<br /><strong>L�sche ALLE Attributmerkmale f�r ALLE Artikel f�r Attributnamen</strong>');
define('TEXT_INFO_OPTION_VALUE_DELETE_ALL', 'Aktualisiere ALLE existierenden Artikel mit mindestens EINEM Attributmerkmal und l�sche ALLE Attributmerkmale eines Attributnamens');
define('TEXT_OPTION_VALUE_DELETE_PRODUCT', '<br /><strong>L�sche ALLE Attributmerkmale zu EINEM Artikel f�r Attributnamen</strong>');
define('TEXT_INFO_OPTION_VALUE_DELETE_PRODUCT', 'Aktualisiere EINEN Artikel mit mindestens EINEM Attributmerkmal und l�sche ALLE Attributmerkmale eines Attributnamens');
define('TEXT_OPTION_VALUE_DELETE_CATEGORY', '<br /><strong>L�sche ALLE Attributmerkmale zu EINER Kategorie von Artikeln f�r Attributnamen</strong>');
define('TEXT_INFO_OPTION_VALUE_DELETE_CATEGORY', 'Aktualisiere EINE Kategorie von Artikeln, wenn der Artikel mindestens EINEN Attributmerkmal hat und l�sche ALLE Attributmerkmale eines Attributnamens');
define('TEXT_COMMENT_OPTION_VALUE_DELETE_ALL', '<strong>HINWEIS:</strong> Alle Attributmerkmale eines Attributnamens werden f�r die ausgew�hlten Artikel gel�scht. Die Einstellungen der Attributmerkmale werden dabei nicht gel�scht.');
define('TEXT_OPTION_VALUE_COPY_ALL', '<strong>Kopiere ALLE Attributmerkmale zueinem anderen Attributnamen</strong>');
define('TEXT_INFO_OPTION_VALUE_COPY_ALL', 'Alle Attributmerkmale werden von einem Attributnamen zu einem anderen Otionsnamen kopiert');
define('TEXT_SELECT_OPTION_FROM', 'Kopiere von Attributnamen: ');
define('TEXT_SELECT_OPTION_TO', 'Kopiere alle Attributmerkmale zum Attributnamen: ');
define('SUCCESS_OPTION_VALUES_COPIED', 'Erfolgreich kopiert! ');
define('ERROR_OPTION_VALUES_COPIED', 'Fehler - kann keine Attributmerkmale zum selben Attributnamen kopieren! ');
define('ERROR_OPTION_VALUES_NONE', 'Fehler - Es wurden keine Attributmerkmale definiert - es wurde nichts kopiert! ');
define('TEXT_WARNING_BACKUP', 'Warnung: F�hren Sie VOR jeder globalen �nderung immer eine Sicherung der Datenbank durch');
define('TEXT_OPTION_ATTRIBUTE_IMAGES_PER_ROW', 'Attributbilder pro Reihe: ');
define('TEXT_OPTION_ATTRIBUTE_IMAGES_STYLE', 'Attributstil f�r Radio Buttons/Checkboxen: ');
define('TEXT_OPTION_ATTIBUTE_MAX_LENGTH', '<strong>Maximale L�nge und Anzeigegr�&szlig;e nur f�r Textattribute:</strong><br />');
define('TEXT_OPTION_IMAGE_STYLE', '<strong>Bilddarstellung:</strong>');
define('TEXT_OPTION_ATTRIBUTE_IMAGES_STYLE_0', '0= Bilder unter Attributnamen');
define('TEXT_OPTION_ATTRIBUTE_IMAGES_STYLE_1', '1= Elemente, Bilder und Attributmerkmale');
define('TEXT_OPTION_ATTRIBUTE_IMAGES_STYLE_2', '2= Elemente, Bilder und Attributnamen darunter');
define('TEXT_OPTION_ATTRIBUTE_IMAGES_STYLE_3', '3= Attributname unterhalb von Elementen und Bildern');
define('TEXT_OPTION_ATTRIBUTE_IMAGES_STYLE_4', '4= Elemente unterhalb der Bilder und Attributnamen');
define('TEXT_OPTION_ATTRIBUTE_IMAGES_STYLE_5', '5= Elemente �ber den Bildern und Attributnamen');

