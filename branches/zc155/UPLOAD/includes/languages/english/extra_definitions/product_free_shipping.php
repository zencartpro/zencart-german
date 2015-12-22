<?php
/**
 * @package languageDefines
 * @copyright Copyright 2003-2016 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart-pro.at/license/2_0.txt GNU Public License V2.0
 * @version $Id: product_free_shipping.php 730 2015-12-22 17:49:16Z webchills $
 */

// defined as an image, text or a combination for Always Free Shipping
// comment out the ones you do not which to use
// to show nothing, comment all out except one and define as ''
// define('TEXT_PRODUCT_FREE_SHIPPING_ICON', 'FREE SHIPPING'); // for text or set to '' for nothing
define('TEXT_PRODUCT_FREE_SHIPPING_ICON', zen_image(DIR_WS_TEMPLATE_IMAGES . 'always-free-shipping.gif', 'Always Free Shipping')); // for an image or comment out to use another