<?php
/**
 * @package languageDefines
 * @copyright Copyright 2003-2008 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.at/license/2_0.txt GNU Public License V2.0
 * @translator: cyaneo/hugo13/wflohr    http://www.zen-cart.at    
 * @version $Id$
 */

define('HEADING_TITLE','Abverkaufsmanager');
define('SUBHEADING_TITLE','Verwendungstipps f�r den Abverkaufsmanager:');
define('INFO_TEXT','<ul>
                      <li>
                        Verwenden Sie immer \'.\' als Trennzeichen f�r Dezimalstellen.
                      </li>
                      <li>
                        Tragen Sie Betr�ge immer in der W�hrung ein, in der Sie einen Artikel erstellt haben.
                      </li>
                      <li>
                        Im Reduzierungsfeld k�nnen Sie den Wert prozentuell oder als reduzierten Preis angeben. (Beispiel: &euro; 5.00 Erm�&szlig;igung auf alle Preise, 10% Reduzierung
                        aller Preise oder alle Preise auf &euro; 25.00 reduzieren)
                      </li>
                      <li>
                        Wenn Sie einen Preisbereich angeben, wirkt sich dieser auf alle Artikel aus, die in diesen Bereich hineinfallen. (z.B.
                        alle Artikel von &euro; 50.00 bis &euro; 150.00)
                      </li>
                      <li>
                        W�hlen Sie diese Aktion, wenn ein Artikel ein Sonderangebot ist <i>und</i> Subjekt dieses Abverkaufs ist:
                                                <ul>
                          <li>
                            <strong>Sonderpreis ignorieren - Aktualisiere Artikelpreis und ersetze Sonderpreis durch den Abverkaufspreis</strong><br>
                                                        die Preisreduktion wird auf den Regul�rpreis des Artikels angewendet.
                            (z.B. Regul�rer Preis ist &euro;  10.00, der Sonderpreis betr�gt &euro;  9.50, die Abverkaufserm�&szlig;igung betr�gt 10%.
                                                        Der endg�ltige Preis des Artikels wird bei einem Abverkauf &euro;  9.00 betragen. Der Sonderpreis wird ignoriert.)
                          </li>
                          <li>
                            <strong>Ignoriere Abverkaufserm�&szlig;igung - ein Abverkauf wird nicht wirksam, so lange ein Sonderpreis existiert</strong><br>
                            Die Abverkaufserm�&szlig;igung wird sich nicht auf Sonderpreise auswirken. Der Sonderpreis wird weiterhin angezeigt als w�rde kein Abverkauf stattfinden. (z.B. Regul�rer Preis ist &euro; 10.00, der Sonderpreis betr�gt &euro; 9.50,
                            die Abverkaufserm�&szlig;igung betr�gt 10%. Der endg�ltige Preis des Artikels wird bei einem Abverkauf &euro; 9.50 betragen.
                            Der Sonderpreis wird ignoriert.)
                          </li>
                          <li>
                            <strong>Abverkaufserm�&szlig;igung auf Sonderpreis anwenden - ansonsten auf Artikelpreis anwenden</strong><br>
                            Die Abverkaufserm�&szlig;igung wird auf Sonderpreise anwenden. Ein vermengter Preis wird angezeigt.
                            (z.B.. Der Regul�re Preis betr�gt &euro; 10.00, der Sonderpreis betr�gt &euro; 9.50, die Abverkaufserm�&szlig;igung betr�gt 10%.
                            Der endg�ltige Preis des Artikels wird bei einem Abverkauf &euro; 8.55 betragen.
                            Also eine zus�tzliche Erm�&szlig;igung von 10% auf den Sonderpreis.)
                          </li>
                        </ul>
                      </li>
                      <li>
                        Wenn Sie das Feld f�r das Startdatum leer lassen, startet der Abverkauf sofort.
                      </li>
                      <li>
                        Lassen Sie das Feld f�r das Enddatum leer, wenn der Zeitraum f�r den Abverkauf unbegrenzt sein soll.</li>
                      <li>
                        Die Auswahl einer Kategorie beinhaltet automatisch auch alle Unterkategorien.
                      </li>
                    </ul>');
define('TEXT_CLOSE_WINDOW','[ Fenster schlie&szlig;en ]');

