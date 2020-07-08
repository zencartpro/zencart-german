<?php
/**
 * Zen Cart Germn Specific
 * @package admin
 * @copyright Copyright 2003-2019 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license https://www.zen-cart-pro.at/license/3_0.txt GNU General Public License V3.0
 * @version $Id: header_navigation.php 733 2019-06-15 16:49:16Z webchills $
 */

if (!defined('IS_ADMIN_FLAG')) die('Illegal Access');

$menuTitles = zen_get_menu_titles();
?>
<nav class="navbar navbar-default" role="navigation">
  <!-- Brand and toggle get grouped for better mobile display -->
  <div class="navbar-header">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-adm1-collapse">
      <span class="sr-only">Toggle navigation</span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>
  </div>
  <!-- Collect the nav links, forms, and other content for toggling -->
  <div class="collapse navbar-collapse navbar-adm1-collapse">
    <ul class="nav navbar-nav">
          <?php foreach (zen_get_admin_menu_for_user() as $menuKey => $pages) { ?>
            <li class="dropdown">
              <a href="<?php echo zen_href_link(FILENAME_ALT_NAV) ?>" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><?php echo $menuTitles[$menuKey] ?><b class="caret"></b></a>
              <ul class="dropdown-menu">
                <?php foreach ($pages as $page) { ?>
                  <li><a href="<?php echo zen_href_link($page['file'], $page['params']) ?>"><?php echo $page['name'] ?></a></li>
                <?php } ?>
              </ul>
            </li>
          <?php } ?>
          <li class="upperMenuItems"><a href="<?php echo zen_href_link(FILENAME_DEFAULT, '', 'NONSSL'); ?>" class="headerLink"><?php echo HEADER_TITLE_TOP; ?></a></li>
          <li class="upperMenuItems"><a href="<?php echo zen_catalog_href_link(FILENAME_DEFAULT); ?>" class="headerLink" target="_blank"><?php echo HEADER_TITLE_ONLINE_CATALOG; ?></a></li>
          <li class="upperMenuItems"><a href="https://www.zen-cart-pro.at" class="headerLink" target="_blank" class="headerLink"><?php echo HEADER_TITLE_SUPPORT_SITE; ?></a></li>
          <li class="upperMenuItems"><a href="<?php echo zen_href_link(FILENAME_SERVER_INFO, '', 'NONSSL'); ?>" class="headerLink"><?php echo HEADER_TITLE_VERSION; ?></a></li>
          <li class="upperMenuItems"><a href="<?php echo zen_href_link(FILENAME_ADMIN_ACCOUNT, '', 'NONSSL'); ?>" class="headerLink"><?php echo HEADER_TITLE_ACCOUNT; ?></a></li>
          <li class="upperMenuItems"><a href="<?php echo zen_href_link(FILENAME_LOGOFF, '', 'NONSSL'); ?>" class="headerLink"><?php echo HEADER_TITLE_LOGOFF; ?></a></li>
    </ul>
  </div><!-- /.navbar-collapse -->
</nav>