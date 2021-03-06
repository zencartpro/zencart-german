<?php
/**
 * autoloader activation point for canonical url handling script
 *
 * @package initSystem
 * @copyright Copyright 2003-2019 Zen Cart Development Team
 * @license https://www.zen-cart-pro.at/license/3_0.txt GNU General Public License V3.0
 * @version $Id: config.canonical.php 729 2011-08-09 15:49:16Z hugo13 $
 */
if (!defined('IS_ADMIN_FLAG')) {
 die('Illegal Access');
}
/**
 * point 161 was selected specifically based on dependancies
 */
  $autoLoadConfig[161][] = array('autoType'=>'init_script',
                                 'loadFile'=> 'init_canonical.php');
