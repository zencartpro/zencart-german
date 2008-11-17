***************************************************************************

  $Id: README 157 2005-04-07 20:33:35Z dogu $

  OSC German Banktransfer
  (http://www.oscommerce.com/community/contributions,826)

  Contribution based on:

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2003 osCommerce

  Released under the GNU General Public License

  Maintainer: Dominik Guder <osc@guder.org> (dogu)
  Extensioncode: Marcel Bossert-Schwab <info@opensourcecommerce.de> (mbs)


http://www.bundesbank.de/zahlungsverkehr/zahlungsverkehr_bankleitzahlen_download.php

--------
--------
ZEN CART
--------
--------

  Angepasst f�r Zen-Cart by MultimediArts www.zencart-hosting.de

  ein Gro�er Dank geht an Michael Kreutzer www.mickser.de
  f�r das Testen und letzte �nderungen.

	29.06.06 wflohr Fixes to run module with register_globals=off zencart (at) cyberflohrs (dot) de

***************************************************************************

Inhalt:
0.) Disclaimer (unbedingt lesen!!!)
1.) �bersicht
2.) Support und weitere Informationen:
3.) Installation
4.) Bankleitzahlenbestand in der DB speichern
5.) Faxbest�tigung
6.) Konto-Daten in der E-Mail
7.) L�schen von Bestellungen
8.) �nderung der GermanBanktransfer Tabellennamen
9.) Erl�uterungen zu den Fehlercodes

***************************************************************************

zum Upgrade von einer Version <= 0.91 auf 0.92 bitte unbedingt die Hinweise in der Datei
UPGRADE beachten

0.) Disclaimer

  Die Verwendung dieses Zahlungsmoduls erfolgt auf eigenes Risiko.

  Dieses Zahlungsmodul ist unter der GNU General Public License (GPL) ver�ffentlicht worden.
  Es kann demnach frei und kostenlos von jedermann genutzt werden.
  Gem�� Ziffer 11 und 12 der GPL wird keine Gew�hrleistung, weder ausdr�cklich
  noch implizit, �bernommen.


1.) �bersicht
  
  Ben�tigt wird mindestens PHP 4.3.4
  
  Dieses Paymentmodul erm�glicht das Lastschriftverfahren mit osCommerce MS2

  Beim Checkout kann der Kunde seine Kontodaten angeben, die gepr�ft und in der
  Datenbank gespeichert werden.
  Ferner kann er ein Dokument downloaden in dem er (offline) schriftlich seine Einwilligung gibt.
  Diese Funktion ist �ber Schalter einstellbar.

  Das Modul f�hrt eine Plausibilit�tspr�fung zwischen BLZ und Kto.Nr. durch.
  Es kann nicht garantieren, dass das angegebene Konto tats�chlich existiert,
  dass dieses Konto dem angegebenen Kontoinhaber zugeordnet ist und ob dieses Konto
  ausreichend Deckung aufweist.

  Die h�ufigsten Fehler (Zahlendreher, Verst�ndnisprobleme bei der �bermittlung der
  Bankverbindung oder falschen Kundenangaben) k�nnen auf diese Art relativ zuverl�ssig
  vermieden werden.

  Nachdem die Pr�fverfahren nicht immer 100%ig funktionieren, ist ein Mechanismus eingebaut,
  der nach eine Fehlermeldung und der (hoffentlich) erneuten Pr�fung der Kontodaten durch
  den Kunden die Werte zul�sst, auch wenn sie als falsch gepr�ft werden. Diese erhalten den
  Fehlercode 1 und die Meldung, dass die Kontonummer eine besondere Beobachtung ben�tigt.

  In Zukunft ist geplant, dass dieses Feature optional implementiert und verfeinert wird.

2.) Support und weitere Informationen:

  http://www.oscommerce.de -> Home von German BankTransfer
  http://www.bundesbank.de -> Zahlungsverker
  http://www.zahlungsverkersfragen.de

  Hinweise, Tipps und Anregungen oder Probleme jederzeit an osc@guder.org

3.) Installation:

  banktransfer_validation.php (classes) wird in /catalog/includes/classes/ kopiert
  blz.cvs (data) wird in /catalog/includes/data/ kopiert
  germanbanktransfer.php (modules) wird in /catalog/includes/modules/payment/ kopiert
  germanbanktransfer.php (languages) wird in /catalog/includes/languages/german/modules/payment/ kopiert

  !!! Bei den Admin-Dateien bitte die Sicherungskopie der alten Dateien nicht vergessen !!!
  !!! Sofern bereits �nderungen in der orders.php gemacht wurden, m�ssen die �nderungen von !!!
  !!! Hand �bertragen werden. Marierung: // begin modification for german banktransfer !!!
  orders.php (admin) wird in /admin/ kopiert
  orders.php (languages) wird in /admin/includes/languages/german/ kopiert

  Das Modul wird �ber den Admin des Shops aktiviert:
  unter Module -> Zahlungsweise -> Lastschriftverfahren -> installieren.
  BankTransfer wird jetzt installiert, auch entsprechende �nderungen an der Datenbank werden
  automatisch vorgenommen.


