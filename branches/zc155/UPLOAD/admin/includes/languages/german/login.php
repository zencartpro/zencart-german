<?php
/**
 * @package admin
 * @copyright Copyright 2003-2016 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart-pro.at/license/2_0.txt GNU Public License V2.0
 * @version $Id: login.php 629 2016-02-29 17:50:14Z webchills $
 */

define('HEADING_TITLE', 'Admin Login');
define('HEADING_TITLE_EXPIRED', 'Admin Login - Passwort abgelaufen');
define('TEXT_LOGIN','Login');
define('TEXT_SUBMIT','Absenden');
define('TEXT_ADMIN_NAME', 'Admin Username:');
define('TEXT_ADMIN_PASS', 'Admin Passwort:');
define('TEXT_ADMIN_OLD_PASSWORD', 'Altes Passwort:');
define('TEXT_ADMIN_NEW_PASSWORD', 'Neues Passwort:');
define('TEXT_ADMIN_CONFIRM_PASSWORD', 'Passwort bestätigen:');
define('ERROR_WRONG_LOGIN', 'Benutzername und / oder Passwort falsch.');
define('ERROR_SECURITY_ERROR', 'Es gab einen Sicherheitsfehler, als Sie versucht haben sich anzumelden.');
define('TEXT_PASSWORD_FORGOTTEN', 'Passwort vergessen?');

define('LOGIN_EXPIRY_NOTICE', '');
define('ERROR_PASSWORD_EXPIRED', 'HINWEIS: Die Gültigkeit Ihres Passworts ist abgelaufen. Bitte wählen Sie ein neues Passwort. Ihr Passwort <strong>muss Zahlen und Buchstaben enthalten und mindestens 7 Zeichen lang sein.</strong>');
define('TEXT_TEMPORARY_PASSWORD_MUST_BE_CHANGED', 'Aus Sicherheitsgründen muss Ihr temporäres Passwort geändert werden. Bitte wählen Sie ein neues Passwort.<br />Ihr Passwort <strong>muss Zahlen und Buchstaben enthalten und mindestens 7 Zeichen lang sein.</strong>');

define('TEXT_EMAIL_SUBJECT_LOGIN_FAILURES', 'Benachrichtigung über mehrere fehlgeschlagene Admin Anmeldeversuche');
define('TEXT_EMAIL_MULTIPLE_LOGIN_FAILURES', 'Wichtiger HINWEIS: Es gab mehrere fehlgeschlagene Anmeldeversuche für Ihr administratives Benutzerkonto. Zu Ihrer Sicherheit und für die Sicherheit des Shops wird Ihr Benutzerkonto nach 6 erfolglosen Loginversuchen für mindestens 30 Minuten gesperrt. In dieser Zeit ist keine Anmeldung möglich, selbst wenn Sie sich mit dem korrekten Passwort anmelden wollen. Weitere erfolglose Anmeldeversuche sperren Ihr Benutzerkonto für weitere 30 Minuten. Während dieser Zeit ist es Ihnen nicht möglich, ihr Passwort zurückzusetzen. Wir bitten diese Unannehmlichkeiten zu entschuldigen.' . "\n\nDer letzte Anmeldeversuch kam von dieser IP-Adresse: %s.\n\n\n");

define('EXPIRED_DUE_TO_SSL', 'HINWEIS: Die Gültigkeit Ihres Passwort ist abgelaufen weil der Shop auf SSL Verschlüsselung (höhere Sicherheit) umgestellt wurde. Die Passwortänderung unter SSL ist ein wichtiger Schritt zu größerer Sicherheit. Entschuldigen Sie bitte die Unannehmlichkeiten. Ihr neues Passwort hat wie gewohnt eine Gültigkeit von 90 Tagen.');
