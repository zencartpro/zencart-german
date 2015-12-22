<?php
/**
 * @package admin
 * @copyright Copyright 2003-2016 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart-pro.at/license/2_0.txt GNU Public License V2.0
 * @version $Id: currencies.php 628 2015-12-22 16:05:14Z webchills $
 */

define('HEADING_TITLE','Währungen');

define('TABLE_HEADING_CURRENCY_NAME','Währung');
define('TABLE_HEADING_CURRENCY_CODES','Code');
define('TABLE_HEADING_CURRENCY_VALUE','Wechselkurs');
define('TABLE_HEADING_ACTION','Aktion');

define('TEXT_INFO_EDIT_INTRO','Führen Sie hier bitte die notwendigen Änderungen durch');
define('TEXT_INFO_CURRENCY_TITLE','Name:');
define('TEXT_INFO_CURRENCY_CODE','Code:');
define('TEXT_INFO_CURRENCY_SYMBOL_LEFT','Währungssymbol links:');
define('TEXT_INFO_CURRENCY_SYMBOL_RIGHT','Währungssymbol rechts:');
define('TEXT_INFO_CURRENCY_DECIMAL_POINT','Dezimalstellen Trennzeichen:');
define('TEXT_INFO_CURRENCY_THOUSANDS_POINT','1000er Trennzeichen');
define('TEXT_INFO_CURRENCY_DECIMAL_PLACES','Dezimalstellen:');
define('TEXT_INFO_CURRENCY_LAST_UPDATED','Letzte Aktualisierung:');

define('TEXT_INFO_CURRENCY_VALUE','Wert:<br /><br/ ><strong>Achtung, wenn hier ein anderer Wert als 1 eingetragen ist, dann wird der jeweilige Artikelpreis mit diesem Wert multipliziert (siehe auch unter Beispielausgabe)!</strong><br /><br />');
define('TEXT_INFO_CURRENCY_EXAMPLE','Beispielausgabe:');
define('TEXT_INFO_INSERT_INTRO','Bitte tragen Sie die neue Währung mit den relevanten Daten ein');
define('TEXT_INFO_DELETE_INTRO','Wollen Sie diese Währung wirklich löschen?');
define('TEXT_INFO_HEADING_NEW_CURRENCY','Neue Währung');
define('TEXT_INFO_HEADING_EDIT_CURRENCY','Währung bearbeiten');
define('TEXT_INFO_HEADING_DELETE_CURRENCY','Währung löschen');
define('TEXT_INFO_SET_AS_DEFAULT',TEXT_SET_DEFAULT . '(Ein manuelles Update der Währungskurse ist notwendig)');


define('ERROR_REMOVE_DEFAULT_CURRENCY','FEHLER: Die Standardwährung kann nicht gelöscht werden. Legen Sie eine andere Währung als Standard fest und versuchen Sie es noch einmal.');

define('ERROR_INVALID_CURRENCY_ENTRY', 'FEHLER: Ihre Angaben sind unvollständig und wurden nicht gespeichert. Sie müssen einen Code und einen Namen angeben.');
