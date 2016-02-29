<?php
/**
 * Module Template
 *
 * Loaded automatically by index.php?main_page=featured_products.<br />
 * Displays listing of Featured Products
 *
 * @package templateSystem
 * @copyright Copyright 2003-2016 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart-pro.at/license/2_0.txt GNU Public License V2.0
 * @version $Id: tpl_modules_products_featured_listing.php 731 2016-02-29 18:49:16Z webchills $
 */
?>
<table class="products-listing productsFeaturedListing">
          <tr>
            <td colspan="3"><hr /></td>
          </tr>
<?php
  $group_id = zen_get_configuration_key_value('PRODUCT_FEATURED_LIST_GROUP_ID');

  if ($featured_products_split->number_of_rows > 0) {
    $featured_products = $db->Execute($featured_products_split->sql_query);

// BOF Easy Google Analytics module pt1
    $google_enhanced_ecommerce_product_counter = 0;


    while (!$featured_products->EOF) {

      /* **************************************************
       * Easy Google Analytics
       * **************************************************/

      if (GOOGLE_ANALYTICS_ENABLED == "Enabled") {
        $google_enhanced_ecommerce_product_counter ++;
        $geeImpression =    "\n\n <!-- Google Enhanced ECommerce -->\n"
                          . "<script>\n"
                          . "ga('ec:addImpression', { "
                          . "'id': '"       . $featured_products->fields['products_id']   . "', "
                          . "'name': '"     . addslashes($featured_products->fields['products_name']) . "', "
                          . "'list': '"     . "Featured Products Listing" . "', "
                          . "'position': "  . $google_enhanced_ecommerce_product_counter . ", "
                          . "});\n"
                          . "</script>\n";

        $geeOnClick =       " onClick=\"ga('ec:addProduct', { "
                          . "'id': '"       . $featured_products->fields['products_id']   . "', "
                          . "'name': '"     . htmlspecialchars(addslashes($featured_products->fields['products_name'])) . "', "
                          . "'position': "   . $google_enhanced_ecommerce_product_counter . ", "
                          . "}); "
                          . "ga('ec:setAction', 'click', {list: 'Featured Products Listing'}); "
                          . "ga('send', 'event', 'UX', 'click', 'Featured Products Listing'); \"";

      } else {
        $geeImpression = "";
        $geeOnClick    = "";
      }

      /* *****
       *
       * *****/
      if (PRODUCT_FEATURED_LIST_IMAGE != '0') {
        if ($featured_products->fields['products_image'] == '' and PRODUCTS_IMAGE_NO_IMAGE_STATUS == 0) {
          $display_products_image = str_repeat('<br class="clearBoth" />', substr(PRODUCT_FEATURED_LIST_IMAGE, 3, 1));
        } else {
          $display_products_image = '<a href="' . zen_href_link(zen_get_info_page($featured_products->fields['products_id']), 'cPath=' . zen_get_generated_category_path_rev($featured_products->fields['master_categories_id']) . '&products_id=' . $featured_products->fields['products_id']) . '"' . $geeOnClick . '>' . zen_image(DIR_WS_IMAGES . $featured_products->fields['products_image'], $featured_products->fields['products_name'], IMAGE_FEATURED_PRODUCTS_LISTING_WIDTH, IMAGE_FEATURED_PRODUCTS_LISTING_HEIGHT) . '</a>' . str_repeat('<br clear="all" />', substr(PRODUCT_FEATURED_LIST_IMAGE, 3, 1));
        }
      } else {
        $display_products_image = '';
      }

      if (PRODUCT_FEATURED_LIST_NAME != '0') {
        $display_products_name = '<a href="' . zen_href_link(zen_get_info_page($featured_products->fields['products_id']), 'cPath=' . zen_get_generated_category_path_rev($featured_products->fields['master_categories_id']) . '&products_id=' . $featured_products->fields['products_id']) . '"' . $geeOnClick . '><strong>' . $featured_products->fields['products_name'] . '</strong></a>' . str_repeat('<br class="clearBoth" />', substr(PRODUCT_FEATURED_LIST_NAME, 3, 1));
      } else {
        $display_products_name = '';
      }
// EOF Easy Google Analytics module pt1

      if (PRODUCT_FEATURED_LIST_MODEL != '0' and zen_get_show_product_switch($featured_products->fields['products_id'], 'model')) {
        $display_products_model = TEXT_PRODUCTS_MODEL . $featured_products->fields['products_model'] . str_repeat('<br class="clearBoth" />', substr(PRODUCT_FEATURED_LIST_MODEL, 3, 1));
      } else {
        $display_products_model = '';
      }

      if (PRODUCT_FEATURED_LIST_WEIGHT != '0' and zen_get_show_product_switch($featured_products->fields['products_id'], 'weight')) {
        $display_products_weight = TEXT_PRODUCTS_WEIGHT . $featured_products->fields['products_weight'] . TEXT_SHIPPING_WEIGHT . str_repeat('<br class="clearBoth" />', substr(PRODUCT_FEATURED_LIST_WEIGHT, 3, 1));
      } else {
        $display_products_weight = '';
      }

      if (PRODUCT_FEATURED_LIST_QUANTITY != '0' and zen_get_show_product_switch($featured_products->fields['products_id'], 'quantity')) {
        if ($featured_products->fields['products_quantity'] <= 0) {
          $display_products_quantity = TEXT_OUT_OF_STOCK . str_repeat('<br class="clearBoth" />', substr(PRODUCT_FEATURED_LIST_QUANTITY, 3, 1));
        } else {
          $display_products_quantity = TEXT_PRODUCTS_QUANTITY . $featured_products->fields['products_quantity'] . str_repeat('<br class="clearBoth" />', substr(PRODUCT_FEATURED_LIST_QUANTITY, 3, 1));
        }
      } else {
        $display_products_quantity = '';
      }

      if (PRODUCT_FEATURED_LIST_DATE_ADDED != '0' and zen_get_show_product_switch($featured_products->fields['products_id'], 'date_added')) {
        $display_products_date_added = TEXT_DATE_ADDED . ' ' . zen_date_long($featured_products->fields['products_date_added']) . str_repeat('<br class="clearBoth" />', substr(PRODUCT_FEATURED_LIST_DATE_ADDED, 3, 1));
      } else {
        $display_products_date_added = '';
      }

      if (PRODUCT_FEATURED_LIST_MANUFACTURER != '0' and zen_get_show_product_switch($featured_products->fields['products_id'], 'manufacturer')) {
        $display_products_manufacturers_name = ($featured_products->fields['manufacturers_name'] != '' ? TEXT_MANUFACTURER . ' ' . $featured_products->fields['manufacturers_name'] . str_repeat('<br class="clearBoth" />', substr(PRODUCT_FEATURED_LIST_MANUFACTURER, 3, 1)) : '');
      } else {
        $display_products_manufacturers_name = '';
      }

      if ((PRODUCT_FEATURED_LIST_PRICE != '0' and zen_get_products_allow_add_to_cart($featured_products->fields['products_id']) == 'Y')  and zen_check_show_prices() == true) {
        $products_price = zen_get_products_display_price($featured_products->fields['products_id']);
        $display_products_price = TEXT_PRICE . ' ' . $products_price . str_repeat('<br class="clearBoth" />', substr(PRODUCT_FEATURED_LIST_PRICE, 3, 1)) . (zen_get_show_product_switch($featured_products->fields['products_id'], 'ALWAYS_FREE_SHIPPING_IMAGE_SWITCH') ? (zen_get_product_is_always_free_shipping($featured_products->fields['products_id']) ? TEXT_PRODUCT_FREE_SHIPPING_ICON . '<br />' : '') : '');
      } else {
        $display_products_price = '';
      }

// BOF Easy Google Analytics module pt2
// more info in place of buy now
      if (PRODUCT_FEATURED_BUY_NOW != '0' and zen_get_products_allow_add_to_cart($featured_products->fields['products_id']) == 'Y') {
        if (zen_has_product_attributes($featured_products->fields['products_id'])) {
          $link = '<a href="' . zen_href_link(zen_get_info_page($featured_products->fields['products_id']), 'cPath=' . zen_get_generated_category_path_rev($featured_products->fields['master_categories_id']) . '&products_id=' . $featured_products->fields['products_id']) . '"' . $geeOnClick . '>' . MORE_INFO_TEXT . '</a>';
        } else {
//          $link= '<a href="' . zen_href_link(FILENAME_FEATURED_PRODUCTS, zen_get_all_get_params(array('action')) . 'action=buy_now&products_id=' . $featured_products->fields['products_id']) . '">' . zen_image_button(BUTTON_IMAGE_IN_CART, BUTTON_IN_CART_ALT) . '</a>';
          if (PRODUCT_FEATURED_LISTING_MULTIPLE_ADD_TO_CART > 0 && $featured_products->fields['products_qty_box_status'] != 0) {
//            $how_many++;
            $link = TEXT_PRODUCT_FEATURED_LISTING_MULTIPLE_ADD_TO_CART . "<input type=\"text\" name=\"products_id[" . $featured_products->fields['products_id'] . "]\" value=\"0\" size=\"4\" />";
          } else {
            $link = '<a href="' . zen_href_link(FILENAME_FEATURED_PRODUCTS, zen_get_all_get_params(array('action')) . 'action=buy_now&products_id=' . $featured_products->fields['products_id']) . '"' . $geeOnClick . '>' . zen_image_button(BUTTON_IMAGE_BUY_NOW, BUTTON_BUY_NOW_ALT) . '</a>&nbsp;';
          }
        }

        $the_button = $link;
        $products_link = '<a href="' . zen_href_link(zen_get_info_page($featured_products->fields['products_id']), 'cPath=' . zen_get_generated_category_path_rev($featured_products->fields['master_categories_id']) . '&products_id=' . $featured_products->fields['products_id']) . '"' . $geeOnClick . '>' . MORE_INFO_TEXT . '</a>';
        $display_products_button = zen_get_buy_now_button($featured_products->fields['products_id'], $the_button, $products_link) . '<br />' . zen_get_products_quantity_min_units_display($featured_products->fields['products_id']) . str_repeat('<br class="clearBoth" />', substr(PRODUCT_FEATURED_BUY_NOW, 3, 1));
      } else {
        $link = '<a href="' . zen_href_link(zen_get_info_page($featured_products->fields['products_id']), 'cPath=' . zen_get_generated_category_path_rev($featured_products->fields['master_categories_id']) . '&products_id=' . $featured_products->fields['products_id']) . '"' . $geeOnClick . '>' . MORE_INFO_TEXT . '</a>';
        $the_button = $link;
        $products_link = '<a href="' . zen_href_link(zen_get_info_page($featured_products->fields['products_id']), 'cPath=' . zen_get_generated_category_path_rev($featured_products->fields['master_categories_id']) . '&products_id=' . $featured_products->fields['products_id']) . '"' . $geeOnClick . '>' . MORE_INFO_TEXT . '</a>';
        $display_products_button = zen_get_buy_now_button($featured_products->fields['products_id'], $the_button, $products_link) . '<br />' . zen_get_products_quantity_min_units_display($featured_products->fields['products_id']) . str_repeat('<br class="clearBoth" />', substr(PRODUCT_FEATURED_BUY_NOW, 3, 1));
      }

      if (PRODUCT_FEATURED_LIST_DESCRIPTION > '0') {
        $disp_text = zen_get_products_description($featured_products->fields['products_id']);
        $disp_text = zen_clean_html($disp_text);

        $display_products_description = stripslashes(zen_trunc_string($disp_text, PRODUCT_FEATURED_LIST_DESCRIPTION, '<a href="' . zen_href_link(zen_get_info_page($featured_products->fields['products_id']), 'cPath=' . zen_get_generated_category_path_rev($featured_products->fields['master_categories_id']) . '&products_id=' . $featured_products->fields['products_id']) . '"' . $geeOnClick . '> ' . MORE_INFO_TEXT . '</a>'));
      } else {
        $display_products_description = '';
      }
// EOF Easy Google Analytics module pt2

?>
          <tr>
            <td width="<?php echo IMAGE_FEATURED_PRODUCTS_LISTING_WIDTH + 10; ?>" valign="top" class="main" align="center">
              <?php
                $disp_sort_order = $db->Execute("select configuration_key, configuration_value from " . TABLE_CONFIGURATION . " where configuration_group_id='" . $group_id . "' and (configuration_value >= 1000 and configuration_value <= 1999) order by LPAD(configuration_value,11,0)");
                while (!$disp_sort_order->EOF) {
                  if ($disp_sort_order->fields['configuration_key'] == 'PRODUCT_FEATURED_LIST_IMAGE') {
                    echo $display_products_image;
                  }
                  if ($disp_sort_order->fields['configuration_key'] == 'PRODUCT_FEATURED_LIST_QUANTITY') {
                    echo $display_products_quantity;
                  }
                  if ($disp_sort_order->fields['configuration_key'] == 'PRODUCT_FEATURED_BUY_NOW') {
                    echo $display_products_button;
                  }

                  if ($disp_sort_order->fields['configuration_key'] == 'PRODUCT_FEATURED_LIST_NAME') {
                    echo $display_products_name;
                  }
                  if ($disp_sort_order->fields['configuration_key'] == 'PRODUCT_FEATURED_LIST_MODEL') {
                    echo $display_products_model;
                  }
                  if ($disp_sort_order->fields['configuration_key'] == 'PRODUCT_FEATURED_LIST_MANUFACTURER') {
                    echo $display_products_manufacturers_name;
                  }
                  if ($disp_sort_order->fields['configuration_key'] == 'PRODUCT_FEATURED_LIST_PRICE') {
                    echo $display_products_price;
                  }
                  if ($disp_sort_order->fields['configuration_key'] == 'PRODUCT_FEATURED_LIST_WEIGHT') {
                    echo $display_products_weight;
                  }
                  if ($disp_sort_order->fields['configuration_key'] == 'PRODUCT_FEATURED_LIST_DATE_ADDED') {
                    echo $display_products_date_added;
                  }
                  $disp_sort_order->MoveNext();
                }
              ?>
            </td>
            <td colspan="2" valign="top" class="main">
              <?php
                $disp_sort_order = $db->Execute("select configuration_key, configuration_value from " . TABLE_CONFIGURATION . " where configuration_group_id='" . $group_id . "' and (configuration_value >= 2000 and configuration_value <= 2999) order by LPAD(configuration_value,11,0)");
                while (!$disp_sort_order->EOF) {
                  if ($disp_sort_order->fields['configuration_key'] == 'PRODUCT_FEATURED_LIST_IMAGE') {
                    echo $display_products_image;
                  }
                  if ($disp_sort_order->fields['configuration_key'] == 'PRODUCT_FEATURED_LIST_QUANTITY') {
                    echo $display_products_quantity;
                  }
                  if ($disp_sort_order->fields['configuration_key'] == 'PRODUCT_FEATURED_BUY_NOW') {
                    echo $display_products_button;
                  }

                  if ($disp_sort_order->fields['configuration_key'] == 'PRODUCT_FEATURED_LIST_NAME') {
                    echo $display_products_name;
                  }
                  if ($disp_sort_order->fields['configuration_key'] == 'PRODUCT_FEATURED_LIST_MODEL') {
                    echo $display_products_model;
                  }
                  if ($disp_sort_order->fields['configuration_key'] == 'PRODUCT_FEATURED_LIST_MANUFACTURER') {
                    echo $display_products_manufacturers_name;
                  }
                  if ($disp_sort_order->fields['configuration_key'] == 'PRODUCT_FEATURED_LIST_PRICE') {
                    echo $display_products_price;
                  }
                  if ($disp_sort_order->fields['configuration_key'] == 'PRODUCT_FEATURED_LIST_WEIGHT') {
                    echo $display_products_weight;
                  }
                  if ($disp_sort_order->fields['configuration_key'] == 'PRODUCT_FEATURED_LIST_DATE_ADDED') {
                    echo $display_products_date_added;
                  }
                  $disp_sort_order->MoveNext();
                }
// BOF Easy Google Analytics module pt3
                // *****
                // Easy Google Analytics
                // *****
                echo $geeImpression;
// EOF Easy Google Analytics module pt3
              ?>
            </td>
          </tr>
<?php if (PRODUCT_FEATURED_LIST_DESCRIPTION > '0') { ?>
          <tr>
            <td colspan="3" valign="top" class="main">
              <?php
                echo $display_products_description;
              ?>
            </td>
          </tr>
<?php } ?>

          <tr>
            <td colspan="3"><hr /></td>
          </tr>
<?php
      $featured_products->MoveNext();
    }
  } else {
?>
          <tr>
            <td class="main" colspan="2"><?php echo TEXT_NO_FEATURED_PRODUCTS; ?></td>
          </tr>
<?php
  }
?>
</table>
