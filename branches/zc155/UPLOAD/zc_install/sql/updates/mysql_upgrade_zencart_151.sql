#
# * This SQL script upgrades the core Zen Cart database structure from v1.5.0 to v1.5.1
# *
# * @package Installer
# * @access private
# * @copyright Copyright 2003-2016 Zen Cart Development Team
# * @copyright Portions Copyright 2003 osCommerce
# * @license http://www.zen-cart-pro.at/license/2_0.txt GNU Public License V2.0
# * @version $Id: mysql_upgrade_zencart_151.sql 2 2016-03-28 09:12:59Z webchills $
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
UPDATE configuration set configuration_value = 'true' where configuration_key = 'DOWN_FOR_MAINTENANCE';

# Clear out active customer sessions
TRUNCATE TABLE whos_online;
TRUNCATE TABLE db_cache;
TRUNCATE TABLE sessions;

#ALTER TABLE admin_activity_log CHANGE COLUMN gzpost gzpost mediumblob ;

ALTER TABLE admin_activity_log CHANGE COLUMN ip_address ip_address varchar(45) NOT NULL default '';
ALTER TABLE whos_online CHANGE COLUMN ip_address ip_address varchar(45) NOT NULL default '';
ALTER TABLE admin MODIFY COLUMN pwd_last_change_date datetime NOT NULL default '0001-01-01 00:00:00', MODIFY COLUMN last_modified datetime NOT NULL default '0001-01-01 00:00:00', MODIFY COLUMN last_login_date datetime NOT NULL default '0001-01-01 00:00:00', MODIFY COLUMN last_failed_attempt datetime NOT NULL default '0001-01-01 00:00:00';
UPDATE admin SET pwd_last_change_date='0001-01-01' where pwd_last_change_date < '0001-01-01';
UPDATE admin SET last_modified='0001-01-01' where last_modified < '0001-01-01';
UPDATE admin SET last_login_date='0001-01-01' where last_login_date < '0001-01-01';
UPDATE admin SET last_failed_attempt='0001-01-01' where last_failed_attempt < '0001-01-01';
ALTER TABLE admin CHANGE COLUMN last_login_ip last_login_ip varchar(45) NOT NULL default '';
ALTER TABLE admin CHANGE COLUMN last_failed_ip last_failed_ip varchar(45) NOT NULL default '';
ALTER TABLE coupon_redeem_track CHANGE COLUMN redeem_ip redeem_ip varchar(45) NOT NULL default '';
ALTER TABLE coupon_gv_queue CHANGE COLUMN ipaddr ipaddr varchar(45) NOT NULL default '';
#Buttonloesung Merkmale in table products_description
ALTER TABLE products_description ADD products_merkmale varchar(256) NOT NULL default '';
#Buttonloesung Optionaleintrag entfernen
DELETE FROM configuration WHERE configuration_key = 'ENABLE_BUTTONLOESUNG';
DELETE FROM configuration_language WHERE configuration_key = 'ENABLE_BUTTONLOESUNG';

#Vataddon Admin Control
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ('Display Vat Addon', 'DISPLAY_VATADDON_WHERE', 'ALL', 'Do you want to display the text incl. or excl. VAT plus shipping costs near the prices?<br />0=off<br/>ALL=everywhere<br/>product_info=only on products details page<br />', '1', '120', NULL, now(), NULL, 'zen_cfg_select_option(array(\'0\', \'ALL\', \'product_info\'), ');

#EU Countries fuer Buttonloesung
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ('EU Countries', 'EU_COUNTRIES_FOR_LAST_STEP', 'BE,BG,DK,DE,EE,FI,FR,GR,IE,IT,LV,LT,LU,MT,NL,AT,PL,PT,RO,SE,SK,SI,ES,CZ,HU,GB,CY,HR', 'Enter the countries which are part of the European Union. Two digit ISO codes, comma separated.', '1', '100', now(), now(), NULL, NULL);

#Set TinyMCE as default HTML editor
UPDATE configuration SET configuration_value = 'CKEDITOR' WHERE configuration_key = 'HTML_EDITOR_PREFERENCE';



# $Id: mysql_multilingual_2.sql 677 2013-09-25 11:02:40Z webchills $
# multilingual part II
# @translators: maleborg/webchills/hugo13


#################################################################
#  LANGUAGE SPECIFIC                                            #
#  questions to: zencart(AT)langheiter.com                      #
#################################################################
# insert language; id == 43 == telephone-countrycode

 # new field: language_id

REPLACE INTO configuration_group (configuration_group_id, language_id, configuration_group_title, configuration_group_description, sort_order, visible) VALUES 
(1, 43, 'Mein Shop', 'Generelle Informationen �ber den Shop', 1, 1),
(2, 43, 'Minimale Werte', 'Die minimale Zeichenl�nge f�r Funktionen / Daten', 2, 1),
(3, 43, 'Maximale Werte', 'Die maximale Zeichenl�nge f�r Funktionen / Daten', 3, 1),
(4, 43, 'Bilder', 'Einstellungen der Bildparameter', 4, 1),
(5, 43, 'Kundendetails', 'Konfiguration der Kundenkonten', 5, 1),
(6, 43, 'Moduloptionen', 'Vom Konfigurationsmen� versteckt', 6, 0),
(7, 43, 'Versandoptionen', 'Im Shop verf�gbare Versandoptionen', 7, 1),
(8, 43, 'Artikelliste', 'Konfiguration der Artikelliste', 8, 1),
(9, 43, 'Lagerverwaltung', 'Konfigurationen der Lagerverwaltung', 9, 1),
(10, 43, 'Protokollierung', 'Konfiguration der Protokollierung', 10, 1),
(11, 43, 'AGB & Datenschutz', 'Konfiguration f�r die AGB', 16, 1),
(12, 43, 'E-Mail Optionen', 'Generelle Einstellungen f�r den E-Mail Transport (SMTP) und die HTML Optionen', 12, 1),
(13, 43, 'Attributeinstellungen', 'Konfiguration f�r die Einstellungen der Artikeloptionen', 13, 1),
(14, 43, 'GZip Komprimierung', 'Konfiguration der GZip Komprimierung', 14, 1),
(15, 43, 'Sitzungen/Sessions', 'Konfiguration der Sitzungsoptionen', 15, 1),
(16, 43, 'Gutscheine & Aktionskupons', 'Konfiguration der Gutsycheine und Aktionskupons', 16, 1),
(17, 43, 'Kreditkarten', 'Konfiguration der zu verwendeten Kreditkarten', 17, 1),
(18, 43, 'Artikeldetails', 'Konfiguration f�r die Anzeige von Artikeldetails', 18, 1),
(19, 43, 'Layouteinstellungen', 'Layouteinstellungen', 19, 1),
(20, 43, 'Shopwartung', 'Konfiguration der Shopwartung', 20, 1),
(21, 43, 'Liste - Neue Artikel', 'Listenansicht f�r neue Artikel', 21, 1),
(22, 43, 'Liste - Empfohlene Artikel', 'Listenansicht f�r Empfohlene Artikel', 22, 1),
(23, 43, 'Liste - Alle Artikel', 'Listenansicht f�r alle Artikel', 23, 1),
(24, 43, 'Liste - Artikelindex', 'Listenansicht f�r Artikelindex', 24, 1),
(25, 43, 'Eigene Seiten', 'Eigene Seiten, die �ber den im Seiteneditor eingegebenen Texte festgelegt werden und HTMLArea Optionen', 25, 1),
(30, 43, 'EZ-Pages Einstellungen', 'EZ-Pages Einstellungen', 30, 1);



REPLACE INTO configuration_language (configuration_title, configuration_key, configuration_language_id, configuration_description, last_modified, date_added) VALUES

# Adminmen� ID 1
('Shopname', 'STORE_NAME', 43, 'Geben Sie hier einen Namen f�r Ihren Shop ein', now(), now()),
('Shopinhaber', 'STORE_OWNER', 43, 'Geben Sie hier einen Namen des Shopinhabers ein', now(), now()),
('Telefonnummer des Kundenservice', 'STORE_TELEPHONE_CUSTSERVICE', 43, 'Geben Sie hier die Telefonnumer an, unter der Kunden Ihren Kundenservice erreichen k�nnen.', now(), now()),
('Land', 'STORE_COUNTRY', 43, 'Geben Sie hier das Land an, in dem der Shop betrieben wird<br /><br /><strong><b>HINWEIS: Bitte nicht vergessen, ggf. das Bundesland des Shops zu aktualisieren</b></strong>', now(), now()),
('Zone/Bundesland', 'STORE_ZONE', 43, 'Geben Sie hier die Zone / das Bundesland an, in dem der Shop betrieben wird', now(), now()),
('Erwartete Artikel: Sortierung', 'EXPECTED_PRODUCTS_SORT', 43, 'Wie sollen die Artikel in der Box "Erwartete Artikel" sortiert werden?<br>ASC = Aufsteigend, DESC=Absteigend', now(), now()),
('Erwartete Artikel: Sortierung', 'EXPECTED_PRODUCTS_FIELD', 43, 'Nach welcher Spalte soll sortiert werden?<br>product_name = Artikelname, date_expected = Erscheinungsdatum', now(), now()),
('Automatisch zur Standardw�hrung der Sprache wechseln', 'USE_DEFAULT_LANGUAGE_CURRENCY', 43, 'Soll automatisch zu der zur Sprache passenden W�hrung gewechselt werden?', now(), now()),
('Sprachauswahl', 'LANGUAGE_DEFAULT_SELECTOR', 43, 'Default Sprache wird durch Shop festgelegt oder die Browsereinstellung?<br /><br />Standard: Shop', now(), now()),
('Suchmaschinenfeste (Kurz-)URLs verwenden (noch in der Entwicklung)', 'SEARCH_ENGINE_FRIENDLY_URLS', 43, 'Suchmaschinenfeste URLs (KurzURL) f�r alle Links im Shop verwenden', now(), now()),
('Warenkorb nach Hinzuf�gen eines Artikels anzeigen', 'DISPLAY_CART', 43, 'Soll der Warenkorb nach dem Hinzuf�gen eines Artikels angezeigt werden? (HINWEIS: false= nein, zur�ck zum Artikel)', now(), now()),
('Standard Suchoperator', 'ADVANCED_SEARCH_DEFAULT_OPERATOR', 43, 'Standard Suchoperator<br />"AND": W�rter, die vorkommen m�ssen<br />"OR": W�rter, die vorkommen k�nnen<br />"NOT": W�rter, die nicht vorkommen sollen', now(), now()),
('Shopadresse und Telefonnummer', 'STORE_NAME_ADDRESS', 43, 'Diese Adresse wird auf ausdruckbaren Dokumenten und online im Shop angezeigt', now(), now()),
('Z�hler hinter Kategorienamen anzeigen', 'SHOW_COUNTS', 43, 'Soll der Z�hler, der die Anzahl von Artikel in der jeweiligen Kategorie anzeigt,<br />hinter dem Kategorienamen sichtbar sein?', now(), now()),
('Dezimalstellen bei Steuern', 'TAX_DECIMAL_PLACES', 43, 'Wieviele Dezimalstellen sollen bei den Steuern angezeigt werden?', now(), now()),
('Bruttopreise im Shop verwenden', 'DISPLAY_PRICE_WITH_TAX', 43, 'Sollen die Bruttopreise im Shop angezeigt werden?<br />true= Bruttopreise (inkl. Steuern)<br />false= Nettopreise (exkl. Steuern)', now(), now()),
('Preise inkl. Steuern im Adminbereich anzeigen', 'DISPLAY_PRICE_WITH_TAX_ADMIN', 43, 'Preise inkl. Steuern (true) oder die Steuern am Ende (false) im Adminbereich anzeigen(Rechnungen)', now(), now()),
('Basis der Steuern f�r Artikel', 'STORE_PRODUCT_TAX_BASIS', 43, 'Auf welcher Basis sollen Steuern bei Artikeln berechnet werden? Die Optionen sind:<br />Versand (Shipping) - Berechnung erfolgt auf Basis der Versandadresse des Kunden<br />Rechnung (Billing) - Berechnung erfolgt auf Basis der Rechnungsadresse des Kunden<br />Shop (Store) - Berechnung erfolgt auf Basis der Shopadresse, wenn die Versand-/Rechnungsadresse innerhalb der Zone / des Bundeslandes des Shops liegt', now(), now()),
('Basis der Steuern f�r Versand', 'STORE_SHIPPING_TAX_BASIS', 43, 'Auf welcher Basis sollen Steuern bei Versandkosten berechnet werden? Die Optionen sind:<br />Versand (Shipping) - Berechnung erfolgt auf Basis der Versandadresse des Kunden<br />Rechnung (Billing) - Berechnung erfolgt auf Basis der Rechnungsadresse des Kunden<br />Shop (Store) - Berechnung erfolgt auf Basis der Shopadresse, wenn die Versand-/Rechnungsadresse innerhalb der Zone / des Bundeslandes des Shops liegt (kann vom Versandmodul �berschrieben werden)', now(), now()),
('Steuern auch bei 0% anzeigen?', 'STORE_TAX_DISPLAY_STATUS', 43, 'Steuer auch dann anzeigen, wenn diese 0% betragen?<br/>0= NEIN<br/>1= JA ', now(), now()),
('Gesplittete Steueranzeige', 'SHOW_SPLIT_TAX_CHECKOUT', 43, 'Wenn Artikel mit verschiedenen Steuers�tzen bestellt werden, soll dann im Bestellvorgang jeder Steuersatz in einer eigenen Zeile ausgewiesen werden?', now(), now()),
('Timeout der Admin-Sitzungen (in Sekunden)', 'SESSION_TIMEOUT_ADMIN', 43, 'Geben Sie die Zeit in Sekunden an. Standard=900<br /> Beispiel: 900= 15 Minuten<br /><b>WICHTIGER HINWEIS: Wenn Sie diesen Wert auf �ber 900 erh�hen, dann erf�llt Ihr Shop die Richtlinien der PA-DSS Zertifizierung nicht mehr!</b><br/><br/>Eine zu geringe Zeitangabe kann zu Problemen bei der Bearbeitung von Artikeln f�hren.', now(), now()),
('Maximale Zeit f�r die Ausf�hrung von Prozessen', 'GLOBAL_SET_TIME_LIMIT', 43, 'Geben Sie die Zeit in Sekunden an. Standard=60<br />Beispiel: 60= 1 Minute<br /><br />HINWEIS: Diesen Wert sollte nur ge�ndert werden, wenn es Probleme bei der Ausf�hrung von Prozessen gibt.', now(), now()),
('Auf neue Version von Zen Cart pr�fen', 'SHOW_VERSION_UPDATE_IN_HEADER', 43, 'Automatische �berpr�fung auf eine neuere Version von Zen Cart bei der Anmeldung im Admin-Bereich. Zeigt dies dann im Header des Admin Bereichs an. Wenn dieses Feature aktiviert ist, kann es manchmal zu Geschwindigkeitseinbu�en im Admin Bereich kommen.', now(), now()),
('Art des Shops', 'STORE_STATUS', 43, 'Welcher Art ist Ihr Shop:<br />0= Normaler Shop<br />1= Showroom ohne Preise<br />2= Showroom mit Preisen<br> Showroom = Artikel werden angezeigt, k�nnen aber nicht gekauft werden!', now(), now()),
('Server Onlinestatus anzeigen', 'DISPLAY_SERVER_UPTIME', 43, 'Zeigt die Onlinezeit des Servers an.<br />HINWEIS: Das Aktivieren diese Einstellung kann bei einigen Server Eintr�ge in den Fehlerprotokollen verursachen.  (true = anzeigen, false = nicht anzeigen)', now(), now()),
('�berpr�fung auf fehlende Seiten', 'MISSING_PAGE_CHECK', 43, 'Zen Cart kann das Fehlen von Seiten in einer URL erkennen und leitet dann bei Bedarf auf die Startseite weiter.<br />F�r ein Debugging kann diese Funktion deaktiviert werden. (true = Auf fehlende Seiten pr�fen, false = Keine �berpr�fung auf fehlende Seiten)', now(), now()),
('cURL Proxy Status', 'CURL_PROXY_REQUIRED', 43, 'Verwenden Sie einen Web-Provider, der f�r die Kommunikation mit externen Seiten cURL via Proxy verwendet?', now(), now()),
('cURL Proxy Adresse', 'CURL_PROXY_SERVER_DETAILS', 43, 'Wenn Sie einen Provider einsetzen, der cURL verwendet (wie z.B. <em>GoDaddy</em> oder <em>Dreamhost</em>), welcher �ber einen Proxy via cURL mit externen Seiten kommuniziert, dann geben Sie hier die Adresse des Proxy Servers ein.<br />Format: adresse:port<br />z.B.: f�r GoDaddy geben Sie folgendes ein: 64.202.165.130:3128', now(), now()),
('HTML Editor', 'HTML_EDITOR_PREFERENCE', 43, 'Welchen HTML Editor wollen Sie zur Bearbeitung von E-Mails, Newslettern und Artikelbeschreibungen im Adminbereich verwenden?', now(), now()),
('phpBB Forumsynchronisierung aktivieren?', 'PHPBB_LINKS_ENABLED', 43, 'Soll Zen Cart neue Kundenkonten mit dem - bereits installierten - phpBB Forum synchronisieren?', now(), now()),
('Kategoriez�hler im Adminbereich anzeigen', 'SHOW_COUNTS_ADMIN', 43, 'Soll der Kategoriez�hler im Adminbereich angezeigt werden?', now(), now()),
('Multiplikator f�r Fremdw�hrungen', 'CURRENCY_UPLIFT_RATIO', 43, 'Wie hoch soll der Faktor f�r den Aufschlag von Fremdw�hrungen in Ihrem Shop bei der Aktualisierung der W�hrungskurse sein?<br /><br />BESCHREIBUNG:<br />Der Umrechnungskurs wird vom externen Wechselkurs-Server w�hrend der Abfrage festgestellt und mit Ihrem Shop abgeglichen.<br />Wird als Faktor z.B. der Wert <em>2.00</em> verwendet, werden Fremdw�hrungen mit diesem Wert multipliziert.<br /><br />BEISPIEL:<br />Die W�hrung <em>EURO</em> ist als <em>Standard</em> definiert:<br />Kurs: EURO = 1.00000000; USD = 1.40000000<br />Als Faktor wird <em>2.00</em> verwendet.<br />Ergebnis: Euro = 1.00000000; USD = 2.80000000<br /><br /><br />Standard: 1.05', now(), now()),
('EU L�nder', 'EU_COUNTRIES_FOR_LAST_STEP', 43, 'Tragen Sie hier die Mitgliedsstaaten der Europ�ischen Union ein. Wenn an L�nder geliefert wird, die nicht in dieser Liste stehen, dann erscheint im letzten Schritt des Bestellvorgangs ein Hinweis auf m�gliche Zollgeb�hren. Zweistellige ISO Codes mit Komma getrennt.', now(), now()),


# Adminmen� ID 2
('Vorname', 'ENTRY_FIRST_NAME_MIN_LENGTH', 43, 'Minimale Zeichenl�nge f�r den Vornamen', now(), now()),
('Nachname', 'ENTRY_LAST_NAME_MIN_LENGTH', 43, 'Minimale Zeichenl�nge f�r den Nachnamen', now(), now()),
('Geburtsdatum', 'ENTRY_DOB_MIN_LENGTH', 43, 'Minimale Zeichenl�nge f�r das Geburtsdatum', now(), now()),
('E-Mail Adresse', 'ENTRY_EMAIL_ADDRESS_MIN_LENGTH', 43, 'Minimale Zeichenl�nge f�r die E-Mail Adresse', now(), now()),
('Strasse', 'ENTRY_STREET_ADDRESS_MIN_LENGTH', 43, 'Minimale Zeichenl�nge f�r die Strasse', now(), now()),
('Firma', 'ENTRY_COMPANY_MIN_LENGTH', 43, 'Minimale Zeichenl�nge der Firma', now(), now()),
('Postleitzahl', 'ENTRY_POSTCODE_MIN_LENGTH', 43, 'Minimale Zeichenl�nge der Postleitzahl', now(), now()),
('Stadt', 'ENTRY_CITY_MIN_LENGTH', 43, 'Minimale Zeichenl�nge der Stadt', now(), now()),
('Bundesland', 'ENTRY_STATE_MIN_LENGTH', 43, 'Minimale Zeichenl�nge f�r das Bundesland', now(), now()),
('Telefonnummer', 'ENTRY_TELEPHONE_MIN_LENGTH', 43, 'Minimale Zeichenl�nge f�r die Telefonnummer', now(), now()),
('Passwort', 'ENTRY_PASSWORD_MIN_LENGTH', 43, 'Minimale Zeichenl�nge f�r das Passwort', now(), now()),
('Kreditkarteninhaber', 'CC_OWNER_MIN_LENGTH', 43, 'Minimale Zeichenl�nge f�r den Namen des Kreditkarteninhabers', now(), now()),
('Kreditkartennummer', 'CC_NUMBER_MIN_LENGTH', 43, 'Minimale Zeichenl�nge f�r die Kreditkartennummer', now(), now()),
('Kreditkarten Pr�fziffer (CVV)', 'CC_CVV_MIN_LENGTH', 43, 'Minimale Zeichenl�nge f�r den Kreditkarten Pr�fziffer (CVV)', now(), now()),
('Zeichenl�nge f�r Bewertungstexte', 'REVIEW_TEXT_MIN_LENGTH', 43, 'Minimale Zeichenl�nge f�r den Text einer Bewertung', now(), now()),
('Bestseller', 'MIN_DISPLAY_BESTSELLERS', 43, 'Wieviele Bestseller/Top Artikel sollen mindestens angezeigt werden?', now(), now()),
('Empfohlene Artikel', 'MIN_DISPLAY_ALSO_PURCHASED', 43, 'Minimale Anzahl der anzuzeigenden Artikel in der Box Empfohlene Artikel', now(), now()),
('Nickname', 'ENTRY_NICK_MIN_LENGTH', 43, 'Minimale Zeichenl�nge f�r Nicknamen', now(), now()),

# Adminmen� ID 3
('Adresseintr�ge im Adressbuch', 'MAX_ADDRESS_BOOK_ENTRIES', 43, 'Wieviele Adresseintr�ge d�rfen Kunden in Ihrem Adressbuch haben?', now(), now()),
('Suchresultate pro Seite', 'MAX_DISPLAY_SEARCH_RESULTS', 43, 'Wieviele Artikel sollen maximal in den Suchresultaten pro Seite angezeigt werden?', now(), now()),
('"Vorherige - N�chste" Navigation: Seitenlinks', 'MAX_DISPLAY_PAGE_LINKS', 43, 'Anzahl der Seitenlinks in der "Vorherige - N�chste" Navigation', now(), now()),
('Anzuzeigende "Sonderangebote"', 'MAX_DISPLAY_SPECIAL_PRODUCTS', 43, 'Wieviele Sonderangebote sollen angezeigt werden?', now(), now()),
('Anzuzeigende "Neue Artikel"', 'MAX_DISPLAY_NEW_PRODUCTS', 43, 'Wieviele "Neue Artikel" sollen in den Kategorien angezeigt werden?', now(), now()),
('Anzuzeigende "Erwartete Artikel"', 'MAX_DISPLAY_UPCOMING_PRODUCTS', 43, 'Wieviele "erwartete Artikel" sollen angezeigt werden?', now(), now()),
('Hersteller - Listenfeld Gr��e/Stil', 'MAX_MANUFACTURERS_LIST', 43, 'Anzahl der Hersteller, die im Listenfeld angezeigt werden sollen. Bei einer Eingabe von 0 oder 1 wird eine Dropdown Liste angezeigt.', now(), now()),
('Hersteller Liste - Produkt�berpr�fung', 'PRODUCTS_MANUFACTURERS_STATUS', 43, 'Hersteller wird nur dann in der Liste angezeigt wenn mindestens 1 Produkt von Ihm verf�gbar ist.<br/>0=AUS<br/>1=EIN<br/>Anmerkung: Ein Aktivieren dieser Einstellung kann bei Shops mit vielen Artikeln zu Performance-Einbu�en f�hren.', now(), now()),
('Musik Genre - Listenfeld Gr��e/Stil', 'MAX_MUSIC_GENRES_LIST', 43, 'Anzahl der Musik Genres, die im Listenfeld angezeigt werden sollen. Bei einer Eingabe von 0 oder 1 wird eine Dropdown Liste angezeigt.', now(), now()),
('Plattenfirma - Listenfeld Gr��e/Stil', 'MAX_RECORD_COMPANY_LIST', 43, 'Anzahl der Plattenfirmen, die im Listenfeld angezeigt werden sollen. Bei einer Eingabe von 0 oder 1 wird eine Dropdown Liste angezeigt.', now(), now()),
('L�nge der Namen von Plattenfirmen', 'MAX_DISPLAY_RECORD_COMPANY_NAME_LEN', 43, 'Wird in der Box "Plattenfirma" verwendet; Maximale L�nge der anzuzeigenden Namen von Plattenfirmen. L�ngere Namen werden abgeschnitten.', now(), now()),
('L�nge der Namen von Musik Genres', 'MAX_DISPLAY_MUSIC_GENRES_NAME_LEN', 43, 'Wird in der Box "Musik Genre" verwendet; Maximale L�nge der anzuzeigenden Namen von Musik Genres. L�ngere Namen werden abgeschnitten.', now(), now()),
('L�nge der Namen von Herstellern', 'MAX_DISPLAY_MANUFACTURER_NAME_LEN', 43, 'Wird in der Box "Hersteller" verwendet; Maximale L�nge der anzuzeigenden Namen von Herstellern. L�ngere Namen werden abgeschnitten.', now(), now()),
('Neue Artikelbewertungen pro Seite', 'MAX_DISPLAY_NEW_REVIEWS', 43, 'Anzahl der Bewertungen auf jeder Seite', now(), now()),
('Box "Bewertungen": zuf�llige Artikel', 'MAX_RANDOM_SELECT_REVIEWS', 43, 'Wieviele Bewertungen sollen zuf�llig ausgew�hlt werden?<br/> Unabh�ngig davon wird immer nur EINE in der Box "Bewertungen" angezeigt.', now(), now()),
('Box "Neue Artikel": zuf�llige Artikel', 'MAX_RANDOM_SELECT_NEW', 43, 'Wieviele neue Artikel sollen in der Box "Neue Artikel" zuf�llig angezeigt werden?', now(), now()),
('Box "Sonderangebot": zuf�llige Artikel', 'MAX_RANDOM_SELECT_SPECIALS', 43, 'Wieviele Sonderangebote sollen in der Box "Sonderangebote" zuf�llig angezeigt werden?', now(), now()),
('Kategorien pro Reihe', 'MAX_DISPLAY_CATEGORIES_PER_ROW', 43, 'Wieviele Kategorien sollen pro Reihe angezeigt werden?', now(), now()),
('Liste "Neue Artikel": Artikel pro Seite', 'MAX_DISPLAY_PRODUCTS_NEW', 43, 'Wieviele Artikel sollen pro Seite in der Liste "Neue Artikel" angezeigt werden?', now(), now()),
('Box "Bestseller": Anzahl der Artikel', 'MAX_DISPLAY_BESTSELLERS', 43, 'Wieviele Bestseller sollen in der Box angezeigt werden?', now(), now()),
('Box "Empfohlene Artikel": Anzahl der Artikel', 'MAX_DISPLAY_ALSO_PURCHASED', 43, 'Wieviele Artikel sollen in der Box "Empfohlene Artikel angezeigt werden?', now(), now()),
('Box "K�rzlich bestellte Artikel" HINWEIS: Diese Box ist deaktiviert', 'MAX_DISPLAY_PRODUCTS_IN_ORDER_HISTORY_BOX', 43, 'Wieviele Artikel sollen in der Box "K�rzlich bestellte Artikel" angezeigt werden?', now(), now()),
('Mein Konto: Anzahl Bestellungen pro Seite der Bestellhistorie', 'MAX_DISPLAY_ORDER_HISTORY', 43, 'Wieviele Bestellungen sollen pro Seite der Bestellhistorie in "Mein Konto" angezeigt werden?', now(), now()),
('Kunden pro Seite', 'MAX_DISPLAY_SEARCH_RESULTS_CUSTOMER', 43, 'Wieviele Kunden sollen pro Seite im Adminbereich --> Kunden --> Kunden angezeigt werden?', now(), now()),
('Bestellungen pro Seite', 'MAX_DISPLAY_SEARCH_RESULTS_ORDERS', 43, 'Wieviele Bestellungen sollen pro Seite im Adminbereich unter --> Kunden --> Bestellungen angezeigt werden?', now(), now()),
('Artikel in Berichten pro Seite', 'MAX_DISPLAY_SEARCH_RESULTS_REPORTS', 43, 'Wieviele Artikel sollen Berichten/Statistiken (Adminbereich) pro Seite angezeigt werden?', now(), now()),
('Artikel in Kategorien pro Seite', 'MAX_DISPLAY_RESULTS_CATEGORIES', 43, 'Wieviele Artikel sollen im Adminbereich --> Artikel & Kategorien in den jeweiligen Kategorien pro Seite angezeigt werden?', now(), now()),
('Artikelliste: Anzahl der Artikel', 'MAX_DISPLAY_PRODUCTS_LISTING', 43, 'Wieviele Artikel in der Artikelliste der jeweiligen Kategorie im Shop angezeigt werden?', now(), now()),
('Artikelattribute: Ansicht Attributnamen und -werte', 'MAX_ROW_LISTS_OPTIONS', 43, 'Wieviele Attributnamen und -werte sollen auf der Seite der Artikelattribute maximal angezeigt werden?', now(), now()),
('Artikelattribute: Ansicht Attributmanager', 'MAX_ROW_LISTS_ATTRIBUTES_CONTROLLER', 43, 'Wieviele Attribute sollen auf der Seite des Attributmanagers maximal angezeigt werden?', now(), now()),
('Artikelattribute - Downloadmanager', 'MAX_DISPLAY_SEARCH_RESULTS_DOWNLOADS_MANAGER', 43, 'Wieviele Downloadattribute sollen pro Seite im Downloadmanager angezeigt werden?', now(), now()),
('Empfohlene Artikel im Adminbereich', 'MAX_DISPLAY_SEARCH_RESULTS_FEATURED_ADMIN', 43, 'Anzahl empfohlener Artikel pro Seite im Adminbereich', now(), now()),
('Empfohlene Artikel auf der Startseite', 'MAX_DISPLAY_SEARCH_RESULTS_FEATURED', 43, 'Anzahl empfohlener Artikel auf der Startseite', now(), now()),
('Liste "Empfohlene Artikel": Artikel pro Seite', 'MAX_DISPLAY_PRODUCTS_FEATURED_PRODUCTS', 43, 'Wieviele Artikel sollen pro Seite in der Liste "Empfohlene Artikel" angezeigt werden?', now(), now()),
('Box "Empfohlene Artikel": Anzahl der Artikel', 'MAX_RANDOM_SELECT_FEATURED_PRODUCTS', 43, 'Anzahl der zuf�llig angezeigten empfohlenen Artikel in der Box "Empfohlene Artikel"', now(), now()),
('Sonderangebote auf der Startseite', 'MAX_DISPLAY_SPECIAL_PRODUCTS_INDEX', 43, 'Wieviele Sonderangebote sollen auf der Startseite angezeigt werden?', now(), now()),
('Liste "Neue Artikel" - Limitieren auf...', 'SHOW_NEW_PRODUCTS_LIMIT', 43, 'Limitiert die Liste der neuen Artikel auf<br />0= Alle absteigend<br />1= Aktueller Monat<br />30= Die letzten 30 Tage<br />60= Die letzten 60 Tage<br />90= Die letzten 90 Tage<br />120= Die letzten 120 Tage', now(), now()),
('Liste "Alle Artikel": Artikel pro Seite', 'MAX_DISPLAY_PRODUCTS_ALL', 43, 'Wieviele Artikel sollen pro Seite in dieser Liste angezeigt werden?', now(), now()),
('Box "Sprachen": Landesflaggen pro Zeile', 'MAX_LANGUAGE_FLAGS_COLUMNS', 43, 'Wieviele Landesflaggen sollen maximal pro Zeile angezeigt werden?', now(), now()),
('Gr��e f�r Datei-Upload', 'MAX_FILE_UPLOAD_SIZE', 43, 'Wie lautet die maximale Gr��e einer Datei, die hochgeladen werden kann?<br />Standard= 2048000 (2MB)', now(), now()),
('Erlaubte Dateierweiterungen f�r Datei-Upload', 'UPLOAD_FILENAME_EXTENSIONS', 43, 'Durch Komma getrennte Liste von Dateierweiterungen (ohne Punkt) welche f�r einen Datei-Upload zul�ssig sind. z.B. jpg,jpeg,gif,png,eps,cdr,ai,pdf,tif,tiff,bmp,zip', now(), now()),
('Max. Anzahl Bestellpositionen / Auftrag (Liste im Adminbereich)', 'MAX_DISPLAY_RESULTS_ORDERS_DETAILS_LISTING', 43, 'Max. Anzahl Bestellpositionen / Auftrag (Liste im Adminbereich)<br/>0= unbegrenzt', now(), now()),
('Max. Anzahl PayPal IPN Transaktionen pro Seite', 'MAX_DISPLAY_SEARCH_RESULTS_PAYPAL_IPN', 43, 'Max. Anzahl PayPal IPN Transaktionen pro Seite<br />Standard: 20', now(), now()),
('Max. Spaltenanzahl - Artikel zu Kategorien-Manager', 'MAX_DISPLAY_PRODUCTS_TO_CATEGORIES_COLUMNS', 43, 'Max. Spaltenanzahl - Artikel zu Kategorien-Manager<br/>3= default', now(), now()),
('Max. Anzahl EZ-Pages', 'MAX_DISPLAY_SEARCH_RESULTS_EZPAGE', 43, 'Maximale Anzahl EZ-Pages<br />20 = Default', now(), now()),

