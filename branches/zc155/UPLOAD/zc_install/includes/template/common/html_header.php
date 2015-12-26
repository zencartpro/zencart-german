<?php
/**
 * @package Installer
 * @copyright Copyright 2003-2016 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart-pro.at/license/2_0.txt GNU Public License V2.0
 * @version $Id: html_header.php 3 2015-12-26 21:49:16Z webchills $
 */
?>
<!DOCTYPE html >
<!--[if IE 9]><html class="lt-ie10" <?php echo HTML_PARAMS; ?> > <![endif]-->
<html class="no-js" <?php echo HTML_PARAMS; ?> >

<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><?php echo META_TAG_TITLE; ?></title>

<meta name="robots" content="noindex, nofollow" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />

<link rel="stylesheet" type="text/css" href="<?php echo DIR_WS_INSTALL_TEMPLATE . 'css/normalize.css'; ?>" />
<link rel="stylesheet" type="text/css" href="<?php echo DIR_WS_INSTALL_TEMPLATE . 'css/foundation.min.css'; ?>" />
<link rel="stylesheet" type="text/css" href="<?php echo DIR_WS_INSTALL_TEMPLATE . 'css/stylesheet.css'; ?>" />

<script src="<?php echo DIR_WS_INSTALL_TEMPLATE . 'foundation/modernizr.js'; ?>"></script>

<script src="//code.jquery.com/jquery-2.1.4.min.js"></script>
<script>window.jQuery || document.write('<script src="includes/template/foundation/jquery.min.js"><\/script>');</script>
</head>

