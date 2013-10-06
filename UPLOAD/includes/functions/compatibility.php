<?php
/**
 * compatibility functions
 *
 * @package functions
 * @copyright Copyright 2003-2012 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart-pro.at/license/2_0.txt GNU Public License V2.0
 * @version $Id: compatibility.php 729 2011-08-09 15:49:16Z hugo13 $
 */


/////////////////////////////////////////
// remove in v1.3 ?
/*
// disabled
  if (!function_exists('fmod')) {
    function fmod($zf_x, $zf_y) {
      $zp_i = floor($zf_x/$zf_y);
      return $zf_x - $zp_i/$zf_y;
    }
  }
*/
// mange for values < 1
  if (!function_exists('fmod')) {
    function fmod($x2, $y2) {
      $i2 = fmod($x2*1000,$y2*1000);
      return $i2;
    }
  }
/////////////////////////////////////////


// The following is not tested extensively, but should work in theory:
/*  if (!function_exists('file_get_contents')) {
    function file_get_contents($zf_file) {
      $za_file=file($zf_file);
      foreach ($za_file as $line) {
        $zp_return .= $line;
      }
      return $zp_return;
    }
  }
*/

?>