# Adminmen� ID 4
('Kleine Bilder: Breite', 'SMALL_IMAGE_WIDTH', 43, 'Die Breite (in Pixel) der kleinen Bilder', now(), now()),
('Kleine Bilder: H�he', 'SMALL_IMAGE_HEIGHT', 43, 'Die H�he (in Pixel) der kleinen Bilder', now(), now()),
('�berschriftsbild im Adminbereich: Breite', 'HEADING_IMAGE_WIDTH', 43, 'Die Breite (in Pixel) der Bilder in der �berschrift im Adminbereich<br>HINWEIS: Momentan regelt dieser Wert nur die Abst�nde zwischen den Eintr�gen im Adminbereich. Er kann aber auch dazu benutzt werden, eigene �berschriftsbilder im Adminbereich hinzuzuf�gen', now(), now()),
('�berschriftsbild im Adminbereich: H�he', 'HEADING_IMAGE_HEIGHT', 43, 'Die H�he (in Pixel) der Bilder in der �berschrift im Adminbereich<br>HINWEIS: Momentan regelt dieser Wert nur die Abst�nde zwischen den Eintr�gen im Adminbereich. Er kann aber auch dazu benutzt werden, eigene �berschriftsbilder im Adminbereich hinzuzuf�gen', now(), now()),
('Unterkategorien: Breite der Bilder', 'SUBCATEGORY_IMAGE_WIDTH', 43, 'Die Breite (in Pixel) der Bilder f�r die Unterkategorien', now(), now()),
('Unterkategorien: H�he der Bilder', 'SUBCATEGORY_IMAGE_HEIGHT', 43, 'Die H�he (in Pixel) der Bilder f�r die Unterkategorien', now(), now()),
('Bildgr��e berechnen', 'CONFIG_CALCULATE_IMAGE_SIZE', 43, 'Soll die Gr��e der Bilder berechnet werden?', now(), now()),
('Platzhalter f�r fehlende Bilder anzeigen', 'IMAGE_REQUIRED', 43, 'Sollen fehlende Bilder "angezeigt" werden? (Hilfreich in der Entwicklungsphase)', now(), now()),
('Warenkorb: Artikelbilder anzeigen', 'IMAGE_SHOPPING_CART_STATUS', 43, 'Sollen Artikelbilder im Warenkorb angezeigt werden?<br />0= nein<br />1= ja', now(), now()),
('Warenkorb: Breite der Artikelbilder', 'IMAGE_SHOPPING_CART_WIDTH', 43, 'Standard = 50', now(), now()),
('Warenkorb: H�he der Artikelbilder', 'IMAGE_SHOPPING_CART_HEIGHT', 43, 'Standard = 40', now(), now()),
('Kategorie: Bildbreite - Artikeldetails', 'CATEGORY_ICON_IMAGE_WIDTH', 43, 'Breite in Pixel f�r das Kategoriebild auf der Artikeldetailseite', now(), now()),
('Kategorie: Bildh�he - Artikeldetails', 'CATEGORY_ICON_IMAGE_HEIGHT', 43, 'H�he in Pixel f�r das Kategoriebild auf der Artikeldetailseite', now(), now()),
('Bild Kategorie mit Unterkategorien: Bildbreite', 'SUBCATEGORY_IMAGE_TOP_WIDTH', 43, 'Die Breite in Pixel<br />Dieses Bild wird beim Klicken auf eine Kategorie oben angezeigt, wenn diese Unterkategorien enth�lt', now(), now()),
('Bild Kategorie mit Unterkategorien: Bildh�he', 'SUBCATEGORY_IMAGE_TOP_HEIGHT', 43, 'Die H�he in Pixel<br />Dieses Bild wird beim Klicken auf eine Kategorie oben angezeigt, wenn diese Unterkategorien enth�lt', now(), now()),
('Artikelbeschreibung: Breite der Artikelbilder', 'MEDIUM_IMAGE_WIDTH', 43, 'Die Breite (in Pixel) der Artikelbilder in der Produktbeschreibung', now(), now()),
('Artikelbeschreibung: H�he der Artikelbilder', 'MEDIUM_IMAGE_HEIGHT', 43, 'Die H�he (in Pixel) der Artikelbilder in der Produktbeschreibung', now(), now()),
('Artikelbeschreibung: Suffix der Bildmedien', 'IMAGE_SUFFIX_MEDIUM', 43, 'Dateizusatz f�r Bildmedien der zus�tzlichen Bilder in der Artikelbeschreibung<br />Standard = _MED', now(), now()),
('Artikelbeschreibung: Suffix der Bildmedien f�r gro�e Bilder', 'IMAGE_SUFFIX_LARGE', 43, 'Dateizusatz f�r Bildmedien der gro�en Bilder in der Artikelbeschreibung<br />Standard = _LRG', now(), now()),
('Artikelbeschreibung: Anzahl der zus�tzlichen Bilder pro Reihe', 'IMAGES_AUTO_ADDED', 43, 'Tragen Sie hier die Anzahl der pro Reihe anzuzeigenden zus�tzlichen Bilder ein<br />Standard = 3', now(), now()),
('Artikelliste: H�he der Artikelbilder', 'IMAGE_PRODUCT_LISTING_HEIGHT', 43, 'Standard = 80', now(), now()),
('Artikelliste: Breite der Artikelbilder', 'IMAGE_PRODUCT_LISTING_WIDTH', 43, 'Standard = 100', now(), now()),
('Liste "Neue Artikel": Breite der Artikelbilder in der Liste', 'IMAGE_PRODUCT_NEW_LISTING_WIDTH', 43, 'Standard = 100', now(), now()),
('Liste "Neue Artikel": H�he der Artikelbilder in der Liste', 'IMAGE_PRODUCT_NEW_LISTING_HEIGHT', 43, 'Standard = 80', now(), now()),
('Neue Artikel: Breite der Artikelbilder', 'IMAGE_PRODUCT_NEW_WIDTH', 43, 'Standard = 100', now(), now()),
('Neue Artikel: H�he der Artikelbilder', 'IMAGE_PRODUCT_NEW_HEIGHT', 43, 'Standard = 80', now(), now()),
('Liste "Empfohlene Artikel": Breite der Artikelbilder', 'IMAGE_FEATURED_PRODUCTS_LISTING_WIDTH', 43, 'Standard = 100', now(), now()),
('Liste "Empfohlene Artikel": H�he der Artikelbilder', 'IMAGE_FEATURED_PRODUCTS_LISTING_HEIGHT', 43, 'Standard = 80', now(), now()),
('Liste "Alle Artikel": Breite der Artikelbilder', 'IMAGE_PRODUCT_ALL_LISTING_WIDTH', 43, 'Standard = 100', now(), now()),
('Liste "Alle Artikel": H�he der Artikelbilder', 'IMAGE_PRODUCT_ALL_LISTING_HEIGHT', 43, 'Standard = 80', now(), now()),
('Artikelbild: Status automatisch auf "kein Bild vorhanden"', 'PRODUCTS_IMAGE_NO_IMAGE_STATUS', 43, 'Soll der Status bei Artikelbildern automatisch auf "kein Bild vorhanden" gesetzt werden, wenn kein Bild dem Artikel hinzugef�gt wurde? <br />0= nein<br />1= ja', now(), now()),
('Artikelbild: "Kein Bild vorhanden" Bild', 'PRODUCTS_IMAGE_NO_IMAGE', 43, 'Welches Bild soll als Eratzbild verwendet werden, wenn kein Bild dem Artikel hinzugef�gt wurde?<br />Standard = no_picture.gif', now(), now()),
('Proportionale Bilder f�r Artikel & Kategorien verwenden', 'PROPORTIONAL_IMAGES_STATUS', 43, 'Artikel und Kategoriebilder werden proportional verkleinert, falls die vorgegebenen Werte f�r H�he / Breite �berschritten werden. Anmerkung: Nicht verwenden wenn f�r H�he  bzw. Breite 0 verwendet wird.', now(), now()),

# Adminmen� ID 5
('Anrede', 'ACCOUNT_GENDER', 43, 'Auswahl der Anrede <br /> Diese wird bei Erstellung des Kundenkontos abgefragt und dann in allen E-Mails benutzt.<br /><br />Wenn diese Option auf FALSE gestellt wird, wird der Kunde stets mit Hallo VORNAME angesprochen.', now(), now()),
('Geburtsdatum', 'ACCOUNT_DOB', 43, 'Soll das Feld "Geburtsdatum" in der Kontoerstellung und in den Kontoinformationen angezeigt werden?', now(), now()),
('Firma', 'ACCOUNT_COMPANY', 43, 'Soll das Feld "Firma" in der Kontoerstellung und in den Kontoinformationen angezeigt werden?', now(), now()),
('Adresszeile 2', 'ACCOUNT_SUBURB', 43, 'Soll das Feld "Adresszeile 2" in der Kontoerstellung und in den Kontoinformationen angezeigt werden?', now(), now()),
('Bundesland', 'ACCOUNT_STATE', 43, 'Soll das Feld "Bundesland" in der Kontoerstellung und in den Kontoinformationen angezeigt werden?', now(), now()),
('Bundesl�nderliste - als Pulldownmen� anzeigen?', 'ACCOUNT_STATE_DRAW_INITIAL_DROPDOWN', 43, 'Soll die Eingabe des Bundeslandes durch eine Auswahlliste dargestellt werden?', now(), now()),
('Kontoerstellung: Standard - Land', 'SHOW_CREATE_ACCOUNT_DEFAULT_COUNTRY', 43, 'Dieses Land als Standard in der Kontoerstellung anzeigen:<br />', now(), now()),
('Faxnummer', 'ACCOUNT_FAX_NUMBER', 43, 'Soll das Feld "Faxnummer" in der Kontoerstellung und in den Kontoinformationen angezeigt werden?', now(), now()),
('Checkbox f�r Newsletter anzeigen', 'ACCOUNT_NEWSLETTER_STATUS', 43, 'Soll die Checkbox f�r Newsletter angezeigt werden?<br />0= nein<br />1= unmarkiert anzeigen<br />2= markiert anzeigen<br /><strong>HINWEIS: In einigen L�ndern steht die Standardanzeige auf "markiert" im Konflikt mit den gesetzlichen Bestimmungen</strong>', now(), now()),
('E-Mail an Kunden im HTML Format senden', 'ACCOUNT_EMAIL_PREFERENCE', 43, 'Standard Einstellung f�r E-Mails an Kunden<br/>0=Text<br/>1=HTML', now(), now()),
('Artikelbenachrichtigung nach Bestellung abfragen', 'CUSTOMERS_PRODUCTS_NOTIFICATION_STATUS', 43, 'Sollen Kunden nach ihrer Bestellung �ber Artikelbenachrichtigungen gefragt werden?<br />0= nie nachfragen<br />1= Immer nachfragen, au�er wenn die Abfrage Global gesetzt wurde<br /><br />HINWEIS: Die Sidebox muss separat ausgeschaltet werden', now(), now()),
('Kunden Shopstatus - Ansicht Shop und Preise', 'CUSTOMERS_APPROVAL', 43, 'Ben�tigen Kunden eine Berechtigung, um im Shop einkaufen zu k�nnen?<br />0= Nein - normaler Shop<br />1= Artikelansicht erst nach Anmeldung<br />2= Artikelansicht ohne Preise, Preise werden erst nach Anmeldung sichtbar<br />3= Nur Showroom (Generell keine Preise sichtbar)<br /><br />Die Option 2 ist empfohlen, wenn Kunden Preise erst nach Anmeldung sehen sollen, aber der Zugriff f�r Webcrawler zugelassen werden soll.', now(), now()),
('Kunden Freigabestatus -  auf Freigabe warten', 'CUSTOMERS_APPROVAL_AUTHORIZATION', 43, 'Ben�tigen Kunden eine gesonderte Freigabe, um im Shop einkaufen zu k�nnen?<br />0= Nein (normaler Shop)<br />1= Artikelansicht erst nach Freigabe<br />2= Artikelansicht ohne Preise, Preise werden erst nach Freigabe sichtbar<br />3= Artikelansicht mit Preise, einkaufen erst nach Freigabe<br /><br />Die Option 2 oder 3 ist empfohlen, wenn der Zugriff f�r Webcrawler zugelassen werden soll.', now(), now()),
('Kunden Autorisierung: Dateiname', 'CUSTOMERS_AUTHORIZATION_FILENAME', 43, 'Der Dateinamen der Kunden Autorisierung<br />HINWEIS: Angabe bitte OHNE Dateierweiterung<br />Standard=customers_authorization', now(), now()),
('Kunden Autorisierung: �berschrift ausblenden', 'CUSTOMERS_AUTHORIZATION_HEADER_OFF', 43, 'Kunden Autorisierung: �berschrift ausblenden <br />(true= ausblenden<br />false= anzeigen)', now(), now()),
('Kunden Autorisierung: linke Spalte ausblenden', 'CUSTOMERS_AUTHORIZATION_COLUMN_LEFT_OFF', 43, 'Kunden Autorisierung: linke Spalte ausblenden <br />(true= ausblenden<br />false= anzeigen)', now(), now()),
('Kunden Autorisierung: rechte Spalte ausblenden', 'CUSTOMERS_AUTHORIZATION_COLUMN_RIGHT_OFF', 43, 'Kunden Autorisierung: rechte Spalte ausblenden <br />(true= ausblenden<br />false= anzeigen)', now(), now()),
('Kunden Autorisierung: Fu�zeile ausblenden', 'CUSTOMERS_AUTHORIZATION_FOOTER_OFF', 43, 'Kunden Autorisierung: Fu�zeile ausblenden<br />(true= ausblenden<br />false= anzeigen)', now(), now()),
('Kunden Autorisierung: Preise ausblenden', 'CUSTOMERS_AUTHORIZATION_PRICES_OFF', 43, 'Kunden Autorisierung: Preise ausblenden <br />(true= ausblenden<br />false= anzeigen)', now(), now()),
('Kundenempfehlung', 'CUSTOMERS_REFERRAL_STATUS', 43, 'Kunden Referer - Status<br /><br />0= AUS - Kundenempfehlung deaktiviert<br />1= Durch die erste Verwendung eines Aktionskupons<br />2= Kunde kann w�hrend der Erstellung des Kundenkontos die Empfehlung eintragen, falls diese leer ist<br /><br />HINWEIS: Wurde die Kundenempfehlung einmal erstellt, kann diese nur noch im Adminbereich ge�ndert werden', now(), now()),

# Adminmen� ID 6 - Wird nicht im Adminbereich angezeigt, dient meist f�r die Module
('Installierte Zahlungsmodule', 'MODULE_PAYMENT_INSTALLED', 43, 'Eine Liste der installierten Zahlungsmodule, durch Semicolon getrennt. Die Liste wird automatisch aktualisiert und muss nicht editiert werden. (Beispiel: cc.php;cod.php;paypal.php)', now(), now()),
('Installierte Bestellmodule', 'MODULE_ORDER_TOTAL_INSTALLED', 43, 'Eine Liste der installierten Bestellmodule, durch Semicolon getrennt. Die Liste wird automatisch aktualisiert und muss nicht editiert werden. (Beispiel: ot_subtotal.php;ot_tax.php;ot_shipping.php;ot_total.php)', now(), now()),
('Installierte Versandmodule', 'MODULE_SHIPPING_INSTALLED', 43, 'Eine Liste der installierten Versandmodule, durch Semikolon getrennt. Die Liste wird automatisch aktualisiert und muss nicht editiert werden. (Beispiel: ups.php;flat.php;item.php)', now(), now()),
('Versandkostenfreie Lieferung aktivieren', 'MODULE_SHIPPING_FREESHIPPER_STATUS', 43, 'Bieten Sie einen versandkostenfreien Versand an?', now(), now()),
('Versandkosten', 'MODULE_SHIPPING_FREESHIPPER_COST', 43, 'Welche Versandkosten fallen an?', now(), now()),
('Bearbeitungsgeb�hr', 'MODULE_SHIPPING_FREESHIPPER_HANDLING', 43, 'Bearbeitungsgeb�hr f�r diese Versandart:', now(), now()),
('Steuerklasse', 'MODULE_SHIPPING_FREESHIPPER_TAX_CLASS', 43, 'Welche Steuerklasse soll bei dieser Versandart angewendet werden?', now(), now()),
('Versandzone', 'MODULE_SHIPPING_FREESHIPPER_ZONE', 43, 'F�r welche L�nder soll diese Versandart angeboten werden?<br/>Die ausw�hlbaren Versandzonen entsprechen den angelegten Steuerzonen und den dort hinterlegten L�ndern.', now(), now()),
('Sortierung', 'MODULE_SHIPPING_FREESHIPPER_SORT_ORDER', 43, 'Bestimmt die Sortierung der angezeigten Versandarten.', now(), now()),
('Selbstabholung aktivieren', 'MODULE_SHIPPING_STOREPICKUP_STATUS', 43, 'Bieten Sie eine Selbstabholung an?', now(), now()),
('Versandkosten', 'MODULE_SHIPPING_STOREPICKUP_COST', 43, 'Welche Versandkosten fallen an?', now(), now()),
('Steuerklasse', 'MODULE_SHIPPING_STOREPICKUP_TAX_CLASS', 43, 'Welche Steuerklasse soll bei dieser Versandart angewendet werden?', now(), now()),
('Basis der Steuern', 'MODULE_SHIPPING_STOREPICKUP_TAX_BASIS', 43, 'Auf welcher Basis sollen Steuern berechnet werden? M�gliche Optionen:<br />Versand (Shipping) - auf Basis der Versandadresse des Kunden<br />Rechnung (Billing) - auf Basis der Rechnungsadresse des Kunden<br />Shop (Store) - auf Basis der Shopadresse, wenn die Rechnungs-/Versandadresse des Kunden innerhalb der Zone der Shopadresse liegt', now(), now()),
('Versandzone', 'MODULE_SHIPPING_STOREPICKUP_ZONE', 43, 'F�r welche L�nder soll diese Versandart angeboten werden?<br/>Die ausw�hlbaren Versandzonen entsprechen den angelegten Steuerzonen und den dort hinterlegten L�ndern.', now(), now()),
('Sortierung', 'MODULE_SHIPPING_STOREPICKUP_SORT_ORDER', 43, 'Bestimmt die Sortierung der angezeigten Versandarten.', now(), now()),
('Versandkosten pro St�ck aktivieren', 'MODULE_SHIPPING_ITEM_STATUS', 43, 'Bieten Sie die Versandart Versandkosten pro St�ck an?', now(), now()),
('Versandkosten pro Artikel', 'MODULE_SHIPPING_ITEM_COST', 43, 'Die Versandkosten werden mit der Anzahl der Artikel in der Bestellung multipliziert.', now(), now()),
('Bearbeitungsgeb�hr', 'MODULE_SHIPPING_ITEM_HANDLING', 43, 'Bearbeitungsgeb�hr f�r diese Versandart:', now(), now()),
('Steuerklasse', 'MODULE_SHIPPING_ITEM_TAX_CLASS', 43, 'Welche Steuerklasse soll bei dieser Versandart angewendet werden?', now(), now()),
('Basis der Steuern', 'MODULE_SHIPPING_ITEM_TAX_BASIS', 43, 'Auf welcher Basis sollen Steuern berechnet werden? M�gliche Optionen:<br />Versand (Shipping) - auf Basis der Versandadresse des Kunden<br />Rechnung (Billing) - auf Basis der Rechnungsadresse des Kunden<br />Shop (Store) - auf Basis der Shopadresse, wenn die Rechnungs-/Versandadresse des Kunden innerhalb der Zone der Shopadresse liegt', now(), now()),
('Versandzone', 'MODULE_SHIPPING_ITEM_ZONE', 43, 'F�r welche L�nder soll diese Versandart angeboten werden?<br/>Die ausw�hlbaren Versandzonen entsprechen den angelegten Steuerzonen und den dort hinterlegten L�ndern.', now(), now()),
('Sortierung', 'MODULE_SHIPPING_ITEM_SORT_ORDER', 43, 'Bestimmt die Sortierung der angezeigten Versandarten.', now(), now()),
('Zahlungsart "Gratis" aktivieren', 'MODULE_PAYMENT_FREECHARGER_STATUS', 43, 'Wollen Sie die Zahlungsart "Gratis" anbieten?', now(), now()),
('Sortierung', 'MODULE_PAYMENT_FREECHARGER_SORT_ORDER', 43, 'Bestimmt die Sortierung der angezeigten Zahlungsarten.', now(), now()),
('Zahlungszone', 'MODULE_PAYMENT_FREECHARGER_ZONE', 43, 'F�r welche L�nder soll diese Zahlungsart angeboten werden?<br/>Die ausw�hlbaren Zahlungszonen entsprechen den angelegten Steuerzonen und den dort hinterlegten L�ndern.', now(), now()),
('Bestellstatus', 'MODULE_PAYMENT_FREECHARGER_ORDER_STATUS_ID', 43, 'Legt den Bestellstatus f�r diese Zahlungsart fest.', now(), now()),
('Vorkasse/�berweisung aktivieren', 'MODULE_PAYMENT_EUTRANSFER_STATUS', 43, 'Akzeptieren Sie Zahlungen per Vorkasse/�berweisung?', now(), now()),
('Bank Name:', 'MODULE_PAYMENT_EUTRANSFER_BANKNAM', 43, 'Tragen Sie hier den Namen Ihrer Bank ein.', now(), now()),
('Kontoinhaber:', 'MODULE_PAYMENT_EUTRANSFER_ACCNAM', 43, 'Tragen Sie hier den Namen des Kontoinhabers ein.', now(), now()),
('Kontonummer:', 'MODULE_PAYMENT_EUTRANSFER_ACCNUM', 43, 'Tragen Sie hier Ihre Kontonummer ein.', now(), now()),
('Bankleitzahl:', 'MODULE_PAYMENT_EUTRANSFER_BLZ', 43, 'Tragen Sie hier die Bankleitzahl ein.', now(), now()),
('IBAN:', 'MODULE_PAYMENT_EUTRANSFER_ACCIBAN', 43, 'Tragen Sie hier Ihre IBAN ein.', now(), now()),
('BIC/SWIFT:', 'MODULE_PAYMENT_EUTRANSFER_BANKBIC', 43, 'Tragen Sie hier Ihren BIC/SWIFT Code ein.', now(), now()),
('Sortierung', 'MODULE_PAYMENT_EUTRANSFER_SORT_ORDER', 43, 'Anzeigereigenfolge f�r dieses Modul. Der niedrigste Wert wird zuerst angezeigt.', now(), now()),
('Zahlungszone', 'MODULE_PAYMENT_EUTRANSFER_ZONE', 43, 'Wenn Sie hier eine Zone angeben, ist Bank�berweisung nur f�r Kunden mit Rechnungsadresse in dieser Zone m�glich. Es empfiehlt sich daf�r eine Zone anzulegen, die nur die L�nder mit EURO enth�lt.', now(), now()),
('Bestellstatus', 'MODULE_PAYMENT_EUTRANSFER_ORDER_STATUS_ID', 43, 'Welchen Bestellstatus sollen Bestellungen bekommen, die mit Bank�berweisung bezahlt werden?', now(), now()),
('L�nder', 'MODULE_PAYMENT_EUTRANSFER_COUNTRIES', 43, 'Geben Sie hier die L�nder an, f�r die Bank�berweisung m�glich sein soll. Es empfiehlt sich hier nur L�nder einzutragen, die den EURO haben, so dass eine EU-Standard�berweisung m�glich ist. Zweistellige ISO-Codes durch Komma getrennt!', now(), now()),
('Inklusive MwSt.', 'MODULE_ORDER_TOTAL_GROUP_PRICING_INC_TAX', 43, 'Der Rabattbetrag enth�lt die MwSt.', now(), now()),
('Gruppenerm��igung aktivieren', 'MODULE_ORDER_TOTAL_GROUP_PRICING_STATUS', 43, 'Bieten Sie eine Erm�i�ung f�r bestimmte Kundengruppen an?', now(), now()),
('Sortierung', 'MODULE_ORDER_TOTAL_GROUP_PRICING_SORT_ORDER', 43, 'Bestimmt die Sortierung in der Bestellzusammenfassung', now(), now()),
('Inklusive Versandkosten', 'MODULE_ORDER_TOTAL_GROUP_PRICING_INC_SHIPPING', 43, 'Die Gruppenerm��igung wird auf den Rechnungsbeitrag inkl. der Versandkosten gew�hrt?', now(), now()),
('MwSt. Betrag neu berechnen', 'MODULE_ORDER_TOTAL_GROUP_PRICING_CALC_TAX', 43, 'Soll der MwSt. Betrag neu berechnet werden?<br/> Dieses ist nur notwendig, wenn die Gruppenerm��igung inkl. MwSt. angezeigt werden soll', now(), now()),
('Steuerklasse', 'MODULE_ORDER_TOTAL_GROUP_PRICING_TAX_CLASS', 43, '!!!TRANSLATE!!! Use the following tax class when treating Group Discount as Credit Note.', now(), now()),
('Einheitliche Versandkosten aktivieren', 'MODULE_SHIPPING_FLAT_STATUS', 43, 'Wollen Sie "Einheitliche Versandkosten" aktivieren?', now(), now()),
('Einheitliche Versandkosten', 'MODULE_SHIPPING_FLAT_COST', 43, 'Die Versandkosten f�r alle Bestellungen, die mit dieser Versandmethode get�tigt werden.', now(), now()),
('Steuerklasse', 'MODULE_SHIPPING_FLAT_TAX_CLASS', 43, 'Folgende Steuerklasse f�r diese Versandmethode verwenden:', now(), now()),
('Basis der Steuern', 'MODULE_SHIPPING_FLAT_TAX_BASIS', 43, 'Auf welcher Basis sollen Steuern berechnet werden? M�gliche Optionen:<br />Versand (Shipping) - auf Basis der Versandadresse des Kunden<br />Rechnung (Billing) - auf Basis der Rechnungsadresse des Kunden<br />Shop (Store) - auf Basis der Shopadresse, wenn die Rechnungs-/Versandadresse des Kunden innerhalb der Zone der Shopadresse liegt', now(), now()),
('Versandzone', 'MODULE_SHIPPING_FLAT_ZONE', 43, 'Wenn eine Zone ausgew�hlt wird, ist diese Versandmethode nur f�r diese Zone aktiviert.', now(), now()),
('Reihenfolge der Anzeige:', 'MODULE_SHIPPING_FLAT_SORT_ORDER', 43, 'Legt die Reihenfolge der Anzeige fest (Der kleinste Wert wird als erstes gezeigt)', now(), now()),
('Standardw�hrung', 'DEFAULT_CURRENCY', 43, 'Standardw�hrung', now(), now()),
('Standardsprache', 'DEFAULT_LANGUAGE', 43, 'Standardsprache', now(), now()),
('Bestellstatus f�r neue Bestellungen', 'DEFAULT_ORDERS_STATUS_ID', 43, 'Wenn eine neue Bestellungen get�tigt wird, ist dies der Status dem sie zugewiesen wird.', now(), now()),
('Admin configuration_key anzeigen', 'ADMIN_CONFIGURATION_KEY_ON', 43, 'Manuell auf Wert 1 wechseln um den configuration_key Namen in der Konfiguration anzuzeigen', now(), now()),

