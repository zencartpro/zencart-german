<?php
/**
 * Page Template
 *
 * Loaded automatically by index.php?main_page=checkout_payment_address.<br />
 * Allows customer to change the billing address.
 *
 * @package templateSystem
 * @copyright Copyright 2003-2019 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license https://www.zen-cart-pro.at/license/3_0.txt GNU General Public License V3.0
 * @version $Id: tpl_checkout_payment_address_default 4 2019-09-27 09:33:58Z webchills $

 */
?>
<div class="centerColumn" id="checkoutPayAddressDefault">

<?php echo zen_draw_form('checkout_address', zen_href_link(FILENAME_CHECKOUT_PAYMENT_ADDRESS, '', 'SSL'), 'post', 'class="group"'); ?>

<h1 id="checkoutPayAddressDefaultHeading"><?php echo HEADING_TITLE; ?></h1>

<?php if ($messageStack->size('checkout_address') > 0) echo $messageStack->output('checkout_address'); ?>

<h2 id="checkoutPayAddressDefaultAddress"><?php echo TITLE_PAYMENT_ADDRESS; ?></h2>
<div class="instructions group">
<address class="back"><?php echo zen_address_label($_SESSION['customer_id'], $_SESSION['billto'], true, ' ', '<br />'); ?></address>
<?php echo TEXT_SELECTED_PAYMENT_DESTINATION; ?>
</div>


<?php
     if ($addresses_count < MAX_ADDRESS_BOOK_ENTRIES) {
?>
<?php
/**
 * require template to collect address details
 */
 require($template->get_template_dir('tpl_modules_checkout_new_address.php', DIR_WS_TEMPLATE, $current_page_base,'templates'). '/' . 'tpl_modules_checkout_new_address.php');
?>
<div class="buttonRow forward"><?php echo zen_draw_hidden_field('action', 'submit') . zen_image_submit(BUTTON_IMAGE_CONTINUE, BUTTON_CONTINUE_ALT); ?></div>
</form>

<?php
    }
    if ($addresses_count > 1) {
?>
<?php echo zen_draw_form('checkout_address_book', zen_href_link(FILENAME_CHECKOUT_PAYMENT_ADDRESS, '', 'SSL'), 'post', 'class="group"'); ?>

<fieldset>
<legend><?php echo TABLE_HEADING_NEW_PAYMENT_ADDRESS; ?></legend>
<?php
      require($template->get_template_dir('tpl_modules_checkout_address_book.php', DIR_WS_TEMPLATE, $current_page_base,'templates'). '/' . 'tpl_modules_checkout_address_book.php');
?>
</fieldset>
<div class="buttonRow forward"><?php echo zen_draw_hidden_field('action', 'submit') . zen_image_submit(BUTTON_IMAGE_CONTINUE, BUTTON_CONTINUE_ALT); ?></div>
</form>
<?php
     }
?>

<div class="buttonRow back"><?php echo TITLE_CONTINUE_CHECKOUT_PROCEDURE . '<br />' . TEXT_CONTINUE_CHECKOUT_PROCEDURE; ?></div>

<div class="buttonRow back clearBoth"><?php echo zen_back_link() . zen_image_button(BUTTON_IMAGE_BACK, BUTTON_BACK_ALT) . '</a>'; ?></div>
</div>
