<?php
/**
 * @package admin
 * @copyright Copyright 2003-2019 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license https://www.zen-cart-pro.at/license/3_0.txt GNU General Public License V3.0
 * @version $Id: alt_nav.php 730 2014-02-08 15:49:16Z webchills $
 */
require('includes/application_top.php');
?>
<!doctype html public "-//W3C//DTD HTML 4.01 Transitional//EN">
<html <?php echo HTML_PARAMS; ?>>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<?php echo CHARSET; ?>">
<title><?php echo TITLE; ?></title>
<meta name="robots" content="noindex, nofollow" />
<script src="includes/menu.js" type="text/javaScript"></script>
<link href="includes/stylesheet.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="includes/cssjsmenuhover.css" media="all" id="hoverJS" />
</head>
<body onLoad="cssjsmenu('navbar')">
<!-- header //-->
<?php require(DIR_WS_INCLUDES . 'header.php'); ?>
<!-- header_eof //-->
<div id="alt_nav">
<h1><?php echo HEADING_TITLE ?></h1>

<?php
 foreach (zen_get_admin_menu_for_user() as $menuKey => $pages)
 {
   $pageList = array();
   foreach ($pages as $page)
   {
      $pageList[] = '<a href="' . zen_href_link($page['file'], $page['params']) . '">' . $page['name'] . '</a>';
   }
?>
  <div>
    <h2><?php echo $menuTitles[$menuKey] ?></h2>
    <p><?php echo implode(', ', $pageList) ?>.</p>
  </div>
<?php
 }
?>
</div>

<!-- body_eof //-->
<!-- footer //-->
<?php require(DIR_WS_INCLUDES . 'footer.php'); ?>
<!-- footer_eof //-->
<br>
</body>
</html>
<?php require(DIR_WS_INCLUDES . 'application_bottom.php'); ?>