# Adminmen� ID 7
('Ursprungsland', 'SHIPPING_ORIGIN_COUNTRY', 43, 'W�hlen Sie das Land, von dem aus die Versandkosten berechnet werden sollen.', now(), now()),
('Postleitzahl', 'SHIPPING_ORIGIN_ZIP', 43, 'Geben Sie die Postleitzahl an, von dem aus die Versandkosten berechnet werden sollen.', now(), now()),
('Maximales Versandgewicht', 'SHIPPING_MAX_WEIGHT', 43, 'Paketdienste haben im Allgemeinen eine Grenze f�r das Maximagewicht eines Paketes.<br />Tragen Sie dieses Gewicht stellvertretend f�r alle ein.', now(), now()),
('Kleine bis mittlere Pakete: prozentuelle Gewichtszunahme', 'SHIPPING_BOX_WEIGHT', 43, 'Wie hoch ist die Gewichtszunahme bei einem typischen kleineren Paketes bis mittleren Paket?<br />Beispiel: 10% + 1kg 10:1<br />10% + 0kg 10:0<br />0% + 5kg 0:5<br />0% + 0kg 0:0', now(), now()),
('Gr��ere Pakete: prozentuelle Gewichtszunahme', 'SHIPPING_BOX_PADDING', 43, 'Wie hoch ist die Zunahme des Gewichtes bei einem typischen gr��eren Paket?<br />Beispiel: 10% + 1kg 10:1<br />10% + 0kg 10:0<br />0% + 5kg 0:5<br />0% + 0kg 0:0', now(), now()),
('Anzahl der Pakete und das Gewicht anzeigen', 'SHIPPING_BOX_WEIGHT_DISPLAY', 43, 'Soll die Anzahl der Pakete und das Gewicht angezeigt werden?<br /><br />0= nein<br />1= nur Anzahl der Pakete<br />2= nur das Gewicht<br />3= Anzahl der Pakete und das Gewicht', now(), now()),
('Einstellungen f�r Versandberechnung im Warenkorb anzeigen', 'SHOW_SHIPPING_ESTIMATOR_BUTTON', 43, '<br />0= AUS<br />1= Als Button im Warenkorb zeigen<br />2= Die voraussichtlichen Versandkosten werden unterhalb des Warenkorb angezeigt. Als Basis f�r die Berechnung wird die Hauptadresse des Kunden genommen.', now(), now()),
('Zeige Bestellkommentare auf der Admin Rechnung an', 'ORDER_COMMENTS_INVOICE', 43, 'Sollen Bestellkommentare auf der Admin Rechnung angezeigt werden?<br />0= AUS<br />1= Nur der erste Kommentar des Kunden<br />2= Alle Kommentare der Bestellung', now(), now()),
('Zeige Bestellkommentare auf dem Admin Lieferschein an', 'ORDER_COMMENTS_PACKING_SLIP', 43, 'Sollen Bestellkommentare auf dem Admin Lieferschein angezeigt werden?<br />0= AUS<br />1= Nur der erste Kommentar des Kunden<br />2= Alle Kommentare der Bestellung', now(), now()),
('Versandkostenfreier Versand wenn das Gesamtgewicht "0" ist', 'ORDER_WEIGHT_ZERO_STATUS', 43, 'Wenn in einer Bestellung das Gesamtgewicht "0" ist, soll die Bestellung als "versandkostenfrei" versendet werden?<br />0= nein<br />1= ja<br />HINWEIS: Wenn diese Option aktiviert ist, wird "versandkostenfrei" nur bei Artikel mit "0" Gewicht angezeigt.', now(), now()),

# Adminmen� ID 8
('Artikelbilder anzeigen', 'PRODUCT_LIST_IMAGE', 43, 'Wollen Sie Artikelbilder in der Artikelliste anzeigen?<br>0= wird nicht angezeigt, 1-7 Spaltennummer in der das Artikelbild angezeigt wird', now(), now()),
('Hersteller anzeigen', 'PRODUCT_LIST_MANUFACTURER', 43, 'Wollen Sie den Hersteller in der Artikelliste anzeigen?<br>0= wird nicht angezeigt, 1-7 Spaltennummer in der der Hersteller angezeigt wird', now(), now()),
('Artikelnummer anzeigen', 'PRODUCT_LIST_MODEL', 43, 'Wollen Sie Artikelnummern in der Artikelliste anzeigen?<br>0= wird nicht angezeigt, 1-7 Spaltennummer in der die Artikelnummer angezeigt wird', now(), now()),
('Artikelnamen anzeigen', 'PRODUCT_LIST_NAME', 43, 'Wollen Sie Artikelnamen in der Artikelliste anzeigen?<br>0= wird nicht angezeigt, 1-7 Spaltennummer in der der Artikelname angezeigt wird', now(), now()),
('Anzeigen von Preis/In den Warenkorb', 'PRODUCT_LIST_PRICE', 43, 'Wollen Sie den Preis und die Anzeige "In den Warenkorb" in der Artikelliste anzeigen?<br>0= wird nicht angezeigt, 1-7 Spaltennummer in der "Preis/in den Warenkorb" angezeigt wird', now(), now()),
('Artikelst�ckzahl anzeigen', 'PRODUCT_LIST_QUANTITY', 43, 'Wollen Sie die vorhandene Artikelst�ckzahl in der Artikelliste anzeigen?<br>0= wird nicht angezeigt, 1-7 Spaltennummer in der die verf�gbare Artikelst�ckzahl angezeigt wird', now(), now()),
('Artikelgewicht anzeigen', 'PRODUCT_LIST_WEIGHT', 43, 'Wollen Sie das Artikelgewicht in der Artikelliste anzeigen?<br>0= wird nicht angezeigt, 1-7 Spaltennummer in der das Artikelgewicht angezeigt wird', now(), now()),
('Preis/In den Warenkorb: Spaltenbreite', 'PRODUCTS_LIST_PRICE_WIDTH', 43, 'Definiert die Spaltenbreite von "Preis/In den Warenkorb"<br />Standard= 125', now(), now()),
('Kategorien-/Herstellerfilter anzeigen (0=nein; 1=ja)', 'PRODUCT_LIST_FILTER', 43, 'Wollen Sie den Filter f�r Kategorien-/Hersteller im Shop anzeigen?', now(), now()),
('"Vorheriger/N�chster" Navigation: Ansicht', 'PREV_NEXT_BAR_LOCATION', 43, 'Wo soll die "Vorheriger / N�chster" Navigation angezeigt werden?<br />(1= oben, 2= unten, 3= oben und unten)', now(), now()),
('Standardsortierung', 'PRODUCT_LISTING_DEFAULT_SORT_ORDER', 43, 'Standard Sortierung f�r Artikellisten<br />HINWEIS: F�r eine Sortierung nach Artikel bitte leer lassen.<br />Sortiert die Artikelliste in der gew�nschten Reihenfolge mit der Sie beginnen m�chten.<br>Wenn Sie z.B. nach Artikelnummer sortieren wollen, geben Sie die Nummer ein, die Sie oben bei Artikelnummer vergeben haben. Direkt dahinter geben Sie ein a f�r aufsteigende Sortierung oder ein d f�r absteigende Sortierung ein', now(), now()),
('Button "In den Warenkorb" anzeigen (0=nein; 1=ja; 2=Ja mit St�ckzahlfeld pro Artikel)', 'PRODUCT_LIST_PRICE_BUY_NOW', 43, 'Wollen Sie den Button "In den Warenkorb" anzeigen?<br /><br /><strong>HINWEIS:</strong> Um die pro Artikel ein St�ckzahlfeld angezeigt zu bekommen (Auswahl 2), setzen Sie bitte die Einstellung "Button "Ausgew�hlte Artikel in den Warenkorb" anzeigen" auf 0', now(), now()),
('Button "Ausgew�hlte Artikel in den Warenkorb" anzeigen', 'PRODUCT_LISTING_MULTIPLE_ADD_TO_CART', 43, 'Eingabefelder und Schaltfl�che anzeigen, um mehrere ausgew�hlte Artikel mit einem Klick in den Warenkorb zu �bernehmen?<br/><br/>0= NEIN<br/>1= Oben<br/>2= Unten<br/>3= Oben und Unten', now(), now()),
('Artikelbeschreibung anzeigen', 'PRODUCT_LIST_DESCRIPTION', 43, 'Soll die Artikelbeschreibung angezeigt werden?<br/><br/>0= Aus<br/>oder z.B. 150 = es werden die ersten 150 Zeichen der Artikelbeschreibung angezeigt', now(), now()),
('Zeichen f�r absteigende Sortierung', 'PRODUCT_LIST_SORT_ORDER_DESCENDING', 43, 'Welches Zeichen soll eine ansteigende Sortierung anzeigen?<br />Default = -', now(), now()),
('Zeichen f�r aufsteigende Sortierung', 'PRODUCT_LIST_SORT_ORDER_ASCENDING', 43, 'Welches Zeichen soll eine aufsteigende Sortierung anzeigen?<br />Default = +', now(), now()),
('Artikelfilter f�r Artikelnamen nach Alphabet anzeigen', 'PRODUCT_LIST_ALPHA_SORTER', 43, 'Soll der Filter f�r Artikel nach Alphabet in der Artikelliste angezeigt werden?', now(), now()),
('Bild f�r Unterkategorien anzeigen', 'PRODUCT_LIST_CATEGORIES_IMAGE_STATUS', 43, 'Wollen Sie die Bilder der Unterkategorien in der Artikelliste anzeigen?', now(), now()),
('Bild f�r ausgew�hlte Kategorie anzeigen', 'PRODUCT_LIST_CATEGORIES_IMAGE_STATUS_TOP', 43, 'Wollen Sie das Bild f�r die aktuell ausgew�hlte Kategorie oben in der Artikelliste anzeigen?', now(), now()),
('Unterkategorien anzeigen', 'PRODUCT_LIST_CATEGORY_ROW_STATUS', 43, 'Sollen die Unterkategorien in der Artikelliste beim Klick auf die Hauptkategorie angezeigt werden?<br /><br />0= Nein<br />1= Ja', now(), now()),

# Adminmen� ID 9
('Lagerbestand pr�fen', 'STOCK_CHECK', 43, '�berpr�fen, ob der bestellte Artikel auch lagernd ist', now(), now()),
('Bestellungen vom Lagerbestand abziehen', 'STOCK_LIMITED', 43, 'Sollen bestellte Artikel vom Lagerbestand abgezogen werden?', now(), now()),
('Bestellung erlauben, wenn Lagerbestand unterschritten wird', 'STOCK_ALLOW_CHECKOUT', 43, 'Soll Kunden bei Unterschreitung des Lagerbestandes eine Bestellung erm�glicht werden?', now(), now()),
('Markierung f�r nicht lagernde Artikel', 'STOCK_MARK_PRODUCT_OUT_OF_STOCK', 43, 'Nicht lagernde Artikel werden bei der Bestellung markiert mit diesen Zeichen markiert<br>Standard: ***', now(), now()),
('Lagermindestbestand f�r Nachbestellungen', 'STOCK_REORDER_LEVEL', 43, 'Legen Sie hier fest, ab welcher Lagermenge ein Artikel nachbestellt werden muss<br>HINWEIS: Diese Einstellung gilt f�r alle Artikel, es kann keine Unterscheidung pro Artikel vorgenommen werden.', now(), now()),
('Artikel im Shop anzeigen, wenn nicht lagernd', 'SHOW_PRODUCTS_SOLD_OUT', 43, 'Sollen Artikel im Shop angezeigt werden, wenn sie nicht lagernd sind<br /><br />0= Nein - Artikelstatus auf AUS<br />1= Ja, Artikelstatus auf EIN', now(), now()),
('Artikel ist ausverkauft: Bild "Ausverkauft" anstelle von "in den Warenkorb" anzeigen', 'SHOW_PRODUCTS_SOLD_OUT_IMAGE', 43, 'Zeige f�r ausverkaufte Artikel das Bild "Ausverkauft" anstelle von "in den Warenkorb"<br /><br />0= nein<br />1= ja', now(), now()),
('Dezimalstellen der Artikelst�ckzahlen', 'QUANTITY_DECIMALS', 43, 'Wieviele Dezimalstellen sollen in der Artikelst�ckzahl angezeigt werden?<br /><br />0= keine', now(), now()),
('Warenkorb: Checkboxen und/oder Buttons zum L�schen anzeigen', 'SHOW_SHOPPING_CART_DELETE', 43, 'Zeigt im Warenkorb Buttons und/oder Checkboxen zum L�schen von Artikel an<br /><br />1= Nur Buttons<br />2= Nur Checkboxen<br />3= Buttons und Checkboxen', now(), now()),
('Warenkorb: Aktualisieren Schaltfl�che anzeigen', 'SHOW_SHOPPING_CART_UPDATE', 43, 'Wo soll die Aktualisieren Schaltfl�che im Warenkorb angezeigt werden?<br/><br/>1= Neben jedem Mengeneingabefeld<br/>2= Einmal unterhalb des Warenkorbes<br/>3= Neben jedem Mengeneingabefeld und unterhalb des Warenkorbes', now(), now()),
('Leerer Warenkorb: "Neue Artikel" anzeigen', 'SHOW_SHOPPING_CART_EMPTY_NEW_PRODUCTS', 43, 'Sollen "Neue Artikel" in der Ansicht "leerer Warenkorb" angezeigt werden?<br />0= Nein (oder Sortierung einstellen)', now(), now()),
('Leerer Warenkorb: "Empfohlene Artikel" anzeigen', 'SHOW_SHOPPING_CART_EMPTY_FEATURED_PRODUCTS', 43, 'Sollen "Empfohlene Artikel" in der Ansicht "leerer Warenkorb" angezeigt werden?<br />0= Nein (oder Sortierung einstellen)', now(), now()),
('Leerer Warenkorb: "Monatliche Sonderangebote" anzeigen', 'SHOW_SHOPPING_CART_EMPTY_SPECIALS_PRODUCTS', 43, 'Sollen "Monatliche Sonderangebote" in der Ansicht "leerer Warenkorb" angezeigt werden?<br />0= Nein (oder Sortierung einstellen)', now(), now()),
('Leerer Warenkorb: "Artikelank�ndigungen" anzeigen', 'SHOW_SHOPPING_CART_EMPTY_UPCOMING', 43, 'Sollen "Artikelank�ndigungen" in der Ansicht "leerer Warenkorb" angezeigt werden?<br />0= Nein (oder Sortierung einstellen)', now(), now()),
('Zeige Hinweis beim Login �ber den zusammengelegten Warenkorb an', 'SHOW_SHOPPING_CART_COMBINED', 43, 'Sobald ein Kunde sich anmeldet und von der letzten Anmeldung noch Artikel im Warenkorb hat, werden die aktuell im Warenkorb vorhandenen Artikel mit dem Warenkorb der letzten Anmeldung kombiniert.<br /><br />Soll der Kunde auf diesen Vorgang hingewiesen werden?<br /><br />0= NEIN, zeige keinen Hinweis an<br />1= JA, und gehe automatisch zum Warenkorb<br />2= JA, aber gehe nicht automatisch zum Warenkorb', now(), now()),

# Adminmen� ID 10
('Speichern der Zeit f�r Seitenaufbau', 'STORE_PAGE_PARSE_TIME', 43, 'Sollen die Zeiten f�r den Seitenaufbau einer Seite gespeichert werden?', now(), now()),
('Protokolldatei f�r Seitenaufbau: Speicherort', 'STORE_PAGE_PARSE_TIME_LOG', 43, 'Verzeichnis und Dateiname der Protokolldatei f�r Seitenaufbau', now(), now()),
('Protokolldatei f�r Seitenaufbau: Datumsformat', 'STORE_PARSE_DATE_TIME_FORMAT', 43, 'Datumsformat f�r die Protokolldatei', now(), now()),
('Zeit f�r Seitenaufbau im Shop anzeigen', 'DISPLAY_PAGE_PARSE_TIME', 43, 'Soll die Zeit f�r den Seitenaufbau im Shop unten angezeigt werden?<br />HINWEIS: Es ist nicht notwendig, die Protokolldatei f�r Seitenaufbau zu speichern, um sie im Shop anzeigen zu lassen.', now(), now()),
('Datenbankabfragen in Protokolldatei speichern', 'STORE_DB_TRANSACTIONS', 43, 'Sollen Datenbankabfragen in der Protokolldatei f�r Seitenabfragen gespeichert werden?<br />HINWEIS: Nur ab PHP 4 m�glich', now(), now()),

# Adminmen� ID 12
('E-Mail Transportmethode', 'EMAIL_TRANSPORT', 43, 'Legt fest, ob dieser Server eine lokale Verbindung zu ''sendmail'' oder einen SMTP - Server �ber TCP/IP Verbindung verwendet.<br />HINWEIS: F�r Server, die unter Windows oder MacOS betrieben werden, sollten Sie die Einstellung ''SMTP'' verwenden.', now(), now()),
('SMTP E-Mail - Mailbox Benutzer', 'EMAIL_SMTPAUTH_MAILBOX', 43, 'Wenn Sie f�r den Versand von E-Mails SMTP Authentifizierung verwenden m�ssen, dann geben Sie hier den Namen Ihres SMTP Benutzerkontos ein z.B. ich@domain.com ', now(), now()),
('SMTP E-Mail - Mailbox Passwort', 'EMAIL_SMTPAUTH_PASSWORD', 43, 'Passwort f� SMTP Authentifizierung', now(), now()),
('SMTP E-Mail - Mailserver Name', 'EMAIL_SMTPAUTH_MAIL_SERVER', 43, 'SMTP Mailserver f�r Authentifizierung z.B. smtp.domain.com', now(), now()),
('SMTP E-Mail - Mailserver Port', 'EMAIL_SMTPAUTH_MAIL_SERVER_PORT', 43, 'SMTP Mailserver Port', now(), now()),
('W�hrungssymbole f�r Text-Emails', 'CURRENCIES_TRANSLATIONS', 43, 'Welche W�hrungssymbole sollen f�r Text-Emails konvertiert werden?<br />Default = &pound;,�:&euro;,�', now(), now()),
('E-Mail Zeilenvorschub', 'EMAIL_LINEFEED', 43, 'Legen Sie hier die Zeichen fest, die Sie zur Trennung des E-Mail Headers verwenden wollen.', now(), now()),
('E-Mail als MIME HTML versenden', 'EMAIL_USE_HTML', 43, 'Wollen Sie e-Mails im HTML Format versenden?', now(), now()),
('E-Mail durch DNS-Server verifizieren', 'ENTRY_EMAIL_ADDRESS_CHECK', 43, 'Soll die G�ltigkeit von e-Mails durch DNS-Server verifiziert werden?', now(), now()),
('E-Mail senden', 'SEND_EMAILS', 43, 'E-Mails senden', now(), now()),
('E-Mail Archivierung aktiviert', 'EMAIL_ARCHIVE', 43, 'Wenn Sie E-Mail, die versendet werden, archivieren wollen, setzen Sie desen Wert auf "true".', now(), now()),
('E-Mail Fehlermeldungen', 'EMAIL_FRIENDLY_ERRORS', 43, 'Gibt lesbare Fehlermeldungen aus falls der E-Mail Versand scheitert (true). Bei (false) werden auch PHP Fehler angezeigt . Diese Einstellung ist nur f�r die Fehlersuche gedacht!', now(), now()),
('E-Mail Adresse (Kontaktadresse)', 'STORE_OWNER_EMAIL_ADDRESS', 43, 'Die E-Mail Adresse des Shopbetreibers / der Kontaktperson.', now(), now()),
('E-Mail Absender', 'EMAIL_FROM', 43, 'Die Absenderadresse, mit der E-Mails versendet werden sollen.', now(), now()),
('E-Mail Absenderdomain verwenden?', 'EMAIL_SEND_MUST_BE_STORE', 43, 'Alle vom Mailserver verschickten E-Mails m�ssen eine Absenderadresse "FROM" haben?<br /><br />Dies wird oft verwendet um das verschicken von SPAM mails zu verhindern. Bei JA wird der Wert der Einstellung "E-Mail Absender" als "FROM" Adresse f�r alle ausgehenden Mails verwendet.', now(), now()),
('E-Mail an Admin: Format', 'ADMIN_EXTRA_EMAIL_FORMAT', 43, 'W�hlen Sie das Format f�r e-Mails, die zus�tzlich an den Administrator versendet werden', now(), now()),
('E-Mail Kopie bei Bestellungen versenden', 'SEND_EXTRA_ORDER_EMAILS_TO', 43, 'Versendet zus�tzlich ein E-Mail bei Bestellungen an die unten angegebene(n) Adresse(n).<br />Die Adressen m�ssen in diesem Format eingegeben werden: Name 1 &lt;email@adresse1&gt;, Name 2 &lt;email@adresse2&gt;', now(), now()),
('"Neues Konto erstellt": Benachrichtigung versenden', 'SEND_EXTRA_CREATE_ACCOUNT_EMAILS_TO_STATUS', 43, 'Benachrichtigung versenden, wenn ein neues Konto erstellt wurde?<br />0= nein<br />1= ja', now(), now()),
('"Neues Konto erstellt": Kopie an diese E-Mail Adresse(n) versenden', 'SEND_EXTRA_CREATE_ACCOUNT_EMAILS_TO', 43, 'Eine Kopie an diese E-Mail Adresse(n) versenden, wenn ein neues Konto erstellt wurde?<br />Die Adressen m�ssen in diesem Format eingegeben werden: Name 1 &lt;email@adresse1&gt;, Name 2 &lt;email@adresse2&gt;', now(), now()),
('"An einen Freund empfehlen": Benachrichtigung senden', 'SEND_EXTRA_TELL_A_FRIEND_EMAILS_TO_STATUS', 43, '"An einen Freund empfehlen": Benachrichtigung senden<br />0= nein<br />1= ja', now(), now()),
('"An einen Freund empfehlen": Kopie an diese E-Mail Adresse(n) versenden', 'SEND_EXTRA_TELL_A_FRIEND_EMAILS_TO', 43, 'Eine Kopie bei "An einen Freund empfehlen" an diese E-Mail Adresse(n) versenden.<br />Die Adressen m�ssen in diesem Format eingegeben werden: Name 1 &lt;email@adresse1&gt;, Name 2 &lt;email@adresse2&gt;', now(), now()),
('"Gutschein versendet": Benachrichtigung versenden', 'SEND_EXTRA_GV_CUSTOMER_EMAILS_TO_STATUS', 43, '"Gutschein versendet": Benachrichtigung versenden<br />0= nein<br />1= ja', now(), now()),
('"Gutschein versendet": Kopie an diese E-Mail Adresse(n) versenden', 'SEND_EXTRA_GV_CUSTOMER_EMAILS_TO', 43, 'Eine Kopie bei "Gutschein versendet" an diese E-Mail Adresse(n) versenden.<br />Die Adressen m�ssen in diesem Format eingegeben werden: Name 1 &lt;email@adresse1&gt;, Name 2 &lt;email@adresse2&gt;', now(), now()),
('"Admin Gutschein versendet": Benachrichtigung versenden', 'SEND_EXTRA_GV_ADMIN_EMAILS_TO_STATUS', 43, '"Admin Gutschein versendet": Benachrichtigung versenden<br />0= nein<br />1= ja', now(), now()),
('"Admin Gutschein versendet": Kopie an diese E-Mail Adresse(n) versenden', 'SEND_EXTRA_GV_ADMIN_EMAILS_TO', 43, 'Eine Kopie bei "Admin Gutschein versendet" an diese E-Mail Adresse(n) versenden.<br />Die Adressen m�ssen in diesem Format eingegeben werden: Name 1 &lt;email@adresse1&gt;, Name 2 &lt;email@adresse2&gt;', now(), now()),
('"Admin Aktionskupon versendet": Benachrichtigung versenden', 'SEND_EXTRA_DISCOUNT_COUPON_ADMIN_EMAILS_TO_STATUS', 43, '"Admin Aktionskupon versendet": Benachrichtigung versenden<br />0= nein<br />1= ja', now(), now()),
('"Admin Aktionskupon versendet": Kopie an diese E-Mail Adresse(n) versenden', 'SEND_EXTRA_DISCOUNT_COUPON_ADMIN_EMAILS_TO', 43, 'Eine Kopie bei "Admin Aktionskupon versendet" an diese E-Mail Adresse(n) versenden.<br />Die Adressen m�ssen in diesem Format eingegeben werden: Name 1 &lt;email@adresse1&gt;, Name 2 &lt;email@adresse2&gt;', now(), now()),
('"Admin Bestellung": Benachrichtigung versenden', 'SEND_EXTRA_ORDERS_STATUS_ADMIN_EMAILS_TO_STATUS', 43, '"Admin Bestellung versendet": Benachrichtigung versenden<br />0= nein<br />1= ja', now(), now()),
('"Admin Bestellung": Kopie an diese E-Mail Adresse(n) versenden', 'SEND_EXTRA_ORDERS_STATUS_ADMIN_EMAILS_TO', 43, 'Eine Kopie bei "Admin Bestellung versendet" an diese E-Mail Adresse(n) versenden.<br />Die Adressen m�ssen in diesem Format eingegeben werden: Name 1 &lt;email@adresse1&gt;, Name 2 &lt;email@adresse2&gt;', now(), now()),
('"Kunden Bewertung" : Benachrichtigung versenden', 'SEND_EXTRA_REVIEW_NOTIFICATION_EMAILS_TO_STATUS', 43, '0= Nein<br/>1= Ja', now(), now()),
('"Kunden Bewertung" : Kopie an diese E-Mail Adresse(n) versenden', 'SEND_EXTRA_REVIEW_NOTIFICATION_EMAILS_TO', 43, 'Eine Kopie an diese E-Mail Adresse(n) versenden, wenn eine Bewertung abgegeben wurde?<br/>Die Adressen m�ssen in diesem Format eingegeben werden: Name 1 &lt;email@adresse1&gt;, Name 2 &lt;email@adresse2&gt;\r\n', now(), now()),
('E-Mail Adressen f�r die "Schreiben Sie uns" Dropdown Liste', 'CONTACT_US_LIST', 43, 'Geben Sie hier die f�r die "Schreiben Sie uns" E-Mail Dropdown Liste gew�nschte(n) E-Mail Adresse(n) ein.<br />Die Adressen m�ssen in diesem Format eingegeben werden: Name 1 &lt;email@adresse1&gt;, Name 2 &lt;email@adresse2&gt;', now(), now()),
('G�ste d�rfen "An einen Freund senden"', 'ALLOW_GUEST_TO_TELL_A_FRIEND', 43, 'G�ste d�rfen "An einen Freund senden"', now(), now()),
('"Schreiben Sie uns": Shopname und Adresse anzeigen', 'CONTACT_US_STORE_NAME_ADDRESS', 43, 'Shopname und Adresse im Formular "Schreiben Sie uns" anzeigen<br />0= nein<br />1= ja', now(), now()),
('"Lagermindestbestand unterschritten": Benachrichtigung versenden', 'SEND_LOWSTOCK_EMAIL', 43, 'Eine Benachrichtigung versenden, wenn der Lagermindestbestand erreicht oder unterschritten wurde?<br />0= nein<br />1= ja', now(), now()),
('"Lagermindestbestand unterschritten": an diese E-Mail Adresse(n) versenden', 'SEND_EXTRA_LOW_STOCK_EMAILS_TO', 43, 'Wenn der Lagermindestbestand erreicht oder unterschritten wurde, soll an diese E-Mail Adresse(n) eine Benachrichtigung versendet werden.<br />Die Adressen m�ssen in diesem Format eingegeben werden: Name 1 &lt;email@adresse1&gt;, Name 2 &lt;email@adresse2&gt;', now(), now()),
('Link "Newsletter abbestellen" anzeigen?', 'SHOW_NEWSLETTER_UNSUBSCRIBE_LINK', 43, 'Soll in der Info Box ein Link f�r "Newsletter abbestellen" angezeigt werden?', now(), now()),
('Empf�ngerliste -  Z�hleranzeige', 'AUDIENCE_SELECT_DISPLAY_COUNTS', 43, 'Wenn die Liste der verf�gbaren Empf�nger angezeigt wird, soll der Empf�ngerz�hler inkludiert werden? <br /><em>(HINWEIS: Es k�nnen Geschwindigkeitseinbu�en auftreten, wenn Sie viele Kunden oder komplexe Empf�ngerabfragen haben)</em>', now(), now()),

