//////////////////////////////////////////  
// Quick Updates 2.05                   //
// angepasst an die deutsche ZC Version //
// getestet auf Zen-Cart 1.3.8 + 1.3.9  //
//                                      //
// Angepasst und getestet von           //
// MaleBorg vom Zen-Cart.at Team        //
//////////////////////////////////////////

========================================================

Was macht diese Erweiterung?

Quick Updates ist eine adminstrative Komponente f�r Zen-Cart.
Es erm�glicht Ihnen die Bearbeitung und Aktualisierung von mehreren Artikel gleichzeitig.

Features: 
- Listet Artikelmerkmale und Preise in einer Tabelle auf, dadurch k�nnen Sie viele Artikel auf einmal bearbeiten.
- Filtern Sie Ihre zu bearbeitenden Artikel nach Herstellern und/oder Kategorien.
- Genereller Preisaufschlag (Fixbetrag oder Prozentwert) f�r alle Artikel, bestimmte Artikel oder Kategorien. Inkl. einer Vorschau, damit Sie ihre �nderungen pr�fen k�nnen.
- Adminbereich um die zu bearbeiteten Artikelmerkmale ein- oder auszublenden
- Erm�glicht Ihnen das schneller Kopieren einzelner Artikel


========================================================

INSTALLATION:

Es werden keine Dateien �berschrieben.
Allerdings wird die Datenbank ver�ndert, daher sollten Sie VOR DER INSTALLATION ein Datenbankbackup durchf�hren!

1. Laden Sie den admin Ordner in Ihr Shopverzeichnis hoch.
   Sollten Sie den admin Ordner umbenannt haben, gleichen Sie bitte vor dem Hochladen den Ordner dieser Erweiterung entsprechend um!

2. Gehen Sie im Adminbereich auf Tools --> SQL Patches installieren und kopieren Sie den Inhalt der Datei "quick_update.sql" in das Textfeld ein.
   Dr�cken Sie dann auf Senden.

3. Fertig
   
Unter Konfiguration --> Quick Updates haben Sie nun diverse Einstellm�glichkeiten. Quick Updates finden Sie unter Webshop --> Quick Updates.
 
=========================================================

Anmerkungen:

1) Werfen Sie auch einen Blick in admin/includes/extra_configures/quick_updates.php, manche Einstellung ist nun dorthin verschoben oder hinzugef�gt worden 

2) CSS Popups funktionieren nicht gut im IE6 und werden es vermutlich auch nie. Dies wird durch IE6 bugs\flaws verursacht. 
   Wenn Sie meinen den IE6 *unbedingt* aus irgendeinem Grund verwenden zu m�ssen, ist es vermutlich besser, den Schalter "use popup" auf falsch zu setzen (quick_updates admin Einstellung). 
   Der empfohlene Browser ist Firefox. Aber paulm hat einen schnellen Test mit IE7 durchgef�hrt, und die CSS popups scheinen, in IE7 okay.
   
3) Um die Funktionen "products_purchase_price" und "products_margin" nutzen zu k�nnen, m�ssen diese in Ihrer Artikeltabelle in der Datenbank (Table products) hinzugef�gt werden. 
   Um diese Funktion zu aktivieren, einfach in der admin/includes/extra_configures/quick_updates.php in Zeile 10 define('QUICKUPDATES_MODIFY_PURCHASE_AND_MARGIN', 'true'); setzen.
   Danach bitte unter Tools --> SQL Patches installieren folgendes einf�gen:
   
   ALTER TABLE `products` ADD `products_purchase_price` DECIMAL( 15, 4 ) NOT NULL DEFAULT '0.0000' AFTER `products_price` ,
   ADD `products_margin` DECIMAL( 15, 2 ) NOT NULL DEFAULT '0.00' AFTER `products_purchase_price`; 
   
4) Im Code hat paulm(der holl�ndische (Mit-)Schaffer der englischen Originalversion f�r diese �bersetzung) eine M�glichkeit eingebaut, eine zus�tzliche Zeile f�r z.B. f�r die Lieferanten-Artikelnummer eingebaut. 
   Um diese Funktion zu aktivieren, einfach in der admin/includes/extra_configures/quick_updates.php in Zeile 28  define('QUICKUPDATES_MODIFY_NEW_COLUMN_1', 'true'); setzen.
   Danach bitte unter Tools --> SQL Patches installieren folgendes einf�gen:
   
   ALTER TABLE `products` ADD `products_artlid` VARCHAR(32) DEFAULT 'NULL' AFTER `products_model`;  
   
Die unter 3 und 4 zus�tzlich eingef�gten Felder f�r Quickupdates, sind rein kosmetischer Natur. Sie k�nnen diese Felder nur in Quick Updates nutzen. Sie tauchen weder in E-Mails noch in Auswertungen auf.

=========================================================

Original Credits:
Contribution:  Quick Updates
Version: v2.03 by Paul Mathot (paulm @ zen-cart.com/forum)
Tested on: Zen Cart v1.3.6 (works on several older version too)
Download: http://www.zen-cart.com/index.php?main_page=product_contrib_info&products_id=101
License: under the GPL - See attached License for info.
Support:  Zen Cart forums.
Discussion (and unofficial support thread) and download new "beta" releases: http://www.zen-cart.com/forum/showthread.php?t=41886
Origninal osCommerce contribution by : by Mathieu (contact@mathieueylert.com)
Converted by : www.portali.co.nz
Cleared by: Andrew Berezin andrew@eCommerce-service.com