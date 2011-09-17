<?php
/*
//////////////////////////////////////////////////////////
//  SUPER ORDERS                                        //
//                                                      //
//  By Frank Koehl (PM: BlindSide)                      //
//                                                      //
//  Powered by Zen-Cart (www.zen-cart.com)              //
//  Portions Copyright (c) 2005 The Zen-Cart Team       //
//                                                      //
//  Released under the GNU General Public License       //
//  available at www.zen-cart.com/license/2_0.txt       //
//  or see "license.txt" in the downloaded zip          //
//////////////////////////////////////////////////////////
//  DESCRIPTION:   Replaces admin/invoice.php, adds     //
//  amount paid & balance due values based on           //
//  super_order class calculations.  Also includes the  //
//  option to display a tax exemption number,           //
//  configurable from the admin.                        //
//////////////////////////////////////////////////////////
// $Id: super_invoice.php 25 2006-02-03 18:55:56Z BlindSide $
*/

  require('includes/application_top.php');
  require(DIR_WS_CLASSES . 'currencies.php');
  require(DIR_WS_CLASSES . 'order.php');
  require(DIR_WS_CLASSES . 'super_order.php');

  $oID = zen_db_prepare_input($_GET['oID']);
  $order = new order($oID);
  $so = new super_order($oID);
  $currencies = new currencies();

  $display_tax = (FED_TAX_ID_NUMBER == '' ? true : false);

  // Find any comments entered at checkout
  // and display on invoice if they exist
  $orders_history = $db->Execute("SELECT orders_status_id, date_added, customer_notified, comments
                                  FROM " . TABLE_ORDERS_STATUS_HISTORY . "
                                  WHERE orders_id = '" . $oID . "'
                                  ORDER BY date_added");

  if ($orders_history->fields['comments'] != '') {
    $customer_notes = $orders_history->fields['comments'];
    $display_notes = 1;
  }
  else {
    $display_notes = 0;
  }


?>
<!doctype html public "-//W3C//DTD HTML 4.01 Transitional//EN">
<html <?php echo HTML_PARAMS; ?>>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<?php echo CHARSET; ?>">
<title><?php echo HEADER_INVOICE . (int)$oID; ?></title>
<link rel="stylesheet" type="text/css" href="includes/stylesheet.css">
<script language="javascript" src="includes/menu.js">
</script>
</head>
<body marginwidth="0" marginheight="0" topmargin="0" bottommargin="0" leftmargin="0" rightmargin="0" bgcolor="#FFFFFF">
<?php
    $prev_oID = $oID - 1;
    $next_oID = $oID + 1;

    $prev_button = '            <a href ="' . zen_href_link(FILENAME_SUPER_INVOICE, 'oID=' . $prev_oID) . '">' . zen_draw_separator('pixel_trans.gif', '50', '30') . '</a>';

    $check_for_next = $db->Execute("SELECT orders_id FROM " . TABLE_ORDERS . " WHERE orders_id = '" . (int)$next_oID . "'");
    if (zen_not_null($check_for_next->fields['orders_id'])) {
      $next_button = '            <a href ="' . zen_href_link(FILENAME_SUPER_INVOICE, 'oID=' . $next_oID) . '">' . zen_draw_separator('pixel_trans.gif', '50', '30') . '</a>';
    }
    else {
      $next_button = '            <a href ="' . zen_href_link(FILENAME_SUPER_ORDERS) . '">' . zen_draw_separator('pixel_trans.gif', '50', '30') . '</a>';
    }
?>
<!-- body_text //-->
<table border="0" width="100%" cellspacing="0" cellpadding="2">
  <tr>
    <td><table border="0" width="100%" cellspacing="0" cellpadding="0">
      <tr>
        <td valign="top" class="invoiceHeading"><?php
          echo nl2br(STORE_NAME_ADDRESS);
          if (!$display_tax) echo '<br /><br />' . HEADER_TAX_ID . FED_TAX_ID_NUMBER;
        ?></td>
        <td><?php echo zen_draw_separator('pixel_trans.gif', '20', '1'); ?></td>
        <td valign="top"><table border="0" cellspacing="2" cellpadding="0">
          <tr>
            <td class="invoiceHeading" align="left" valign="top"><?php echo HEADER_PHONE; ?></td>
            <td class="invoiceHeading" align="left" valign="top"><?php echo STORE_PHONE; ?></td>
          </tr>
          <tr>
            <td class="invoiceHeading" align="left" valign="top"><?php echo HEADER_FAX; ?></td>
            <td class="invoiceHeading" align="left" valign="top"><?php echo STORE_FAX; ?></td>
          </tr>
          <tr>
            <td class="invoiceHeading" align="left" valign="bottom"><?php echo $prev_button; ?></td>
            <td class="invoiceHeading" align="right" valign="bottom"><?php echo $next_button; ?></td>
          </tr>
        </table></td>
        <td class="pageHeading" align="right"><?php
          echo zen_image(DIR_WS_IMAGES . HEADER_LOGO_IMAGE, HEADER_ALT_TEXT) . '<br />';
          echo HEADER_INVOICE . (int)$oID;
        ?></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="2">
      <tr>
        <td colspan="6"><?php echo zen_draw_separator(); ?></td>
      </tr>
      <tr>
        <td><?php echo zen_draw_separator('pixel_trans.gif', '23', '1'); ?></td>
        <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr>
            <td><?php echo zen_draw_separator('pixel_trans.gif', '1', '5'); ?></td>
          </tr>        
          <tr>
            <td class="main"><strong><?php echo ENTRY_BILL_TO; ?></strong></td>
          </tr>
          <tr>
            <td><?php echo zen_draw_separator('pixel_trans.gif', '1', '5'); ?></td>
          </tr>
          <tr>
            <td class="main"><?php echo zen_address_format($order->customer['format_id'], $order->billing, 1, '', '<br />'); ?></td>
          </tr>
          <tr>
            <td><?php echo zen_draw_separator('pixel_trans.gif', '1', '5'); ?></td>
          </tr>
          <tr>
            <td class="main"><?php echo $order->customer['telephone']; ?></td>
          </tr>
          <tr>
            <td class="main"><?php echo '<a href="mailto:' . $order->customer['email_address'] . '">' . $order->customer['email_address'] . '</a>'; ?></td>
          </tr>
        </table></td>
        <td><?php echo zen_draw_separator('pixel_trans.gif', '60', '1'); ?></td>
        <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr>
            <td><?php echo zen_draw_separator('pixel_trans.gif', '1', '5'); ?></td>
          </tr>
          <tr>
            <td class="main"><strong><?php echo ENTRY_SHIP_TO; ?></strong></td>
          </tr>
          <tr>
            <td><?php echo zen_draw_separator('pixel_trans.gif', '1', '5'); ?></td>
          </tr>
          <tr>
            <td class="main"><?php echo zen_address_format($order->delivery['format_id'], $order->delivery, 1, '', '<br />'); ?></td>
          </tr>
        </table></td>
<?php
        if ($so->purchase_order) {
?>
        <td align="right" valign="top"><table border="0" cellspacing="0" cellpadding="2">
          <tr>
            <td><?php echo zen_draw_separator('pixel_trans.gif', '1', '5'); ?></td>
          </tr>
          <tr>
            <td class="main" colspan="2"><strong><?php echo ENTRY_PO_INFO; ?></strong></td>
          </tr>
          <tr>
            <td><?php echo zen_draw_separator('pixel_trans.gif', '1', '5'); ?></td>
          </tr>
          <tr>
            <td class="main" align="left"><?php echo HEADER_PO_NUMBER; ?></td>
            <td class="main" align="right"><?php echo $so->purchase_order[0]['number']; ?></td>
          </tr>
          <tr>
            <td class="main" align="left"><?php echo HEADER_PO_INVOICE_DATE; ?></td>
            <td class="main" align="right"><?php echo zen_date_short($so->purchase_order[0]['posted']); ?></td>
          </tr>
          <tr>
            <td class="main" align="left"><?php echo HEADER_PO_TERMS; ?></td>
            <td class="main" align="right"><?php echo HEADER_PO_TERMS_LENGTH; ?></td>
          </tr>
        </table></td>
<?php } ?>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><?php echo zen_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
  </tr>
  <tr>
    <td><table border="0" cellspacing="0" cellpadding="2">
      <tr>
        <td class="main"><strong><?php echo ENTRY_ORDER_ID . $oID; ?></strong></td>
      </tr>
      <tr>
        <td class="main"><strong><?php echo ENTRY_DATE_PURCHASED; ?></strong></td>
        <td class="main"><?php echo zen_date_long($order->info['date_purchased']); ?></td>
      </tr>
      <tr>
        <td class="main"><strong><?php echo ENTRY_PAYMENT_METHOD; ?></strong></td>
        <td class="main"><?php echo $order->info['payment_method']; ?></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><?php echo zen_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
  </tr>
  <tr>
    <td><table border="0" width="100%" cellspacing="0" cellpadding="2">
      <tr class="dataTableHeadingRow">
        <td class="dataTableHeadingContent" colspan="2"><?php echo TABLE_HEADING_PRODUCTS; ?></td>
        <td class="dataTableHeadingContent"><?php echo TABLE_HEADING_PRODUCTS_MODEL; ?></td>
        <td class="dataTableHeadingContent" align="right"><?php echo TABLE_HEADING_TAX; ?></td>
        <?php if ($display_tax) { ?>
        <td class="dataTableHeadingContent" align="right"><?php echo TABLE_HEADING_PRICE_EXCLUDING_TAX; ?></td>
        <td class="dataTableHeadingContent" align="right"><?php echo TABLE_HEADING_PRICE_INCLUDING_TAX; ?></td>
        <td class="dataTableHeadingContent" align="right"><?php echo TABLE_HEADING_TOTAL_EXCLUDING_TAX; ?></td>
        <td class="dataTableHeadingContent" align="right"><?php echo TABLE_HEADING_TOTAL_INCLUDING_TAX; ?></td>
        <?php }
        else { ?>
        <td class="dataTableHeadingContent" align="right"><?php echo TABLE_HEADING_PRICE_NO_TAX; ?></td>
        <td class="dataTableHeadingContent" align="right"><?php echo TABLE_HEADING_TOTAL_NO_TAX; ?></td>
        <?php } ?>
      </tr>
<?php
    for ($i = 0, $n = sizeof($order->products); $i < $n; $i++) {
      echo '      <tr class="dataTableRow">' . "\n" .
           '        <td class="dataTableContent" valign="top" align="right">' . $order->products[$i]['qty'] . '&nbsp;x</td>' . "\n" .
           '        <td class="dataTableContent" valign="top">' . $order->products[$i]['name'];

      if (isset($order->products[$i]['attributes']) && (($k = sizeof($order->products[$i]['attributes'])) > 0)) {
        for ($j = 0; $j < $k; $j++) {
          echo '<br /><nobr><small>&nbsp;<i> - ' . $order->products[$i]['attributes'][$j]['option'] . ': ' . $order->products[$i]['attributes'][$j]['value'];
          if ($order->products[$i]['attributes'][$j]['price'] != '0') echo ' (' . $order->products[$i]['attributes'][$j]['prefix'] . $currencies->format($order->products[$i]['attributes'][$j]['price'] * $order->products[$i]['qty'], true, $order->info['currency'], $order->info['currency_value']) . ')';
          if ($order->products[$i]['attributes'][$j]['product_attribute_is_free'] == '1' and $order->products[$i]['product_is_free'] == '1') echo TEXT_INFO_ATTRIBUTE_FREE;
          echo '</i></small></nobr>';
        }
      }

      echo '        </td>' . "\n" .
           '        <td class="dataTableContent" valign="top">' . $order->products[$i]['model'] . '</td>' . "\n";
      echo '        <td class="dataTableContent" align="right" valign="top">';
      if ($display_tax) {
        echo zen_display_tax_value($order->products[$i]['tax']) . '%';
      }
      else {
        echo ENTRY_NO_TAX;
      }
      echo '</td>' . "\n" ;
    if ($display_tax) {
      echo '        <td class="dataTableContent" align="right" valign="top"><strong>' . $currencies->format($order->products[$i]['final_price'], true, $order->info['currency'], $order->info['currency_value']) . '</strong></td>' . "\n" .
           '        <td class="dataTableContent" align="right" valign="top"><strong>' . $currencies->format(zen_add_tax($order->products[$i]['final_price'], $order->products[$i]['tax']), true, $order->info['currency'], $order->info['currency_value']) . '</strong></td>' . "\n" .
           '        <td class="dataTableContent" align="right" valign="top"><strong>' . $currencies->format($order->products[$i]['final_price'] * $order->products[$i]['qty'], true, $order->info['currency'], $order->info['currency_value']) . '</strong></td>' . "\n" .
           '        <td class="dataTableContent" align="right" valign="top"><strong>' . $currencies->format(zen_add_tax($order->products[$i]['final_price'], $order->products[$i]['tax']) * $order->products[$i]['qty'], true, $order->info['currency'], $order->info['currency_value']) . '</strong></td>' . "\n";
      echo '      </tr>' . "\n";
    }
    else {
      echo '        <td class="dataTableContent" align="right" valign="top"><strong>' . $currencies->format($order->products[$i]['final_price'], true, $order->info['currency'], $order->info['currency_value']) . '</strong></td>' . "\n" .
           '        <td class="dataTableContent" align="right" valign="top"><strong>' . $currencies->format($order->products[$i]['final_price'] * $order->products[$i]['qty'], true, $order->info['currency'], $order->info['currency_value']) . '</strong></td>' . "\n" .
           '      </tr>' . "\n";
    }
    }
?>
      <tr>
        <td align="right" colspan="8"><table border="0" cellspacing="0" cellpadding="2">
<?php
  for ($i = 0, $n = sizeof($order->totals); $i < $n; $i++) {
      if ($order->totals[$i]['class'] == 'ot_shipping') {
        $format_shipping = explode(" (", $order->totals[$i]['title'], 2);
        $clean_shipping = rtrim($format_shipping[0], ":");
        $display_title = $clean_shipping . ':';
      }
      else {
        $display_title = $order->totals[$i]['title'];
      }

    echo '          <tr>' . "\n" .
         '            <td align="right" class="'. str_replace('_', '-', $order->totals[$i]['class']) . '-Text">' . $display_title . '</td>' . "\n" .
         '            <td align="right" class="'. str_replace('_', '-', $order->totals[$i]['class']) . '-Amount">' . $order->totals[$i]['text'] . '</td>' . "\n" .
         '          </tr>' . "\n";
    $order_total = $order->totals[$i]['text'];
  }

    echo '          <tr>' . "\n" .
         '            <td class="dataTableContent" align="right" valign="top"><strong>Amount Paid:</strong></td>' . "\n" .
         '            <td class="dataTableContent" align="right" valign="top"><strong>' . $currencies->format($so->amount_applied) . '</strong></td>' . "\n" .
         '          </tr>' . "\n";

    echo '          <tr>' . "\n" .
         '            <td class="dataTableContent" align="right" valign="top"><strong>Balance Due:</strong></td>' . "\n" .
         '            <td class="dataTableContent" align="right" valign="top"><strong>' . $currencies->format($so->balance_due) . '</strong></td>' . "\n" .
         '          </tr>' . "\n";
?>
        </table></td>
      </tr>
    </table></td>
  </tr>
<?php if ($display_notes == 1) { ?>
  <tr>
    <td><?php echo zen_draw_separator('pixel_trans.gif', '1', '5'); ?></td>
  </tr>
  <tr>
    <td class="main" colspan="2"><strong><?php echo HEADER_CUSTOMER_NOTES; ?></strong></td>
  </tr>
  <tr>
    <td class="main" colspan="2"><?php echo $customer_notes; ?></td>
  </tr>
<?php } ?>  
</table>
<!-- body_text_eof //-->
</body>
</html>
<?php require(DIR_WS_INCLUDES . 'application_bottom.php'); ?>