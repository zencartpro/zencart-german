<?php
/**
 * @package admin
 * @copyright Copyright 2003-2021 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license https://www.zen-cart-pro.at/license/3_0.txt GNU General Public License V3.0
 * @version $Id: tinymce.php 765 2021-06-19 13:04:09Z webchills $
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
<script>window.jQuery || document.write('<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4" crossorigin="anonymous"><\/script>');</script>
<script>window.jQuery || document.write('<script src="includes/javascript/jquery-3.6.0.min.js"><\/script>');</script>

<script type="text/javascript" src="../<?php echo DIR_WS_EDITORS ?>tiny_mce/jquery.tinymce.min.js"></script>
<script type="text/javascript" src="../<?php echo DIR_WS_EDITORS ?>tiny_mce/tinymce.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
  <?php echo $jsLanguageLookupArray ?>
  $('textarea').each(function() {
    if ($(this).attr('name') != 'message' && $(this).attr('class') != 'noEditor')
    {
      index = $(this).attr('name').match(/\d+/);
      if (index == null) index = <?php echo $_SESSION['languages_id'] ?>;
      tinymce.init(
        {
          language : lang[index],
          selector: '.editorHook',
          
    entity_encoding : 'raw',
          browser_spellcheck: true,
    plugins : 'advlist,autolink,lists,link,image,charmap,print,preview,hr,anchor,pagebreak,searchreplace,wordcount,visualblocks,visualchars,code,fullscreen,insertdatetime,media,nonbreaking,save,table,contextmenu,directionality,emoticons,template,paste,textcolor',
   

    toolbar1: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image",
    toolbar2: "print preview media | forecolor backcolor emoticons",
    image_advtab: true
        });
    }
  });
});
</script>
