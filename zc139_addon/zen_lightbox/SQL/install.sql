#####################################################################
# Zen Lightbox 1.5.2 Multilanguage Install - 2010-05-21 - webchills
#####################################################################

SET @gid=0;
SELECT @gid:=configuration_group_id
FROM configuration_group
WHERE configuration_group_title LIKE '%Zen Lightbox%'
LIMIT 1;
DELETE FROM configuration WHERE configuration_group_id = @gid;
DELETE FROM configuration_group WHERE configuration_group_id = @gid;
SET @gid=0;
SELECT @gid:=configuration_group_id
FROM configuration_group
WHERE configuration_group_title LIKE '%Zen Lightbox%'
LIMIT 1;
DELETE FROM configuration WHERE configuration_group_id = @gid;
DELETE FROM configuration_group WHERE configuration_group_id = @gid;
DELETE FROM configuration_group WHERE configuration_group_title LIKE '%Zen Lightbox%';
DELETE FROM configuration WHERE configuration_description LIKE 'Zen Lightbox%' LIMIT 12;
DELETE FROM configuration WHERE configuration_title LIKE 'LB - %' LIMIT 12;

INSERT INTO configuration_group (configuration_group_id, configuration_group_title, configuration_group_description, sort_order, visible) VALUES
(NULL, 'Zen Lightbox', 'Configure Zen Lightbox settings', '0', '1');
SET @gid=last_insert_id();

UPDATE configuration_group SET sort_order = @gid WHERE configuration_group_id = @gid;

INSERT INTO configuration VALUES 

