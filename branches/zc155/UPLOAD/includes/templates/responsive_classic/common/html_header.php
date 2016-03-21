<?php
/**
 * Common Template
 *
 * outputs the html header. i,e, everything that comes before the \</head\> tag <br />
 *
 * @package templateSystem
 * @copyright Copyright 2003-2016 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart-pro.at/license/2_0.txt GNU Public License V2.0
 * @version $Id: html_header.php 7 2016-03-21 20:10:39Z webchills $
 */
$zco_notifier->notify('NOTIFY_HTML_HEAD_START', $current_page_base, $template_dir);

// Prevent clickjacking risks by setting X-Frame-Options:SAMEORIGIN
header('X-Frame-Options:SAMEORIGIN');
/**
 * load the module for generating page meta-tags
 */
require(DIR_WS_MODULES . zen_get_module_directory('meta_tags.php'));
/**
 * output main page HEAD tag and related headers/meta-tags, etc
 */
?>
<?php

if (!class_exists('Mobile_Detect')) {
  include_once(DIR_WS_CLASSES . 'Mobile_Detect.php');
}
  $detect = new Mobile_Detect;
  $isMobile = $detect->isMobile();
  $isTablet = $detect->isTablet();
  if (!isset($layoutType)) $layoutType = ($isMobile ? ($isTablet ? 'tablet' : 'mobile') : 'default');

  $paginateAsUL = true;

?>
<!DOCTYPE html>
<html <?php echo HTML_PARAMS; ?>>
  <head>
  <meta charset="<?php echo CHARSET; ?>">
  <title><?php echo META_TAG_TITLE; ?></title>
  <meta name="keywords" content="<?php echo META_TAG_KEYWORDS; ?>" />
  <meta name="description" content="<?php echo META_TAG_DESCRIPTION; ?>" />
  <meta name="language" content="<?php echo META_TAG_LANGUAGE; ?>" />
  <meta name="author" content="<?php echo STORE_NAME ?>" />
  <meta name="generator" content="Zen-Cart 1.5.5 - deutsche Version, http://www.zen-cart-pro.at" />
<?php if (defined('ROBOTS_PAGES_TO_SKIP') && in_array($current_page_base,explode(",",constant('ROBOTS_PAGES_TO_SKIP'))) || $current_page_base=='down_for_maintenance' || $robotsNoIndex === true) { ?>
  <meta name="robots" content="noindex, nofollow" />
<?php } ?>

  <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=yes"/>

<?php if (defined('FAVICON')) { ?>
  <link rel="icon" href="<?php echo FAVICON; ?>" type="image/x-icon" />
  <link rel="shortcut icon" href="<?php echo FAVICON; ?>" type="image/x-icon" />
<?php } //endif FAVICON ?>

  <base href="<?php echo (($request_type == 'SSL') ? HTTPS_SERVER . DIR_WS_HTTPS_CATALOG : HTTP_SERVER . DIR_WS_CATALOG ); ?>" />
<?php if (isset($canonicalLink) && $canonicalLink != '') { ?>
  <link rel="canonical" href="<?php echo $canonicalLink; ?>" />
<?php } ?>
<?php
  // BOF hreflang for multilingual sites
  if (!isset($lng) || (isset($lng) && !is_object($lng))) {
    $lng = new language;
  }
  reset($lng->catalog_languages);
  while (list($key, $value) = each($lng->catalog_languages)) {
    if ($value['id'] == $_SESSION['languages_id']) continue;
    echo '<link rel="alternate" href="' . ($this_is_home_page ? zen_href_link(FILENAME_DEFAULT, 'language=' . $key, $request_type) : $canonicalLink . '&amp;language=' . $key) . '" hreflang="' . $key . '" />' . "\n";
  }
  // EOF hreflang for multilingual sites
