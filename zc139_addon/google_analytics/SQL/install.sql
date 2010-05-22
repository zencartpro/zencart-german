#######################################################################
# Google Analytics 1.3.1 Multilanguage Install - 2010-05-22 - webchills
#######################################################################

SET @gid=0;
SELECT @gid:=configuration_group_id
FROM configuration_group
WHERE configuration_group_title LIKE '%Google Analytics Configuration%'
LIMIT 1;
DELETE FROM configuration WHERE configuration_group_id = @gid;
DELETE FROM configuration_group WHERE configuration_group_id = @gid;
SET @gid=0;
SELECT @gid:=configuration_group_id
FROM configuration_group
WHERE configuration_group_title LIKE '%Google Analytics Einstellungen%'
LIMIT 1;
DELETE FROM configuration WHERE configuration_group_id = @gid;
DELETE FROM configuration_group WHERE configuration_group_id = @gid;
DELETE FROM configuration_group WHERE configuration_group_title LIKE '%Google Analytics Configuration%';
DELETE FROM configuration_group WHERE configuration_group_title LIKE '%Google Analytics Einstellungen%';
DELETE FROM configuration WHERE configuration_description LIKE 'Google Analytics%' LIMIT 12;
DELETE FROM configuration WHERE configuration_title LIKE 'GA - %' LIMIT 12;
INSERT INTO configuration_group (configuration_group_id, configuration_group_title, configuration_group_description, sort_order, visible) VALUES
(NULL, 'Google Analytics Configuration', 'Google Analytics Configuration Settings', '1', '1');
SET @gid=last_insert_id();

UPDATE configuration_group SET sort_order = @gid WHERE configuration_group_id = @gid;

