<?php
/**
 * Zen Cart German Specific
 * @package shippingMethod
 * @copyright Copyright 2003-2020 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license https://www.zen-cart-pro.at/license/3_0.txt GNU General Public License V3.0
 * @version $Id: storepickup.php 738 2020-07-09 08:56:16Z webchills $
 */
/**
 * Store-Pickup / Will-Call shipping method
 * with multiple location choices as radio-buttons
 */
class storepickup extends base {
  /**
   * $code determines the internal 'code' name used to designate "this" shipping module
   *
   * @var string
   */
  var $code;
  /**
   * $title is the displayed name for this shipping method
   *
   * @var string
   */
  var $title;
  /**
   * $description is a soft name for this shipping method
   *
   * @var string
   */
  var $description;
  /**
   * module's icon
   *
   * @var string
   */
  var $icon;
  /**
   * $enabled determines whether this module shows or not... during checkout.
   *
   * @var boolean
   */
  var $enabled;
  /**
   * constructor
   *
   * @return storepickup
   */
  function __construct() {
    $this->code = 'storepickup';
    $this->title = MODULE_SHIPPING_STOREPICKUP_TEXT_TITLE;
    $this->description = MODULE_SHIPPING_STOREPICKUP_TEXT_DESCRIPTION;
    $this->sort_order = defined('MODULE_SHIPPING_STOREPICKUP_SORT_ORDER') ? MODULE_SHIPPING_STOREPICKUP_SORT_ORDER : null;
    if (null === $this->sort_order) return false;

    $this->icon = ''; // add image filename here; must be uploaded to the /images/ subdirectory
    $this->tax_class = MODULE_SHIPPING_STOREPICKUP_TAX_CLASS;
    $this->tax_basis = MODULE_SHIPPING_STOREPICKUP_TAX_BASIS;
    $this->enabled = ((MODULE_SHIPPING_STOREPICKUP_STATUS == 'True') ? true : false);
    $this->update_status();
  }
  /**
   * Perform various checks to see whether this module should be visible
   */
  function update_status() {
    global $order, $db;
    if (!$this->enabled) return;
    if (IS_ADMIN_FLAG === true) return;

    
       // check country
        $dest_country = isset ($order->delivery['country']['iso_code_2']) ? $order->delivery['country']['iso_code_2'] : 0 ;
        $dest_zone = 0;
        $error = false;
        $countries_table = MODULE_SHIPPING_STOREPICKUP_COUNTRIES; 
        $country_zones = explode(",", $countries_table);
        if (in_array($dest_country, $country_zones)) {
            $dest_zone = $i;
            $this->enabled = true;
        } else {
            $this->enabled = false;
        }

  }
  /**
   * Obtain quote from shipping system/calculations
   *
   * @param string $method
   * @return array
   */
  function quote($method = '') {
    global $order;

    // this code looks to see if there's a language-specific translation for the available shipping locations/methods, to override what is entered in the Admin (since the admin setting is in the default language)
    $ways_translated = (defined('MODULE_SHIPPING_STOREPICKUP_MULTIPLE_WAYS')) ? trim(MODULE_SHIPPING_STOREPICKUP_MULTIPLE_WAYS) : '';
    $ways_default = trim(MODULE_SHIPPING_STOREPICKUP_LOCATIONS_LIST);
    $methodsToParse = ($ways_translated == '') ? $ways_default : $ways_translated;

    if ($methodsToParse == '') {
      $this->methodsList[] = array('id' => $this->code,
                                   'title' => trim((string)MODULE_SHIPPING_STOREPICKUP_TEXT_WAY),
                                   'cost' => MODULE_SHIPPING_STOREPICKUP_COST);
    } else {
      $this->locations = explode(';', (string)$methodsToParse);
      $this->methodsList = array();
      foreach ($this->locations as $key => $val)
      {
        if ($method != '' && $method != $this->code . (string)$key) continue;
        $cost = MODULE_SHIPPING_STOREPICKUP_COST;
        $title = $val;
        if (strstr($val, ',')) {
          list($title, $cost) = explode(',', $val);
        }
        $this->methodsList[] = array('id' => $this->code . (string)$key,
                                     'title' => trim($title),
                                     'cost' => $cost);
      }
    }

    $this->quotes = array('id' => $this->code,
                          'module' => MODULE_SHIPPING_STOREPICKUP_TEXT_TITLE,
                          'methods' => $this->methodsList);

    if ($this->tax_class > 0) {
      $this->quotes['tax'] = zen_get_tax_rate($this->tax_class, $order->delivery['country']['id'], $order->delivery['zone_id']);
    }

    if (zen_not_null($this->icon)) $this->quotes['icon'] = zen_image($this->icon, $this->title);

    return $this->quotes;
  }
  /**
   * Check to see whether module is installed
   *
   * @return boolean
   */
  function check() {
    global $db;
    if (!isset($this->_check)) {
      $check_query = $db->Execute("select configuration_value from " . TABLE_CONFIGURATION . " where configuration_key = 'MODULE_SHIPPING_STOREPICKUP_STATUS'");
      $this->_check = $check_query->RecordCount();
    }
    if ($this->_check > 0 && !defined('MODULE_SHIPPING_STOREPICKUP_LOCATIONS_LIST')) $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Pickup Locations', 'MODULE_SHIPPING_STOREPICKUP_LOCATIONS_LIST', 'Walk In', 'Enter a list of locations, separated by semicolons (;).<br>Optionally you may specify a fee/surcharge for each location by adding a comma and an amount. If no amount is specified, then the generic Shipping Cost amount from the next setting will be applied.<br><br>Examples:<br>121 Main Street;20 Church Street<br>Sunnyside,4.00;Lee Park,5.00;High Street,0.00<br>Dallas;Tulsa,5.00;Phoenix,0.00<br>For multilanguage use, see the define-statement in the language file for this module.', '6', '0', now())");
    return $this->_check;
  }
  /**
   * Install the shipping module and its configuration settings
   *
   */
  function install() {
    global $db;
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Store Pickup Shipping', 'MODULE_SHIPPING_STOREPICKUP_STATUS', 'True', 'Do you want to offer In Store rate shipping?', '6', '0', 'zen_cfg_select_option(array(\'True\', \'False\'), ', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Pickup Locations', 'MODULE_SHIPPING_STOREPICKUP_LOCATIONS_LIST', 'Demogasse 17 in 1010 Wien', 'Enter a list of locations, separated by semicolons (;).<br>Optionally you may specify a fee/surcharge for each location by adding a comma and an amount. If no amount is specified, then the generic Shipping Cost amount from the next setting will be applied.<br><br>Examples:<br>121 Main Street;20 Church Street<br>Sunnyside,4.00;Lee Park,5.00;High Street,0.00<br>Dallas;Tulsa,5.00;Phoenix,0.00<br>For multilanguage use, see the define-statement in the language file for this module.', '6', '0', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Shipping Cost', 'MODULE_SHIPPING_STOREPICKUP_COST', '0.00', 'The shipping cost for all orders using this shipping method.', '6', '0', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('Tax Class', 'MODULE_SHIPPING_STOREPICKUP_TAX_CLASS', '0', 'Use the following tax class on the shipping fee.', '6', '0', 'zen_get_tax_class_title', 'zen_cfg_pull_down_tax_classes(', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Tax Basis', 'MODULE_SHIPPING_STOREPICKUP_TAX_BASIS', 'Shipping', 'On what basis is Shipping Tax calculated. Options are<br />Shipping - Based on customers Shipping Address<br />Billing Based on customers Billing address<br />Store - Based on Store address if Billing/Shipping Zone equals Store zone', '6', '0', 'zen_cfg_select_option(array(\'Shipping\', \'Billing\'), ', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_SHIPPING_STOREPICKUP_SORT_ORDER', '0', 'Sort order of display.', '6', '0', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Countries', 'MODULE_SHIPPING_STOREPICKUP_COUNTRIES', 'AT', 'Enter the countries for which you want to offer storepickup. Two digit ISO codes, comma separated.', '6', '11', now());");
   // www.zen-cart-pro.at languages_id==43 START
    $db->Execute("insert into " . TABLE_CONFIGURATION_LANGUAGE   . " (configuration_title, configuration_key, configuration_language_id, configuration_description, date_added) values ('Selbstabholung anbieten?', 'MODULE_SHIPPING_STOREPICKUP_STATUS', '43', 'Wollen Sie Selbstabholung aktivieren?', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION_LANGUAGE   . " (configuration_title, configuration_key, configuration_language_id, configuration_description, date_added) values ('Orte für die Selbstabholung', 'MODULE_SHIPPING_STOREPICKUP_LOCATIONS_LIST', '43', 'Geben Sie eine Liste der Orte ein, getrennt durch Semikolon (;).<br/>Optional können Sie für jeden Standort eine Gebühr/Zuschlag festlegen, indem Sie ein Komma und einen Betrag hinzufügen. Wenn kein Betrag angegeben ist, wird der normale Betrag aus der Einstellung Kosten für Selbstabholung übernommen.<br/><br/>Beispiele:<br/><br/>Demogasse 17 in 1010 Wien;Beispielweg 15 in 8020 Graz<br/>Demogasse 17 in 1010 Wien,4.00;Beispielweg 15 in 8020 Graz,5.00<br/>Demogasse 17 in 1010 Wien,4.00;Beispielweg 15 in 8020 Graz,0.00<br/><br/>Wenn Sie nur einen Ort für die Abholung anbieten, dann tragen Sie einfach ein z.B. Demogasse 17 in 1010 Wien<br/><br/>Wenn Sie einen mehrsprachigen Shop betreiben und diese Definitionen mehrsprachig haben wollen, dann hinterlegen Sie Ihre Texte in den entsprechenden Sprachdateien includes/languages/SPRACHE/modules/shipping/storepickup.php.', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION_LANGUAGE   . " (configuration_title, configuration_key, configuration_language_id, configuration_description, date_added) values ('Kosten für Selbstabholung', 'MODULE_SHIPPING_STOREPICKUP_COST', '43', 'Versandkosten für Selbstabholung', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION_LANGUAGE   . " (configuration_title, configuration_key, configuration_language_id, configuration_description, date_added) values ('Steuerklasse', 'MODULE_SHIPPING_STOREPICKUP_TAX_CLASS', '43', 'Falls Sie Versandkosten für Selbstabholung eingetragen haben, welche Steuerklasse soll auf die Versandkosten angewendet werden?', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION_LANGUAGE   . " (configuration_title, configuration_key, configuration_language_id, configuration_description, date_added) values ('Basis der Steuern', 'MODULE_SHIPPING_STOREPICKUP_TAX_BASIS', '43', 'Auf welcher Basis soll die Steuer für die Versandkosten berechnet werden? Mögliche Werte sind.<br/>Shipping - basiert auf der Versandadresse des Kunden<br/>Billing - basiert auf der Rechnungsadresse des Kunden<br/>Store - basiert auf der Adresse des Shops wenn Versand- und Rechnungszone in derselben Zone liegen wie der Shop', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION_LANGUAGE   . " (configuration_title, configuration_key, configuration_language_id, configuration_description, date_added) values ('Sortierreihenfolge', 'MODULE_SHIPPING_STOREPICKUP_SORT_ORDER', '43', 'Anzeigereihenfolge. Niedrigste Werte werden zuerst angezeigt.', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION_LANGUAGE   . " (configuration_title, configuration_key, configuration_language_id, configuration_description, date_added) values ('Länder', 'MODULE_SHIPPING_STOREPICKUP_COUNTRIES', '43', 'Geben Sie hier die Länder an, für die Selbstabholung möglich sein soll.<br/>Zweistellige ISO-Codes durch Komma getrennt!', now())");   
      // www.zen-cart.at languages_id==43  END
  }
  /**
   * Remove the module and all its settings
   *
   */
  function remove() {
    global $db;
    $db->Execute("delete from " . TABLE_CONFIGURATION . " where configuration_key like 'MODULE\_SHIPPING\_STOREPICKUP\_%'");
    // www.zen-cart-pro.at languages_id == delete all
    $db->Execute("delete from " . TABLE_CONFIGURATION_LANGUAGE . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
  }
  /**
   * Internal list of configuration keys used for configuration of the module
   *
   * @return array
   */
  function keys() {
    return array('MODULE_SHIPPING_STOREPICKUP_STATUS', 'MODULE_SHIPPING_STOREPICKUP_LOCATIONS_LIST', 'MODULE_SHIPPING_STOREPICKUP_COST', 'MODULE_SHIPPING_STOREPICKUP_TAX_CLASS', 'MODULE_SHIPPING_STOREPICKUP_TAX_BASIS', 'MODULE_SHIPPING_STOREPICKUP_SORT_ORDER', 'MODULE_SHIPPING_STOREPICKUP_COUNTRIES');
  }
}