?>
<?php if (RSS_FEED_ENABLED == 'true'){ ?>
<?php echo rss_feed_link_alternate();?>
<?php } ?>
<script type="text/javascript">window.jQuery || document.write(unescape('%3Cscript type="text/javascript" src="//code.jquery.com/jquery-1.12.0.min.js"%3E%3C/script%3E'));</script>
<script type="text/javascript">window.jQuery || document.write(unescape('%3Cscript type="text/javascript" src="<?php echo $template->get_template_dir('.js',DIR_WS_TEMPLATE, $current_page_base,'jscript'); ?>/jquery.min.js"%3E%3C/script%3E'));</script>

<?php
/**
* load the loader files
*/
$RC_loader_files = array();
if($RI_CJLoader->get('status') && (!isset($Ajax) || !$Ajax->status())){
    $RI_CJLoader->autoloadLoaders();
    $RI_CJLoader->loadCssJsFiles();
    $RC_loader_files = $RI_CJLoader->header();

    foreach($RC_loader_files['meta'] as $file) {
        include($file['src']);
        echo "\n";
    }

    foreach($RC_loader_files['css'] as $file){
        if($file['include']) {
            include($file['src']);
        } else if (!$RI_CJLoader->get('minify_css') || $file['external']) {
            
            echo '<link rel="stylesheet" type="text/css" href="'.$file['src'] .'" />'."\n";
        } else {
            
            echo '<link rel="stylesheet" type="text/css" href="extras/min/?f='.$file['src'].'&amp;'.$RI_CJLoader->get('minify_time').'" />'."\n";
        }
    } 
}
//DEBUG: echo '<!-- I SEE cat: ' . $current_category_id . ' || vs cpath: ' . $cPath . ' || page: ' . $current_page . ' || template: ' . $current_template . ' || main = ' . ($this_is_home_page ? 'YES' : 'NO') . ' -->';
?>
<?php require($template->get_template_dir('super_data_head.php',DIR_WS_TEMPLATE, $current_page_base,'templates'). '/super_data_head.php'); ?>
<?php 
$responsive_mobile = '<link rel="stylesheet" type="text/css" href="' . $template->get_template_dir('.css',DIR_WS_TEMPLATE, $current_page_base,'css') . '/' . 'responsive_mobile.css' . '" /><link rel="stylesheet" type="text/css" href="' . $template->get_template_dir('.css',DIR_WS_TEMPLATE, $current_page_base,'css') . '/' . 'jquery.mmenu.all.css' . '" />';
$responsive_tablet = '<link rel="stylesheet" type="text/css" href="' . $template->get_template_dir('.css',DIR_WS_TEMPLATE, $current_page_base,'css') . '/' . 'responsive_tablet.css' . '" /><link rel="stylesheet" type="text/css" href="' . $template->get_template_dir('.css',DIR_WS_TEMPLATE, $current_page_base,'css') . '/' . 'jquery.mmenu.all.css' . '" />';
$responsive_default = '<link rel="stylesheet" type="text/css" href="' . $template->get_template_dir('.css',DIR_WS_TEMPLATE, $current_page_base,'css') . '/' . 'responsive_default.css' . '" />';

if (in_array($current_page_base,explode(",",'popup_image,popup_image_additional')) ) {
  echo '';
} else {
  echo '<link rel="stylesheet" type="text/css" href="' . $template->get_template_dir('.css',DIR_WS_TEMPLATE, $current_page_base,'css') . '/' . 'responsive.css' . '" />';
  if ( $detect->isMobile() && !$detect->isTablet() || $_SESSION['layoutType'] == 'mobile' ) {
    echo $responsive_mobile;
  } else if ( $detect->isTablet() || $_SESSION['layoutType'] == 'tablet' ){
    echo $responsive_tablet;
  } else if ( $_SESSION['layoutType'] == 'full' ) {
    echo '';
  } else {
    echo $responsive_default;
  }
}
?>
  <script type="text/javascript">document.documentElement.className = 'no-fouc';</script>
  <link rel="stylesheet" type="text/css" href="//maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" />
<?php
  $zco_notifier->notify('NOTIFY_HTML_HEAD_END', $current_page_base);
?>
</head>
<?php // NOTE: Blank line following is intended: ?>
