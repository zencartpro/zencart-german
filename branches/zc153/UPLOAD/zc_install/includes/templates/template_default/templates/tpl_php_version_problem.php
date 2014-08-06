<?php
/**
 * This page is auto-displayed if an outdated version of PHP version is detected
 *
 * @package Installer
 * @access private
 * @copyright Copyright 2003-2014 Zen Cart Development Team
 * @license http://www.zen-cart-pro.at/license/2_0.txt GNU Public License V2.0
 * @version $Id: tpl_php_version_problem.php 807 2014-07-05 11:03:26Z webchills $
 */
$relPath = (file_exists('includes/templates/template_default/images/zen_header_bg.jpg')) ? '' : '../';
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf8">
<title>PHP Versions Update erforderlich</title>
<meta name="keywords" content="">
<meta name="description" content="">
<meta http-equiv="imagetoolbar" content="no">
<meta name="authors" content="The Zen Cart&reg; Team and others">
<meta name="generator" content="shopping cart program by Zen Cart&reg;, http://www.zen-cart.com">
<meta name="robots" content="noindex, nofollow">
<style type="text/css">
<!--
body {margin: 10px}
#container {width: 730px; background-color: #ffffff; margin: auto; padding: 10px; border: 0px solid #cacaca;font-family:Arial,Verdana,sans-serif;}
div .headerimg {padding:0; width: 730px;}
.systemError {color: red}
-->
</style>
</head>

<body id="pagebody">
<div id="container">
<img src="<?php echo $relPath; ?>includes/templates/template_default/images/zen_header_bg.jpg" alt="Zen Cart&reg;" title=" Zen Cart&reg; " class="headerimg">
<div align="center"><h2>Danke, dass Sie die deutsche Zen-Cart Version installieren.</h2></div>
<h2 class="systemError">Leider haben wir folgendes Problem festgestellt</h2>
<p class="systemError">Die PHP Version (<?php echo PHP_VERSION; ?>) die Sie verwenden ist zu alt. Zen-Cart 1.5.3 kann mit dieser PHP-Version NICHT verwendet werden. Bitte führen Sie auf Ihrem Server ein Update auf die aktuelle PHP Version durch.</p>
<p>Diese Version von Zen-Cart erfordert mindestens die PHP Version 5.2.14<br><strong>Wir empfehlen den Einsatz der PHP Version 5.4 oder 5.5</strong></p>
</div>
</body>
</html>