INSERT INTO configuration VALUES 
(NULL, 'GA - Use Older "urchin.js" Tracking Code', 'GOOGLE_ANALYTICS_URCHINTRACKING_ACTIVE', 'No', 'Google Analytics:<br/><br/><b>Note:<br/>It is NOT recommended to use the old tracking code!</b><br/><br/>This enables you to select which type of tracking code to use (either the older "urchin.js" version or the newer "ga.js" version. By default the system now uses the newer "ga.js" code.<br><br><span style="color:#ff0000;font-weight:bold;">Important Note:</span> There were hundreds of reports across the Internet of ecommerce tracking not being exactly correct when using the new "ga.js" tracking code Google released.<br><br>It <strong>has been confirmed</strong> by Google that the problem is on their end. They were working on the issue and a fix has been out for the new "ga.js" code near the first week in April 2008.<br><br>So there is no need to use the older "urchin.js" tracking code anymore. Anyway: To revert back to the older urchin.js code, set this opotion to "Yes" temporarily (meaning you will actually be using the older "urchin.js" tracking code).<br><br>For more hints and tips on how to use Google Analytics to increase sales from your store, visit <b><a href="http://www.zencartoptimization.com" target="blank">ZenCartOptimization.com</a></b><br><br><b>Do you want to use the older "urchin.js" tracking code?</b><br>', @gid, 1, NOW(), NOW(), NULL, 'zen_cfg_select_option(array(''Yes'', ''No''), '),
(NULL, 'GA - Analytics Account', 'GOOGLE_ANALYTICS_UACCT', 'UA-XXXXXX-X', 'Google Analytics:<br/><br/>This number is the unique id you were given by Google when you registered for your Google Analytics account.<br><br>For more hints and tips on how to use Google Analytics to increase sales from your store, visit <b><a href="http://www.zencartoptimization.com" target="blank">ZenCartOptimization.com</a></b><br><br><b>Enter your Google Analytics account number (starting with the "UA-") in the space provided below.</b><br>', @gid, 2, NOW(), NOW(), NULL, NULL),
(NULL, 'GA - Target Address', 'GOOGLE_ANALYTICS_TARGET', 'customers', 'Google Analytics:<br/><br/>This element is used in conjunction with Google E-Commerce Tracking. It indicates how you want your "transactions" to be identified in your Analytics reports.<br><br>Addresses consist of City,State, and Country.<br><br>This information can help you determine locality of orders placed, shipped to, or billed to.<br><br>For more hints and tips on how to use Google Analytics to increase sales from your store, visit <b><a href="http://www.zencartoptimization.com" target="blank">ZenCartOptimization.com</a></b><br><br><b>Which address type do you want to use for recording transaction information?</b><br>', @gid, 3, NOW(), NOW(), NULL, 'zen_cfg_select_option(array(''customers'', ''delivery'', ''billing''),'),
(NULL, 'GA - Affiliation', 'GOOGLE_ANALYTICS_AFFILIATION', '', 'Google Analytics:<br/><br/>This <b>optional</b> tracking element is used in conjunction with Google E-Commerce Tracking.<br><br>The Affiliation tag describes the affiliating store or processing site.<br><br>It can be used if you have multiple stores (or web sites) in various locations and is used to track from which location a particular sale originated.<br><br>For more hints and tips on how to use Google Analytics to increase sales from your store, visit <b><a href="http://www.zencartoptimization.com" target="blank">ZenCartOptimization.com</a></b><br><br><b>If you have one, enter your optional partner or store affiliation in the space provided below.</b><br>', @gid, 4, NOW(), NOW(), NULL, NULL),
(NULL, 'GA - Use sku/code', 'GOOGLE_ANALYTICS_SKUCODE', 'products_id', 'Google Analytics:<br/><br/>This tracking element is used in conjunction with Google Analytics E-Commerce tracking.<br><br>It enables you to track which products perform better than others using either the Product ID, or the Product Model Number as a unique identifier.<br><br>For more hints and tips on how to use Google Analytics to increase sales from your store, visit <b><a href="http://www.zencartoptimization.com" target="blank">ZenCartOptimization.com</a></b><br><br><b>Indicate which identifier you want to use to track product performance by selecting one of the options below.</b>', @gid, 5, now(), now(), NULL, 'zen_cfg_select_option(array(''products_id'', ''products_model''),'),
(NULL, 'GA - Activate Conversion Tracking', 'GOOGLE_ANALYTICS_CONVERSION_ACTIVE', 'No', 'Google Analytics:<br/><br/>This element enables you turn on or off Google Conversion Tracking.<br><br><span style="color:#ff0000;font-weight:bold;">Please Note:</span> Conversion tracking is used to track the effectiveness of Google AdWords paid search campaigns. If you are <b>not</b> running any paid search campaigns, then you should leave this set to "No".<br><br>If you are running Google AdWords (paid search) campaigns, then turning this on will place the proper conversion tracking code on your checkout success page and enable you to start tracking conversions.<br><br>Turning this on <b>requires you</b> to enter your unique Google Conversion Tracking ID in place of the "XXXXXXXXXXX" number shown in the next section.<br><br>For more hints and tips on how to use Google Analytics to increase sales from your store, visit <b><a href="http://www.zencartoptimization.com" target="blank">ZenCartOptimization.com</a></b><br><br><b>Do you want to turn on Google AdWords Conversion Tracking?</b><br>', @gid, 6, NOW(), NOW(), NULL, 'zen_cfg_select_option(array(''Yes'', ''No''), '),
(NULL, 'GA - Google AdWords Conversion Tracking Number', 'GOOGLE_ANALYTICS_CONVERSION_IDNUM', 'XXXXXXXXXX', 'Google Analytics:<br/><br/>If you activated Conversion Tracking in the previous section, then you <b>must</b> enter your unique Google Conversion Tracking ID in place of the "XXXXXXXXXXX" shown in the space provided below.<br><br>If you have activated Conversion Tracking, and do not enter your number below, tracking will not work.<br><br>For more hints and tips on how to use Google Analytics to increase sales from your store, visit <b><a href="http://www.zencartoptimization.com" target="blank">ZenCartOptimization.com</a></b><br><br><b>Enter your AdWords Conversion Tracking ID Number below.</b>', @gid, 7, NOW(), NOW(), NULL, NULL),
(NULL, 'GA - Google AdWords Language', 'GOOGLE_ANALYTICS_CONVERSION_LANG', 'de', 'Google Analytics:<br/><br/>Select the language to be used. The default is "German".<br><br>For more hints and tips on how to use Google Analytics to increase sales from your store, visit <b><a href="http://www.zencartoptimization.com" target="blank">ZenCartOptimization.com</a></b><br><br><b>Select your language below</b><br>', @gid, 8, NOW(), NOW(), NULL, 'zen_cfg_pull_down_google_analytics_languages(');

