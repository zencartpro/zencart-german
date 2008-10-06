<?php
/***************************************************************
*  Copyright notice
*
*  (c) 2006 rainer langheiter <rainer@langheiter.com>
*  All rights reserved
*
*  This script is part of the ZenCart project. The ZenCart project is
*  free software; you can redistribute it and/or modify
*  it under the terms of the GNU General Public License as published by
*  the Free Software Foundation; either version 2 of the License, or
*  (at your option) any later version.
*
*  The GNU General Public License can be found at
*  http://www.gnu.org/copyleft/gpl.html.
*
*  This script is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*
*  This copyright notice MUST APPEAR in all copies of the script!
* $Id$       
***************************************************************/

require_once 'includes/application_top.php'; 
$filename = 'soap/tmpl.ZenCart.wsdl';
$tmp = file_get_contents($filename);
$wsdl = str_replace('http://redt.ar-pub.com/zc136/', HTTP_SERVER . DIR_WS_CATALOG, $tmp);

$filename = 'soap/ZenCart.wsdl';
if (is_writable($filename)) {
   if (!$handle = fopen($filename, "w")) {
         print "Kann die Datei $filename nicht �ffnen";
         exit;
   }
   if (!fwrite($handle, $wsdl)) {
       print "Kann in die Datei $filename nicht schreiben";
       exit;
   }
   print "<strong>OK! changed $filename !</strong>";
   fclose($handle);
} else {
   print "Die Datei $filename ist nicht schreibbar";
}
print '<hr>';

?>