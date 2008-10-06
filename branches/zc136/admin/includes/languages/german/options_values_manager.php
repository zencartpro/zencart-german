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
//  $Id: options_values_manager.php 1148 2005-04-07 19:24:10Z drbyte $
//

define('HEADING_TITLE_OPT', 'Artikeloptionen');
define('ATTRIBUTE_WARNING_DUPLICATE_UPDATE', '&Auml;nderung nicht m&ouml;glich - Attribut ist bereits vorhanden');
define('ATTRIBUTE_WARNING_INVALID_MATCH', 'Attribut konnte nicht erstellt werden - Attributoption und Attributmerkmal stimmen nicht &uuml;berein');
define('ATTRIBUTE_WARNING_INVALID_MATCH_UPDATE', 'Attribut konnte nicht ge&auml;ndert werden - Attributoption und Attributmerkmal stimmen nicht &uuml;berein');
define('ATTRIBUTE_POSSIBLE_OPTIONS_NAME_WARNING_DUPLICATE', 'M&ouml;glicherweise wurde ein doppelter Attributname hinzugef&uuml;gt');
define('ATTRIBUTE_POSSIBLE_OPTIONS_VALUE_WARNING_DUPLICATE', 'M&ouml;glicherweise wurde ein doppeltes Attributmerkmal hinzugef&uuml;gt');

define('PRODUCTS_ATTRIBUTES_EDITING', 'BEARBEITE');
define('PRODUCTS_ATTRIBUTES_DELETE', 'L&Ouml;SCHE');
define('PRODUCTS_ATTRIBUTES_ADDING', 'F&Uuml;GE NEUES ATTRIBUT HINZU');
define('TEXT_DOWNLOADS_DISABLED', 'Hinweis: Downloads sind deaktiviert');
define('TABLE_HEADING_OPTION_VALUE_SIZE', 'Gr&ouml;&szlig;e');

// Option Names/Values copier from one to another
define('TEXT_OPTION_VALUE_COPY_ALL', '<strong>ALLE Attribute kopieren, bei denen Optionsname und Wert...</strong>');

// Option Name/Value to Option Name for Category with Product defaults
define('TEXT_OPTION_VALUE_COPY_OPTIONS_TO', '<strong>Kopiere Optionsname u. Wert zu Artikel mit einem bestimmten Optionsnamen ...</strong>');
                                                 <br /><strong>z.B.:</strong> Hinzuf&uuml;gen Optionsname: Color, Optionswert: Red, zu allen Artikeln mit dem Optionsnamen: Size
                                                 <br /><strong>z.B.:</strong> Hinzuf&uuml;gen Optionsname: Color, Optionswert: Red, mit default Werten von Artikel-ID: 34 zu allen Artikeln mit dem Optionsnamen: Size
                                                 <br /><strong>z.B.:</strong> Hinzuf&uuml;gen Optionsname: Color, Optionswert: Red, mit default Werten von Artikel-ID: 34 zu allen Artikeln mit dem Optionsnamen: Size f&uuml; Kategorie ID: 65
      ');


?>