# Adminmen� ID 13
('Downloads aktivieren', 'DOWNLOAD_ENABLED', 43, 'Wollen Sie Download-Artikel aktivieren?.', now(), now()),
('Downloads �ber Weiterleitung', 'DOWNLOAD_BY_REDIRECT', 43, 'Wollen Sie Browser-Weiterleitung f�r Download-Artikel aktivieren? (Ist auf nicht-UNIX Systemen deaktiviert).<br /><br />HINWEIS: Setzten Sie /pub auf CHMOD 777 bei aktivierter Weiterleitung', now(), now()),
('Streaming Download', 'DOWNLOAD_IN_CHUNKS', 43, 'Wenn Download via redirect gesperrt ist und ihr PHP Speicherlimit < 8 MB ist, sollten Sie diese Einstellung verwenden, da die Daten in kleineren Bl�cken an den Browser �bermittelt werden.<br /><br />Hat keine Bedeutung wenn Download via Redirect freigegeben ist.', now(), now()),
('Ablaufdatum f�r Downloads (Anzahl in Tagen)', 'DOWNLOAD_MAX_DAYS', 43, 'Geben Sie hier die Anzahl der Tagen ein, f�r wie lange ein Download-Artikel g�ltig sein soll. (0= Unlimitiert)', now(), now()),
('Anzahl erlaubter Downloads - pro Artikel', 'DOWNLOAD_MAX_COUNT', 43, 'Geben Sie hier die maximale Anzahl der erlaubten Downloads pro Artikel ein. (0= Download nicht erlaubt)', now(), now()),
('Downloadmanager: Wert f�r Aktualisierungsstatus', 'DOWNLOADS_ORDERS_STATUS_UPDATED_VALUE', 43, 'Welcher Bestellstatus soll die Tage der G�ltigkeitsdauer und die maximal erlaubte Downloadanzahl f�r Download-Artikel zur�cksetzen? (Standard = 4)', now(), now()),
('Downloadmanager: Wert f�r Bestellstatus', 'DOWNLOADS_CONTROLLER_ORDERS_STATUS', 43, 'Nur wenn der Auftragsstatus gr��er/gleich dem eingegebenen Wert ist, k�nnen Download-Artikel heruntergeladen werden. Standard: 2', now(), now()),
('Max. Auftragsstatus f�r Download-Artikel', 'DOWNLOADS_CONTROLLER_ORDERS_STATUS_END', 43, 'Nur wenn der Auftragsstatus kleiner/gleich dem eingegebenen Wert ist, k�nnen Download-Artikel heruntergeladen werden. Standard: 4', now(), now()),
('Preis durch Attribute', 'ATTRIBUTES_ENABLED_PRICE_FACTOR', 43, 'Preise durch Attribute aktivieren?', now(), now()),
('Mengenrabatt aktivieren', 'ATTRIBUTES_ENABLED_QTY_PRICES', 43, 'Mengenrabatte erm�glichen?.', now(), now()),
('Attributbilder', 'ATTRIBUTES_ENABLED_IMAGES', 43, 'Attributbilder aktivieren?', now(), now()),
('Textpreise aktivieren (Wort oder Buchstabe)', 'ATTRIBUTES_ENABLED_TEXT_PRICES', 43, 'Soll das Attribut "Textpreis nach Wort oder Buchstabe" aktiviert werden?', now(), now()),
('Textpreise: Leerzeichen sind kostenlos', 'TEXT_SPACES_FREE', 43, 'Sind bei Textpreisen die Leerzeichen kostenlos?<br /><br />0= nein 1= ja', now(), now()),
('Artikel mit Read-Only Attributen - Hinzuf�gen zum Warenkorb', 'PRODUCTS_OPTIONS_TYPE_READONLY_IGNORED', 43, 'K�nnen Artikel mit nur Read-Only Attributen in den Warenkorb gelegt werden?<br/>0=NEIN<br/>1=JA', now(), now()),

# Adminmen� ID 14
('GZip Komprimierung aktivieren', 'GZIP_LEVEL', 43, '0= nein 1= ja', now(), now()),

# Adminmen� ID 15
('Verzeichnis f�r Sitzungen', 'SESSION_WRITE_DIRECTORY', 43, 'Wenn das Speichern von Sitzungen Dateibasierend ist, werden sie in dieses Verzeichnis gespeichert.', now(), now()),
('Cookies - Dom�nenname', 'SESSION_USE_FQDN', 43, 'Wenn f�r den Shop Cookies verwendet werden, ben�tigen Sie einen Dom�nennamen (z.B. www.meinedomain.at). Wenn nicht, wird nur ein teilweiser Dom�nenname ben�tigt (z.B. meinedomain.at) Wenn Sie sich nicht sicher sind, lassen Sie diese Option auf "true".', now(), now()),
('Cookies - Verwendung erzwingen', 'SESSION_FORCE_COOKIE_USE', 43, 'Die Verwendung von Cookies erzwingen.<br />HINWEIS: Wenn ein Kunde in den Browsereinstellungen die Verwendung von Cookies deaktiviert hat, kann dieser den Shop nicht verwenden..', now(), now()),
('�berpr�fung der SSL Sitzungs- ID', 'SESSION_CHECK_SSL_SESSION_ID', 43, '�berpr�ft die Sitzungs-ID bei jeder gesicherten HTTPS Seitenanfrage.', now(), now()),
('Browser des Kunden pr�fen', 'SESSION_CHECK_USER_AGENT', 43, '�berpr�ft den Browser des Kunden bei jeder Seitenanfrage.', now(), now()),
('IP Adresse �berpr�fen', 'SESSION_CHECK_IP_ADDRESS', 43, '�berpr�ft die IP Adresse des Benutzers bei jeder Seitenanfrage.', now(), now()),
('Spider Sitzungen verhindern', 'SESSION_BLOCK_SPIDERS', 43, 'Verhindert das Starten von Sitzungen bei bekannten Spidern.', now(), now()),
('Sitzungen wiederherstellen', 'SESSION_RECREATE', 43, 'Sollen Sitzungen wiederhergestellt werden, um eine neue Sitzungs-ID zu erstellen, wenn ein Kunde sich anmeldet oder ein neues Konto erstellt? (ben�tigt PHP >=4.1).', now(), now()),
('Umwandlung IP Adresse zu Hostname', 'SESSION_IP_TO_HOST_ADDRESS', 43, 'Soll die IP-Adresse auf einen Hostnamen umgewandelt werden?<br/><br/>Anmerkung: Auf manchen Systemen kann dies zu einem langsameren Session Start und E-Mailversand f�hren. ', now(), now()),

# Adminmen� ID 16
('L�nge der Aktionskupon-/Gutscheinnummer', 'SECURITY_CODE_LENGTH', 43, 'Tragen Sie hier die L�nge der Aktionskupon-/Gutscheinnummer ein<br />Tipp: Je l�nger um so sicherer.', now(), now()),
('Standard Auftragsstatus bei Bestellsumme 0', 'DEFAULT_ZERO_BALANCE_ORDERS_STATUS_ID', 43, 'Auftragsstatus der Bestellungen mit der Bestellsumme 0 zugewiesen werden soll', now(), now()),
('Neuregistrierung: Aktionskupon ID#', 'NEW_SIGNUP_DISCOUNT_COUPON', 43, 'W�hlen Sie einen Aktionskupon<br />(none= keine Aktiosnkupons bei Neuregistrierungen senden)', now(), now()),
('Neuregistrierung: Erm��igungsbetrag', 'NEW_SIGNUP_GIFT_VOUCHER_AMOUNT', 43, 'Bitte leer lassen, falls Sie keine "Willkommensgeschenke" in Form eines Aktionskupons an Neukunden versenden wollen,<br />oder geben Sie den Betrag an (z.B. 10 f�r &euro;10.00)', now(), now()),
('Max. Anzahl Gutscheine pro Seite', 'MAX_DISPLAY_SEARCH_RESULTS_DISCOUNT_COUPONS', 43, 'Max. Anzahl Gutscheine pro Seite', now(), now()),
('Max. Anzahl Gutscheine auf Reportseite', 'MAX_DISPLAY_SEARCH_RESULTS_DISCOUNT_COUPONS_REPORTS', 43, 'Max. Anzahl Gutscheine auf Reportseite', now(), now()),

# Adminmen� ID 17
('VISA', 'CC_ENABLED_VISA', 43, 'Wollen Sie Zahlungen mit VISA Kreditkarten akzeptieren (0= nein 1= ja)', now(), now()),
('MasterCard', 'CC_ENABLED_MC', 43, 'Wollen Sie Zahlungen mit MasterCard Kreditkarten akzeptieren (0= nein 1= ja)', now(), now()),
('AmericanExpress', 'CC_ENABLED_AMEX', 43, 'Wollen Sie Zahlungen mit AmericanExpress Kreditkarten akzeptieren (0= nein 1= ja)', now(), now()),
('Diners Club', 'CC_ENABLED_DINERS_CLUB', 43, 'Wollen Sie Zahlungen mit Diners Club Kreditkarten akzeptieren (0= nein 1= ja)', now(), now()),
('Discover Card', 'CC_ENABLED_DISCOVER', 43, 'Wollen Sie Zahlungen mit Discover Card Kreditkarten akzeptieren (0= nein 1= ja)', now(), now()),
('JCB', 'CC_ENABLED_JCB', 43, 'Wollen Sie Zahlungen mit JCB Kreditkarten akzeptieren (0= nein 1= ja)', now(), now()),
('AUSTRALIAN BANKCARD', 'CC_ENABLED_AUSTRALIAN_BANKCARD', 43, 'Wollen Sie Zahlungen mit AUSTRALIAN BANKCARD Kreditkarten akzeptieren (0= nein 1= ja)', now(), now()),
('SOLO', 'CC_ENABLED_SOLO', 43, 'Wollen Sie Zahlungen mit SOLO Kreditkarten akzeptieren (0= nein 1= ja)', now(), now()),
('Switch', 'CC_ENABLED_SWITCH', 43, 'Wollen Sie Zahlungen mit Switch Kreditkarten akzeptieren (0= nein 1= ja)', now(), now()),
('Maestro', 'CC_ENABLED_MAESTRO', 43, 'Wollen Sie Zahlungen mit Maestro Kreditkarten akzeptieren (0= nein 1= ja)', now(), now()),
('Akzeptierte Kreditkarten in der Seite f�r Bezahlung anzeigen', 'SHOW_ACCEPTED_CREDIT_CARDS', 43, 'Sollen die akzeptierten Kreditkarten in der Seite f�r die Bezahlung angezeigt werden?<br />0= nicht anzeigen<br />1= als Text anzeigen<br />2= als Bild anzeigen<br /><br />HINWEIS: Die Bilder und Texte m�ssen sowohl in der Datenbank als auch in den Sprachfiles f�r die jeweilige Kreditkarte definiert sein.', now(), now()),

# Adminmen� ID 6 - Wird nicht angezeigt, dient meist f�r die Module
('Dieses Modul ist installiert', 'MODULE_ORDER_TOTAL_GV_STATUS', 43, '', now(), now()),
('Sortierung', 'MODULE_ORDER_TOTAL_GV_SORT_ORDER', 43, 'Legt die Sortierung fest.', now(), now()),
('Warteschlange f�r Gutscheinbestellungen aktivieren', 'MODULE_ORDER_TOTAL_GV_QUEUE', 43, 'Wollen Sie die Warteschlange f�r Gutscheinbestellungen aktivieren?', now(), now()),
('Versandkosten im Gutschein inkludieren', 'MODULE_ORDER_TOTAL_GV_INC_SHIPPING', 43, 'Sollen die Versandkosten in die Berechnung inkludiert werden?', now(), now()),
('Gutscheine inklusive Steuern', 'MODULE_ORDER_TOTAL_GV_INC_TAX', 43, 'Sollen die Steuern in die Berechnung inkludiert werden?', now(), now()),
('Steuern neu berechnen', 'MODULE_ORDER_TOTAL_GV_CALC_TAX', 43, 'Steuern neu berechnen', now(), now()),
('Steuerklasse f�r Gutscheine', 'MODULE_ORDER_TOTAL_GV_TAX_CLASS', 43, 'Folgende Steuerklasse wird bei Gutscheinen und im Kreditguthaben verwendet:', now(), now()),
('Kreditguthaben inklusive Steuern', 'MODULE_ORDER_TOTAL_GV_CREDIT_TAX', 43, 'Sollen die Steuern bei bestellten Gutscheinen im Kreditguthaben inkludiert werden?', now(), now()),
('Bestellstatus', 'MODULE_ORDER_TOTAL_GV_ORDER_STATUS_ID', 43, 'Legt den Bestellstatus fest, wenn der komplette Auftrag mit einem Gutschein vollst�ndig bezahlt wurde.', now(), now()),

('Dieses Modul ist installiert', 'MODULE_ORDER_TOTAL_LOWORDERFEE_STATUS', 43, '', now(), now()),
('Sortierung', 'MODULE_ORDER_TOTAL_LOWORDERFEE_SORT_ORDER', 43, 'Sortierung der Anzeige', now(), now()),
('Geb�hr f�r Mindestbestellmenge', 'MODULE_ORDER_TOTAL_LOWORDERFEE_LOW_ORDER_FEE', 43, 'Wollen Sie einen Mindestbestellzuschlag aktivieren?', now(), now()),
('Geb�hr bei Unterschreitung der Mindestbestellmenge', 'MODULE_ORDER_TOTAL_LOWORDERFEE_ORDER_UNDER', 43, 'Wie hoch ist Geb�hr bei Unterschreitung der Mindestbestellmenge?', now(), now()),
('Geb�hr f�r Mindestbestellmenge - Betrag', 'MODULE_ORDER_TOTAL_LOWORDERFEE_FEE', 43, 'F�r eine prozentuelle Kalkulation f�gen Sie ein "%" Zeichen an. Beispiel: 10%<br />F�r eine pauschale Geb�hr geben Sie den Betrag an. Beispiel: 5 f�r &euro;5.00', now(), now()),
('Geb�hr f�r Mindestbestellmenge - nur bestimmte Bestellungen', 'MODULE_ORDER_TOTAL_LOWORDERFEE_DESTINATION', 43, 'Geb�hren f�r Mindestbestellmengen werden nur f�r Bestellungen angewendet, die zum hier eingestellten Ziel gesendet werden.', now(), now()),
('Geb�hr f�r Mindestbestellmenge - Steuerklasse', 'MODULE_ORDER_TOTAL_LOWORDERFEE_TAX_CLASS', 43, 'Folgende Steuerklasse bei Geb�hren f�r Mindestbestellmengen verwenden.', now(), now()),
('Virtuelle Artikel - keine Geb�hr f�r Mindestbestellmenge', 'MODULE_ORDER_TOTAL_LOWORDERFEE_VIRTUAL', 43, 'Soll bei Bestellungen, die nur virtuellen Artikel beinhalten, keine Geb�hr f�r Mindestbestellmenge gerechnet werden?', now(), now()),
('Geschenkgutscheine - keine Geb�hr f�r Mindestbestellmenge', 'MODULE_ORDER_TOTAL_LOWORDERFEE_GV', 43, 'Soll bei Bestellungen, die nur Geschenkgutscheine beinhalten, keine Geb�hr f�r Mindestbestellmenge gerechnet werden?', now(), now()),

('Dieses Modul ist installiert', 'MODULE_ORDER_TOTAL_SHIPPING_STATUS', 43, '', now(), now()),
('Sortierung', 'MODULE_ORDER_TOTAL_SHIPPING_SORT_ORDER', 43, 'Sortierung der Anzeige', now(), now()),
('Versandkostenfreie Lieferung erlauben', 'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING', 43, 'Wollen Sie Versandkostenfreie Lieferungen erlauben?', now(), now()),
('Versandkostenfreie Lieferung �ber', 'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING_OVER', 43, 'Versandkostenfreie Lieferung �ber dem hier eingegebenen Bestellwert.', now(), now()),
('Versandkostenfreie Lieferung f�r diese Bestellung erlauben', 'MODULE_ORDER_TOTAL_SHIPPING_DESTINATION', 43, 'Versandkostenfreie Lieferung f�r Bestellungen erlauben, die zum hier eingestellten Ziel gesendet werden.', now(), now()),
('Dieses Modul ist installiert', 'MODULE_ORDER_TOTAL_SUBTOTAL_STATUS', 43, '', now(), now()),
('Sortierung', 'MODULE_ORDER_TOTAL_SUBTOTAL_SORT_ORDER', 43, 'Sortierung der Anzeige', now(), now()),
('Dieses Modul ist installiert', 'MODULE_ORDER_TOTAL_TAX_STATUS', 43, '', now(), now()),
('Sortierung', 'MODULE_ORDER_TOTAL_TAX_SORT_ORDER', 43, 'Sortierung der Anzeige', now(), now()),
('Dieses Modul ist installiert', 'MODULE_ORDER_TOTAL_TOTAL_STATUS', 43, '', now(), now()),
('Sortierung', 'MODULE_ORDER_TOTAL_TOTAL_SORT_ORDER', 43, 'Sortierung der Anzeige', now(), now()),

('Steuerklasse f�r das Einl�sen von Aktionskupons', 'MODULE_ORDER_TOTAL_COUPON_TAX_CLASS', 43, 'Diese Steuerklasse beim Einl�sen von Aktionskupons verwenden', now(), now()),
('Inklusive Steuern', 'MODULE_ORDER_TOTAL_COUPON_INC_TAX', 43, 'Steuern in die Berechnung inkludieren', now(), now()),
('Sortierung', 'MODULE_ORDER_TOTAL_COUPON_SORT_ORDER', 43, 'Sortierung der Anzeige', now(), now()),
('Inklusive Versandkosten', 'MODULE_ORDER_TOTAL_COUPON_INC_SHIPPING', 43, 'Versandkosten in die Berechnung inkludieren', now(), now()),
('Dieses Modul ist installiert', 'MODULE_ORDER_TOTAL_COUPON_STATUS', 43, '', now(), now()),
('Steuern neu berechnen', 'MODULE_ORDER_TOTAL_COUPON_CALC_TAX', 43, 'Steuern neu berechnen', now(), now()),
('Admin Demostatus', 'ADMIN_DEMO', 43, 'Soll die Admin Demofunktion aktiviert werden?<br />0= nein 1= ja', now(), now()),

('Artikeloptionstyp: Auswahltyp', 'PRODUCTS_OPTIONS_TYPE_SELECT', 43, 'Die Zahl repr�sentiert den Auswahltyp der Artikeloptionen', now(), now()),
('Artikeloptionstyp: Text', 'PRODUCTS_OPTIONS_TYPE_TEXT', 43, 'Numerischer Wert des Textes des Artikeloptionstyps', now(), now()),
('Artikeloptionstyp: Radio Button', 'PRODUCTS_OPTIONS_TYPE_RADIO', 43, 'Numerischer Wert des Radio Buttons des Artikeloptionstyps', now(), now()),
('Artikeloptionstyp: Check Box', 'PRODUCTS_OPTIONS_TYPE_CHECKBOX', 43, 'Numerischer Wert der Check Box des Artikeloptionstyps', now(), now()),
('Artikeloptionstyp: Datei', 'PRODUCTS_OPTIONS_TYPE_FILE', 43, 'Numerischer Wert der Datei des Artikeloptionstyps', now(), now()),
('ID f�r Text und Datei des Artikeloption Wertes', 'PRODUCTS_OPTIONS_VALUES_TEXT_ID', 43, 'Numerischer Wert der Artikeloptionswert ID (products_options_values_id), die vom Text- und Dateiattribute verwendet wird', now(), now()),
('Upload Pr�fix', 'UPLOAD_PREFIX', 43, 'Pr�fix zu Unterscheidung zwischen Uploadoptionen und anderen Optionen', now(), now()),
('Text Pr�fix', 'TEXT_PREFIX', 43, 'Pr�fix zu Unterscheidung zwischen Textoptionen und anderen Optionen', now(), now()),
('Artikeloptionstyp: Nur lesen', 'PRODUCTS_OPTIONS_TYPE_READONLY', 43, 'Numerischer Wert des Status der Datei des Artikeloptionstyps', now(), now()),

