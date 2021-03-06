<?php
/**
* !!!! Nach erfolgreicher Aktualisierung, löschen Sie diese Datei sofort wieder vom Server !!!!!
* @copyright Copyright 2003-2021 Zen Cart Development Team
* @copyright Portions Copyright 2003 osCommerce
* @license https://www.zen-cart-pro.at/license/3_0.txt GNU General Public License V3.0
* @version $Id: init_156f_update.php 2021-06-19 22:00:51Z webchills $
*/

if (!defined('IS_ADMIN_FLAG')) {
die('Illegal Access');
}
// -----
// Script erst starten, nachdem ein Admin eingeloggt ist, damit jemand die Updatemeldungen mitbekommt.
//
if (isset($_SESSION['admin_id'])) {


// -----
// Image Handler auf 5.1.11 aktualisieren
// 
//
$db->Execute("DELETE FROM ".TABLE_CONFIGURATION." WHERE configuration_key = 'IH_VERSION';");
$db->Execute("INSERT INTO ".TABLE_CONFIGURATION." (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ('Image Handler Version', 'IH_VERSION', '5.1.11', 'This is used by image handler to check if the database is up to date with uploaded image handler files.', 0, 100, NULL, now(), NULL, 'zen_cfg_textarea_small(');");

$db->Execute("UPDATE " . TABLE_CONFIGURATION . "
                     SET configuration_description = '<br>Choose the method that <em>Image Handler</em> uses to name the resized images in the <code>cache/images</code> directory.<br><br><em>Hashed</em>: Uses an &quot;MD5&quot; hash to produce the filenames.  It can be &quot;difficult&quot; to visually identify the original file using this method.<br><br><em>Readable</em>: This is a good choice for new installations of <em>IH</em> or for upgraded installations that do not have hard-coded image links.<br><br><em>Mirrored</em>: Similar to <em>Readable</em>, but the directory structure under <code>cache/images</code> mirrors the original images sub-directory structure.',
                         set_function = 'zen_cfg_select_option(array(\'Hashed\', \'Mirrored\', \'Readable\'),'
                     WHERE configuration_key = 'IH_CACHE_NAMING' LIMIT 1"
            );

$db->Execute("REPLACE INTO ".TABLE_CONFIGURATION_LANGUAGE." (configuration_title, configuration_key, configuration_language_id, configuration_description, last_modified, date_added) VALUES ('IH - Benennung der Bilder im cache/images Ordner', 'IH_CACHE_NAMING', 43, 'Wählen Sie die Methode, die <em>Image Handler</em> verwendet, um die verkleinerten Bilder im Verzeichnis <code>cache/images</code> zu benennen.<br><br><em>Hashed</em>: Verwendet einen &quot;MD5&quot; Hash, um die Dateinamen zu erzeugen.  Es kann &quot;schwierig&quot; sein, die Originaldatei mit dieser Methode visuell zu identifizieren.<br><br><em>Readable (Lesbar)</em>: Dies ist eine gute Wahl für neue Installationen oder für aktualisierte Installationen, die keine hardcodierten Bildverknüpfungen zu alten Hashed Dateinamen haben. <br><br><em>Mirrored (Gespiegelt)</em>: Ähnlich wie <em>Readable</em>, aber die Verzeichnisstruktur unter <code>cache/images</code> spiegelt die Struktur der Unterverzeichnisse der Originalbilder wider.', now(), now());");

$messageStack->add('Image Handler erfolgreich auf Version 5.1.11 aktualisiert', 'success');

$messageStack->add('1.5.6f Datenbankänderungen erfolgreich vorgenommen', 'success');

// -----
// Version History aktualisieren
// 
//  
$db->Execute ("INSERT INTO ".TABLE_PROJECT_VERSION_HISTORY." (project_version_key, project_version_major, project_version_minor, project_version_patch, project_version_date_applied, project_version_comment)
SELECT project_version_key, project_version_major, project_version_minor, project_version_patch1 as project_version_patch, project_version_date_applied, project_version_comment
FROM ".TABLE_PROJECT_VERSION.";");
$db->Execute ("UPDATE ".TABLE_PROJECT_VERSION." SET project_version_major='1', project_version_minor='5.6f', project_version_patch1='', project_version_patch1_source='', project_version_patch2='', project_version_patch2_source='', project_version_comment='Version Update 1.5.6e->1.5.6f', project_version_date_applied=now() WHERE project_version_key = 'Zen-Cart Main';");
$db->Execute ("UPDATE ".TABLE_PROJECT_VERSION." SET project_version_major='1', project_version_minor='5.6', project_version_patch1='', project_version_patch1_source='', project_version_patch2='', project_version_patch2_source='', project_version_comment='Version Update 1.5.6e->1.5.6f', project_version_date_applied=now() WHERE project_version_key = 'Zen-Cart Database';");
// -----
// abschließende Erfolgsmeldung ausgeben
//
$messageStack->add('Aktualisierung auf 1.5.6f deutsch erfolgreich abgeschlossen.<br/><b>WICHTIG:<br/>Bevor Sie nun irgendwohin clicken, löschen Sie erst folgende Dateien vom Server:<br/>DEINADMIN/includes/auto_loaders/config.156f_update.php<br/>DEINADMIN/includes/init_includes/init_156f_update.php', 'success'); 
}