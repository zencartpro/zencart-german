#
# * This SQL script upgrades the core Zen Cart database structure from v1.5.3 to v1.5.4
# *
# * @package Installer
# * @access private
# * @copyright Copyright 2003-2016 Zen Cart Development Team
# * @copyright Portions Copyright 2003 osCommerce
# * @license http://www.zen-cart-pro.at/license/2_0.txt GNU Public License V2.0
# * @version $Id: mysql_upgrade_zencart_154.sql 4 2016-03-28 09:42:59Z webchills $
#

############ IMPORTANT INSTRUCTIONS ###############
#
# * Zen Cart uses the zc_install/index.php program to do database upgrades
# * This SQL script is intended to be used by running zc_install
# * It is *not* recommended to simply run these statements manually via any other means
# * ie: not via phpMyAdmin or via the Install SQL Patch tool in Zen Cart admin
# * The zc_install program catches possible problems and also handles table-prefixes automatically
# *
# * To use the zc_install program to do your database upgrade:
# * a. Upload the NEWEST zc_install folder to your server
# * b. Surf to zc_install/index.php via your browser
# * c. On the System Inspection page, scroll to the bottom and click on Database Upgrade
# *    NOTE: do NOT click on the "Install" button, because that will erase your database.
# * d. On the Database Upgrade screen, you will be presented with a list of checkboxes for
# *    various Zen Cart versions, with the recommended upgrades already pre-selected.
# * e. Verify the checkboxes, then scroll down and enter your Zen Cart Admin username
# *    and password, and then click on the Upgrade button.
# * f. If any errors occur, you will be notified.  Some warnings can be ignored.
# * g. When done, you will be taken to the Finished page.
#
#####################################################

# Set store to Down-For-Maintenance mode.  Must reset manually via admin after upgrade is done.
#UPDATE configuration set configuration_value = 'true' where configuration_key = 'DOWN_FOR_MAINTENANCE';

# Clear out active customer sessions
TRUNCATE TABLE whos_online;
TRUNCATE TABLE db_cache;

#### Ajax Checkout - New in 1.5.4
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES 
('PA-DSS Ajax Checkout?', 'PADSS_AJAX_CHECKOUT', '1', 'PA-DSS Compliance requires that for some inbuilt payment methods, that we use ajax to draw the checkout confirmation screen. While this will only happen if one of those payment methods is actually present, some people may want the traditional checkout flow <strong>Disabling this makes your site NON-COMPLIANT with PA-DSS rules, thus invalidating any certification.</strong>', 1, 30, now(), now(), NULL, 'zen_cfg_select_drop_down(array(array(\'id\'=>\'0\', \'text\'=>\'Non-Compliant\'), array(\'id\'=>\'1\', \'text\'=>\'On\')),');
INSERT INTO configuration_language (configuration_title, configuration_key, configuration_language_id, configuration_description, last_modified, date_added) VALUES
('PA-DSS Ajax Checkout?', 'PADSS_AJAX_CHECKOUT', '43', 'PA-DSS Compliance erfordert, dass für gewisse Zahlungsarten für die Bestellbestätigungsseite Ajax verwendet wird. Dies wird zwar nur bei manchen unterstützten Zahlungsarten der Fall sein, dennoch wollen Sie vielleicht generell den normalen Bestellablauf ohne Ajax verwenden.<br/>Hinweis: Wenn Sie dieses Setting auf false stellen, dann erfüllt der Shop die PA-DSS Richtlinien nicht mehr.', now(), now());
#### Welcome Mail optional - New in 1.5.4
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES
('Send Welcome Email', 'SEND_WELCOME_EMAIL', 'true', 'Send Welcome Email to the customer after registration?', 12, 90, now(), now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO configuration_language (configuration_title, configuration_key, configuration_language_id, configuration_description, last_modified, date_added) VALUES
('Willkommensemail senden?', 'SEND_WELCOME_EMAIL', '43', 'Wollen Sie Neukunden nach der Registrierung ein Willkommensemail senden?', now(), now());
#### Checkbox Digital Downloads - New in 1.5.4
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES 
('Display Revocation Checkbox on Checkout Confirmation Page?', 'DISPLAY_WIDERRUF_DOWNLOADS_ON_CHECKOUT_CONFIRMATION', 'false', 'Do you want to display a checkbox for the revocation clause for digital downloads on the checkout confirmation page?<br/>Only activate if you are selling digital downloads!', 11, 3, NOW(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
REPLACE INTO configuration_language (configuration_title, configuration_key, configuration_description, configuration_language_id) VALUES
('Checkbox für Widerrufsrecht bei digitalen Downloads', 'DISPLAY_WIDERRUF_DOWNLOADS_ON_CHECKOUT_CONFIRMATION', 'Wollen Sie auf der Bestellbestätigungsseite eine zusätzliche Checkbox für das Widerrufsrecht bei digitalen Downloads anzeigen? Der Kunde muss dann explizit zustimmen, dass sein Widerrufsrecht erlischt.<br/>Nur aktivieren, falls Sie digitale Downloads verkaufen!', 43);

#############

#### VERSION UPDATE STATEMENTS
## THE FOLLOWING 2 SECTIONS SHOULD BE THE "LAST" ITEMS IN THE FILE, so that if the upgrade fails prematurely, the version info is not updated.
##The following updates the version HISTORY to store the prior version info (Essentially "moves" the prior version info from the "project_version" to "project_version_history" table
#NEXT_X_ROWS_AS_ONE_COMMAND:3
INSERT INTO project_version_history (project_version_key, project_version_major, project_version_minor, project_version_patch, project_version_date_applied, project_version_comment)
SELECT project_version_key, project_version_major, project_version_minor, project_version_patch1 as project_version_patch, project_version_date_applied, project_version_comment
FROM project_version;

## Now set to new version
UPDATE project_version SET project_version_major='1', project_version_minor='5.4', project_version_patch1='', project_version_patch1_source='', project_version_patch2='', project_version_patch2_source='', project_version_comment='Version Update 1.5.3->1.5.4', project_version_date_applied=now() WHERE project_version_key = 'Zen-Cart Main';
UPDATE project_version SET project_version_major='1', project_version_minor='5.4', project_version_patch1='', project_version_patch1_source='', project_version_patch2='', project_version_patch2_source='', project_version_comment='Version Update 1.5.3->1.5.4', project_version_date_applied=now() WHERE project_version_key = 'Zen-Cart Database';

#####  END OF UPGRADE SCRIPT

