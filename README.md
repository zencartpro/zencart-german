# zencart-156-de
Zen Cart 1.5.6 - deutsche Version

1.5.6b BETA - Juni 2019

Systemvoraussetzungen:
* Linux Server mit Apache 2.4 oder 2.2
* PHP 7.0.x bis 7.3.x
* MySQL 5.1 bis 5.7 oder or MariaDB 10.1 bis 10.3

Empfohlene Konfiguration:
* Apache 2.4
* PHP 7.3.x
* MySQL 5.7
* Datenbank mit Character Set: utf8mb4 und Kollation: utf8mb4_unicode_ci 

Neu in 1.5.6
* Vollständige Unterstützung von PHP 7.2 und 7.3.
* Unterstützung von utf8mb4 Datenbank Character Set (neue Defaulteinstellung, bisher utf8)
* Neues Layout für die Shopadministration mit verbesserter Unterstützung für kleinere Bildschirme
* Neuer graphischer Verkaufsbericht unter Administration > Statistiken
* EZ Pages sind nun multilingual
* Zahlungsart Sofortüberweisung vorintegriert
* Zahlungsart Kreditkarte via Braintree vorintegriert
* Bestellbestätigungsemail enthält falls angegeben die Telefonnummer des Kunden für die Zustellung
* Admin-Seiten zeigen nun ihren Namen im Browser-Tabs an
* Zahlreiche neue Notifier zur einfacheren Integration von Modulen
* Die Anzeige der Geschenkgutscheinwarteschlange kann in den Einstellungen des Geschenkgutscheinmoduls ein- und ausgeschaltet werden.
* Erweiterte Anzeige von Debug Logfiles in der Shopadministration
* Zahlreiche neue Funktionen bei den Aktionskupons: Suchen, Exportieren, Reaktivieren, Duplikate löschen, bestehende Aktionskupons klonen
* Aktionskupons können nun auf den Betrag einer Bestellung oder eines bestimmten Produkts beschränkt werden.
* Aktionskupons können nun auf Kunden mit einer bestimmten Anzahl von bisherigen Bestellungen beschränkt werden.
* Aktionskupons können nun auf Produkte beschränkt werden, die nicht im Sonderangebot sind.
* Einschränkungen für Aktionskupons können nun über den Herstellerfilter in großen Mengen hinzugefügt werden.
* Statistiken und Exportmöglichkeit für die Verwendung von Aktionskupons
* In der Tabelle Orders werden bei einer Bestellung mehr Details als bisher gespeichert (Gesamtgewicht, usw.)
* Das Datei-Uploading gibt nun detaillierteres Feedback über Fehler im Zusammenhang mit ungültigen Dateitypen.
* Update TinyMCE auf 5.03
* Update CKEditor auf 4.11.4
* Update Mailbeez auf 4.0.0
* Update Mobile Detect auf 2.8.3.3
* Update PHP Mailer auf 6.0.6
* Update Image Handler auf 5.1.3

Dies ist eine BETA Version.
* Ausschließlich in einem Testsystem installieren.
* Keinesfalls einen Liveshop darauf aktualisieren.
* Dokumentation noch nicht aktualisiert, Installation gegenüber 1.5.5f unverändert, Installatiosanleitung in der 1.5.5f Dokumentation:
  https://www.zen-cart-pro.at/docs/155-deutsch-doku/
* Fehler als Issues in Github melden oder im Suportforum im Thread Zen Cart 1.5.6 deutsch Betatest:
  https://www.zen-cart-pro.at/forum/forums/153-BETA-TEST-Zen-Cart-1-5-6-deutsch

Bekannte Fehler/noch nicht implementiert
* IT Recht Kanzlei Funktionalität noch nicht auf die neue EZ Pages Struktur angepasst