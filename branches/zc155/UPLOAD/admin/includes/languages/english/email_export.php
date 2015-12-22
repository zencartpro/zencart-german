<?php
/**
 * @package admin
 * @copyright Copyright 2003-2016 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart-pro.at/license/2_0.txt GNU Public License V2.0
 * @version $Id: email_export.php 730 2015-12-22 15:49:16Z webchills $
 */
define('HEADING_TITLE', 'Email Address Export');
define('TEXT_EMAIL_EXPORT_FORMAT', 'Export File Format:');
define('TEXT_PLEASE_SELECT_AUDIENCE', 'Please choose the desired recipient list:');
define('TEXT_EMAIL_EXPORT_FILENAME', 'Export Filename:');
define('TEXT_EMAIL_EXPORT_SAVETOFILE','Save to file on server? (otherwise will stream for download directly from this window)');
define('TEXT_EMAIL_EXPORT_DEST','Destination: ');
define('ERROR_PLEASE_SELECT_AUDIENCE','Error: Please select an audience list to export');
define('TEXT_INSTRUCTIONS','<u>INSTRUCTIONS</u><br />You can use this page to export your Zen Cart newsletter subscribers (and others)<br />
list to a CSV, TXT, XML or HTML file for easy import into an email program\'s address book.<br />Thus, you can use a 3rd-party emailing tool for
sending your <br />advertising newsletters, etc.<br /><br />
1. Choose your export format.<br />
2. Choose the snapshot of customer info (recipient list).<br />
3. Enter a filename.  Careful about your choice of file extension.<br />
&nbsp;&nbsp;&nbsp;&nbsp;If you use .TXT, you can save it or open it in a Text Editor directly.<br />
&nbsp;&nbsp;&nbsp;&nbsp;If you use .CSV, you can save it or open it in a spreadsheet program directly.<br />
4. Click Save to proceed.<br />
5. Choose whether to save or open the file, depending on what your browser offers.');