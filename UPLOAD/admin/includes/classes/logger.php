<?php
/**
 * @package admin
 * @copyright Copyright 2003-2019 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license https://www.zen-cart-pro.at/license/3_0.txt GNU General Public License V3.0
 * @version $Id: logger.php 731 2015-12-21 19:49:16Z webchills $
 */

class logger {
  var $timer_start, $timer_stop, $timer_total;

// class constructor
  function __construct() {
    $this->timer_start();
  }

  function timer_start() {
    if (defined("PAGE_PARSE_START_TIME")) {
      $this->timer_start = PAGE_PARSE_START_TIME;
    } else {
      $this->timer_start = microtime();
    }
  }

  function timer_stop($display = 'false') {
    $this->timer_stop = microtime();

    $time_start = explode(' ', $this->timer_start);
    $time_end = explode(' ', $this->timer_stop);

    $this->timer_total = number_format(($time_end[1] + $time_end[0] - ($time_start[1] + $time_start[0])), 3);

    $this->write($_SERVER['REQUEST_URI'], $this->timer_total . 's');

    if ($display == 'true') {
      return $this->timer_display();
    }
  }

  function timer_display() {
    return '<span class="smallText">Parse Time: ' . $this->timer_total . 's</span>';
  }

  function write($message, $type) {
    error_log(strftime(STORE_PARSE_DATE_TIME_FORMAT) . ' [' . $type . '] ' . $message . "\n", 3, STORE_PAGE_PARSE_TIME_LOG);
  }
}