##############################
# Add values for German admin
##############################

INSERT INTO configuration_group (configuration_group_id, language_id, configuration_group_title, configuration_group_description, sort_order, visible ) VALUES 
(@gid, 43, 'Google Analytics Einstellungen', 'Konfiguration von Google Analytics', '1', '1');

REPLACE INTO configuration_language (configuration_title, configuration_key, configuration_description, configuration_language_id) VALUES
('GA - Alten urchin.js Tracking Code verwenden?', 'GOOGLE_ANALYTICS_URCHINTRACKING_ACTIVE', 'Google Analytics:<br/><br/><b>Nicht empfohlen!</b><br/>Voreingestellt ist die neue Variante des Google Analytics Codes (ga.js). Wenn möglich unbedingt diese neuere Variante verwenden.<br/><br/><b>Soll der alte Code verwendet werden?:</b>', 43),
('GA - Analytics Account', 'GOOGLE_ANALYTICS_UACCT', 'Google Analytics:<br/><br/>Die ID, die Sie von Google bei der Anmeldung zu Google Analytics bekommen haben.<br/>Format:<br/>UA-XXXXXX-X<br/><br/><b>Tragen Sie hier Ihre Analytics Account Nummer ein:</b>', 43),
('GA - E-Commerce Tracking Zieladresse', 'GOOGLE_ANALYTICS_TARGET','Google Analytics:<br/><br/>Diese Einstellung bezieht sich auf das Google E-Commerce Tracking und legt fest, ob sie die Auswertung auf Basis von Kundenadresse (customers), Rechnungsadresse (billing) oder Lieferadresse (delivery) haben wollen.<br/><br/><b>Welchen Adresstyp wollen Sie für die Aufzeichnung der Transaktionen verwenden?</b>', 43),
('GA - Affiliate', 'GOOGLE_ANALYTICS_AFFILIATION', 'Google Analytics:<br/><br/>Falls ein Affiliate vorhanden ist (z.B. ein zweiter Shop) hier eintragen. Bei dieser Einstellung geht es darum auszuwerten, von welchem Partnershop/Partnerseite der Kunde ursprünglich kam.<br/><br/><b>Tragen Sie hier den Affiliate ein:</b>', 43),
('GA - SKU Code', 'GOOGLE_ANALYTICS_SKUCODE', 'Google Analytics:<br/><br/>Diese Einstellung bezieht sich auf das Google E-Commerce Tracking und legt fest, ob die Artikel ID oder die Artikelnummer in den Statistiken angezeigt werden soll.<br/><br/><b>Wählen Sie hier aus, was angezeigt werden soll: product_id = interne Zen-Cart Artikel ID<br/>products_model = eingegebene Artikelnummer</b>', 43),
('GA - Conversion Tracking aktivieren?', 'GOOGLE_ANALYTICS_CONVERSION_ACTIVE', 'Google Analytics:<br/><br/><b>WICHTIG:<br/>Diese Einstellung nur aktivieren, wenn auch das kostenpflichtige Google Adwords genutzt wird!</b><br/><br/>Durch Aktivieren wird der Google Conversion Tracking Code in die Checkout Success Seite eingefügt. Dadurch kann die Effektivität der Adwords Kampagne ausgewertet werden. Wenn Sie hier das Conversion Tracking aktivieren, müssen Sie in der nächsten Option Ihre Conversion Tracking Nummer einstellen.<br/><br/><b>Wollen Sie Google AdWords Conversion Tracking aktivieren?</b>', 43),
('GA - Adwords Conversion Tracking Nummer', 'GOOGLE_ANALYTICS_CONVERSION_IDNUM', 'Google Analytics:<br/><br/>Wenn Sie oben Conversion Tracking aktiviert haben, geben Sie hier Ihre Conversion Tracking ID anstelle der XXXXXXXXXXX ein. Sollten Sie hier keine Nummer eingeben, wird das Conversion Tracking nicht funktionieren.<br/><br/><b>Geben Sie hier Ihre AdWords Conversion Tracking ID ein:</b>', 43),
('GA - Google Adwords Sprache', 'GOOGLE_ANALYTICS_CONVERSION_LANG', 'Google Analytics:<br/><br/>Spracheinstellung für Google Adwords. Voreingestellt ist: Deutsch<br/><br/><b>Wählen Sie die gewünschte Sprache aus:</b>', 43);


