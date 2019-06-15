<?php
/**
 * Load extra user defined language files
 * see  {@link  http://www.zen-cart.com/wiki/index.php/Developers_API_Tutorials#InitSystem wikitutorials} for more details.
 *
 * @package initSystem
 * @copyright Copyright 2003-2019 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart-pro.at/license/2_0.txt GNU Public License V2.0
 * @version $Id: extra_definitions.php 731 2019-06-15 17:29:16Z webchills $
 */
// must be called appropriately
if (!defined('IS_ADMIN_FLAG')) {
  die('Illegal Access');
}
// Set current template
$template_id = $template_dir;

// set directories to check for language files
$languages_extra_definitions_directory = DIR_FS_CATALOG . DIR_WS_LANGUAGES . $_SESSION['language'] . '/extra_definitions/';
$languages_extra_definitions_directory_template = DIR_FS_CATALOG . DIR_WS_LANGUAGES . $_SESSION['language'] . '/extra_definitions/' . $template_id . '/';

$ws_languages_extra_definitions_directory = DIR_WS_LANGUAGES . $_SESSION['language'] . '/extra_definitions/';
$ws_languages_extra_definitions_directory_template = DIR_WS_LANGUAGES . $_SESSION['language'] . '/extra_definitions/' . $template_id . '/';

// Check for new definitions in template directory

$directory_array = array();
if ($dir = @dir($languages_extra_definitions_directory_template)) {
  while ($file = $dir->read()) {
    if (!is_dir($languages_extra_definitions_directory_template . $file)) {
      if (preg_match('~^[^\._].*\.php$~i', $file) > 0) {
        $directory_array[] = $file;
      }
    }
  }
  if (sizeof($directory_array)) {
    sort($directory_array);
  }
  $dir->close();
}

// Check for new definitions in extra_definitions directory
$dir_check = $directory_array;

if ($dir = @dir($languages_extra_definitions_directory)) {
  while ($file = $dir->read()) {
    if (!is_dir($languages_extra_definitions_directory . $file)) {
      if (preg_match('~^[^\._].*\.php$~i', $file) > 0) {
        if (in_array($file, $dir_check, TRUE)) {
          // skip name exists
        } else {
          $directory_array[] = $file;
        }
      }
    }
  }
  if (sizeof($directory_array)) {
    sort($directory_array);
  }
  $dir->close();
}

$file_cnt=0;
for ($i = 0, $n = sizeof($directory_array); $i < $n; $i++) {
  $file_cnt++;
  $file = $directory_array[$i];

  if (file_exists($ws_languages_extra_definitions_directory_template . $file)) {
    include($ws_languages_extra_definitions_directory_template . $file);
  } else {
    include($ws_languages_extra_definitions_directory . $file);
  }
}
