<?php
/**
 * Zen Cart German Specific
 * Common Template main_template_vars handler
 *
 * Normally a page will automatically load its own template based on the page name.<br />
 * so that a page called some_page will load tpl_some_page_default.php from the template directory.<br />
 * <br />
 * However sometimes a page may need to choose the template it displays based on a set of criteria.<br />
 * Placing a file in the includes/modules/pages/some_page/ directory called main_template_vars.php<br />
 * allows you to override this page and choose the template that loads.<br />
 *
 * @package templateSystem
 * @copyright Copyright 2003-2019 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license https://www.zen-cart-pro.at/license/3_0.txt GNU General Public License V3.0
 * @version $Id: main_template_vars.php 731 2019-06-21 18:02:16Z webchills $
 */

  $zco_notifier->notify('NOTIFY_MAIN_TEMPLATE_VARS_START', $template_dir);


/**
 * load page-specific main_template_vars if present, or jump directly to template file
 */
  if (file_exists(DIR_WS_MODULES . 'pages/' . $current_page_base . '/main_template_vars.php')) {
    $body_code = DIR_WS_MODULES . 'pages/' . $current_page_base . '/main_template_vars.php';
  } else {
    $body_code = $template->get_template_dir('tpl_' . preg_replace('/.php/', '',$_GET['main_page']) . '_default.php',DIR_WS_TEMPLATE, $current_page_base,'templates'). '/tpl_' . $_GET['main_page'] . '_default.php';
  }

  $zco_notifier->notify('NOTIFY_MAIN_TEMPLATE_VARS_END', $template_dir, $body_code);