(NULL, 'LB - Zen Lightbox', 'ZEN_LIGHTBOX_STATUS', 'true', '<br />If true, all product images on the following pages will be displayed within a lightbox:<br /><br />- document_general_info<br />- document_product_info<br />- page (EZ-Pages)<br />- product_free_shipping_info<br />- product_info<br />- product_music_info<br />- product_reviews<br />- product_reviews_info<br />- product_reviews_write<br /><br /><b>Default: true</b>', @gid, 100, NOW(), NOW(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), '),
(NULL, 'LB - Overlay Opacity', 'ZEN_LIGHTBOX_OVERLAY_OPACITY', '0.8', '<br />Controls the transparency of the overlay.<br /><br /><b>Default: 0.8</b>', @gid, 101, NOW(), NOW(), NULL, 'zen_cfg_select_option(array(''0'', ''0.1'', ''0.2'', ''0.3'', ''0.4'', ''0.5'', ''0.6'', ''0.7'', ''0.8'', ''0.9'', ''1''), '),
(NULL, 'LB - Overlay Fade Duration', 'ZEN_LIGHTBOX_OVERLAY_FADE_DURATION', '400', '<br />Controls the fade duration of the overlay.<br /><br />Note: This value is measured in milliseconds.<br /><br /><b>Default: 400</b><br />', @gid, 102, NOW(), NOW(), NULL, NULL),
(NULL, 'LB - Resize Duration', 'ZEN_LIGHTBOX_RESIZE_DURATION', '400', '<br />Controls the speed of the image resizing.<br /><br />Note: This value is measured in milliseconds.<br /><br /><b>Default: 400</b><br />', @gid, 103, NOW(), NOW(), NULL, NULL),
(NULL, 'LB - Resize Transition', 'ZEN_LIGHTBOX_RESIZE_TRANSITION', 'false', '<br />Allows for custom control over the transition effect used to animate the lightbox.<br /><br /><b>Default: false</b><br />', @gid, 104, NOW(), NOW(), NULL, NULL),
(NULL, 'LB - Initial Width', 'ZEN_LIGHTBOX_INITIAL_WIDTH', '250', '<br />If Enable Resize Animations is set to true, the lightbox will resize its width from this value to the current image width, when first displayed.<br /><br />Note: This value is measured in pixels.<br /><br /><b>Default: 250</b><br />', @gid, 105, NOW(), NOW(), NULL, NULL),
(NULL, 'LB - Initial Height', 'ZEN_LIGHTBOX_INITIAL_HEIGHT', '250', '<br />If Enable Resize Animations is set to true, the lightbox will resize its height from this value to the current image height, when first displayed.<br /><br />Note: This value is measured in pixels.<br /><br /><b>Default: 250</b><br />', @gid, 106, NOW(), NOW(), NULL, NULL),
(NULL, 'LB - Image Fade Duration', 'ZEN_LIGHTBOX_IMAGE_FADE_DURATION', '400', '<br />Controls the fade duration of images.<br /><br />Note: This value is measured in milliseconds.<br /><br /><b>Default: 400</b><br />', @gid, 107, NOW(), NOW(), NULL, NULL),
(NULL, 'LB - Caption Animation Duration', 'ZEN_LIGHTBOX_CAPTION_ANIMATION_DURATION', '400', '<br />Controls the animation duration of the caption.<br /><br />Note: This value is measured in milliseconds.<br /><br /><b>Default: 400</b><br />', @gid, 108, NOW(), NOW(), NULL, NULL),
(NULL, 'LB - Display Image Counter', 'ZEN_LIGHTBOX_COUNTER', 'true', '<br />If true, the image counter will be displayed (below the caption of each image) within the lightbox.<br /><br /><b>Default: true</b>', @gid, 109, NOW(), NOW(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),'),
(NULL, 'LB - Close on Image Click', 'ZEN_LIGHTBOX_CLOSE_IMAGE', 'false', '<br />If true, the lightbox will close when the image being displaying is clicked.<br /><br /><b>Default: false</b>', @gid, 110, NOW(), NOW(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), '),
(NULL, 'LB - Close on Overlay Click', 'ZEN_LIGHTBOX_CLOSE_OVERLAY', 'false', '<br />If true, the lightbox will close when the overlay is clicked.<br /><br /><b>Default: false</b>', @gid, 111, NOW(), NOW(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), '),
(NULL, 'LB - Keyboard Navigation', 'ZEN_LIGHTBOX_KEYBOARD_NAVIGATION', 'true', '<br />If true, keyboard inputs will also be used to control the lightbox.<br /><br /><b>Default: true</b>', @gid, 112, NOW(), NOW(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), '),
(NULL, 'LB - Close Lightbox', 'ZEN_LIGHTBOX_ESCAPE_KEYS', '27,88,67', '<br />The lightbox will close when any of these keys are pressed.<br /><br />Note: Only <a href="http://en.wikipedia.org/wiki/ASCII" target="_blank">ASCII</a> decimal values should be entered and separated with a comma (if listing multiple values).<br /><br /><b>Default: 27,88,67</b><br />', @gid, 113, NOW(), NOW(), NULL, NULL),
(NULL, 'LB - Previous Image', 'ZEN_LIGHTBOX_PREVIOUS_KEYS', '37,80', '<br />The lightbox will display the previous image (if available) when any of these keys are pressed.<br /><br />Note: Only <a href="http://en.wikipedia.org/wiki/ASCII" target="_blank">ASCII</a> decimal values should be entered and separated with a comma (if listing multiple values).<br /><br /><b>Default: 37,80</b><br />', @gid, 114, NOW(), NOW(), NULL, NULL),
(NULL, 'LB - Next Image', 'ZEN_LIGHTBOX_NEXT_KEYS', '39,78', '<br />The lightbox will display the next image (if available) when any of these keys are pressed.<br /><br />Note: Only <a href="http://en.wikipedia.org/wiki/ASCII" target="_blank">ASCII</a> decimal values should be entered and separated with a comma (if listing multiple values).<br /><br /><b>Default: 39,78</b><br />', @gid, 115, NOW(), NOW(), NULL, NULL),
(NULL, 'LB - Gallery Mode', 'ZEN_LIGHTBOX_GALLERY_MODE', 'true', '<br />If true, the lightbox will allow additional images to quickly be displayed using previous and next buttons.<br /><br /><b>Default: true</b>', @gid, 116, NOW(), NOW(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),'),
(NULL, 'LB - Include Main Image in Gallery', 'ZEN_LIGHTBOX_GALLERY_MAIN_IMAGE', 'true', '<br />If true, the main product image will be included in the lightbox gallery.<br /><br /><b>Default: true</b>', @gid, 117, NOW(), NOW(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),'),
(NULL, 'LB - EZ-Pages Support', 'ZEN_LIGHTBOX_EZPAGES', 'true', '<br />If true, the lightbox effect will be used for linked images on all EZ-Pages.<br /><br /><b>Default: true</b>', @gid, 118, NOW(), NOW(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),'),
(NULL, 'LB - File Types', 'ZEN_LIGHTBOX_FILE_TYPES', 'jpg,png,gif', '<br />On EZ-Pages, the lightbox effect will be applied to all images with one of the following file types.<br /><br /><b>Default: jpg,png,gif</b><br />', @gid, 119, NOW(), NOW(), NULL, NULL);


##############################
# Add values for German admin
##############################

INSERT INTO configuration_group (configuration_group_id, language_id, configuration_group_title, configuration_group_description, sort_order, visible ) VALUES 
(@gid, 43, 'Zen Lightbox', 'Zen Lightbox Einstellungen', '0', '1');


REPLACE INTO configuration_language (configuration_title, configuration_key, configuration_description, configuration_language_id) VALUES
('LB - Zen Lightbox aktivieren?', 'ZEN_LIGHTBOX_STATUS', 'Wenn auf true werden alle Produktbilder beim Click darauf innerhalb einer Lightbox angezeigt auf folgenden Seiten: <br /><br />- document_general_info<br />- document_product_info<br />- page (EZ-Pages)<br />- product_free_shipping_info<br />- product_info<br />- product_music_info<br />- product_reviews<br />- product_reviews_info<br />- product_reviews_write<br /><br /><b>Voreinstellung: true</b><br />',	43),
('LB - Overlay Transparenz', 'ZEN_LIGHTBOX_OVERLAY_OPACITY', '<br />Steuert die Transparenz des Overlays<br /><br /><b>Voreinstellung: 0.8</b><br />',	43),
('LB - Overlay Fade Dauer', 'ZEN_LIGHTBOX_OVERLAY_FADE_DURATION', 'Steuert die Dauer des Fade Effekts des Overlays. Angegeben in Millisekunden.<br /><br /><b>Voreinstellung: 400</b><br />',	43),
('LB - Resize Dauer', 'ZEN_LIGHTBOX_RESIZE_DURATION', 'Geschwindigkeit der Bildvergrößerung. Angegeben in Millisekunden.<br /><br /><b>Voreinstellung: 400</b><br />',	43),
('LB - Resize Übergangseffekt</b>', 'ZEN_LIGHTBOX_RESIZE_TRANSITION', 'Benutzerdefinierte Steuerung des Vergrößerungseffekts<br/><br/><b>Voreinstellung: false</b><br />',	43),
('LB - Anfangsbreite', 'ZEN_LIGHTBOX_INITIAL_WIDTH', '<br />Wenn der Resize Effekt aktiv ist, startet die Lightbox mit der hier eingestellten Breite.<br /><br />Hinweis: Dieser Wert ist in Pixel anzugeben.<br /><br /><b>Voreinstellung: 250</b><br />',	43),
('LB - Anfangshöhe', 'ZEN_LIGHTBOX_INITIAL_HEIGHT', '<br />Wenn der Resize Effekt aktiv ist, startet die Lightbox mit der hier eingestellten Höhe.<br /><br />Hinweis: Dieser Wert ist in Pixel anzugeben.<br /><br /><b>Voreinstellung: 250</b><br />',	43),
('LB - Dauer des Fade Effekts', 'ZEN_LIGHTBOX_IMAGE_FADE_DURATION', '<br />Stellen Sie hier die Dauer des Fade Effekts eins.<br /><br />Hinweis: Dieser Wert ist in Millisekunden anzugeben.<br /><br /><b>Voreinstellung: 400</b><br />',	43),
('LB - Dauer des Caption Effekts', 'ZEN_LIGHTBOX_CAPTION_ANIMATION_DURATION', '<br />Stellen Sie hier die Dauer der Caption Animation ein.<br /><br />Hinweis: Dieser Wert ist in Millisekunden anzugeben.<br /><br /><b>Voreinstellung: 400</b><br />',	43),
('LB - Bildzähler anzeigen', 'ZEN_LIGHTBOX_COUNTER', '<br />Wenn auf true wird bei mehreren Bildern unterhalb des Bilds in der Lightboxein Bildzähler angezeigt.<br /><br /><b>Voreingestellt: true</b><br/>',	43),
('LB - Lightbox beim Anclicken des Bildes schliessen?', 'ZEN_LIGHTBOX_CLOSE_IMAGE', 'Wenn auf true gestellt, schliesst sich die Lightbox wenn aufs Bild geklickt wird.<br /><br /><b>Voreinstellung: false</b><br />',	43),
('LB - Lightbox beim Klick aufs Overlay schliessen?', 'ZEN_LIGHTBOX_CLOSE_OVERLAY', 'Wenn auf true gestellt, schliesst sich die Lightbox wenn aufs Overlay geklickt wird.<br /><br /><b>Voreinstellung: false</b><br />',	43),
('LB - Tastatur Navigation', 'ZEN_LIGHTBOX_KEYBOARD_NAVIGATION', 'Sollen Tastaturbefehle die Lightbox steuern können?<br/><br/><b>Voreinstellung: true</b><br />',	43),
('LB - Lightbox schliessen', 'ZEN_LIGHTBOX_ESCAPE_KEYS',	'<br />Die Lightbox wird geschlossen, wenn eine dieser Tasten gedrückt wird.<br /><br />Hinweis: Nur <a href="http://en.wikipedia.org/wiki/ASCII" target="_blank">ASCII</a> dezimale Werte dürfen verwendet werden, mit Komma getrennt (falls Sie mehrere Werte angeben).<br /><br /><b>Voreinstellung: 27,88,67</b><br />',	43),
('LB - Vorheriges Bild', 'ZEN_LIGHTBOX_PREVIOUS_KEYS', '<br />Die Lightbox zeigt das vorherige Bild - falls verfügbar -, wenn eine dieser Tasten gedrückt wird.<br /><br />Hinweis: Nur <a href="http://en.wikipedia.org/wiki/ASCII" target="_blank">ASCII</a> dezimale Werte dürfen verwendet werden, mit Komma getrennt (falls Sie mehrere Werte angeben).<br /><br /><b>Voreinstellung: 37,80</b><br />',	43),
('LB - Nächstes Bild', 'ZEN_LIGHTBOX_NEXT_KEYS', '<br />Die Lightbox zeigt das nächste Bild - falls verügbar -, wenn eine dieser Tasten gedrückt wird.<br /><br />Hinweis: Nur <a href="http://en.wikipedia.org/wiki/ASCII" target="_blank">ASCII</a> dezimale Werte dürfen verwendet werden, mit Komma getrennt (falls Sie mehrere Werte angeben).<br /><br /><b>Voreinstellung: 39,78</b><br />',	43),
('LB - Galerie Modus', 'ZEN_LIGHTBOX_GALLERY_MODE', 'Sollen die zusätzlichen Artikelbilder in der Lightbox Galerie angezeigt werden?<br/><br/><b>Voreinstellung: true</b><br />', 43),
('LB - Hauptbild in der Galerie anzeigen', 'ZEN_LIGHTBOX_GALLERY_MAIN_IMAGE', 'Soll das Hauptbild in der Galerie enthalten sein?<br/><br/><b>Voreinstellung: true</b><br />',	43),
('LB - Lightbox auf EZ Pages', 'ZEN_LIGHTBOX_EZPAGES', 'Soll die Lightbox auch bei Bildern auf EZ-Pages angewandt werden?<br/><br/><b>Voreinstellung: true</b><br />',	43),
('LB - Dateitypen', 'ZEN_LIGHTBOX_FILE_TYPES', 'Auf EZ Pages wird der Lightbox Effekt auf alle Bilder mit den hier eingestellten Dateitypen angewandt.<br/><br/><b>Voreinstellung: jpg,gif,png</b><br />',	43);