# Adminmen� ID 18
('Artikelbeschreibung: Sortierung der Artikelattribute', 'PRODUCTS_OPTIONS_SORT_BY_PRICE', 43, 'Wie soll die Sortierung der Artikelattribute in der Artikelbeschreibung angezeigt werden?<br>0= Sortierung, Preis<br>1= Sortierung, Attributeigenschaften', now(), now()),
('Artikelbeschreibung: Sortierung der Artikeloptionen', 'PRODUCTS_OPTIONS_SORT_ORDER', 43, 'Wie soll die Sortierung der Artikeloptionen in der Artikelbeschreibung angezeigt werden?<br>0= Sortierung, Attributnamen<br>1= Attributnamen', now(), now()),
('Artikelbeschreibung: Namen des Attributmerkmales unter dem Attributbild anzeigen', 'PRODUCT_IMAGES_ATTRIBUTES_NAMES', 43, 'Soll der Name des Attributmerkmales unter dem Attributbild angezeigt werden?<br />0= nein 1= ja', now(), now()),
('Artikelbeschreibung: Anzeigen der Differenz der Preisreduktion ("sie sparen...")', 'SHOW_SALE_DISCOUNT_STATUS', 43, 'Soll die Differenz der Preisreduktion ("sie sparen...) angezeigt werden?<br />0= nein 1= ja', now(), now()),
('Artikelbeschreibung: Anzeige der Preisreduktion in W�hrung oder Prozent', 'SHOW_SALE_DISCOUNT', 43, 'Zeige den Preisreduktion an in:<br />1= %<br />2= Betrag', now(), now()),
('Artikelbeschreibung: Dezimalstellen bei Anzeige der Preisreduktion in Prozent', 'SHOW_SALE_DISCOUNT_DECIMALS', 43, 'Wieviel Dezimalstellen sollen bei Anzeige der Preisreduktion in Prozent dargestellt werden?<br />Standard= 0', now(), now()),
('Artikelbeschreibung: Kostenlose Artikel als Bild oder Text darstellen', 'OTHER_IMAGE_PRICE_IS_FREE_ON', 43, 'Soll "Artikel ist kostenlos" als Bild oder Text dargestellt werden?<br />0= Text<br />1= Bild', now(), now()),
('Artikelbeschreibung: "F�r Preis bitte anrufen" als Bild oder Text darstellen', 'PRODUCTS_PRICE_IS_CALL_IMAGE_ON', 43, 'Soll "F�r Preis bitte anrufen" als Bild oder Text dargestellt werden?<br />0= Text<br />1= Bild', now(), now()),
('Artikelanzahl: Bei neuen Artikel aktiviert', 'PRODUCTS_QTY_BOX_STATUS', 43, 'Wie soll die Box der Artikelanzahl f�r den Warenkorb bei neuen Artikel standardm��ig eingestellt sein?<br /><br />0= aus<br />1= ein<br /><br />Hinweis:<br />EIN<br />Diese Option zeigt eine Box, die dem Kunden die M�glichkeit zur Eingabe der Artikelanzahl im Warenkorb anzeigt<br />AUS<br />Die Artikelanzahl wird auf nur "1" gesetzt, ohne der M�glichkeit zur �nderung der Artikelanzahl im Warenkorb', now(), now()),
('Artikelbewertungen ben�tigen �berpr�fung', 'REVIEWS_APPROVAL', 43, 'Sollen Artikelbewertungen erst nach einer �berpr�fung freigegeben werden?<br /><br />HINWEIS: Wenn der Bewertungsstatus deaktiviert ist, wird diese Option nicht aktiv<br /><br />0= nein 1= ja', now(), now()),
('Meta Tags: Artikelnummer im Titel integrieren', 'META_TAG_INCLUDE_MODEL', 43, 'Soll die Artikelnummer im Meta Tag Titel integriert werden?<br /><br />0= nein 1= ja', now(), now()),
('Meta Tags: Artikelpreis im Titel integrieren', 'META_TAG_INCLUDE_PRICE', 43, 'Sollen der Artikelpreis im Meta Tag Titel integriert werden?<br /><br />0= nein 1= ja', now(), now()),
('Max. Anzahl W�rter f�r Metatag "description"', 'MAX_META_TAG_DESCRIPTION_LENGTH', 43, 'Max. Anzahl W�rter f�r description Metatag. Default 50:', now(), now()),
('Artikelbeschreibung: Anzahl empfohlener Artikel pro Zeile ', 'SHOW_PRODUCT_INFO_COLUMNS_ALSO_PURCHASED_PRODUCTS', 43, 'Anzahl empfohlener Artikel die pro Zeile angezeigt werden sollen', now(), now()),
('"Vorheriger - N�chster" Navigation: Position der Navigationsleite', 'PRODUCT_INFO_PREVIOUS_NEXT', 43, 'Geben Sie hier an, wo die "Vorheriger - N�chster" Navigation angezeigt werden soll<br />0= nicht anzeigen<br />1= oben auf der Seite anzeigen<br />2= unten auf der Seite anzeigen<br />3= oben und unten auf der Seite anzeigen', now(), now()),
('"Vorheriger - N�chster" Navigation: Sortierung der Artikel', 'PRODUCT_INFO_PREVIOUS_NEXT_SORT', 43, 'Geben Sie hier an, wie die Artikel in der "Vorheriger - N�chster" Navigation sortiert werden sollen<br />0= Artikel ID<br />1= Artikelname<br />2= Artikelnummer<br />3= Preis, Artikelname<br />4= Preis, Artikelnummer<br />5= Artikelname, Artikelnummer<br />6= ArtikelSortierung', now(), now()),
('"Vorheriger - N�chster" Navigation: Button und Artikelbilder', 'SHOW_PREVIOUS_NEXT_STATUS', 43, 'Sollen Buttons und Artikelbilder angezeigt werden?<br />0= nein<br />1= ja', now(), now()),
('"Vorheriger - N�chster" Navigation: Button und Artikelbilder - Einstellungen', 'SHOW_PREVIOUS_NEXT_IMAGES', 43, 'Wie sollen Buttons und Artikelbilder angezeigt werden?<br />0= nur Buttons<br />1= Buttons und Artikelbilder<br />2= nur Artikelbilder', now(), now()),
('"Vorheriger - N�chster" Navigation: Breite der Bilder', 'PREVIOUS_NEXT_IMAGE_WIDTH', 43, 'Geben Sie die Breite der Artikelbilder (in Pixel) an', now(), now()),
('"Vorheriger - N�chster" Navigation: H�he der Bilder', 'PREVIOUS_NEXT_IMAGE_HEIGHT', 43, 'Geben Sie die H�he der Artikelbilder (in Pixel) an', now(), now()),
('"Vorheriger - N�chster" Navigation: Kategorien anzeigen', 'PRODUCT_INFO_CATEGORIES', 43, 'Wie sollen Artikelkategorien, Kategoriebilder und Kategorienamen oberhalb der "Vorheriger - N�chster" Navigation angezeigt werden?<br />0= nicht anzeigen<br />1= Linksausrichtung<br />2= Zentriert<br />3= Rechtsausrichtung', now(), now()),
('"Vorheriger - N�chster" Navigation: Kategoriebezeichnung und -Bild anzeigen', 'PRODUCT_INFO_CATEGORIES_IMAGE_STATUS', 43, 'Wie sollen Kategoriename und Kategoriebild angezeigt werden?<br />0= Kategoriename und -Bild immer anzeigen<br />1= Nur Kategoriename<br />2= Kategoriename und -Bild falls vorhanden', now(), now()),

# Adminmen� ID 19
('Spaltenbreite: Linke Boxen', 'BOX_WIDTH_LEFT', 43, 'Die Breite der linken Boxen<br />"px" kann mit angegeben werden<br /><br />Standard = 150px', now(), now()),
('Spaltenbreite: Rechte Boxen', 'BOX_WIDTH_RIGHT', 43, 'Die Breite der rechten Boxen<br />"px" kann mit angegeben werden<br /><br />Standard = 150px', now(), now()),
('"Brotkr�mel" Navigation (Bread Crumbs): Separator', 'BREAD_CRUMBS_SEPARATOR', 43, 'Geben Sie hier das Symbol f�r den Separator f�r die sog. Brotkr�mel Navigation ein<br />HINWEIS: Leerzeichen m�ssen mit "& " angegeben.<br />Standard = & ::& ', now(), now()),
('"Brotkr�mel" Navigationpfad anzeigen', 'DEFINE_BREADCRUMB_STATUS', 43, 'Soll ein Navigationspfad angezeigt werden?<br />0= AUS<br />1= EIN<br/>2= EIN aber nicht auf der Startseite', now(), now()),
('Bestseller: Einr�cken der Zahlen', 'BEST_SELLERS_FILLER', 43, 'Wie wollen Sie die Zahlen f�r Bestseller einr�cken?<br />Standard = & ', now(), now()),
('Bestseller: Artikelnamen k�rzen', 'BEST_SELLERS_TRUNCATE', 43, 'Ab wie vielen Zeichen sollen Artikelnamen gek�rzt werden?<br />Standard = 35', now(), now()),
('Bestseller: K�rze Artikelnamen ab dem folgenden...', 'BEST_SELLERS_TRUNCATE_MORE', 43, 'Artikelnamen werden gek�rzt, gefolgt von...<br />Standard = true', now(), now()),
('Kategoriebox: Link f�r Sonderangebote anzeigen', 'SHOW_CATEGORIES_BOX_SPECIALS', 43, 'Soll der Link "Sonderangebote" in der Kategoriebox angezeigt werden?', now(), now()),
('Kategoriebox: Link f�r Neue Artikel anzeigen', 'SHOW_CATEGORIES_BOX_PRODUCTS_NEW', 43, 'Soll der Link "Neue Artikel" in der Kategoriebox angezeigt werden?', now(), now()),
('Warenkorb anzeigen', 'SHOW_SHOPPING_CART_BOX_STATUS', 43, 'Wie soll der Warenkorb angezeigt werden?<br />0= Immer<br />1= Nur wenn Artikel im Warenkorb sind<br />2= Nur wenn Artikel im Warenkorb sind und der Warenkorb angesehen wird', now(), now()),
('Kategorie Box - Zeige Link f�r "Empfohlene Artikel"', 'SHOW_CATEGORIES_BOX_FEATURED_PRODUCTS', 43, 'Soll der Link "Empfohlene Artikel" in der Kategoriebox angezeigt werden?', now(), now()),
('Kategorie Box - Zeige Link f�r "Alle Artikel"', 'SHOW_CATEGORIES_BOX_PRODUCTS_ALL', 43, 'Soll der Link "Alle Artikel" in der Kategoriebox angezeigt werden?', now(), now()),
('Linke Spaltenansicht - Global', 'COLUMN_LEFT_STATUS', 43, 'Linke Spalte anzeigen?<br />0= Linke Spalte immer aus<br />1= Linke Spalte immer ein', now(), now()),
('Rechte Spaltenansicht - Global', 'COLUMN_RIGHT_STATUS', 43, 'Rechte Spalte anzeigen?<br />0= Rechte Spalte immer aus<br />1= Rechte Spalte immer ein', now(), now()),
('Spaltenbreite: Linke Spalte', 'COLUMN_WIDTH_LEFT', 43, 'Die Breite der linken Spalte<br />"px" kann mit angegeben werden<br />Standard = 150px', now(), now()),
('Spaltenbreite: Rechte Spalte', 'COLUMN_WIDTH_RIGHT', 43, 'Die Breite der rechten Spalte<br />"px" kann mit angegeben werden<br />Standard = 150px', now(), now()),
('Kategorien: Separator zwischen Kategorien und Links', 'SHOW_CATEGORIES_SEPARATOR_LINK', 43, 'Soll ein Separator zwischen Kategorien und Links angezeigt werden?<br />0= nein<br />1= ja', now(), now()),
('Kategorien: Trennzeichen zwischen Kategorienamen und -z�hler', 'CATEGORIES_SEPARATOR', 43, 'Welches Trennzeichen soll zwischen Kategorienamen und -z�hler verwendet werden?<br />Standard = -&gt;', now(), now()),
('Kategorien: Separator zwischen Kategorienamen und Unterkategorien', 'CATEGORIES_SEPARATOR_SUBS', 43, 'Welcher Separator soll zwischen Kategorienamen und Unterkategorien verwendet werden?<br />Standard = |_& ', now(), now()),
('Kategoriez�hler Pr�fix', 'CATEGORIES_COUNT_PREFIX', 43, 'Welches Symbol wollen Sie f�r den Prefix f�r Kategoriez�hler verwenden?<br />Standard= (', now(), now()),
('Kategoriez�hler Suffix', 'CATEGORIES_COUNT_SUFFIX', 43, 'Welches Symbol wollen Sie f�r den Suffix f�r Kategoriez�hler verwenden?<br />Standard= )', now(), now()),
('Unterkategorie einr�cken mit', 'CATEGORIES_SUBCATEGORIES_INDENT', 43, 'Wie sollen Unterkategorien einger�ckt werden?<br />Standard= & & ', now(), now()),
('Kategoriez�hler f�r Kategorien mit 0 Artikel anzeigen', 'CATEGORIES_COUNT_ZERO', 43, 'Sollen Kategoriez�hler f�r Kategorien, die keine Artikel enthalten, angezeigt werden?<br />0= nein<br />1= ja', now(), now()),
('Kategoriebox teilen', 'CATEGORIES_SPLIT_DISPLAY', 43, 'Soll die Kategoriebox nach Artikeltyp aufgeteilt werden?', now(), now()),
('Warenkorb: Summe anzeigen', 'SHOW_TOTALS_IN_CART', 43, 'Soll die Summe unter dem Warenkorb angezeigt werden?<br />0= nein<br />1= ja, Summe Artikel - Gewicht - Betrag<br />2= ja, Summe Artikel - Gewicht - Betrag, keine Anzeige des Gewichts, wenn dieses 0 ist<br />3= ja, Summe Artikel - Betrag', now(), now()),
('Willkommenstext auf Startseite zeigen?', 'SHOW_CUSTOMER_GREETING', 43, 'Willkommenstext auf Startseite zeigen?<br />0= AUS<br />1= EIN', now(), now()),
('Kategorien: Immer auf der Startseite anzeigen', 'SHOW_CATEGORIES_ALWAYS', 43, 'Sollen Top Level Kategorien immer auf der Startseite angezeigt werden?<br />0= nein<br />1= ja<br />Die Standardkategorie kann als "Top Level Kategorie" gesetzt sein oder eine bestimmte "Top Level Kategorie" sein', now(), now()),
('Startseite er�ffnet mit Kategorien', 'CATEGORIES_START_MAIN', 43, '0= Top Level Kategorien<br />oder geben Sie eine Kategorie ID# ein<br />HINWEIS: Unterkategorien k�nnen ebenso verwendet werden. Beispiel: 3_10', now(), now()),
('Unterkategorien anzeigen?', 'SHOW_CATEGORIES_SUBCATEGORIES_ALWAYS', 43, 'Sollen Unterkategorien im Navigationsmen� angezeigt werden, wenn die Hauptkategorie selektiert ist?<br/>0=AUS<br/>1=EIN', now(), now()),
('Bannergruppen: �berschrift Position 1', 'SHOW_BANNERS_GROUP_SET1', 43, 'Die Bannergruppe kann aus einer oder aus mehreren Bannergruppen bestehen<br /><br />F�r mehrfache Bannergruppen geben Sie bitte die Namen der Bannergruppen getrennt durch <strong>:</strong> ein<br /><br />Beispiel: Wide-Banners:SideBox-Banners<br /><br />Welche Bannergruppe(n) wollen Sie in der �berschrift 1 verwenden?<br />Bitte leer lassen, wenn Sie keine Bannergruppe(n) verwenden wollen', now(), now()),
('Bannergruppen: �berschrift Position 3', 'SHOW_BANNERS_GROUP_SET3', 43, 'Die Bannergruppe kann aus einer oder aus mehreren Bannergruppen bestehen<br /><br />F�r mehrfache Bannergruppen geben Sie bitte die Namen der Bannergruppen getrennt durch <strong>:</strong> ein<br /><br />Beispiel: Wide-Banners:SideBox-Banners<br /><br />Welche Bannergruppe(n) wollen Sie in der �berschrift 3 verwenden?<br />Bitte leer lassen, wenn Sie keine Bannergruppe(n) verwenden wollen', now(), now()),
('Bannergruppen: �berschrift Position 2', 'SHOW_BANNERS_GROUP_SET2', 43, 'Die Bannergruppe kann aus einer oder aus mehreren Bannergruppen bestehen<br /><br />F�r mehrfache Bannergruppen geben Sie bitte die Namen der Bannergruppen getrennt durch <strong>:</strong> ein<br /><br />Beispiel: Wide-Banners:SideBox-Banners<br /><br />Welche Bannergruppe(n) wollen Sie in der �berschrift 2 verwenden?<br />Bitte leer lassen, wenn Sie keine Bannergruppe(n) verwenden wollen', now(), now()),
('Bannergruppen: Fu�zeile Position 1', 'SHOW_BANNERS_GROUP_SET4', 43, 'Die Bannergruppe kann aus einer oder aus mehreren Bannergruppen bestehen<br /><br />F�r mehrfache Bannergruppen geben Sie bitte die Namen der Bannergruppen getrennt durch <strong>:</strong> ein<br /><br />Beispiel: Wide-Banners:SideBox-Banners<br /><br />Welche Bannergruppe(n) wollen Sie in der Fu�zeile 1 verwenden?<br />Bitte leer lassen, wenn Sie keine Bannergruppe(n) verwenden wollen', now(), now()),
('Bannergruppen: Fu�zeile Position 2', 'SHOW_BANNERS_GROUP_SET5', 43, 'Die Bannergruppe kann aus einer oder aus mehreren Bannergruppen bestehen<br /><br />F�r mehrfache Bannergruppen geben Sie bitte die Namen der Bannergruppen getrennt durch <strong>:</strong> ein<br /><br />Beispiel: Wide-Banners:SideBox-Banners<br /><br />Welche Bannergruppe(n) wollen Sie in der Fu�zeile 2 verwenden?<br />Bitte leer lassen, wenn Sie keine Bannergruppe(n) verwenden wollen', now(), now()),
('Bannergruppen: Fu�zeile Position 3', 'SHOW_BANNERS_GROUP_SET6', 43, 'Die Bannergruppe kann aus einer oder aus mehreren Bannergruppen bestehen<br /><br />F�r mehrfache Bannergruppen geben Sie bitte die Namen der Bannergruppen getrennt durch <strong>:</strong> ein<br /><br />Beispiel: Wide-Banners:SideBox-Banners<br /><br />Standard Bannergruppe = Wide-Banners<br /><br />Welche Bannergruppe(n) wollen Sie in der Fu�zeile 3 verwenden?<br />Bitte leer lassen, wenn Sie keine Bannergruppe(n) verwenden wollen', now(), now()),
('Bannergruppen: Sidebox banner_box', 'SHOW_BANNERS_GROUP_SET7', 43, 'Die Bannergruppe kann aus einer oder aus mehreren Bannergruppen bestehen<br /><br />F�r mehrfache Bannergruppen geben Sie bitte die Namen der Bannergruppen getrennt durch <strong>:</strong> ein<br /><br />Beispiel: Wide-Banners:SideBox-Banners<br />Standard Bannergruppe = SideBox-Banners<br /><br />Welche Bannergruppe(n) wollen Sie in der Sidebox - banner_box verwenden?<br />Bitte leer lassen, wenn Sie keine Bannergruppe(n) verwenden wollen', now(), now()),
('Bannergruppen: Sidebox banner_box2', 'SHOW_BANNERS_GROUP_SET8', 43, 'Die Bannergruppe kann aus einer oder aus mehreren Bannergruppen bestehen<br /><br />F�r mehrfache Bannergruppen geben Sie bitte die Namen der Bannergruppen getrennt durch <strong>:</strong> ein<br /><br />Beispiel: Wide-Banners:SideBox-Banners<br />Standard Bannergruppe = SideBox-Banners<br /><br />Welche Bannergruppe(n) wollen Sie in der Sidebox - banner_box2 verwenden?<br />Bitte leer lassen, wenn Sie keine Bannergruppe(n) verwenden wollen', now(), now()),
('Banner Anzeigengruppe - Sidebox banner_box_all', 'SHOW_BANNERS_GROUP_SET_ALL', 43, 'Welche Banneranzeigengruppe soll in der Sidebox "banner_box_all" angezeigt werden? F�r keine Gruppe Feld leer lassen!', now(), now()),
('IP Adresse in der Fu�zeile anzeigen', 'SHOW_FOOTER_IP', 43, 'Soll die IP Adresse des Kunden in der Fu�zeile angezeigt werden?<br />0= nein<br />1= ja', now(), now()),
('Mengenrabatt: Anzahl leerer Rabatte', 'DISCOUNT_QTY_ADD', 43, 'Wieviele leere Mengenrabatte sollen bei der Artikel Bepreisung hinzugef�gt werden?', now(), now()),
('Mengenrabatt: Anzahl Ansicht pro Reihe', 'DISCOUNT_QUANTITY_PRICES_COLUMN', 43, 'Wieviele Mengenrabatte sollen pro Reihe angezeigt werden?', now(), now()),
('Kategorie/Artikel Sortierung', 'CATEGORIES_PRODUCTS_SORT_ORDER', 43, 'Kategorie/Artikel Sortierung<br/><br/>0= Kategorie/Artikel Sortierung/Name<br/>1= Kategorie/Artikel Name<br/>2= Artikelnummer<br/>3= Artikelmenge aufsteigend, Artikelname<br/>4= Artikelmenge abteigend, Artikelname<br/>5= Artikelpreis aufsteigend, Artikelname<br/>6= Artikelpreis absteigend, Artikelname<br/>', now(), now()),
('Globale Attributfunktionen - Hinzuf�gen, Kopieren und L�schen   ', 'OPTION_NAMES_VALUES_GLOBAL_STATUS', 43, 'Globale Attributfunktionen (Attributname und Attributmerkmale) - Hinzuf�gen, Kopieren und L�schen<br/><br/>0= nicht verf�gbar<br/>1= verf�gbar<br/>2= Artikelnummer', now(), now()),
('Kategorie-Tabs Men� EIN/AUS', 'CATEGORIES_TABS_STATUS', 43, 'Kategorie-Tabs<br />Zeigt die Toplevel Kategorien unterhalb des Banners an. <br />0= Kategorie Tabs AUS<br />1= Kategorie Tabs EIN', now(), now()),
('Sitemap - Link f�r "Mein Konto" inkludieren', 'SHOW_ACCOUNT_LINKS_ON_SITE_MAP', 43, 'Soll der Link f�r "Mein Konto" in der Sitemap inkludiert werden?<br /><br />Standard: false', now(), now()),
('�berspringe Kategorien mit einem Artikel', 'SKIP_SINGLE_PRODUCT_CATEGORIES', 43, '�berspringe Kategorien mit einem Artikel<br />Wenn true dann wird bei Klick auf die Kategorie gleich direkt die Artikelansicht angezeigt.<br />Standard: True', now(), now()),
('Anmeldeseite geteilt anzeigen', 'USE_SPLIT_LOGIN_MODE', 43, 'Die Anmeldeseite kann in zwei Varianten angezeigt werden: Geteilt oder vertikal.<br />Die geteilte Variante zeigt neben der Felder f�r die Anmeldung einen Text und einen "Neues Konto erstellen" Button, der auf die Seite zur <em>Kontoerstellung</em> weiterleitet. In der vertikalen Variante werden alle Felder zur Kontoerstellung unterhalb der Felder f�r die Anmeldung angezeigt.<br />Standard: False', now(), now()),
('CSS Schaltfl�chen', 'IMAGE_USE_CSS_BUTTONS', 43, 'CSS Schaltfl�chen<br />CSS Schaltfl�chen anstelle von Bildern verwenden (GIF/JPG)?<br />CSS Schaltfl�chen-Stile m�ssen in den Stylesheets definiert werden.', now(), now()),

# Adminmen� ID 20
('<strong>Wegen Shopwartung geschlossen:</strong>', 'DOWN_FOR_MAINTENANCE', 43, 'Wegen Shopwartung geschlossen <br>(true=ein false=aus)', now(), now()),
('Wegen Shopwartung geschlossen: Dateiname', 'DOWN_FOR_MAINTENANCE_FILENAME', 43, 'Welcher Dateinamen soll f�r den Status "Wegen Shopwartung geschlossen" verwendet werden?<br />HINWEIS: Bitte den Dateinamen ohne Dateierweiterung angeben<br />Standard= down_for_maintenance', now(), now()),
('Wegen Shopwartung geschlossen: Header ausblenden', 'DOWN_FOR_MAINTENANCE_HEADER_OFF', 43, 'Wegen Shopwartung geschlossen: Header ausblenden<br>(true= ausblenden<br />false= anzeigen)', now(), now()),
('Wegen Shopwartung geschlossen: Linke Spalte ausblenden', 'DOWN_FOR_MAINTENANCE_COLUMN_LEFT_OFF', 43, 'Wegen Shopwartung geschlossen: Linke Spalte ausblenden<br>(true= ausblenden<br />false= anzeigen)', now(), now()),
('Wegen Shopwartung geschlossen: Rechte Spalte ausblenden', 'DOWN_FOR_MAINTENANCE_COLUMN_RIGHT_OFF', 43, 'Wegen Shopwartung geschlossen: Rechte Spalte ausblenden<br>(true= ausblenden<br />false= anzeigen)', now(), now()),
('Wegen Shopwartung geschlossen: Fu�zeile ausblenden', 'DOWN_FOR_MAINTENANCE_FOOTER_OFF', 43, 'Wegen Shopwartung geschlossen: Fu�zeile ausblenden<br>(true= ausblenden<br />false= anzeigen)', now(), now()),
('Wegen Shopwartung geschlossen: Preise ausblenden', 'DOWN_FOR_MAINTENANCE_PRICES_OFF', 43, 'Wegen Shopwartung geschlossen: Preise ausblenden<br>(true= ausblenden<br />false= anzeigen)', now(), now()),
('Wegen Shopwartung geschlossen: diese IP-Adresse(n) ausschlie�en', 'EXCLUDE_ADMIN_IP_FOR_MAINTENANCE', 43, 'Diese IP Adresse(n) hat w�hrend der Shopwartung vollen Zugriff auf den Shop (z.B. Webmaster)<br />Bei Eingabe mehrerer IP Adressen werden diese mit einem Komma getrennt.<br /><br />TIP: Wenn Sie Ihre IP Adresse nicht kennen, finden Sie diese in der Fu�zeile des Shops.', now(), now()),
('Ihre Besucher vor Beginn der Shopwartung informieren:', 'WARN_BEFORE_DOWN_FOR_MAINTENANCE', 43, 'Ver�ffentlicht eine bestimmte Zeit vor der Shopwartung einen Hinweis, wann die Shopwartung starten wird<br>(true=ein false=aus)<br>IWenn Sie die Option ''Wegen Shopwartung geschlossen'' auf "true" setzen,wird diese Option automatisch auf "false" gesetzt.', now(), now()),
('Datum und Stunden f�r Hinweis vor Beginn der Shopwartung', 'PERIOD_BEFORE_DOWN_FOR_MAINTENANCE', 43, 'Datum und Stunden f�r den Hinweis vor der Shopwartung, geben Sie Datum und Stunden f�r die Zeit der Shopwartung ein', now(), now()),
('Anzeigen, wann mit der Shopwartung begonnen wurde', 'DISPLAY_MAINTENANCE_TIME', 43, 'Zeigt an, wann mit der Shopwartung begonnen wurde<br>(true=ein false=aus)<br />', now(), now()),
('Dauer der Shopwartung anzeigen', 'DISPLAY_MAINTENANCE_PERIOD', 43, 'Zeigt die Dauer der Shopwartung an<br>(true=ein false=aus)<br />', now(), now()),
('Dauer der Shopwartung', 'TEXT_MAINTENANCE_PERIOD_TIME', 43, 'Geben Sie die Dauer der Shopwartung an (hh:mm)', now(), now()),

# Adminmen� ID 11
('AGB Best�tigungsfeld bei der Bestellung anzeigen', 'DISPLAY_CONDITIONS_ON_CHECKOUT', 43, 'Den Kunden wird w�hrend der Bestellung das AGB Best�tigungsfeld angezeigt und sie m�ssen den AGB zustimmen.', now(), now()),
('Datenschutzbestimmungen Best�tigungsfeld bei der Kontoerstellung anzeigen', 'DISPLAY_PRIVACY_CONDITIONS', 43, 'Den Kunden wird w�hrend der Kontoerstellung das Datenschutzbestimmungen Best�tigungsfeld angezeigt und sie m�ssen den Datenschutzbestimmungen zustimmen.', now(), now()),

