<?php
/**
 * @package Installer
 * @copyright Copyright 2003-2013 Zen Cart Development Team
 * @license http://www.zen-cart-pro.at/license/2_0.txt GNU Public License V2.0
 * @version $Id: partial_breadcrumb.php 3 2015-12-26 21:49:16Z webchills $
 */

?>
<div>
  <ul class="breadcrumbs">
    <li <?php echo ($_GET['main_page'] == 'index') ? 'class="current"' : ""; ?>><a href="#"><?php echo TEXT_NAVBAR_SYSTEM_INSPECTION; ?></a></li>
  <?php if ($_GET['main_page'] == 'database_upgrade' || (isset($_POST['upgrade_mode']) && $_POST['upgrade_mode'] == 'yes')) { ?>
    <li <?php echo ($_GET['main_page'] == 'database_upgrade') ? 'class="current"' : ""; ?>><a href="#"><?php echo TEXT_NAVBAR_DATABASE_UPGRADE; ?></a></li>
  <?php } else { ?>
    <li <?php echo ($_GET['main_page'] == 'system_setup') ? 'class="current"' : ""; ?>><a href="#"><?php echo TEXT_NAVBAR_SYSTEM_SETUP; ?></a></li>
    <li <?php echo ($_GET['main_page'] == 'database') ? 'class="current"' : ""; ?>><a href="#"><?php echo TEXT_NAVBAR_DATABASE_SETUP; ?></a></li>
    <li <?php echo ($_GET['main_page'] == 'admin_setup') ? 'class="current"' : ""; ?>><a href="#"><?php echo TEXT_NAVBAR_ADMIN_SETUP; ?></a></li>
  <?php } ?>
    <li <?php echo ($_GET['main_page'] == 'completion') ? 'class="current"' : ""; ?>><a href="#"><?php echo TEXT_NAVBAR_COMPLETION; ?></a></li>
  </ul>
</div>