4.) Bankleitzahlenbestand in der DB speichern:

  Seit der Version 0.84 ist es m�glich, den Bankleitzahlenbestand in der Datenbank zu
  hinterlegen. Dazu m�ssen lediglich die beiden Dateien banktransfer_blz_split1.sql
  und banktransfer_blz_split2.sql in die catalog-DB (Tabelle 'banktransfer_blz') eingespielt 
  werden (phpMyAdmin). Dabei werden alle existierende Eintr�ge in der Tabelle banktransfer_blz 
  gel�scht und neu angelegt.
  Danach kann im Admin zwischen File- und DB-basierter Abfrage der Bankleitzahl gew�hlt werden.


5.) Faxbest�tigung:

  Im Admin muss der Dateiname der Faxbest�tigung (muss sich im catalog-Verzeichnis befinden)
  definiert werden. Es kann entweder eine selbst entworfene html-Datei, oder die Faxvorlage aus
  dem Fax-Verzeichnis verwendet werden (s.u.).

  Faxvorlage:
    Im Verzeichnis 'fax' befindet sich eine Datei fax.html, die in das Catalog-Verzeichnis kopiert
    werden kann. Die Datei fax/images/einzug.gif wird f�r die Schattierung ben�tigt und muss in
    catalog/images abgelegt werden. Die Anpassung an den Shop muss in fax.html direkt durchgef�hrt
    werden.


6.) Konto-Daten in der E-Mail:

  Sicherhei:
  Beim �bertragen der Kontodaten in der Email ist zu bedenken, dass die Emails unverschl�sselt
  �ber das Internet verschickt werden.


  Da das zum einen dem Modul-Gedanken wiederspricht, und ich nicht davon ausgehen kann, dass das
  jeder m�chte, muss das von jedem Selbst in der checkout_process.php ge�ndert werden:

  in der checkout_process.php sind folgende folgende Zeilen f�r den Versand an den Shop-Admin zust�ndig:

// send emails to other people
  if (SEND_EXTRA_ORDER_EMAILS_TO != '') {
    tep_mail('', SEND_EXTRA_ORDER_EMAILS_TO, EMAIL_TEXT_SUBJECT, $email_order, STORE_OWNER, STORE_OWNER_EMAIL_ADDRESS);
  }

  Diese k�nnen nach belieben ersetzt und erweitert werden:

// send emails to other people
  if (SEND_EXTRA_ORDER_EMAILS_TO != '') {
    if ($gbt_array['bt_fax'] != true) {
  		$email_order .= "Kontoinhaber: ". $gbt_array['bt_owner'] . "\n";
  		$email_order .= "BLZ:          ". $gbt_array['bt_blz'] . "\n";
  		$email_order .= "Konto:        ". $gbt_number . "\n";
  		$email_order .= "Bank:         ". $gbt_array['bt_bankname'] . "\n";

  		if ($gbt_array['bt_status'] == 0 || $gbt_array['bt_status'] == 2 || $gbt_array['bt_status'] == 3 || $gbt_array['bt_status'] == 4){
  			$email_order .= "Pr�fstatus:   OK\n";
  		}else{
  			$email_order .= "Pr�fstatus:   Es ist ein Problem aufgetreten, bitte beobachten!\n";
  		}
  	} else {
  	  $email_order .= "Kontodaten werden per Fax best�tigt!\n";
  	}
    tep_mail('', SEND_EXTRA_ORDER_EMAILS_TO, EMAIL_TEXT_SUBJECT, $email_order, STORE_OWNER, STORE_OWNER_EMAIL_ADDRESS);
  }

7.) L�schen von Bestellungen

    Um die Tabelle Banktransfer mit der Tabelle Orders konsistent zu halten wurde von mir
    in der Datei admin/orders.php folgender L�schbefehl mit eingef�gt.
    Damit werden die Bestellungen nun auch in der Tabelle banktransfer gel�scht.

    ca. Zeile 74ff
        tep_remove_order($oID, $HTTP_POST_VARS['restock']);
        // begin modification for banktransfer
          tep_db_query("DELETE FROM banktransfer WHERE orders_id = '" . (int)$oID . "'");
        // end modification for banktransfer

8.) �nderung der GermanBanktransfer Tabellennamen

	Ab 0.92 ist es m�glich die Tabellennamen f�r das Modul zu �ndern.
	Dazu muss eine existierende Tabelle entsprechend umbenannt werden. 

	F�r den Catalogbereich in /catalog/includes/modules/payment/germanbanktransfer.php
	F�r den Admin Bereich in /admin/includes/languages/german/orders.php


9.) Erl�uterungen zu den Fehlercodes:

  1 -> Kontonummer & BLZ passen nicht
    ---> kritischer Fehler
  2 -> F�r diese Kontonummer ist kein Pr�fziffernverfahren definiert
    ---> Unkritischer Fehler, Bank habe bei der Bundebank kein Pr�fverfahren angemeldet
  3 -> Dieses Pr�fziffernverfahren ist noch nicht implementiert
    ---> Bitte bei vermehrtem Auftreten eine email mit Kto-Nr., BLZ und Pr�fverfahren an mich schicken (osc@guder.org)
  4 -> Diese Kontonummer ist technisch nicht pr�fbar
    ---> Unkritischer Fehler, Kontonummer ist laut Spezifikation nicht pr�fbar
  5 -> BLZ nicht gefunden eine email mit der BLZ an mich schicken (email siehe oben)
    ---> Bitte bei vermehrtem Auftreten
  8 -> Keine BLZ �bergeben oder BLZ zu kurz
  9 -> Keine Kontonummer �bergeben