# Adminmen� ID 21
('Bild anzeigen', 'PRODUCT_NEW_LIST_IMAGE', 43, 'Wollen Sie Artikelbilder in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('St�ckzahl anzeigen', 'PRODUCT_NEW_LIST_QUANTITY', 43, 'Wollen Sie die Artikelst�ckzahlen in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('"jetzt kaufen" - Button anzeigen', 'PRODUCT_NEW_BUY_NOW', 43, 'Wollen Sie den "jetzt kaufen" - Button in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('Artikelname anzeigen', 'PRODUCT_NEW_LIST_NAME', 43, 'Wollen Sie den Artikelnamen in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('Artikelnummer anzeigen', 'PRODUCT_NEW_LIST_MODEL', 43, 'Wollen Sie die Artikelnummer in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('Herstellernamen anzeigen', 'PRODUCT_NEW_LIST_MANUFACTURER', 43, 'Wollen Sie den Herstellernamen in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('Preis anzeigen', 'PRODUCT_NEW_LIST_PRICE', 43, 'Wollen Sie den Artikelpreis in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('Gewicht anzeigen', 'PRODUCT_NEW_LIST_WEIGHT', 43, 'Wollen Sie das Artikelgewicht in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('"Hinzuf�gt am" anzeigen', 'PRODUCT_NEW_LIST_DATE_ADDED', 43, 'Wollen Sie "Hinzugef�gt am" in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('Artikelbeschreibung anzeigen', 'PRODUCT_NEW_LIST_DESCRIPTION', 43, 'Wollen Sie die Artikelbeschreibung in der Liste anzeigen? - Die ersten 150 Zeichen?<br />0= nein<br />1= ja', now(), now()),
('Standardsortierung', 'PRODUCT_NEW_LIST_SORT_DEFAULT', 43, 'Wie sollen die Artikel in der Liste sortiert werden?<br />Standard= 6 (nach Datum, absteigend)<br /><br />1= nach Artikelname, aufsteigend<br />2= nach Artikelname, absteigend<br />3= nach Preis (aufsteigend), dann nach Artikelname<br />4= nach Preis absteigend, dann nach Artikelname<br />5= nach Artikelnummer<br />6= nach Hinzuf�gedatum, absteigend<br />7= nach Hinzuf�gedatum, aufsteigend<br />8= nach ArtikelSortierung', now(), now()),
('Gruppen ID f�r "neue Artikel"', 'PRODUCT_NEW_LIST_GROUP_ID', 43, 'WARNUNG: �ndern Sie diesen Wert erst, wenn die Gruppen ID vom Standardwert 21 ge�ndert wurde<br />Wie lautet die configuration_group_id f�r die "neue Artikel" Liste?', now(), now()),
('Button "Ausgew�hlte Artikel in den Warenkorb" anzeigen', 'PRODUCT_NEW_LISTING_MULTIPLE_ADD_TO_CART', 43, 'Eingabefelder und Schaltfl�che anzeigen, um mehrere ausgew�hlte Artikel mit einem Klick in den Warenkorb zu �bernehmen?<br/><br/>0= NEIN<br/>1= Oben<br/>2= Unten<br/>3= Oben und Unten', now(), now()),
('Artikelank�ndigungen als Neue Artikel anzeigen', 'SHOW_NEW_PRODUCTS_UPCOMING_MASKED', 43, 'Sollen Artikelank�ndigungen in Artikellisten, Seitenboxen und Centerboxen als neue Artikel angezeigt werden?<br />0= Nein<br />1= Ja', now(), now()),

# Adminmen� ID 22
('Bild anzeigen', 'PRODUCT_FEATURED_LIST_IMAGE', 43, 'Wollen Sie Artikelbilder in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('St�ckzahl anzeigen', 'PRODUCT_FEATURED_LIST_QUANTITY', 43, 'Wollen Sie die Artikelst�ckzahlen in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('"jetzt kaufen" - Button anzeigen', 'PRODUCT_FEATURED_BUY_NOW', 43, 'Wollen Sie den "jetzt kaufen" - Button in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('Artikelname anzeigen', 'PRODUCT_FEATURED_LIST_NAME', 43, 'Wollen Sie den Artikelnamen in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('Artikelnummer anzeigen', 'PRODUCT_FEATURED_LIST_MODEL', 43, 'Wollen Sie die Artikelnummer in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('Herstellernamen anzeigen', 'PRODUCT_FEATURED_LIST_MANUFACTURER', 43, 'Wollen Sie den Herstellernamen in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('Preis anzeigen', 'PRODUCT_FEATURED_LIST_PRICE', 43, 'Wollen Sie den Artikelpreis in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('Gewicht anzeigen', 'PRODUCT_FEATURED_LIST_WEIGHT', 43, 'Wollen Sie das Artikelgewicht in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('"Hinzuf�gt am" anzeigen', 'PRODUCT_FEATURED_LIST_DATE_ADDED', 43, 'Wollen Sie d"Hinzugef�gt am" in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('Artikelbeschreibung anzeigen', 'PRODUCT_FEATURED_LIST_DESCRIPTION', 43, 'Wollen Sie die Artikelbeschreibung in der Liste anzeigen? - Die ersten 150 Zeichen?<br />0= nein<br />1= ja', now(), now()),
('Standardsortierung', 'PRODUCT_FEATURED_LIST_SORT_DEFAULT', 43, 'Wie sollen die Artikel in der Liste sortiert werden?<br />Standard= 6 (nach Datum, absteigend)<br /><br />1= nach Artikelname, aufsteigend<br />2= nach Artikelname, absteigend<br />3= nach Preis (aufsteigend), dann nach Artikelname<br />4= nach Preis absteigend, dann nach Artikelname<br />5= nach Artikelnummer<br />6= nach Hinzuf�gedatum, absteigend<br />7= nach Hinzuf�gedatum, aufsteigend<br />8= nach ArtikelSortierung', now(), now()),
('Gruppen ID f�r "Empfohlene Artikel"', 'PRODUCT_FEATURED_LIST_GROUP_ID', 43, 'WARNUNG: �ndern Sie diesen Wert erst, wenn die Gruppen ID vom Standardwert 22 ge�ndert wurde<br />Wie lautet die configuration_group_id f�r die "Empfohlenen Artikel" Liste?', now(), now()),
('Button "Ausgew�hlte Artikel in den Warenkorb" anzeigen', 'PRODUCT_FEATURED_LISTING_MULTIPLE_ADD_TO_CART', 43, 'Eingabefelder und Schaltfl�che anzeigen, um mehrere ausgew�hlte Artikel mit einem Klick in den Warenkorb zu �bernehmen?<br/><br/>0= NEIN<br/>1= Oben<br/>2= Unten<br/>3= Oben und Unten', now(), now()),

# Adminmen� ID 23
('Bild anzeigen', 'PRODUCT_ALL_LIST_IMAGE', 43, 'Wollen Sie Artikelbilder in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('St�ckzahl anzeigen', 'PRODUCT_ALL_LIST_QUANTITY', 43, 'Wollen Sie St�ckzahlen in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('"jetzt kaufen" - Button anzeigen', 'PRODUCT_ALL_BUY_NOW', 43, 'Wollen Sie den "jetzt kaufen" - Button in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('Artikelname anzeigen', 'PRODUCT_ALL_LIST_NAME', 43, 'Wollen Sie den Artikelname in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('Artikelnummer anzeigen', 'PRODUCT_ALL_LIST_MODEL', 43, 'Wollen Sie die Artikelnummer in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('Herstellernamen anzeigen', 'PRODUCT_ALL_LIST_MANUFACTURER', 43, 'Wollen Sie den Herstellernamen in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('Preis anzeigen', 'PRODUCT_ALL_LIST_PRICE', 43, 'Wollen Sie den Artikelpreis in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('Gewicht anzeigen', 'PRODUCT_ALL_LIST_WEIGHT', 43, 'Wollen Sie das Artikelgewicht in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('"Hinzugef�gt am" Datum anzeigen', 'PRODUCT_ALL_LIST_DATE_ADDED', 43, 'Wollen Sie das "Hinzugef�gt am" Datum in der Liste anzeigen?<br /><br />0= nein<br /><br />1. Zahl = links oder rechts<br />2. und 3. Zahl = Sortierung<br />4. Zahl = Anzahl der Leerzeilen danach<br />', now(), now()),
('Artikelbeschreibung anzeigen', 'PRODUCT_ALL_LIST_DESCRIPTION', 43, 'Wollen Sie die Artikelbeschreibung in der Liste anzeigen? - Die ersten 150 Zeichen?<br />0= nein<br />1= ja', now(), now()),
('Standardsortierung', 'PRODUCT_ALL_LIST_SORT_DEFAULT', 43, 'Wie sollen die Artikel in der Liste sortiert werden?<br />Standard= 6 (nach Datum, absteigend)<br /><br />1= nach Artikelname, aufsteigend<br />2= nach Artikelname, absteigend<br />3= nach Preis (aufsteigend), dann nach Artikelname<br />4= nach Preis absteigend, dann nach Artikelname<br />5= nach Artikelnummer<br />6= nach Hinzuf�gedatum, absteigend<br />7= nach Hinzuf�gedatum, aufsteigend<br />8= nach ArtikelSortierung', now(), now()),
('Gruppen ID f�r "Alle Artikel"', 'PRODUCT_ALL_LIST_GROUP_ID', 43, 'WARNUNG: �ndern Sie diesen Wert erst, wenn die Gruppen ID vom Standardwert 23 ge�ndert wurde<br />Wie lautet die configuration_group_id f�r die "Alle Artikel" Liste?', now(), now()),
('Button "Ausgew�hlte Artikel in den Warenkorb" anzeigen', 'PRODUCT_ALL_LISTING_MULTIPLE_ADD_TO_CART', 43, 'Eingabefelder und Schaltfl�che anzeigen, um mehrere ausgew�hlte Artikel mit einem Klick in den Warenkorb zu �bernehmen?<br/><br/>0= NEIN<br/>1= Oben<br/>2= Unten<br/>3= Oben und Unten', now(), now()),

# Adminmen� ID 24
('Startseite: Neue Artikel anzeigen', 'SHOW_PRODUCT_INFO_MAIN_NEW_PRODUCTS', 43, 'Sollen neue Artikel auf der Startseite angezeigt werden?<br />0= nein (oder legen Sie die Sortierung fest)', now(), now()),
('Startseite: Empfohlene Artikel anzeigen', 'SHOW_PRODUCT_INFO_MAIN_FEATURED_PRODUCTS', 43, 'Sollen Empfohlene Artikel auf der Startseite angezeigt werden?<br />0= nein (oder legen Sie die Sortierung fest)', now(), now()),
('Startseite: Sonderangebote anzeigen', 'SHOW_PRODUCT_INFO_MAIN_SPECIALS_PRODUCTS', 43, 'Sollen Sonderangebote auf der Startseite angezeigt werden?<br />0= nein (oder legen Sie die Sortierung fest)', now(), now()),
('Startseite: Artikelank�ndigungen anzeigen', 'SHOW_PRODUCT_INFO_MAIN_UPCOMING', 43, 'Sollen kommende Artikel auf der Startseite angezeigt werden?<br />0= nein (oder legen Sie die Sortierung fest)', now(), now()),
('Kategorien mit Unterkategorien: "Neue Artikel" anzeigen', 'SHOW_PRODUCT_INFO_CATEGORY_NEW_PRODUCTS', 43, 'Sollen neue Artikel in Kategorien mit Unterkategorien angezeigt werden?<br />0= nein (oder legen Sie die Sortierung fest)', now(), now()),
('Kategorien mit Unterkategorien: "Empfohlene Artikel" anzeigen', 'SHOW_PRODUCT_INFO_CATEGORY_FEATURED_PRODUCTS', 43, 'Sollen empfohlene Artikel in Kategorien mit Unterkategorien angezeigt werden?<br />0= nein (oder legen Sie die Sortierunge fest)', now(), now()),
('Kategorien mit Unterkategorien: "Sonderangebote" anzeigen', 'SHOW_PRODUCT_INFO_CATEGORY_SPECIALS_PRODUCTS', 43, 'Sollen Sonderangebote in Kategorien mit Unterkategorien angezeigt werden?<br />0= nein (oder legen Sie die Sortierung fest)', now(), now()),
('Kategorien mit Unterkategorien: "Artikelank�ndigungen" anzeigen', 'SHOW_PRODUCT_INFO_CATEGORY_UPCOMING', 43, 'Sollen kommende Artikel in Kategorien mit Unterkategorien angezeigt werden?<br />0= nein (oder legen Sie die Sortierung fest)', now(), now()),
('Fehlerseiten: "Neue Artikel" anzeigen', 'SHOW_PRODUCT_INFO_MISSING_NEW_PRODUCTS', 43, 'Sollen neue Artikel auf Fehlerseiten angezeigt werden?<br />0= nein (oder legen Sie die Sortierung fest)', now(), now()),
('Fehlerseiten: "Empfohlene Artikel" anzeigen', 'SHOW_PRODUCT_INFO_MISSING_FEATURED_PRODUCTS', 43, 'Sollen empfohlene Artikel auf Fehlerseiten angezeigt werden?<br />0= nein (oder legen Sie die Sortierung fest)', now(), now()),
('Fehlerseiten: "Sonderangebote" anzeigen', 'SHOW_PRODUCT_INFO_MISSING_SPECIALS_PRODUCTS', 43, 'Sollen Sonderangebote auf Fehlerseiten angezeigt werden?<br />0= nein (oder legen Sie die Sortierung fest)', now(), now()),
('Fehlerseiten: "Artikelank�ndigungen" anzeigen', 'SHOW_PRODUCT_INFO_MISSING_UPCOMING', 43, 'Sollen kommende Artikel auf Fehlerseiten angezeigt werden?<br />0= nein (oder legen Sie die Sortierung fest)', now(), now()),
('Artikelliste: "Neue Artikel" anzeigen', 'SHOW_PRODUCT_INFO_LISTING_BELOW_NEW_PRODUCTS', 43, 'Neue Artikel unter Artikelliste anzeigen<br />0= nein (oder legen Sie die Sortierung fest)', now(), now()),
('Artikelliste: "Empfohlene Artikel" anzeigen', 'SHOW_PRODUCT_INFO_LISTING_BELOW_FEATURED_PRODUCTS', 43, 'Empfohlene Artikel unter Artikelliste anzeigen<br />0= nein (oder legen Sie die Sortierung fest)', now(), now()),
('Artikelliste: "Sonderangebote" anzeigen', 'SHOW_PRODUCT_INFO_LISTING_BELOW_SPECIALS_PRODUCTS', 43, 'Sonderangebote unter Artikelliste anzeigen<br />0= nein (oder legen Sie die Sortierung fest)', now(), now()),
('Artikelliste: "Artikelank�ndigungen" anzeigen', 'SHOW_PRODUCT_INFO_LISTING_BELOW_UPCOMING', 43, 'Artikelank�ndigungen unter Artikelliste anzeigen<br />0= nein (oder legen Sie die Sortierung fest)', now(), now()),
('Neue Artikel: Spalten pro Reihe', 'SHOW_PRODUCT_INFO_COLUMNS_NEW_PRODUCTS', 43, 'Wieviele Spalten wollen Sie pro Reihe anzeigen lassen?', now(), now()),
('Empfohlene Artikel: Spalten pro Reihe', 'SHOW_PRODUCT_INFO_COLUMNS_FEATURED_PRODUCTS', 43, 'Wieviele Spalten wollen Sie pro Reihe anzeigen lassen?', now(), now()),
('Sonderangebote: Spalten pro Reihe', 'SHOW_PRODUCT_INFO_COLUMNS_SPECIALS_PRODUCTS', 43, 'Wieviele Spalten wollen Sie pro Reihe anzeigen lassen?', now(), now()),
('Artikelliste: Artikel in den Centerboxen filtern', 'SHOW_PRODUCT_INFO_ALL_PRODUCTS', 43, 'Filter f�r die Artikel in den Centerboxen "Neue Artikel", "Empfohlene Artikel", "Sonderangebot" und "Artikelank�ndigungen".<br><br>1= Filter ein. es werden nur Artikel aus der jeweiligen Hauptkategorie inkl. deren Unterkategorien angezeigt.<br>0= Filter aus, es werden Artikel aus allen Kategorien angezeigt.', now(), now()),

# Adminmen� ID 25
('Startseite', 'DEFINE_MAIN_PAGE_STATUS', 43, 'Den Inhalt f�r diese Seite k�nnen Sie �ber <em>Tools->Seiteneditor</em> bearbeiten.<br /><strong>Zust�ndige Datei: <em>define_main_page.php</em></strong><br /><br />BESCHREIBUNG:<br /><em>Link EIN</em> bedeutet, dass der Link in der Infobox sichtbar ist.<br /><em>Text AUS</em> bedeutet, dass der definierte Seitentext nicht eingeblendet wird.<br /><br />OPTIONEN:<br />0= Link EIN, Text AUS<br />1= Link EIN, Text EIN<br />2= Link AUS, Text EIN<br />3= Link AUS, Text AUS<br />', now(), now()),
('Schreiben Sie uns', 'DEFINE_CONTACT_US_STATUS', 43, 'Den Inhalt f�r diese Seite k�nnen Sie �ber <em>Tools->Seiteneditor</em> bearbeiten.<br /><strong>Zust�ndige Datei: <em>define_contact_us.php</em></strong><br /><br />BESCHREIBUNG:<br /><em>Link EIN</em> bedeutet, dass der Link in der Infobox sichtbar ist.<br /><em>Text AUS</em> bedeutet, dass der definierte Seitentext nicht eingeblendet wird.<br /><br />OPTIONEN:<br />0= Link EIN, Text AUS<br />1= Link EIN, Text EIN<br />2= Link AUS, Text EIN<br />3= Link AUS, Text AUS<br />', now(), now()),
('Datenschutz', 'DEFINE_PRIVACY_STATUS', 43, 'Den Inhalt f�r diese Seite k�nnen Sie �ber <em>Tools->Seiteneditor</em> bearbeiten.<br /><strong>Zust�ndige Datei: <em>define_privacy.php</em></strong><br /><br />BESCHREIBUNG:<br /><em>Link EIN</em> bedeutet, dass der Link in der Infobox sichtbar ist.<br /><em>Text AUS</em> bedeutet, dass der definierte Seitentext nicht eingeblendet wird.<br /><br />OPTIONEN:<br />0= Link EIN, Text AUS<br />1= Link EIN, Text EIN<br />2= Link AUS, Text EIN<br />3= Link AUS, Text AUS<br />', now(), now()),
('Versandbedingungen', 'DEFINE_SHIPPINGINFO_STATUS', 43, 'Den Inhalt f�r diese Seite k�nnen Sie �ber <em>Tools->Seiteneditor</em> bearbeiten.<br /><strong>Zust�ndige Datei: <em>define_shippinginfo.php</em></strong><br /><br />BESCHREIBUNG:<br /><em>Link EIN</em> bedeutet, dass der Link in der Infobox sichtbar ist.<br /><em>Text AUS</em> bedeutet, dass der definierte Seitentext nicht eingeblendet wird.<br /><br />OPTIONEN:<br />0= Link EIN, Text AUS<br />1= Link EIN, Text EIN<br />2= Link AUS, Text EIN<br />3= Link AUS, Text AUS<br />', now(), now()),
('AGB', 'DEFINE_CONDITIONS_STATUS', 43, 'Den Inhalt f�r diese Seite k�nnen Sie �ber <em>Tools->Seiteneditor</em> bearbeiten.<br /><strong>Zust�ndige Datei: <em>define_conditions.php</em></strong><br /><br />BESCHREIBUNG:<br /><em>Link EIN</em> bedeutet, dass der Link in der Infobox sichtbar ist.<br /><em>Text AUS</em> bedeutet, dass der definierte Seitentext nicht eingeblendet wird.<br /><br />OPTIONEN:<br />0= Link EIN, Text AUS<br />1= Link EIN, Text EIN<br />2= Link AUS, Text EIN<br />3= Link AUS, Text AUS<br />', now(), now()),
('Bestellung erfolgreich', 'DEFINE_CHECKOUT_SUCCESS_STATUS', 43, 'Den Inhalt f�r diese Seite k�nnen Sie �ber <em>Tools->Seiteneditor</em> bearbeiten.<br /><strong>Zust�ndige Datei: <em>define_checkout_success.php</em></strong><br /><br />BESCHREIBUNG:<br /><em>Link EIN</em> bedeutet, dass der Link in der Infobox sichtbar ist.<br /><em>Text AUS</em> bedeutet, dass der definierte Seitentext nicht eingeblendet wird.<br /><br />OPTIONEN:<br />0= Link EIN, Text AUS<br />1= Link EIN, Text EIN<br />2= Link AUS, Text EIN<br />3= Link AUS, Text AUS<br />', now(), now()),
('Aktionskupons', 'DEFINE_DISCOUNT_COUPON_STATUS', 43, 'Den Inhalt f�r diese Seite k�nnen Sie �ber <em>Tools->Seiteneditor</em> bearbeiten.<br /><strong>Zust�ndige Datei: <em>define_discount_coupon.php</em></strong><br /><br />BESCHREIBUNG:<br /><em>Link EIN</em> bedeutet, dass der Link in der Infobox sichtbar ist.<br /><em>Text AUS</em> bedeutet, dass der definierte Seitentext nicht eingeblendet wird.<br /><br />OPTIONEN:<br />0= Link EIN, Text AUS<br />1= Link EIN, Text EIN<br />2= Link AUS, Text EIN<br />3= Link AUS, Text AUS<br />', now(), now()),
('Sitemap', 'DEFINE_SITE_MAP_STATUS', 43, 'Den Inhalt f�r diese Seite k�nnen Sie �ber <em>Tools->Seiteneditor</em> bearbeiten.<br /><strong>Zust�ndige Datei: <em>define_site_map.php</em></strong><br /><br />BESCHREIBUNG:<br /><em>Link EIN</em> bedeutet, dass der Link in der Infobox sichtbar ist.<br /><em>Text AUS</em> bedeutet, dass der definierte Seitentext nicht eingeblendet wird.<br /><br />OPTIONEN:<br />0= Link EIN, Text AUS<br />1= Link EIN, Text EIN<br />2= Link AUS, Text EIN<br />3= Link AUS, Text AUS<br />', now(), now()),
('404 ERROR - Seite nicht gefunden', 'DEFINE_PAGE_NOT_FOUND_STATUS', 43, 'Den Inhalt f�r diese Seite k�nnen Sie �ber <em>Tools->Seiteneditor</em> bearbeiten.<br /><strong>Zust�ndige Datei: <em>define_page_not_found.php</em></strong><br /><br />BESCHREIBUNG:<br /><em>Link EIN</em> bedeutet, dass der Link in der Infobox sichtbar ist.<br /><em>Text AUS</em> bedeutet, dass der definierte Seitentext nicht eingeblendet wird.<br /><br />OPTIONEN:<br />0= Link EIN, Text AUS<br />1= Link EIN, Text EIN<br />2= Link AUS, Text EIN<br />3= Link AUS, Text AUS<br />', now(), now()),
('Seite 2', 'DEFINE_PAGE_2_STATUS', 43, 'Den Inhalt f�r diese Seite k�nnen Sie �ber <em>Tools->Seiteneditor</em> bearbeiten.<br /><strong>Zust�ndige Datei: <em>define_page_2.php</em></strong><br /><br />BESCHREIBUNG:<br /><em>Link EIN</em> bedeutet, dass der Link in der Infobox sichtbar ist.<br /><em>Text AUS</em> bedeutet, dass der definierte Seitentext nicht eingeblendet wird.<br /><br />OPTIONEN:<br />0= Link EIN, Text AUS<br />1= Link EIN, Text EIN<br />2= Link AUS, Text EIN<br />3= Link AUS, Text AUS<br />', now(), now()),
('Seite 3', 'DEFINE_PAGE_3_STATUS', 43, 'Den Inhalt f�r diese Seite k�nnen Sie �ber <em>Tools->Seiteneditor</em> bearbeiten.<br /><strong>Zust�ndige Datei: <em>define_page_3.php</em></strong><br /><br />BESCHREIBUNG:<br /><em>Link EIN</em> bedeutet, dass der Link in der Infobox sichtbar ist.<br /><em>Text AUS</em> bedeutet, dass der definierte Seitentext nicht eingeblendet wird.<br /><br />OPTIONEN:<br />0= Link EIN, Text AUS<br />1= Link EIN, Text EIN<br />2= Link AUS, Text EIN<br />3= Link AUS, Text AUS<br />', now(), now()),
('Seite 4', 'DEFINE_PAGE_4_STATUS', 43, 'Den Inhalt f�r diese Seite k�nnen Sie �ber <em>Tools->Seiteneditor</em> bearbeiten.<br /><strong>Zust�ndige Datei: <em>define_page_4.php</em></strong><br /><br />BESCHREIBUNG:<br /><em>Link EIN</em> bedeutet, dass der Link in der Infobox sichtbar ist.<br /><em>Text AUS</em> bedeutet, dass der definierte Seitentext nicht eingeblendet wird.<br /><br />OPTIONEN:<br />0= Link EIN, Text AUS<br />1= Link EIN, Text EIN<br />2= Link AUS, Text EIN<br />3= Link AUS, Text AUS<br />', now(), now()),
('Widerrufsrecht', 'DEFINE_WIDERRUFSRECHT_STATUS', 43, 'Den Inhalt f�r diese Seite k�nnen Sie �ber <em>Tools->Seiteneditor</em> bearbeiten.<br /><strong>Zust�ndige Datei: <em>define_widerrufsrecht.php</em></strong><br /><br />BESCHREIBUNG:<br /><em>Link EIN</em> bedeutet, dass der Link in der Infobox sichtbar ist.<br /><em>Text AUS</em> bedeutet, dass der definierte Seitentext nicht eingeblendet wird.<br /><br />OPTIONEN:<br />0= Link EIN, Text AUS<br />1= Link EIN, Text EIN<br />2= Link AUS, Text EIN<br />3= Link AUS, Text AUS<br />', now(), now()),
('Impressum', 'DEFINE_IMPRESSUM_STATUS', 43, 'Den Inhalt f�r diese Seite k�nnen Sie �ber <em>Tools->Seiteneditor</em> bearbeiten.<br /><strong>Zust�ndige Datei: <em>define_impressum.php</em></strong><br /><br />BESCHREIBUNG:<br /><em>Link EIN</em> bedeutet, dass der Link in der Infobox sichtbar ist.<br /><em>Text AUS</em> bedeutet, dass der definierte Seitentext nicht eingeblendet wird.<br /><br />OPTIONEN:<br />0= Link EIN, Text AUS<br />1= Link EIN, Text EIN<br />2= Link AUS, Text EIN<br />3= Link AUS, Text AUS<br />', now(), now()),

# Adminmen� ID 30
('Kopfzeile anzeigen', 'EZPAGES_STATUS_HEADER', 43, 'Sollen die EZ-Pages Kopfzeilen global angezeigt werden?<br />0= NEIN<br />1= JA<br />2= JA (Nur Admin-IP: siehe Shopwartung)<br />Anmerkung: Seite kann nur von Admin gesehen werden', now(), now()),
('Fu�zeile anzeigen', 'EZPAGES_STATUS_FOOTER', 43, 'Sollen die EZ-Pages Fu�zeilen global angezeigt werden?<br />0= NEIN<br />1= JA<br />2= JA (Nur Admin-IP: siehe Shopwartung)<br />Anmerkung: Seite kann nur von Admin gesehen werden', now(), now()),
('Sidebox anzeigen', 'EZPAGES_STATUS_SIDEBOX', 43, 'Sollen die EZ-Pages Sidebox global angezeigt werden?<br />0= NEIN<br />1= JA<br />2= JA (Nur Admin-IP: siehe Shopwartung)<br />Anmerkung: Seite kann nur von Admin gesehen werden', now(), now()),
('Trennzeichen f�r Links in Kopfzeile', 'EZPAGES_SEPARATOR_HEADER', 43, 'Welche Trennzeichen sollen f�r Links in der EZ-Pages Kopfzeile angezeigt werden?<br />Standard = & ::& ', now(), now()),
('Trennzeichen f�r Links in Fu�zeile', 'EZPAGES_SEPARATOR_FOOTER', 43, 'Welche Trennzeichen sollen f�r Links in der EZ-Pages Fu�zeile angezeigt werden?<br />Standard = & ::& ', now(), now()),
('Vor/Zur�ck Schaltfl�chen', 'EZPAGES_SHOW_PREV_NEXT_BUTTONS', 43, 'Sollen Vor/Zur�ck Schaltflachen f�r EZ-Pages angezeigt werden?<br />0=NEIN (keine Schaltfl�chen)<br />1="Weiter"<br />2="Zur�ck/Weiter/Vor"<br /><br />Standard = 2', now(), now()),
('Inhaltsverzeichnis f�r Kapitel anzeigen', 'EZPAGES_SHOW_TABLE_CONTENTS', 43, 'Soll das EZ-Pages Inhaltsverzeichnis f�r Kapitel angezeigt werden?<br />0= NEIN<br />1= JA', now(), now()),
('In diesen Seiten keine Kopfzeile anzeigen', 'EZPAGES_DISABLE_HEADER_DISPLAY_LIST', 43, 'Geben Sie hier die "Seiten" der EZ-Pages an, in der keine Kopfzeile angezeigt werden sollen.<br />Seiten IDs durch Komma getrennt (ohne Leerzeichen) eingeben.<br />Seiten IDs k�nnen in der EZ-Pages Ansicht �ber <em>Admin->Tools->EZ-Pages</em> ermittelt werden.<br />z.B. 3,7<br />oder leer lassen.', now(), now()),
('In diesen Seiten keine Fu�zeile anzeigen', 'EZPAGES_DISABLE_FOOTER_DISPLAY_LIST', 43, 'Geben Sie hier die "Seiten" der EZ-Pages an, in der keine Fu�zeile angezeigt werden sollen.<br />Seiten IDs durch Komma getrennt (ohne Leerzeichen) eingeben.<br />Seiten IDs k�nnen in der EZ-Pages Ansicht �ber <em>Admin->Tools->EZ-Pages</em> ermittelt werden.<br />z.B. 3,7<br />oder leer lassen.', now(), now()),
('In diesen Seiten keine linke Spalte anzeigen', 'EZPAGES_DISABLE_LEFTCOLUMN_DISPLAY_LIST', 43, 'Geben Sie hier die "Seiten" der EZ-Pages an, in der keine linken Spalten (der Sideboxen) angezeigt werden sollen.<br />Seiten IDs durch Komma getrennt (ohne Leerzeichen) eingeben.<br />Seiten IDs k�nnen in der EZ-Pages Ansicht �ber <em>Admin->Tools->EZ-Pages</em> ermittelt werden.<br />z.B. 3,7<br />oder leer lassen.', now(), now()),
('In diesen Seiten keine rechte Spalte anzeigen', 'EZPAGES_DISABLE_RIGHTCOLUMN_DISPLAY_LIST', 43, 'Geben Sie hier die "Seiten" der EZ-Pages an, in der keine rechten Spalten (der Sideboxen) angezeigt werden sollen.<br />Seiten IDs durch Komma getrennt (ohne Leerzeichen) eingeben.<br />Seiten IDs k�nnen in der EZ-Pages Ansicht �ber <em>Admin->Tools->EZ-Pages</em> ermittelt werden.<br />z.B. 3,7<br />oder leer lassen.', now(), now()),

# Deutsche Eintr�ge f�r Versandmodul Versandkostenfrei mit Optionen
('Versandkostenfrei mit Optionen aktivieren', 'MODULE_SHIPPING_FREEOPTIONS_STATUS', 43, 'Wollen Sie "Versandkostenfrei mit Optionen" aktivieren?', now(), now()),
('Versandkosten', 'MODULE_SHIPPING_FREEOPTIONS_COST', 43, 'Die Versandkosten betragen', now(), now()),
('Bearbeitungsgeb�hr', 'MODULE_SHIPPING_FREEOPTIONS_HANDLING', 43, 'Die Bearbeitungsgeb�hr betr�gt', now(), now()),
('Ab Bestellsumme', 'MODULE_SHIPPING_FREEOPTIONS_TOTAL_MIN', 43, 'Versandkostenfrei ab einer Bestellsumme von', now(), now()),
('Bis Bestellsumme', 'MODULE_SHIPPING_FREEOPTIONS_TOTAL_MAX', 43, 'Versandkostenfrei bis zu einer Bestellsumme von', now(), now()),
('Ab Gewicht', 'MODULE_SHIPPING_FREEOPTIONS_WEIGHT_MIN', 43, 'Versandkostenfrei ab einem Gewicht von', now(), now()),
('Bis Gewicht', 'MODULE_SHIPPING_FREEOPTIONS_WEIGHT_MAX', 43, 'Versandkostenfrei bis zu einen Gewicht von', now(), now()),
('Ab Artikelanzahl', 'MODULE_SHIPPING_FREEOPTIONS_ITEMS_MIN', 43, 'Versandkostenfrei ab einer Artikelanzahl von', now(), now()),
('Bis Artikelanzahl', 'MODULE_SHIPPING_FREEOPTIONS_ITEMS_MAX', 43, 'Versandkostenfrei bis zu einer Artikelanzahl von', now(), now()),
('Steuerklasse', 'MODULE_SHIPPING_FREEOPTIONS_TAX_CLASS', 43, 'Welche Steuerklasse soll bei dieser Versandart angewendet werden?', now(), now()),
('Basis der Steuern', 'MODULE_SHIPPING_FREEOPTIONS_TAX_BASIS', 43, 'Auf welcher Basis sollen Steuern berechnet werden? M�gliche Optionen:<br />Versand (Shipping) - auf Basis der Versandadresse des Kunden<br />Rechnung (Billing) - auf Basis der Rechnungsadresse des Kunden<br />Shop (Store) - auf Basis der Shopadresse, wenn die Rechnungs-/Versandadresse des Kunden innerhalb der Zone der Shopadresse liegt', now(), now()),
('Versandzone', 'MODULE_SHIPPING_FREEOPTIONS_ZONE', 43, 'F�r welche L�nder soll diese Versandart angeboten werden?<br/>Die ausw�hlbaren Versandzonen entsprechen den angelegten Steuerzonen und den dort hinterlegten L�nder.', now(), now()),
('Sortierung', 'MODULE_SHIPPING_FREEOPTIONS_SORT_ORDER', 43, 'Bestimmt die Sortierung der angezeigten Versandarten.', now(), now()),

# Deutsche Eintr�ge f�r Order Total Modul Nachnamegeb�hr
('Nachnahmegeb�hr anzeigen', 'MODULE_ORDER_TOTAL_COD_STATUS', 43, 'Wollen Sie die Nachnahmegeb�hr anzeigen?', now(), now()),
('Sort Order', 'MODULE_ORDER_TOTAL_COD_SORT_ORDER', 43, 'Sortierung', now(), now()),
('Nachnahmegeb�hr f�r Versandkostenpauschale', 'MODULE_ORDER_TOTAL_COD_FEE_FLAT', 43, 'Versandkostenpauschale: &lt;L�ndercode&gt;:&lt;Nachnahmegeb�hr&gt;, .... 00 als L�ndercode sorgt daf�r, dass die Nachnahmegeb�hr f�r alle L�nder g�ltig ist. Wenn der L�ndercode 00 ist, muss es der letzte Eintrag sein. Wenn kein Eintrag 00:9.99 vorhanden ist, wird die Nachnahmegeb�hr in fremde L�nder nicht berechnet (unm�glich).', now(), now()),
('Nachnahmegeb�hr f�r standardm��ige Frei Haus Lieferung', 'MODULE_ORDER_TOTAL_COD_FEE_FREE', 43, 'Standardm��ige Frei Haus Lieferung: &lt;L�ndercode&gt;:&lt;Nachnahmegeb�hr&gt;, .... 00 als L�ndercode sorgt daf�r, dass die Nachnahmegeb�hr f�r alle L�nder g�ltig ist. Wenn der L�ndercode 00 ist, muss es der letzte Eintrag sein. Wenn kein Eintrag 00:9.99 vorhanden ist, wird die Nachnahmegeb�hr in fremde L�nder nicht berechnet (unm�glich).', now(), now()),
('Nachnahmegeb�hr f�r "Immer Versandkostenfrei"', 'MODULE_ORDER_TOTAL_COD_FEE_FREESHIPPER', 43, 'Immer Versandkostenfrei: &lt;L�ndercode&gt;:&lt;Nachnahmegeb�hr&gt;, .... 00 als L�ndercode sorgt daf�r, dass die Nachnahmegeb�hr f�r alle L�nder g�ltig ist. Wenn der L�ndercode 00 ist, muss es der letzte Eintrag sein. Wenn kein Eintrag 00:9.99 vorhanden ist, wird die Nachnahmegeb�hr in fremde L�nder nicht berechnet (unm�glich).', now(), now()),
('Nachnahmegeb�hr f�r Versandkosten mit Optionen', 'MODULE_ORDER_TOTAL_COD_FEE_FREEOPTIONS', 43, 'Versandkostenfrei mit Optionen: &lt;L�ndercode&gt;:&lt;Nachnahmegeb�hr&gt;, .... 00 als L�ndercode sorgt daf�r, dass die Nachnahmegeb�hr f�r alle L�nder g�ltig ist. Wenn der L�ndercode 00 ist, muss es der letzte Eintrag sein. Wenn kein Eintrag 00:9.99 vorhanden ist, wird die Nachnahmegeb�hr in fremde L�nder nicht berechnet (unm�glich).', now(), now()),
('Nachnahmegeb�hr f�r Versandkosten nach Gewicht', 'MODULE_ORDER_TOTAL_COD_FEE_PERWEIGHTUNIT', 43, 'Versandkosten nach Gewicht: &lt;L�ndercode&gt;:&lt;Nachnahmegeb�hr&gt;, .... 00 als L�ndercode sorgt daf�r, dass die Nachnahmegeb�hr f�r alle L�nder g�ltig ist. Wenn der L�ndercode 00 ist, muss es der letzte Eintrag sein. Wenn kein Eintrag 00:9.99 vorhanden ist, wird die Nachnahmegeb�hr in fremde L�nder nicht berechnet (unm�glich).', now(), now()),
('Nachnahmegeb�hr f�r Versandkosten pro St�ck', 'MODULE_ORDER_TOTAL_COD_FEE_ITEM', 43, 'Versandkosten pro St�ck: &lt;L�ndercode&gt;:&lt;Nachnahmegeb�hr&gt;, .... 00 als L�ndercode sorgt daf�r, dass die Nachnahmegeb�hr f�r alle L�nder g�ltig ist. Wenn der L�ndercode 00 ist, muss es der letzte Eintrag sein. Wenn kein Eintrag 00:9.99 vorhanden ist, wird die Nachnahmegeb�hr in fremde L�nder nicht berechnet (unm�glich).', now(), now()),
('Nachnahmegeb�hr f�r "Tabellarische Versandkosten"', 'MODULE_ORDER_TOTAL_COD_FEE_TABLE', 43, 'Tabellarische Versandkosten: &lt;L�ndercode&gt;:&lt;Nachnahmegeb�hr&gt;, .... 00 als L�ndercode sorgt daf�r, dass die Nachnahmegeb�hr f�r alle L�nder g�ltig ist. Wenn der L�ndercode 00 ist, muss es der letzte Eintrag sein. Wenn kein Eintrag 00:9.99 vorhanden ist, wird die Nachnahmegeb�hr in fremde L�nder nicht berechnet (unm�glich).', now(), now()),
('Nachnahmegeb�hr f�r UPS', 'MODULE_ORDER_TOTAL_COD_FEE_UPS', 43, 'UPS: &lt;L�ndercode&gt;:&lt;Nachnahmegeb�hr&gt;, .... 00 als L�ndercode sorgt daf�r, dass die Nachnahmegeb�hr f�r alle L�nder g�ltig ist. Wenn der L�ndercode 00 ist, muss es der letzte Eintrag sein. Wenn kein Eintrag 00:9.99 vorhanden ist, wird die Nachnahmegeb�hr in fremde L�nder nicht berechnet (unm�glich).', now(), now()),
('Nachnahmegeb�hr f�r USPS', 'MODULE_ORDER_TOTAL_COD_FEE_USPS', 43, 'USPS: &lt;L�ndercode&gt;:&lt;Nachnahmegeb�hr&gt;, .... 00 als L�ndercode sorgt daf�r, dass die Nachnahmegeb�hr f�r alle L�nder g�ltig ist. Wenn der L�ndercode 00 ist, muss es der letzte Eintrag sein. Wenn kein Eintrag 00:9.99 vorhanden ist, wird die Nachnahmegeb�hr in fremde L�nder nicht berechnet (unm�glich).', now(), now()),
('Nachnahmegeb�hr f�r Versandkosten nach Zonen', 'MODULE_ORDER_TOTAL_COD_FEE_ZONES', 43, 'Versandkosten nach Zonen: &lt;L�ndercode&gt;:&lt;Nachnahmegeb�hr&gt;, .... 00 als L�ndercode sorgt daf�r, dass die Nachnahmegeb�hr f�r alle L�nder g�ltig ist. Wenn der L�ndercode 00 ist, muss es der letzte Eintrag sein. Wenn kein Eintrag 00:9.99 vorhanden ist, wird die Nachnahmegeb�hr in fremde L�nder nicht berechnet (unm�glich).', now(), now()),
('Nachnahmegeb�hr f�r die �sterreichische Post', 'MODULE_ORDER_TOTAL_COD_FEE_AP', 43, '�sterreichische Post: &lt;L�ndercode&gt;:&lt;Nachnahmegeb�hr&gt;, .... 00 als L�ndercode sorgt daf�r, dass die Nachnahmegeb�hr f�r alle L�nder g�ltig ist. Wenn der L�ndercode 00 ist, muss es der letzte Eintrag sein. Wenn kein Eintrag 00:9.99 vorhanden ist, wird die Nachnahmegeb�hr in fremde L�nder nicht berechnet (unm�glich).', now(), now()),
('Nachnahmegeb�hr f�r die deutsche Post', 'MODULE_ORDER_TOTAL_COD_FEE_DP', 43, 'Deutsche Post: &lt;L�ndercode&gt;:&lt;Nachnahmegeb�hr&gt;, .... 00 als L�ndercode sorgt daf�r, dass die Nachnahmegeb�hr f�r alle L�nder g�ltig ist. Wenn der L�ndercode 00 ist, muss es der letzte Eintrag sein. Wenn kein Eintrag 00:9.99 vorhanden ist, wird die Nachnahmegeb�hr in fremde L�nder nicht berechnet (unm�glich).', now(), now()),
('Nachnahmegeb�hr f�r Servicepakke', 'MODULE_ORDER_TOTAL_COD_FEE_SERVICEPAKKE', 43, 'Servicepakke: &lt;L�ndercode&gt;:&lt;Nachnahmegeb�hr&gt;, .... 00 als L�ndercode sorgt daf�r, dass die Nachnahmegeb�hr f�r alle L�nder g�ltig ist. Wenn der L�ndercode 00 ist, muss es der letzte Eintrag sein. Wenn kein Eintrag 00:9.99 vorhanden ist, wird die Nachnahmegeb�hr in fremde L�nder nicht berechnet (unm�glich).', now(), now()),
('Nachnahmegeb�hr f�r FedEx', 'MODULE_ORDER_TOTAL_COD_FEE_FEDEX', 43, 'FedEx: &lt;L�ndercode&gt;:&lt;Nachnahmegeb�hr&gt;, .... 00 als L�ndercode sorgt daf�r, dass die Nachnahmegeb�hr f�r alle L�nder g�ltig ist. Wenn der L�ndercode 00 ist, muss es der letzte Eintrag sein. Wenn kein Eintrag 00:9.99 vorhanden ist, wird die Nachnahmegeb�hr in fremde L�nder nicht berechnet (unm�glich).', now(), now()),
('Steuerklasse', 'MODULE_ORDER_TOTAL_COD_TAX_CLASS', 43, 'Welche Steuerklasse soll angewendet werden?', now(), now()),

# Vataddon
('Anzeige incl. Mwst. zzgl. Versandkosten', 'DISPLAY_VATADDON_WHERE', 43, 'Wollen Sie unterhalb der Preise den Zusatz incl. bzw. excl. Mwst. zzgl. Versandkosten anzeigen?<br/>O=Nein, Anzeige komplett deaktiviert<br/>ALL = Anzeige �berall im Shop aktiv<br/>product_info = Anzeige nur auf der Artikeldetailseite<br/><br/>Hinweis: Den Text dieser Anzeige k�nnen Sie in folgender Datei �ndern: includes/languages/german/extra_definitions/rl.vat_info.php', now(), now());

#####################################################################################################
UPDATE configuration SET configuration_value = 'de' WHERE configuration_key = 'DEFAULT_LANGUAGE' LIMIT 1 ;



###########################################################################################################

CREATE TABLE IF NOT EXISTS product_type_layout_language (
  configuration_id int(11) NOT NULL auto_increment,
  configuration_title text NOT NULL,
  configuration_key varchar(255) NOT NULL default '',
  languages_id int(11) NOT NULL default '1',
  configuration_description text NOT NULL,
  last_modified datetime default NULL,
  date_added datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (configuration_id),
  UNIQUE KEY config_lang (configuration_key,languages_id)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=144 ;
#
# Daten f�r Tabelle product_type_layout_language
#
REPLACE INTO product_type_layout_language (configuration_title, configuration_key, languages_id, configuration_description, last_modified, date_added) VALUES
('Artikelnummer anzeigen', 'SHOW_PRODUCT_INFO_MODEL', 43, 'Soll die Artikelnummer auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Gewicht anzeigen', 'SHOW_PRODUCT_INFO_WEIGHT', 43, 'Soll das Gewicht auf der Produktinfoseite angezeigt werden<br/> 0= AUS 1= AN', now(), now()),
('Attribut Gewicht anzeigen', 'SHOW_PRODUCT_INFO_WEIGHT_ATTRIBUTES', 43, 'Soll das Attribut Gewicht auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Hersteller anzeigen', 'SHOW_PRODUCT_INFO_MANUFACTURER', 43, 'Soll der Hersteller auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Menge im Warenkorb anzeigen', 'SHOW_PRODUCT_INFO_IN_CART_QTY', 43, 'Soll die bereits im Warenkorb vorhandene Menge diese Artikels auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Lagermenge anzeigen', 'SHOW_PRODUCT_INFO_QUANTITY', 43, 'Soll die aktuelle Lagermenge auf der Produktinfoseite angezeigt werden<br/> 0= AUS 1= AN', now(), now()),
('Anzahl der Artikelbewertungen anzeigen', 'SHOW_PRODUCT_INFO_REVIEWS_COUNT', 43, 'Soll die Anzehl der Artikelbewertungen auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Button "Artikel bewerten" anzeigen', 'SHOW_PRODUCT_INFO_REVIEWS', 43, 'Soll der Button "Artikel bewerten" auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('"Verf�gbar am" anzeigen', 'SHOW_PRODUCT_INFO_DATE_AVAILABLE', 43, 'Soll auf der Produktinfoseite "Verf�gbar am" angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('"Hinzugef�gt am" anzeigen', 'SHOW_PRODUCT_INFO_DATE_ADDED', 43, 'Soll auf der Produktinfoseite "Hinzugef�gt am" angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Artikel URL anzeigen', 'SHOW_PRODUCT_INFO_URL', 43, 'Soll die Artikel URL auf der Produktinfoseite angezeigt werden? 0= AUS 1= AN', now(), now()),
('Zus�tzliche Artikelbilder anzeigen', 'SHOW_PRODUCT_INFO_ADDITIONAL_IMAGES', 43, 'Sollen auf der Produktinfoseite zus�tzliche Artikelbilder angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Preis "ab.." anzeigen', 'SHOW_PRODUCT_INFO_STARTING_AT', 43, 'Soll bei Produkten mit Attributen die Preisanzeige mit "ab" beginnen?<br/> 0= AUS 1= AN', now(), now()),
('Button "Einem Freund empfehlen" anzeigen', 'SHOW_PRODUCT_INFO_TELL_A_FRIEND', 43, 'Soll der Button "Einem Freund empfehlen" auf der Produktinfoseite angezeigt werden?<br /><br />HINWEIS: Das Deaktivieren dieser Einstellung hat keine Auswirkungen auf die entsprechende Sidebox. Das Deaktivieren der Sidebox deaktiviert nicht diesen Button<br />0= AUS 1= AN', now(), now()),
('Bild "Versandkostenfreie Lieferung" anzeigen', 'SHOW_PRODUCT_INFO_ALWAYS_FREE_SHIPPING_IMAGE_SWITCH', 43, 'Soll das Bild bzw. der Text f�r "Versandkostenfreie Lieferung" im Shop angezeigt werden?', now(), now()),
('Artikelpreis Steuerklasse - Standardeinstellung', 'DEFAULT_PRODUCT_TAX_CLASS_ID', 43, 'Welche Steuerklasse soll jeder neu angelegte Artikel haben<br/>Bitte geben Sie die ID der Steuerklasse ein.', now(), now()),
('Artikel ist virtuell - Standardeinstellung', 'DEFAULT_PRODUCT_PRODUCTS_VIRTUAL', 43, 'Soll jeder neu angelegte Artikel ein virtueller sein?', now(), now()),
('Artikel "immer versandkostenfrei" - Standardeinstellung', 'DEFAULT_PRODUCT_PRODUCTS_IS_ALWAYS_FREE_SHIPPING', 43, 'Welche Einstellung soll beim Anlegen eines neuen Artikels standardm��ig aktiviert werden?<br />JA, Immer versandkostenfrei AN<br />NEIN, Immer versandkostenfrei AUS<br />Spezial, Artikel/Download ben�tigt Versand', now(), now()),

('Artikelnummer anzeigen', 'SHOW_PRODUCT_MUSIC_INFO_MODEL', 43, 'Soll die Artikelnummer auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Gewicht anzeigen', 'SHOW_PRODUCT_MUSIC_INFO_WEIGHT', 43, 'Soll das Gewicht auf der Produktinfoseite angezeigt werden<br/> 0= AUS 1= AN', now(), now()),
('Attribut Gewicht anzeigen', 'SHOW_PRODUCT_MUSIC_INFO_WEIGHT_ATTRIBUTES', 43, 'Soll das Attribut Gewicht auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('K�nstler anzeigen', 'SHOW_PRODUCT_MUSIC_INFO_ARTIST', 43, 'Soll der K�nstler auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Musik Genre anzeigen', 'SHOW_PRODUCT_MUSIC_INFO_GENRE', 43, 'Soll das Musik Genre auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Record Label anzeigen', 'SHOW_PRODUCT_MUSIC_INFO_RECORD_COMPANY', 43, 'Soll das Record Label auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Menge im Warenkorb anzeigen', 'SHOW_PRODUCT_MUSIC_INFO_IN_CART_QTY', 43, 'Soll die bereits im Warenkorb vorhandene Menge diese Artikels auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Lagermenge anzeigen', 'SHOW_PRODUCT_MUSIC_INFO_QUANTITY', 43, 'Soll die aktuelle Lagermenge auf der Produktinfoseite angezeigt werden<br/> 0= AUS 1= AN', now(), now()),
('Anzahl der Artikelbewertungen anzeigen', 'SHOW_PRODUCT_MUSIC_INFO_REVIEWS_COUNT', 43, 'Soll die Anzehl der Artikelbewertungen auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Button "Artikel bewerten" anzeigen', 'SHOW_PRODUCT_MUSIC_INFO_REVIEWS', 43, 'Soll der Button "Artikel bewerten" auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('"Verf�gbar am" anzeigen', 'SHOW_PRODUCT_MUSIC_INFO_DATE_AVAILABLE', 43, 'Soll auf der Produktinfoseite "Verf�gbar am" angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('"Hinzugef�gt am" anzeigen', 'SHOW_PRODUCT_MUSIC_INFO_DATE_ADDED', 43, 'Soll auf der Produktinfoseite "Hinzugef�gt am" angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Preis "ab.." anzeigen', 'SHOW_PRODUCT_MUSIC_INFO_STARTING_AT', 43, 'Soll bei Produkten mit Attributen die Preisanzeige mit "ab" beginnen?<br/> 0= AUS 1= AN', now(), now()),
('Zus�tzliche Artikelbilder anzeigen', 'SHOW_PRODUCT_MUSIC_INFO_ADDITIONAL_IMAGES', 43, 'Sollen auf der Produktinfoseite zus�tzliche Artikelbilder angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Button "Einem Freund empfehlen" anzeigen', 'SHOW_PRODUCT_MUSIC_INFO_TELL_A_FRIEND', 43, 'Soll der Button "Einem Freund empfehlen" auf der Produktinfoseite angezeigt werden?<br /><br />HINWEIS: Das Deaktivieren dieser Einstellung hat keine Auswirkungen auf die entsprechende Sidebox. Das Deaktivieren der Sidebox deaktiviert nicht diesen Button<br />0= AUS 1= AN', now(), now()),
('Bild "Versandkostenfreie Lieferung" anzeigen', 'SHOW_PRODUCT_MUSIC_INFO_ALWAYS_FREE_SHIPPING_IMAGE_SWITCH', 43, 'Soll das Bild bzw. der Text f�r "Versandkostenfreie Lieferung" im Shop angezeigt werden?', now(), now()),
('Artikelpreis Steuerklasse - Standardeinstellung', 'DEFAULT_PRODUCT_MUSIC_TAX_CLASS_ID', 43, 'Welche Steuerklasse soll jeder neu angelegte Artikel haben<br/>Bitte geben Sie die ID der Steuerklasse ein.', now(), now()),
('Artikel ist virtuell - Standardeinstellung', 'DEFAULT_PRODUCT_MUSIC_PRODUCTS_VIRTUAL', 43, 'Soll jeder neu angelegte Artikel ein virtueller sein?', now(), now()),
('Artikel "immer versandkostenfrei" - Standardeinstellung', 'DEFAULT_PRODUCT_MUSIC_PRODUCTS_IS_ALWAYS_FREE_SHIPPING', 43, 'Welche Einstellung soll beim Anlegen eines neuen Artikels standardm��ig aktiviert werden?<br />JA, Immer versandkostenfrei AN<br />NEIN, Immer versandkostenfrei AUS<br />Spezial, Artikel/Download ben�tigt Versand', now(), now()),

('Anzahl der Artikelbewertungen anzeigen', 'SHOW_DOCUMENT_GENERAL_INFO_REVIEWS_COUNT', 43, 'Soll die Anzahl der Artikelbewertungen auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Button "Artikel bewerten" anzeigen', 'SHOW_DOCUMENT_PRODUCT_INFO_REVIEWS', 43, 'Soll der Button "Artikel bewerten" auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('"Verf�gbar am" anzeigen', 'SHOW_DOCUMENT_GENERAL_INFO_DATE_AVAILABLE', 43, 'Soll auf der Produktinfoseite "Verf�gbar am" angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('"Hinzugef�gt am" anzeigen', 'SHOW_DOCUMENT_GENERAL_INFO_DATE_ADDED', 43, 'Soll auf der Produktinfoseite "Hinzugef�gt am" angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Button "Einem Freund empfehlen" anzeigen', 'SHOW_DOCUMENT_GENERAL_INFO_TELL_A_FRIEND', 43, 'Soll der Button "Einem Freund empfehlen" auf der Produktinfoseite angezeigt werden?<br /><br />HINWEIS: Das Deaktivieren dieser Einstellung hat keine Auswirkungen auf die entsprechende Sidebox. Das Deaktivieren der Sidebox deaktiviert nicht diesen Button<br />0= AUS 1= AN', now(), now()),
('Artikel URL anzeigen', 'SHOW_DOCUMENT_GENERAL_INFO_URL', 43, 'Soll die Artikel URL auf der Produktinfoseite angezeigt werden? 0= AUS 1= AN', now(), now()),
('Zus�tzliche Artikelbilder anzeigen', 'SHOW_DOCUMENT_GENERAL_INFO_ADDITIONAL_IMAGES', 43, 'Sollen auf der Produktinfoseite zus�tzliche Artikelbilder angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Artikelnummer anzeigen', 'SHOW_DOCUMENT_PRODUCT_INFO_MODEL', 43, 'Soll die Artikelnummer auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Gewicht anzeigen', 'SHOW_DOCUMENT_PRODUCT_INFO_WEIGHT', 43, 'Soll das Gewicht auf der Produktinfoseite angezeigt werden<br/> 0= AUS 1= AN', now(), now()),
('Attribut Gewicht anzeigen', 'SHOW_DOCUMENT_PRODUCT_INFO_WEIGHT_ATTRIBUTES', 43, 'Soll das Attribut Gewicht auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Hersteller anzeigen', 'SHOW_DOCUMENT_PRODUCT_INFO_MANUFACTURER', 43, 'Soll der Hersteller auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Menge im Warenkorb anzeigen', 'SHOW_DOCUMENT_PRODUCT_INFO_IN_CART_QTY', 43, 'Soll die bereits im Warenkorb vorhandene Menge diese Artikels auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Lagermenge anzeigen', 'SHOW_DOCUMENT_PRODUCT_INFO_QUANTITY', 43, 'Soll die aktuelle Lagermenge auf der Produktinfoseite angezeigt werden<br/> 0= AUS 1= AN', now(), now()),
('Anzahl der Artikelbewertungen anzeigen', 'SHOW_DOCUMENT_PRODUCT_INFO_REVIEWS_COUNT', 43, 'Soll die Anzehl der Artikelbewertungen auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('"Verf�gbar am" anzeigen', 'SHOW_DOCUMENT_PRODUCT_INFO_DATE_AVAILABLE', 43, 'Soll auf der Produktinfoseite "Verf�gbar am" angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('"Hinzugef�gt am" anzeigen', 'SHOW_DOCUMENT_PRODUCT_INFO_DATE_ADDED', 43, 'Soll auf der Produktinfoseite "Hinzugef�gt am" angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Artikel URL anzeigen', 'SHOW_DOCUMENT_PRODUCT_INFO_URL', 43, 'Soll die Artikel URL auf der Produktinfoseite angezeigt werden? 0= AUS 1= AN', now(), now()),
('Zus�tzliche Artikelbilder anzeigen', 'SHOW_DOCUMENT_PRODUCT_INFO_ADDITIONAL_IMAGES', 43, 'Sollen auf der Produktinfoseite zus�tzliche Artikelbilder angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Preis "ab.." anzeigen', 'SHOW_DOCUMENT_PRODUCT_INFO_STARTING_AT', 43, 'Soll bei Produkten mit Attributen die Preisanzeige mit "ab" beginnen?<br/> 0= AUS 1= AN', now(), now()),
('Button "Einem Freund empfehlen" anzeigen', 'SHOW_DOCUMENT_PRODUCT_INFO_TELL_A_FRIEND', 43, 'Soll der Button "Einem Freund empfehlen" auf der Produktinfoseite angezeigt werden?<br /><br />HINWEIS: Das Deaktivieren dieser Einstellung hat keine Auswirkungen auf die entsprechende Sidebox. Das Deaktivieren der Sidebox deaktiviert nicht diesen Button<br />0= AUS 1= AN', now(), now()),
('Bild "Versandkostenfreie Lieferung" anzeigen', 'SHOW_DOCUMENT_PRODUCT_INFO_ALWAYS_FREE_SHIPPING_IMAGE_SWITCH', 43, 'Soll das Bild bzw. der Text f�r "Versandkostenfreie Lieferung" im Shop angezeigt werden?', now(), now()),
('Artikelpreis Steuerklasse - Standardeinstellung', 'DEFAULT_DOCUMENT_PRODUCT_TAX_CLASS_ID', 43, 'Welche Steuerklasse soll jeder neu angelegte Artikel haben<br/>Bitte geben Sie die ID der Steuerklasse ein.', now(), now()),
('Artikel ist virtuell - Standardeinstellung', 'DEFAULT_DOCUMENT_PRODUCT_PRODUCTS_VIRTUAL', 43, 'Soll jeder neu angelegte Artikel ein virtueller sein?', now(), now()),
('Artikel "immer versandkostenfrei" - Standardeinstellung', 'DEFAULT_DOCUMENT_PRODUCT_PRODUCTS_IS_ALWAYS_FREE_SHIPPING', 43, 'Welche Einstellung soll beim Anlegen eines neuen Artikels standardm��ig aktiviert werden?<br />JA, Immer versandkostenfrei AN<br />NEIN, Immer versandkostenfrei AUS<br />Spezial, Artikel/Download ben�tigt Versand', now(), now()),

('Artikelnummer anzeigen', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_MODEL', 43, 'Soll die Artikelnummer auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Gewicht anzeigen', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_WEIGHT', 43, 'Soll das Gewicht auf der Produktinfoseite angezeigt werden<br/> 0= AUS 1= AN', now(), now()),
('Attribut Gewicht anzeigen', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_WEIGHT_ATTRIBUTES', 43, 'Soll das Attribut Gewicht auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Hersteller anzeigen', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_MANUFACTURER', 43, 'Soll der Hersteller auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Menge im Warenkorb anzeigen', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_IN_CART_QTY', 43, 'Soll die bereits im Warenkorb vorhandene Menge diese Artikels auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Lagermenge anzeigen', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_QUANTITY', 43, 'Soll die aktuelle Lagermenge auf der Produktinfoseite angezeigt werden<br/> 0= AUS 1= AN', now(), now()),
('Anzahl der Artikelbewertungen anzeigen', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_REVIEWS_COUNT', 43, 'Soll die Anzehl der Artikelbewertungen auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Button "Artikel bewerten" anzeigen', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_REVIEWS', 43, 'Soll der Button "Artikel bewerten" auf der Produktinfoseite angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('"Verf�gbar am" anzeigen', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_DATE_AVAILABLE', 43, 'Soll auf der Produktinfoseite "Verf�gbar am" angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('"Hinzugef�gt am" anzeigen', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_DATE_ADDED', 43, 'Soll auf der Produktinfoseite "Hinzugef�gt am" angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Artikel URL anzeigen', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_URL', 43, 'Soll die Artikel URL auf der Produktinfoseite angezeigt werden? 0= AUS 1= AN', now(), now()),
('Zus�tzliche Artikelbilder anzeigen', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_ADDITIONAL_IMAGES', 43, 'Sollen auf der Produktinfoseite zus�tzliche Artikelbilder angezeigt werden?<br/> 0= AUS 1= AN', now(), now()),
('Preis "ab.." anzeigen', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_STARTING_AT', 43, 'Soll bei Produkten mit Attributen die Preisanzeige mit "ab" beginnen?<br/> 0= AUS 1= AN', now(), now()),
('Button "Einem Freund empfehlen" anzeigen', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_TELL_A_FRIEND', 43, 'Soll der Button "Einem Freund empfehlen" auf der Produktinfoseite angezeigt werden?<br /><br />HINWEIS: Das Deaktivieren dieser Einstellung hat keine Auswirkungen auf die entsprechende Sidebox. Das Deaktivieren der Sidebox deaktiviert nicht diesen Button<br />0= AUS 1= AN', now(), now()),
('Bild "Versandkostenfreie Lieferung" anzeigen', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_ALWAYS_FREE_SHIPPING_IMAGE_SWITCH', 43, 'Soll das Bild bzw. der Text f�r "Versandkostenfreie Lieferung" im Shop angezeigt werden?', now(), now()),
('Artikelpreis Steuerklasse - Standardeinstellung', 'DEFAULT_PRODUCT_FREE_SHIPPING_TAX_CLASS_ID', 43, 'Welche Steuerklasse soll jeder neu angelegte Artikel haben<br/>Bitte geben Sie die ID der Steuerklasse ein.', now(), now()),
('Artikel ist virtuell - Standardeinstellung', 'DEFAULT_PRODUCT_FREE_SHIPPING_PRODUCTS_VIRTUAL', 43, 'Soll jeder neu angelegte Artikel ein virtueller sein?', now(), now()),
('Artikel "immer versandkostenfrei" - Standardeinstellung', 'DEFAULT_PRODUCT_FREE_SHIPPING_PRODUCTS_IS_ALWAYS_FREE_SHIPPING', 43, 'Welche Einstellung soll beim Anlegen eines neuen Artikels standardm��ig aktiviert werden?<br />JA, Immer versandkostenfrei AN<br />NEIN, Immer versandkostenfrei AUS<br />Spezial, Artikel/Download ben�tigt Versand', now(), now()),

('Metatag Titel Standardeinstellung - Produkt Titel', 'SHOW_PRODUCT_INFO_METATAGS_TITLE_STATUS', 43, 'Soll der Produkt Titel im Metatag Titel angezeigt werden<br/>0= AUS 1= AN', now(), now()),
('Metatag Titel Standardeinstellung - Artikelname', 'SHOW_PRODUCT_INFO_METATAGS_PRODUCTS_NAME_STATUS', 43, 'Soll der Artikelname im Metatag Titel angezeigt werden<br/>0= AUS 1= AN', now(), now()),
('Metatag Titel Standardeinstellung - Artikelnummer', 'SHOW_PRODUCT_INFO_METATAGS_MODEL_STATUS', 43, 'Soll die Artikelnummer im Metatag Titel angezeigt werden<br/>0= AUS 1= AN', now(), now()),
('Metatag Titel Standardeinstellung - Artikelpreis', 'SHOW_PRODUCT_INFO_METATAGS_PRICE_STATUS', 43, 'Soll der Artikelpreis im Metatag Titel angezeigt werden<br/>0= AUS 1= AN', now(), now()),
('Metatag Titel Standardeinstellung - Artikel Tagline', 'SHOW_PRODUCT_INFO_METATAGS_TITLE_TAGLINE_STATUS', 43, 'Soll die Artikel Tagline im Metatag Titel angezeigt werden<br/>0= AUS 1= AN', now(), now()),
('Metatag Titel Standardeinstellung - Produkt Titel', 'SHOW_PRODUCT_MUSIC_INFO_METATAGS_TITLE_STATUS', 43, 'Soll der Produkt Titel im Metatag Titel angezeigt werden<br/>0= AUS 1= AN', now(), now()),
('Metatag Titel Standardeinstellung - Artikelname', 'SHOW_PRODUCT_MUSIC_INFO_METATAGS_PRODUCTS_NAME_STATUS', 43, 'Soll der Artikelname im Metatag Titel angezeigt werden<br/>0= AUS 1= AN', now(), now()),
('Metatag Titel Standardeinstellung - Artikelnummer', 'SHOW_PRODUCT_MUSIC_INFO_METATAGS_MODEL_STATUS', 43, 'Soll die Artikelnummer im Metatag Titel angezeigt werden<br/>0= AUS 1= AN', now(), now()),
('Metatag Titel Standardeinstellung - Artikelpreis', 'SHOW_PRODUCT_MUSIC_INFO_METATAGS_PRICE_STATUS', 43, 'Soll der Artikelpreis im Metatag Titel angezeigt werden<br/>0= AUS 1= AN', now(), now()),
('Metatag Titel Standardeinstellung - Artikel Tagline', 'SHOW_PRODUCT_MUSIC_INFO_METATAGS_TITLE_TAGLINE_STATUS', 43, 'Soll die Artikel Tagline im Metatag Titel angezeigt werden<br/>0= AUS 1= AN', now(), now()),
('Metatag Titel Standardeinstellung - Dokument Titel', 'SHOW_DOCUMENT_GENERAL_INFO_METATAGS_TITLE_STATUS', 43, 'Soll der Dokument Titel im Metatag Titel angezeigt werden<br/>0= AUS 1= AN', now(), now()),
('Metatag Titel Standardeinstellung - Dokumentname', 'SHOW_DOCUMENT_GENERAL_INFO_METATAGS_PRODUCTS_NAME_STATUS', 43, 'Soll der Dokumentname im Metatag Titel angezeigt werden<br/>0= AUS 1= AN', now(), now()),
('Metatag Titel Standardeinstellung - Dokument Tagline', 'SHOW_DOCUMENT_GENERAL_INFO_METATAGS_TITLE_TAGLINE_STATUS', 43, 'Soll die Dokument Tagline im Metatag Titel angezeigt werden<br/>0= AUS 1= AN', now(), now()),
('Metatag Titel Standardeinstellung - Dokument Titel', 'SHOW_DOCUMENT_PRODUCT_INFO_METATAGS_TITLE_STATUS', 43, 'Soll der Dokument Titel im Metatag Titel angezeigt werden<br/>0= AUS 1= AN', now(), now()),
('Metatag Titel Standardeinstellung - Dokumentname', 'SHOW_DOCUMENT_PRODUCT_INFO_METATAGS_PRODUCTS_NAME_STATUS', 43, 'Soll der Dokumentname im Metatag Titel angezeigt werden<br/>0= AUS 1= AN', now(), now()),
('Metatag Titel Standardeinstellung - Dokumentnummer', 'SHOW_DOCUMENT_PRODUCT_INFO_METATAGS_MODEL_STATUS', 43, 'Soll die Dokumentnummer im Metatag Titel angezeigt werden<br/>0= AUS 1= AN', now(), now()),
('Metatag Titel Standardeinstellung - Dokumentpreis', 'SHOW_DOCUMENT_PRODUCT_INFO_METATAGS_PRICE_STATUS', 43, 'Soll der Dokumentpreis im Metatag Titel angezeigt werden<br/>0= AUS 1= AN', now(), now()),
('Metatag Titel Standardeinstellung - Dokument Tagline', 'SHOW_DOCUMENT_PRODUCT_INFO_METATAGS_TITLE_TAGLINE_STATUS', 43, 'Soll die Dokument Tagline im Metatag Titel angezeigt werden<br/>0= AUS 1= AN', now(), now()),
('Metatag Titel Standardeinstellung - Produkt Titel', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_METATAGS_TITLE_STATUS', 43, 'Soll der Produkt Titel im Metatag Titel angezeigt werden<br/>0= AUS 1= AN', now(), now()),
('Metatag Titel Standardeinstellung - Artikelname', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_METATAGS_PRODUCTS_NAME_STATUS', 43, 'Soll der Artikelname im Metatag Titel angezeigt werden<br/>0= AUS 1= AN', now(), now()),
('Metatag Titel Standardeinstellung - Artikelnummer', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_METATAGS_MODEL_STATUS', 43, 'Soll die Artikelnummer im Metatag Titel angezeigt werden<br/>0= AUS 1= AN', now(), now()),
('Metatag Titel Standardeinstellung - Artikelpreis', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_METATAGS_PRICE_STATUS', 43, 'Soll der Artikelpreis im Metatag Titel angezeigt werden<br/>0= AUS 1= AN', now(), now()),
('Metatag Titel Standardeinstellung - Artikel Tagline', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_METATAGS_TITLE_TAGLINE_STATUS', 43, 'Soll die Artikel Tagline im Metatag Titel angezeigt werden<br/>0= AUS 1= AN', now(), now()),

('PRODUCT Attribut wird nur zur Darstellung ben�tigt - Standardeinstellung', 'DEFAULT_PRODUCT_ATTRIBUTES_DISPLAY_ONLY', 43, 'PRODUCT Attribut wird nur zur Anzeige ben�tigt<br />0= NEIN 1= JA', now(), now()),
('PRODUCT Attribut ist kostenlos - Standardeinstellung', 'DEFAULT_PRODUCT_ATTRIBUTE_IS_FREE', 43, 'PRODUCT Attribut ist kostenlos<br />Attribut ist kostenlos, wenn der Artikel kostenlos ist.<br />0= NEIN 1= JA', now(), now()),
('PRODUCT Attribut ist standardm��ig markiert - Standardeinstellung', 'DEFAULT_PRODUCT_ATTRIBUTES_DEFAULT', 43, 'PRODUCT Attribut ist standardm��ig markiert<br />0= NEIN 1= JA', now(), now()),
('PRODUCT Attribut ist preisreduziert - Standardeinstellung', 'DEFAULT_PRODUCT_ATTRIBUTES_DISCOUNTED', 43, 'PRODUCT Attribut ist preisreduziert<br />Angewendete Rabatte des Artikels (Sonderpreis/Abverkauf) werden auch f�r die Attribute verwendet<br />0= NEIN 1= JA', now(), now()),
('PRODUCT Attribut ist inkludiert im Basispreis - Standardeinstellung', 'DEFAULT_PRODUCT_ATTRIBUTES_PRICE_BASE_INCLUDED', 43, 'PRODUCT Attribut ist inkludiert im Basispreis<br />Inkludiert im Basispreis bei "Preis per Attribut"<br />0= NEIN 1= JA', now(), now()),
('PRODUCT Attribut wird ben�tigt - Standardeinstellung', 'DEFAULT_PRODUCT_ATTRIBUTES_REQUIRED', 43, 'PRODUCT Attribut wird ben�tigt<br />Attribut wird f�r Text ben�tigt<br />0= NEIN 1= JA', now(), now()),
('PRODUCT Attribut Preis Pr�fix - Standardeinstellung', 'DEFAULT_PRODUCT_PRICE_PREFIX', 43, 'PRODUCT Attribut Preis Pr�fix<br />Standard Preis Pr�fix<br />Leer, + oder -', now(), now()),
('PRODUCT Attribut Gewicht Pr�fix - Standardeinstellung', 'DEFAULT_PRODUCT_PRODUCTS_ATTRIBUTES_WEIGHT_PREFIX', 43, 'PRODUCT Attribut Gewicht Pr�fix<br />Standard Gewicht Pr�fix<br />Leer, + oder -', now(), now()),

('MUSIC Attribut wird nur zur Darstellung ben�tigt - Standardeinstellung', 'DEFAULT_PRODUCT_MUSIC_ATTRIBUTES_DISPLAY_ONLY', 43, 'MUSIC Attribut wird nur zur Anzeige ben�tigt<br />0= NEIN 1= JA', now(), now()),
('MUSIC Attribut ist kostenlos - Standardeinstellung', 'DEFAULT_PRODUCT_MUSIC_ATTRIBUTE_IS_FREE', 43, 'MUSIC Attribut ist kostenlos<br />Attribut ist kostenlos, wenn der Artikel kostenlos ist.<br />0= NEIN 1= JA', now(), now()),
('MUSIC Attribut ist standardm��ig markiert - Standardeinstellung', 'DEFAULT_PRODUCT_MUSIC_ATTRIBUTES_DEFAULT', 43, 'MUSIC Attribut ist standardm��ig markiert<br />0= NEIN 1= JA', now(), now()),
('MUSIC Attribut ist preisreduziert - Standardeinstellung', 'DEFAULT_PRODUCT_MUSIC_ATTRIBUTES_DISCOUNTED', 43, 'MUSIC Attribut ist preisreduziert<br />Angewendete Rabatte des Artikels (Sonderpreis/Abverkauf) werden auch f�r die Attribute verwendet<br />0= NEIN 1= JA', now(), now()),
('MUSIC Attribut ist inkludiert im Basispreis - Standardeinstellung', 'DEFAULT_PRODUCT_MUSIC_ATTRIBUTES_PRICE_BASE_INCLUDED', 43, 'MUSIC Attribut ist inkludiert im Basispreis<br />Inkludiert im Basispreis bei "Preis per Attribut"<br />0= NEIN 1= JA', now(), now()),
('MUSIC Attribut wird ben�tigt - Standardeinstellung', 'DEFAULT_PRODUCT_MUSIC_ATTRIBUTES_REQUIRED', 43, 'MUSIC Attribut wird ben�tigt<br />Attribut wird f�r Text ben�tigt<br />0= NEIN 1= JA', now(), now()),
('MUSIC Attribut Preis Pr�fix - Standardeinstellung', 'DEFAULT_PRODUCT_MUSIC_PRICE_PREFIX', 43, 'MUSIC Attribut Preis Pr�fix<br />Standard Preis Pr�fix<br />Leer, + oder -', now(), now()),
('MUSIC Attribut Gewicht Pr�fix - Standardeinstellung', 'DEFAULT_PRODUCT_MUSIC_PRODUCTS_ATTRIBUTES_WEIGHT_PREFIX', 43, 'MUSIC Attribut Gewicht Pr�fix<br />Standard Gewicht Pr�fix<br />Leer, + oder -', now(), now()),

('DOCUMENT GENERAL Attribut wird nur zur Darstellung ben�tigt - Standardeinstellung', 'DEFAULT_DOCUMENT_GENERAL_ATTRIBUTES_DISPLAY_ONLY', 43, 'DOCUMENT GENERAL Attribut wird nur zur Anzeige ben�tigt<br />0= NEIN 1= JA', now(), now()),
('DOCUMENT GENERAL Attribut ist kostenlos - Standardeinstellung', 'DEFAULT_DOCUMENT_GENERAL_ATTRIBUTE_IS_FREE', 43, 'DOCUMENT GENERAL Attribut ist kostenlos<br />Attribut ist kostenlos, wenn der Artikel kostenlos ist.<br />0= NEIN 1= JA', now(), now()),
('DOCUMENT GENERAL Attribut ist standardm��ig markiert - Standardeinstellung', 'DEFAULT_DOCUMENT_GENERAL_ATTRIBUTES_DEFAULT', 43, 'DOCUMENT GENERAL Attribut ist standardm��ig markiert<br />0= NEIN 1= JA', now(), now()),
('DOCUMENT GENERAL Attribut ist preisreduziert - Standardeinstellung', 'DEFAULT_DOCUMENT_GENERAL_ATTRIBUTES_DISCOUNTED', 43, 'DOCUMENT GENERAL Attribut ist preisreduziert<br />Angewendete Rabatte des Artikels (Sonderpreis/Abverkauf) werden auch f�r die Attribute verwendet<br />0= NEIN 1= JA', now(), now()),
('DOCUMENT GENERAL Attribut ist inkludiert im Basispreis - Standardeinstellung', 'DEFAULT_DOCUMENT_GENERAL_ATTRIBUTES_PRICE_BASE_INCLUDED', 43, 'DOCUMENT GENERAL Attribut ist inkludiert im Basispreis<br />Inkludiert im Basispreis bei "Preis per Attribut"<br />0= NEIN 1= JA', now(), now()),
('DOCUMENT GENERAL Attribut wird ben�tigt - Standardeinstellung', 'DEFAULT_DOCUMENT_GENERAL_ATTRIBUTES_REQUIRED', 43, 'DOCUMENT GENERAL Attribut wird ben�tigt<br />Attribut wird f�r Text ben�tigt<br />0= NEIN 1= JA', now(), now()),
('DOCUMENT GENERAL Attribut Preis Pr�fix - Standardeinstellung', 'DEFAULT_DOCUMENT_GENERAL_PRICE_PREFIX', 43, 'DOCUMENT GENERAL Attribut Preis Pr�fix<br />Standard Preis Pr�fix<br />Leer, + oder -', now(), now()),
('DOCUMENT GENERAL Attribut Gewicht Pr�fix - Standardeinstellung', 'DEFAULT_DOCUMENT_GENERAL_PRODUCTS_ATTRIBUTES_WEIGHT_PREFIX', 43, 'DOCUMENT GENERAL Attribut Gewicht Pr�fix<br />Standard Gewicht Pr�fix<br />Leer, + oder -', now(), now()),
('DOCUMENT PRODUCT Attribut wird nur zur Darstellung ben�tigt - Standardeinstellung', 'DEFAULT_DOCUMENT_PRODUCT_ATTRIBUTES_DISPLAY_ONLY', 43, 'DOCUMENT PRODUCT Attribut wird nur zur Anzeige ben�tigt<br />0= NEIN 1= JA', now(), now()),
('DOCUMENT PRODUCT Attribut ist kostenlos - Standardeinstellung', 'DEFAULT_DOCUMENT_PRODUCT_ATTRIBUTE_IS_FREE', 43, 'DOCUMENT PRODUCT Attribut ist kostenlos<br />Attribut ist kostenlos, wenn der Artikel kostenlos ist.<br />0= NEIN 1= JA', now(), now()),
('DOCUMENT PRODUCT Attribut ist standardm��ig markiert - Standardeinstellung', 'DEFAULT_DOCUMENT_PRODUCT_ATTRIBUTES_DEFAULT', 43, 'DOCUMENT PRODUCT Attribut ist standardm��ig markiert<br />0= NEIN 1= JA', now(), now()),
('DOCUMENT PRODUCT Attribut ist preisreduziert - Standardeinstellung', 'DEFAULT_DOCUMENT_PRODUCT_ATTRIBUTES_DISCOUNTED', 43, 'DOCUMENT PRODUCT Attribut ist preisreduziert<br />Angewendete Rabatte des Artikels (Sonderpreis/Abverkauf) werden auch f�r die Attribute verwendet<br />0= NEIN 1= JA', now(), now()),
('DOCUMENT PRODUCT Attribut ist inkludiert im Basispreis - Standardeinstellung', 'DEFAULT_DOCUMENT_PRODUCT_ATTRIBUTES_PRICE_BASE_INCLUDED', 43, 'DOCUMENT PRODUCT Attribut ist inkludiert im Basispreis<br />Inkludiert im Basispreis bei "Preis per Attribut"<br />0= NEIN 1= JA', now(), now()),
('DOCUMENT PRODUCT Attribut wird ben�tigt - Standardeinstellung', 'DEFAULT_DOCUMENT_PRODUCT_ATTRIBUTES_REQUIRED', 43, 'DOCUMENT PRODUCT Attribut wird ben�tigt<br />Attribut wird f�r Text ben�tigt<br />0= NEIN 1= JA', now(), now()),
('DOCUMENT PRODUCT Attribut Preis Pr�fix - Standardeinstellung', 'DEFAULT_DOCUMENT_PRODUCT_PRICE_PREFIX', 43, 'DOCUMENT PRODUCT Attribut Preis Pr�fix<br />Standard Preis Pr�fix<br />Leer, + oder -', now(), now()),
('DOCUMENT PRODUCT Attribut Gewicht Pr�fix - Standardeinstellung', 'DEFAULT_DOCUMENT_PRODUCT_PRODUCTS_ATTRIBUTES_WEIGHT_PREFIX', 43, 'DOCUMENT PRODUCT Attribut Gewicht Pr�fix<br />Standard Gewicht Pr�fix<br />Leer, + oder -', now(), now()),

('PRODUCT FREE SHIPPING Attribut wird nur zur Darstellung ben�tigt - Standardeinstellung', 'DEFAULT_PRODUCT_FREE_SHIPPING_ATTRIBUTES_DISPLAY_ONLY', 43, 'PRODUCT FREE SHIPPING Attribut wird nur zur Anzeige ben�tigt<br />0= NEIN 1= JA', now(), now()),
('PRODUCT FREE SHIPPING Attribut ist kostenlos - Standardeinstellung', 'DEFAULT_PRODUCT_FREE_SHIPPING_ATTRIBUTE_IS_FREE', 43, 'PRODUCT FREE SHIPPING Attribut ist kostenlos<br />Attribut ist kostenlos, wenn der Artikel kostenlos ist.<br />0= NEIN 1= JA', now(), now()),
('PRODUCT FREE SHIPPING Attribut ist standardm��ig markiert - Standardeinstellung', 'DEFAULT_PRODUCT_FREE_SHIPPING_ATTRIBUTES_DEFAULT', 43, 'PRODUCT FREE SHIPPING Attribut ist standardm��ig markiert<br />0= NEIN 1= JA', now(), now()),
('PRODUCT FREE SHIPPING Attribut ist preisreduziert - Standardeinstellung', 'DEFAULT_PRODUCT_FREE_SHIPPING_ATTRIBUTES_DISCOUNTED', 43, 'PRODUCT FREE SHIPPING Attribut ist preisreduziert<br />Angewendete Rabatte des Artikels (Sonderpreis/Abverkauf) werden auch f�r die Attribute verwendet<br />0= NEIN 1= JA', now(), now()),
('PRODUCT FREE SHIPPING Attribut ist inkludiert im Basispreis - Standardeinstellung', 'DEFAULT_PRODUCT_FREE_SHIPPING_ATTRIBUTES_PRICE_BASE_INCLUDED', 43, 'PRODUCT FREE SHIPPING Attribut ist inkludiert im Basispreis<br />Inkludiert im Basispreis bei "Preis per Attribut"<br />0= NEIN 1= JA', now(), now()),
('PRODUCT FREE SHIPPING Attribut wird ben�tigt - Standardeinstellung', 'DEFAULT_PRODUCT_FREE_SHIPPING_ATTRIBUTES_REQUIRED', 43, 'PRODUCT FREE SHIPPING Attribut wird ben�tigt<br />Attribut wird f�r Text ben�tigt<br />0= NEIN 1= JA', now(), now()),
('PRODUCT FREE SHIPPING Attribut Preis Pr�fix - Standardeinstellung', 'DEFAULT_PRODUCT_FREE_SHIPPING_PRICE_PREFIX', 43, 'PRODUCT FREE SHIPPING Attribut Preis Pr�fix<br />Standard Preis Pr�fix<br />Leer, + oder -', now(), now()),
('PRODUCT FREE SHIPPING Attribut Gewicht Pr�fix - Standardeinstellung', 'DEFAULT_PRODUCT_FREE_SHIPPING_PRODUCTS_ATTRIBUTES_WEIGHT_PREFIX', 43, 'PRODUCT FREE SHIPPING Attribut Gewicht Pr�fix<br />Standard Gewicht Pr�fix<br />Leer, + oder -', now(), now());

REPLACE INTO product_type_layout_language (configuration_title , configuration_key , languages_id, configuration_description)
VALUES ('LANGUAGE_VERSION 20100926', 'LANGUAGE_VERSION', '43', 'Deutsch');



#############

#### VERSION UPDATE STATEMENTS
## THE FOLLOWING 2 SECTIONS SHOULD BE THE "LAST" ITEMS IN THE FILE, so that if the upgrade fails prematurely, the version info is not updated.
##The following updates the version HISTORY to store the prior version info (Essentially "moves" the prior version info from the "project_version" to "project_version_history" table
#NEXT_X_ROWS_AS_ONE_COMMAND:3
INSERT INTO project_version_history (project_version_key, project_version_major, project_version_minor, project_version_patch, project_version_date_applied, project_version_comment)
SELECT project_version_key, project_version_major, project_version_minor, project_version_patch1 as project_version_patch, project_version_date_applied, project_version_comment
FROM project_version;

## Now set to new version
UPDATE project_version SET project_version_major='1', project_version_minor='5.1', project_version_patch1='', project_version_patch1_source='', project_version_patch2='', project_version_patch2_source='', project_version_comment='Version Update 1.5.0->1.5.1', project_version_date_applied=now() WHERE project_version_key = 'Zen-Cart Main';
UPDATE project_version SET project_version_major='1', project_version_minor='5.1', project_version_patch1='', project_version_patch1_source='', project_version_patch2='', project_version_patch2_source='', project_version_comment='Version Update 1.5.0->1.5.1', project_version_date_applied=now() WHERE project_version_key = 'Zen-Cart Database';

#####  END OF UPGRADE SCRIPT