#################################################################
# Add Table for Language support with Google Conversion Tracking
#################################################################


DROP TABLE IF EXISTS google_analytics_languages;
CREATE TABLE google_analytics_languages (
  languages_id int(11) NOT NULL auto_increment,
  name varchar(50) NOT NULL default '',
  code char(10) NOT NULL default '',
  sort_order int(3) default NULL,
  PRIMARY KEY  (languages_id),
  KEY idx_languages_name_zen (name)
) TYPE=MyISAM;


INSERT INTO google_analytics_languages VALUES ('','Chinese (simplified) - Chinesisch (einfach)','zh_CN',1);
INSERT INTO google_analytics_languages VALUES ('','Chinese (traditional) - Chinesisch (traditionell)','zh_TW',2);
INSERT INTO google_analytics_languages VALUES ('','Danish - Dänisch','da',3);
INSERT INTO google_analytics_languages VALUES ('','Dutch - Holländisch','nl',4);
INSERT INTO google_analytics_languages VALUES ('','English (Australia)','en_AU',5);
INSERT INTO google_analytics_languages VALUES ('','English (UK))','en_GB',6);
INSERT INTO google_analytics_languages VALUES ('','English (US)','en_US',7);
INSERT INTO google_analytics_languages VALUES ('','Finnish - Finnisch','fi',8);
INSERT INTO google_analytics_languages VALUES ('','French - Französisch','fr',9);
INSERT INTO google_analytics_languages VALUES ('','German - Deutsch','de',10);
INSERT INTO google_analytics_languages VALUES ('','Hebrew - Hebräisch','iw',11);
INSERT INTO google_analytics_languages VALUES ('','Italian - Italienisch','it',12);
INSERT INTO google_analytics_languages VALUES ('','Japanese - Japanisch','ja',13);
INSERT INTO google_analytics_languages VALUES ('','Korean - Koreanisch','ko',14);
INSERT INTO google_analytics_languages VALUES ('','Norwegian - Norwegisch','no',15);
INSERT INTO google_analytics_languages VALUES ('','Polish - Polnisch','pl',16);
INSERT INTO google_analytics_languages VALUES ('','Portuguese (Brazil) - Portugiesisch (Brasilien)','pt_BR',17);
INSERT INTO google_analytics_languages VALUES ('','Portuguese (Portugal) - Portugiesisch (Portugal)','pt_PT',18);
INSERT INTO google_analytics_languages VALUES ('','Russian - Russisch','ru',19);
INSERT INTO google_analytics_languages VALUES ('','Spanish - Spanisch','es',20);
INSERT INTO google_analytics_languages VALUES ('','Swedish - Schwedisch','sv',21);
INSERT INTO google_analytics_languages VALUES ('','Turkish - Türkisch','tr',22);