<?php
/**
 * @package admin
 * @copyright Copyright 2003-2016 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart-pro.at/license/2_0.txt GNU Public License V2.0
 * @version $Id: orders_status.php 628 2015-12-22 16:39:16Z webchills $
 */

define('HEADING_TITLE','Bestellstatus');
define('TABLE_HEADING_ORDERS_STATUS','Bestellstatus');
define('TABLE_HEADING_ACTION','Aktion');
define('TEXT_INFO_EDIT_INTRO','Führen Sie hier bitte die notwendigen Änderungen durch');
define('TEXT_INFO_ORDERS_STATUS_NAME','Bestellstatus:');
define('TEXT_INFO_INSERT_INTRO','Tragen Sie bitte den neuen Bestellstatus mit den dazu notwendigen Daten ein');
define('TEXT_INFO_DELETE_INTRO','Wollen Sie diesen Bestellstatus wirklich löschen?');
define('TEXT_INFO_HEADING_NEW_ORDERS_STATUS','Neuer Bestellstatus');
define('TEXT_INFO_HEADING_EDIT_ORDERS_STATUS','Bestellstatus bearbeiten');
define('TEXT_INFO_HEADING_DELETE_ORDERS_STATUS','Bestellstatus löschen');
define('ERROR_REMOVE_DEFAULT_ORDER_STATUS','FEHLER: Der Standardbestellstatus kann nicht gelöscht werden. Legen Sie bitte einen anderen Bestellstatus als Standard fest und versuchen Sie es noch einmal.');
define('ERROR_STATUS_USED_IN_ORDERS','FEHLER: Dieser Bestellstatus wird derzeit in aktuellen Bestellungen verwendet.');
define('ERROR_STATUS_USED_IN_HISTORY','FEHLER: Dieser Bestellstatus wird derzeit in der aktuellen Bestellstatistik verwendet.');