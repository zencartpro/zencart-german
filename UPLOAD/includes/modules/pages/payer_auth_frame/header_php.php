<?php
/**
 * payer_auth_frame page
 *
 * @package paymentMethod
 * @copyright Copyright 2003-2019 Zen Cart Development Team
 * @copyright Portions Copyright 2005 CardinalCommerce
 * @license https://www.zen-cart-pro.at/license/3_0.txt GNU General Public License V3.0
 * @version $Id: header_php.php 729 2011-08-09 15:49:16Z hugo13 $
 */
/**
 * Purpose:
 * Creates a frame display so the the customer can complete
 * payer authentication but still have the experience that they have
 * not left the online store.
 */

if (!isset($_SESSION['customer_id']) || (int)$_SESSION['customer_id'] < 1 || !isset($_SESSION['payment']) || $_SESSION['payment'] == '' || !isset($_SESSION['3Dsecure_acsURL']) || $_SESSION['3Dsecure_acsURL'] == '') {
  die(WARNING_SESSION_TIMEOUT);
}

$_SESSION['3Dsecure_term_url'] = zen_href_link(FILENAME_PAYER_AUTH_VERIFIER, '', 'SSL', true, false);
$_SESSION['3Dsecure_auth_url'] = zen_href_link(FILENAME_PAYER_AUTH_AUTH, '', 'SSL', true, false);
$flag_disable_left = TRUE;
$flag_disable_right = TRUE;

header("Cache-Control: max-age=1");  // stores for only 1 second, which prevents page from being re-displayed
