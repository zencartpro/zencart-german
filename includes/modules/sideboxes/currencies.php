<?php
/**
 * currencies sidebox - allows customer to select from available currencies
 *
 * @package templateSystem
 * @copyright Copyright 2003-2012 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart-pro.at/license/2_0.txt GNU Public License V2.0
 * @version $Id: currencies.php 729 2011-08-09 15:49:16Z hugo13 $
 */

// test if box should display
  $show_currencies= false;

  // don't display on checkout page:
  if (substr($current_page, 0, 8) != 'checkout') {
    $show_currencies= true;
  }

  if ($show_currencies == true) {
    if (isset($currencies) && is_object($currencies)) {

      reset($currencies->currencies);
      $currencies_array = array();
      while (list($key, $value) = each($currencies->currencies)) {
        $currencies_array[] = array('id' => $key, 'text' => $value['title']);
      }

      $hidden_get_variables = '';
      reset($_GET);
      while (list($key, $value) = each($_GET)) {
        if ( ($key != 'currency') && ($key != zen_session_name()) && ($key != 'x') && ($key != 'y') ) {
          $hidden_get_variables .= zen_draw_hidden_field($key, $value);
        }
      }

      require($template->get_template_dir('tpl_currencies.php',DIR_WS_TEMPLATE, $current_page_base,'sideboxes'). '/tpl_currencies.php');
      $title =  '<label>' . BOX_HEADING_CURRENCIES . '</label>';
      $title_link = false;
      require($template->get_template_dir($column_box_default, DIR_WS_TEMPLATE, $current_page_base,'common') . '/' . $column_box_default);
    }
  }
?>