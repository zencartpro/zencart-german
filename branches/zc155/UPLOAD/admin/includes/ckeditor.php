<?php
/**
 * @package admin
 * @copyright Copyright 2010 Kuroi Web Design
 * @copyright Portions Copyright 2003-2016 Zen Cart Development Team
 * @license http://www.zen-cart-pro.at/license/2_0.txt GNU Public License V2.0
 * @version $Id: ckeditor.php 282 2016-03-27 19:09:32Z webchills $
 */
if (!defined('IS_ADMIN_FLAG')) {
  die('Illegal Access');
}

$var = zen_get_languages();
$jsLanguageLookupArray = "var lang = new Array;\n";
foreach ($var as $key)
{
  $jsLanguageLookupArray .= "  lang[" . $key['id'] . "] = '" . $key['code'] . "';\n";
}
?>
<script type="text/javascript" src="../<?php echo DIR_WS_EDITORS ?>ckeditor/jquery-1.12.1.min.js"></script>
<script type="text/javascript" src="../<?php echo DIR_WS_EDITORS ?>ckeditor/ckeditor.js"></script>
<script type="text/javascript"><!--
$(document).ready(function() {
  <?php echo $jsLanguageLookupArray ?>
  $('textarea').each(function()	{
    if ($(this).attr('class') == 'editorHook' || ($(this).attr('name') != 'message' && $(this).attr('class') != 'noEditor'))
    {
      index = $(this).attr('name').match(/\d+/);
      if (index == null) index = <?php echo $_SESSION['languages_id'] ?>;
      CKEDITOR.replace($(this).attr('name'),
        {
          coreStyles_underline : { element : 'u' },
          width : 760,
          language: lang[index]
        });
    }
  });
});
//--></script>