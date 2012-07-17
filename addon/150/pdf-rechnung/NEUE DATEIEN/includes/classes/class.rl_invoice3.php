<?php
/**
 * @package rl_invoice3
 * @copyright Copyright 2005-2012 langheiter.com 
 * @license http://www.zen-cart-pro.at/license/2_0.txt GNU Public License V2.0
 *
 * @author rainer AT langheiter DOT com // http://www.filosofisch.com // http://edv.langheiter.com
 * 
 * @version $Id: class.rl_invoice3.php 2012-07-12 17:14:06Z webchills $
 */
 
define('FPDF_FONTPATH', DIR_FS_CATALOG . DIR_WS_INCLUDES . 'pdf/font/');
include_once (DIR_FS_CATALOG . DIR_WS_INCLUDES . 'pdf/fpdi.php');
function ExtractNumberX($number) {
    return substr($number, strpos($number, ';') + 1);
}
class rl_invoice3 extends fpdi {
    var $widths;
    var $aligns;
    function rl_invoice3($oID, $orientation, $unit, $format) {
        global $db;
        $this->db = $db;
        $this->oID = $oID;
        $this->checkInstall();
        if(is_null($unit)){
            $paper = $this->getDefault(RL_INVOICE3_PAPER, array('format' => 'A4', 'unit' => 'mm', 'orientation' => 'P'));  
            $this->pdf = new FPDI($paper['orientation'], $paper['unit'], $paper['format']);
        } else {
            $this->pdf = new FPDI($orientation, $unit, $format);
        }
        #parent::fpdi($orientation, $unit, $format);
        $this->currencies = new currencies();
        $this->order = new order($this->oID);
        $this->order_check = $this->db->Execute("select cc_cvv, customers_name, customers_company, customers_street_address,
                    customers_suburb, customers_city, customers_postcode,
                    customers_state, customers_country, customers_telephone,
                    customers_email_address, customers_address_format_id, delivery_name,
                    delivery_company, delivery_street_address, delivery_suburb,
                    delivery_city, delivery_postcode, delivery_state, delivery_country,
                    delivery_address_format_id, billing_name, billing_company,
                    billing_street_address, billing_suburb, billing_city, billing_postcode,
                    billing_state, billing_country, billing_address_format_id,
                    payment_method, cc_type, cc_owner, cc_number, cc_expires, currency,
                    currency_value, date_purchased, orders_status, last_modified
                    from " . TABLE_ORDERS . "
                    where orders_id = '" . (int)$this->oID . "'");
        $this->margin = $this->getDefault(RL_INVOICE3_MARGIN, array('top' => '10', 'right' => '30', 'bottom' => '30', 'left' => '60'));
        $this->maxWidth = $this->w - $this->margin['left'] - $this->margin['right'];
        $this->address1Pos = $this->getDefault(RL_INVOICE3_ADDRESS1_POS, array('X' => '0', 'Y' => '30'));
        $this->address1Pos['X']+= $this->margin['left'];
        $this->address1Pos['Y']+= $this->margin['top'];
        $this->address2Pos = $this->getDefault(RL_INVOICE3_ADDRESS2_POS, array('X' => '120', 'Y' => '30'));
        $this->address2Pos['X']+= $this->margin['left'];
        $this->address2Pos['Y']+= $this->margin['top'];
        $this->addressWidth = $this->getDefault(RL_INVOICE3_ADDRESS_WIDTH, array('addr1' => '80', 'addr2' => '80'));
        $this->addressBorder = $this->getDefault(RL_INVOICE3_ADDRESS_BORDER, array('addr1' => '', 'addr2' => ''));
        $this->paper = $this->getDefault(RL_INVOICE3_PAPER, array('format' => 'A4', 'unit' => 'mm', 'orientation' => 'P'));
        $this->templates = $this->getDefault(RL_INVOICE3_TABLE_TEMPLATE, array('pCols' => 'col_templ_1', 'pOptions' => 'options_templ_1', 'tCols' => 'total_col_1', 'tOptions' => 'total_opt_1'));
        $this->fonts2 = $this->getDefaultCheck(RL_INVOICE3_FONTS, array('general' => 'dejavusanscondensed', 'table' => 'freemono'));
        $this->pdf->AddFont($this->fonts2['general']);
        if($this->fonts2['general'] != $this->fonts2['table']){
            $this->pdf->AddFont($this->fonts2['table']);
        }
        $this->pdfPath = $this->getDefault(RL_INVOICE3_PDF_PATH, array('path' => DIR_FS_CATALOG . 'pdf/', 'save' => '1'));
        $this->delta = $this->getDefault(RL_INVOICE3_DELTA, array('addrInvoice' => '20', 'invoiceProducts' => '30'));
        $this->debug = $this->getDefault(RL_INVOICE3_DEBUG, array('debug' => 0));
        $this->lineHeight = $this->getDefault(RL_INVOICE3_LINE_HEIGT, '1.25');
        $this->lineThick = $this->getDefault(RL_INVOICE3_LINE_THICK, '0.5');
        $this->delta2page = $this->getDefault(RL_INVOICE3_DELTA_2PAGE, '10');
        $this->fontsOk = $this->checkFonts();
        $this->bgPDF = $this->getDefault(RL_INVOICE3_PDF_BACKGROUND, array('file' => DIR_FS_CATALOG . DIR_WS_INCLUDES . 'pdf/rl_invoice3_bg.pdf'));
        
        $realPW = 999;
        include (DIR_FS_CATALOG . DIR_WS_INCLUDES . 'pdf/rl_invoice3_def.php');
        $this->colsP = $colsP;
        $this->optionsP = $optionsP;
        $this->cols = $cols;
        $this->options = $options;
        $this->t1Col = $colsP[$this->templates['pCols']];
        $this->t1Opt = $optionsP[$this->templates['pOptions']];
        if(isset($this->t1Opt['paperOriantation'])){
            $this->paper['orientation'] = $this->t1Opt['paperOriantation'];
        }
        if(isset($this->t1Opt['bgPDF'])){
            $this->bgPDF['file'] = $this->t1Opt['bgPDF'];
        }
        if(isset($this->t1Opt['bgPDFLang'])){
            if (isset($this->t1Opt['bgPDFLang'][$_SESSION['languages_id']])){
                if(file_exists($this->t1Opt['bgPDFLang'][$_SESSION['languages_id']])){
                    $this->bgPDF['file'] = $this->t1Opt['bgPDFLang'][$_SESSION['languages_id']];
                }
            }
        }
        if(isset($this->amazonOpt['bgPDF'])){
            $this->bgPDF['file'] = $this->amazonOpt['bgPDF'];
        }
        if(isset($this->amazonOpt['bgPDFLang'])){
            if (isset($this->amazonOpt['bgPDFLang'][$_SESSION['languages_id']])){
                if(file_exists($this->amazonOpt['bgPDFLang'][$_SESSION['languages_id']])){
                    $this->bgPDF['file'] = $this->amazonOpt['bgPDFLang'][$_SESSION['languages_id']];
                }
            }
        }
        $this->subtotal = 0;
        $this->subtotalColumn = $this->getSubtotalColumn();
        $pagecount = $this->pdf->setSourceFile($this->bgPDF['file']);
        $this->tplidx2 = $this->pdf->ImportPage(1);
        $this->pdf->addPage($this->paper['orientation']);
        $this->pdf->useTemplate($this->tplidx2);
        $this->pdf->SetMargins($this->margin['left'], $this->margin['top'], $this->margin['right']);
        $this->pdf->SetAutoPageBreak(true, $this->margin['bottom']);
        if ($this->debug['debug'] == 1) {
            $this->debugInfo = rldp($this, 'DebugInfo');
        }
    }
    function getSubtotalColumn(){
        $i = 0;
        foreach ($this->t1Opt['cols'] as $key => $value) {
            if($key == $this->t1Opt['subtotal']){
                return $i;
            }
            $i++;
        }
    }
    function deleteConfGroup($gID){
        $sql = 'DELETE ' . TABLE_CONFIGURATION_LANGUAGE . '
                    FROM ' . TABLE_CONFIGURATION . ' INNER JOIN ' . TABLE_CONFIGURATION_LANGUAGE . ' ON ' . TABLE_CONFIGURATION . '.configuration_key = ' . TABLE_CONFIGURATION_LANGUAGE . '.configuration_key 
                    WHERE ' . TABLE_CONFIGURATION . '.configuration_group_id=' . $gID;
        $this->db->Execute($sql);
        $sql = 'DELETE ' . TABLE_CONFIGURATION . ' FROM ' . TABLE_CONFIGURATION . ' WHERE ' . TABLE_CONFIGURATION . '.configuration_group_id=' . $gID;
        $this->db->Execute($sql);
        $sql = "DELETE FROM " . TABLE_CONFIGURATION_GROUP . " WHERE configuration_group_id=" . $gID;
        $this->db->Execute($sql);
         $sql = "DELETE FROM " . TABLE_ADMIN_PAGES . " WHERE page_key='configPDF3'";
        $this->db->Execute($sql);
        $sql = "DELETE FROM " . TABLE_ADMIN_PAGES . " WHERE page_key='toolsPDF3'";
        $this->db->Execute($sql);
    }
    function setTemplate($cp, $op) {
        #rldp($this->colsP, '$this->colsP');
        $this->t1Col = $cp;
        $this->t1Opt = $op;
    }
    function checkInstall() {
        // link to invoice
        $link = HTTP_SERVER . DIR_WS_ADMIN . 'rl_invoice3.php?oID=' . zen_db_prepare_input($_GET['oID']);
        if (!defined('RL_INVOICE3_DELTA_2PAGE')) {
            // check multilingual installation
            if (rl_invoice3::isMultiLingual()) {
                $multi = true;
            } else {
                $multi = false;
            }
            // rewrite group info
            $sql = "SELECT configuration_group_id FROM " . TABLE_CONFIGURATION_GROUP . " WHERE configuration_group_title LIKE 'PDF_INVOICE'" ;
            $res = $this->db->Execute($sql);
            while (!$res->EOF){
                $this->deleteConfGroup($res->fields['configuration_group_id']);
                $res->MoveNext();
            }

            $sql = "SELECT configuration_group_id FROM " . TABLE_CONFIGURATION_GROUP . " WHERE configuration_group_title LIKE 'PDF_INVOICE3'" ;
            $res = $this->db->Execute($sql);
            if($res->RecordCount()>1){
                $this->deleteConfGroup($res->fields['configuration_group_id']);
                zen_redirect($link);
            }
            if($res->RecordCount()==0){
                $group = getNextConfigGroupID();
                if (!$multi) {
                    $sql = "INSERT INTO " . TABLE_CONFIGURATION_GROUP . " (configuration_group_id, configuration_group_title, configuration_group_description, sort_order, visible) VALUES ($group, 'PDF Invoice', 'PDF3', 726, 1)";
                    $this->db->Execute($sql);
                } else {
                    $sql = "INSERT INTO " . TABLE_CONFIGURATION_GROUP . " (configuration_group_id, language_id, configuration_group_title, configuration_group_description, sort_order, visible) VALUES ($group, 1, 'PDF Invoice', 'PDF3', 726, 1)";
                    $this->db->Execute($sql);
                    $sql = "INSERT INTO " . TABLE_CONFIGURATION_GROUP . " (configuration_group_id, language_id, configuration_group_title, configuration_group_description, sort_order, visible) VALUES ($group, 43, 'PDF Rechnung', 'PDF3', 726, 1)";
                    $this->db->Execute($sql);
                    $sql = "INSERT INTO " . TABLE_ADMIN_PAGES . " (page_key,language_key,main_page,page_params,menu_key,display_on_menu,sort_order) VALUES ('configPDF3', 'BOX_CONFIGURATION_PDF3', 'FILENAME_CONFIGURATION', 'gID=".$group."', 'configuration', 'Y', '100')";
		                $this->db->Execute($sql);
		                $sql = "INSERT INTO " . TABLE_ADMIN_PAGES . " (page_key,language_key,main_page,page_params,menu_key,display_on_menu,sort_order) VALUES ('toolsPDF3','BOX_TOOLS_PDF3','RL_INVOICE3_ADMIN_FILENAME','','tools','Y','100')";
		               $this->db->Execute($sql);
                }
            } else {
                $group = $res->fields['configuration_group_id'];
            }
            // orders_status insert resend invoice
            $sql = "SELECT * FROM " . TABLE_ORDERS_STATUS . " WHERE orders_status_id=100";
            $res = $this->db->Execute($sql);
            if($res->EOF){
                $sql = "INSERT INTO " . TABLE_ORDERS_STATUS . " (orders_status_id, language_id, orders_status_name) VALUES ('100', '1', 'Resend Invoice')";
                $this->db->Execute($sql);
                if($multi){
                    $sql = "INSERT INTO " . TABLE_ORDERS_STATUS . " (orders_status_id, language_id, orders_status_name) VALUES ('100', '43', 'Rechnung versenden')";
                    $this->db->Execute($sql);
                }
            }
            // rl_invoive3 config-parameter
            $confArr = array('RL_INVOICE3_ADDRESS1_POS', 'RL_INVOICE3_ADDRESS2_POS', 'RL_INVOICE3_ADDRESS_BORDER', 'RL_INVOICE3_ADDRESS_WIDTH', 
                            'RL_INVOICE3_DELTA', 'RL_INVOICE3_FONTS', 'RL_INVOICE3_LINE_HEIGT', 'RL_INVOICE3_LINE_THICK', 
                            'RL_INVOICE3_MARGIN', 'RL_INVOICE3_NOT_NULL_INVOICE', 'RL_INVOICE3_ORDERSTATUS', 'RL_INVOICE3_ORDER_ID_PREFIX', 
                            'RL_INVOICE3_PAPER', 'RL_INVOICE3_PDF_BACKGROUND', 'RL_INVOICE3_PDF_PATH', 'RL_INVOICE3_SEND_ATTACH', 
                            'RL_INVOICE3_SEND_ORDERSTATUS_CHANGE', 'RL_INVOICE3_SEND_PDF', 'RL_INVOICE3_TABLE_TEMPLATE', 
                            'RL_INVOICE3_WITHOUTINVOICE', 'RL_INVOICE3_TEMPLATE_ONLY_FIRST_PAGE', 'RL_INVOICE3_DELTA_2PAGE');
            $sql = ' SELECT configuration_key FROM ' . TABLE_CONFIGURATION . " WHERE configuration_key LIKE 'RL_INVOICE3%'";
            $res = $this->db->Execute($sql);
            $confArrAct = array();
            while (!$res->EOF) {
                $confArrAct[] = $res->fields['configuration_key'];
                $res->MoveNext();
            }
            $confDiffAdd = array_diff($confArr, $confArrAct);
            $confDiffDEL = array_diff($confArrAct, $confArr);
            // delete obsolte params
            if (!empty($confDiffDEL)) {
                $where = "'" . implode("', '", $confDiffDEL) . "'";
                $sql = "DELETE FROM " . TABLE_CONFIGURATION . " WHERE configuration_key IN ($where)";
                $this->db->Execute($sql);
                if ($multi) {
                    $sql = "DELETE FROM " . TABLE_CONFIGURATION_LANGUAGE . " WHERE configuration_key IN ($where)";
                    $this->db->Execute($sql);
                }
            }
            // only insert new params; let the old ones live    
            $ins = "INSERT INTO  " . TABLE_CONFIGURATION . "  (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function) VALUES ";
            $confArrAdd = array(
                                'RL_INVOICE3_ADDRESS1_POS' => "('XY-position of address1 position', 'RL_INVOICE3_ADDRESS1_POS', '0|30', 'XY-position of address; its the margin delta <br />Default: 0|30', $group, 30, NULL)", 
                                'RL_INVOICE3_ADDRESS2_POS' => "('XY-position of address2 position', 'RL_INVOICE3_ADDRESS2_POS', '90|30', 'XY-position of address; its the margin delta <br />Default: 80|30', $group, 80, NULL)",
                                'RL_INVOICE3_ADDRESS_BORDER' => "('border Address1|2', 'RL_INVOICE3_ADDRESS_BORDER', 'LTRB|LTRB', 'border Address1|2: LTRB (Left Top Right Bottom)<br />', $group, 70, NULL)", 
                                'RL_INVOICE3_ADDRESS_WIDTH' => "('width Address1|2', 'RL_INVOICE3_ADDRESS_WIDTH', '80|80', 'width Address1|2: 60|60<br />', $group, 40, NULL)", 
                                'RL_INVOICE3_DELTA' => "('deltas', 'RL_INVOICE3_DELTA', '26|20', 'delta address invoice|delta invoice products: 20|20<br />', $group, 50, NULL)", 
                                'RL_INVOICE3_FONTS' => "('fonts for invoice|products', 'RL_INVOICE3_FONTS', 'dejavusanscondensed|dejavusanscondensed', 'fonts for <br />1. invoice in general <br >2. products & total-table<br />', $group, 120, NULL)", 
                                'RL_INVOICE3_LINE_HEIGT' => "('Line Height', 'RL_INVOICE3_LINE_HEIGT', '1.25', 'Line Height', $group, 130, NULL)", 
                                'RL_INVOICE3_LINE_THICK' => "('Line Total Thickness', 'RL_INVOICE3_LINE_THICK', '0.5', 'thickness off total-line', $group, 130, NULL)", 
                                'RL_INVOICE3_MARGIN' => "('defines the margins', 'RL_INVOICE3_MARGIN', '25|10|30|20', 'defines the margins:<br />top|right|bottom|left<br />(Note: 1inch = 72pt / 2.54cm; 1cm = 28,35pt)<br />', $group, 20, NULL)", 
                                'RL_INVOICE3_NOT_NULL_INVOICE' => "('Accounting for free product', 'RL_INVOICE3_NOT_NULL_INVOICE', '0', 'Accounting for free product: send e-mail invoice', $group, 130, NULL)", 
                                'RL_INVOICE3_ORDERSTATUS' =>  "('send by orderstatus greater/equal than ', 'RL_INVOICE3_ORDERSTATUS', '3', 'only send invoice if orders_status greater or equal than', $group, 130, NULL)", 
                                'RL_INVOICE3_ORDER_ID_PREFIX' => "('prefix for OrderNo', 'RL_INVOICE3_ORDER_ID_PREFIX', ': 2012', 'prefix for OrderNo<br />', $group, 110, NULL)", 
                                'RL_INVOICE3_PAPER' => "('Paper Size/Units/Oriantation', 'RL_INVOICE3_PAPER', 'A4|mm|P', '1. papersize = A3|A4|A5|Letter|Legal <br />2. units: pt|mm|cm|inch <br />3. Oriantation: L|P<br />', $group, 10, NULL)", 
                                'RL_INVOICE3_PDF_BACKGROUND' => "('pdf background file', 'RL_INVOICE3_PDF_BACKGROUND', '" . DIR_FS_CATALOG . DIR_WS_INCLUDES . "pdf/rechnung_de.pdf', 'pdf background file: " . DIR_FS_CATALOG . DIR_WS_INCLUDES . "pdf/rl_invoice3_bg.pdf<br />', $group, 60, NULL)", 
                                'RL_INVOICE3_PDF_PATH' => "('filename and path to store the pdf-file', 'RL_INVOICE3_PDF_PATH', '" . DIR_FS_CATALOG . "pdf/|1', '1. path to store the pdf-file (!!must be writeable !!)<br />Default: ../pdf/|1<br />', $group, 130, NULL)", 
                                'RL_INVOICE3_SEND_ATTACH' => "('additional attachements', 'RL_INVOICE3_SEND_ATTACH', 'AGB.pdf|Widerrufsrecht.pdf', 'RL_INVOICE3_SEND_PDF', $group, 130, NULL)", 
                                'RL_INVOICE3_SEND_ORDERSTATUS_CHANGE' =>  "('[RE]send order', 'RL_INVOICE3_SEND_ORDERSTATUS_CHANGE', '3|100', '[RE]send invoice, if orderstatus changed to', $group, 130, NULL)", 
                                'RL_INVOICE3_SEND_PDF' => "('send pdf invoice with order', 'RL_INVOICE3_SEND_PDF', '1', 'Do you want to send the invoice with an order?', $group, 130, NULL)", 
                                'RL_INVOICE3_TABLE_TEMPLATE' => "('Templates for products table & total table', 'RL_INVOICE3_TABLE_TEMPLATE', 'amazon|amazon_templ|total_col_1|total_opt_1', 'templates for products_table & total_table; this is defined in rl_invoice3_def.php; see also: docs/rl_invoice/readme_ezpdf.pdf<br />', $group, 90, NULL)",
                                'RL_INVOICE3_WITHOUTINVOICE' => "('do not print invoice address', 'RL_INVOICE3_WITHOUTINVOICE', 'false', 'do not print invoice address', $group, 160, \"zen_cfg_select_option(array('true', 'false'), \")",
                                'RL_INVOICE3_TEMPLATE_ONLY_FIRST_PAGE' => "('PDF-template on first page', 'RL_INVOICE3_TEMPLATE_ONLY_FIRST_PAGE', 'false', 'print pdf-background-template omly on the first page', $group, 160, \"zen_cfg_select_option(array('true', 'false'), \")",
                                'RL_INVOICE3_DELTA_2PAGE' => "('Delta 2.Page', 'RL_INVOICE3_DELTA_2PAGE', '15', 'Delta 2.Page', $group, 160, \"\")",
                                );
            foreach ($confDiffAdd as $value) {
               $sql = $ins . $confArrAdd[$value];
               $this->db->Execute($sql);
            }
            if ($multi) {
               $ins = "INSERT INTO " . TABLE_CONFIGURATION_LANGUAGE . " (configuration_key, configuration_language_id, configuration_title, configuration_description) VALUES ";
               $confArrMultiAdd = array(
                                    'RL_INVOICE3_ADDRESS1_POS' => "('RL_INVOICE3_ADDRESS1_POS', 43, 'XY-Position der Adresse1', 'XY-Position der Adresse1; es ist das Delta zu den Rändern einzugeben<br />Standard: 0|30')", 
                                    'RL_INVOICE3_ADDRESS2_POS' => "('RL_INVOICE3_ADDRESS2_POS', 43, 'XY-Postion der Adresse2', 'XY-Postion der Adresse2; es ist das Delta zu den Rändern einzugeben<br />Standard: 0|30')",
                                    'RL_INVOICE3_ADDRESS_BORDER' => "('RL_INVOICE3_ADDRESS_BORDER', 43, 'Rändereinstellungen für Adresse1|2', 'Rändereinstellungen für Adresse1|2<br />LTRB (Left Top Right Bottom)<br />Standard: LTRB|LTRB<br />')", 
                                    'RL_INVOICE3_ADDRESS_WIDTH' => "('RL_INVOICE3_ADDRESS_WIDTH', 43, 'Breite von Adressfeld1|2', '<br />standard: 80|60')", 
                                    'RL_INVOICE3_DELTA' => "('RL_INVOICE3_DELTA', 43, 'Deltas', 'Abstand Adresse:Rechnungsnummer | Abstand Rechnungsnummer:Produktliste<br />Standard: 20|20<br />')", 
                                    'RL_INVOICE3_FONTS' => "('RL_INVOICE3_FONTS', 43, 'Schriftarten für Rechnung und Artikel', 'Welche Schriftarten wollen Sie verwenden? <br />1. Für Rechnungstexte <br >2. Für Artikel und Summe<br /><br />Standard: dejavusanscondensed|dejavusanscondensed<br />(Pfad/und Schriftart für Rechnung|Pfad/und Schriftart für Artikel und Summe<br />')", 
                                    'RL_INVOICE3_LINE_HEIGT' => "('RL_INVOICE3_LINE_HEIGT', 43, 'Zeilenhöhe', 'Zeilenhöhe')", 
                                    'RL_INVOICE3_LINE_THICK' => "('RL_INVOICE3_LINE_THICK', 43, 'Dicke der Striche bei Gesamtsumme', 'Wie dick soll der Strich bei der Gesamtsumme sein?')", 
                                    'RL_INVOICE3_MARGIN' => "('RL_INVOICE3_MARGIN', 43, 'Rändereinstellungen', 'Format: oben|rechts|unten|links<br />(Hinweis: 1inch = 72pt / 2.54cm; 1cm = 28,35pt)<br />Standard: 30|30|30|60<br />')", 
                                    'RL_INVOICE3_NOT_NULL_INVOICE' => "('RL_INVOICE3_NOT_NULL_INVOICE', 43, 'Rechnung bei Gratisprodukt', 'Soll die Rechnung auch bei einem Gratisprodukt dem Mail hinzugefügt werden?')", 
                                    'RL_INVOICE3_ORDERSTATUS' =>  "('RL_INVOICE3_ORDERSTATUS', 43, 'Rechnungsversand bei Bestellstatus', 'Rechnung nur mitschicken, wenn der Bestellstatus grösser/gleich ist [default: 3 == verschickt]')", 
                                    'RL_INVOICE3_ORDER_ID_PREFIX' => "('RL_INVOICE3_ORDER_ID_PREFIX', 43, 'Präfix für Rechnungsnummer in der Rechnung', 'Präfix für Rechnungsnummer in der Rechnung<br />Beispiel: : 2012/<br />')", 
                                    'RL_INVOICE3_PAPER' => "('RL_INVOICE3_PAPER', 43, 'Papiergrösse|Einheit|Orientierung', '1. Papiergrösse = A3|A4|A5|Letter|Legal <br />2. Einheit: pt|mm|cm|inch <br />3. Orientierung: L|P<br />')", 
                                    'RL_INVOICE3_PDF_BACKGROUND' => "('RL_INVOICE3_PDF_BACKGROUND', 43, 'PDF Hintergrunddatei', 'PDF Hintergrunddatei<br />Standard: " . DIR_FS_CATALOG . DIR_WS_INCLUDES . "pdf/rl_invoice3_bg.pdf<br />')", 
                                    'RL_INVOICE3_PDF_PATH' => "('RL_INVOICE3_PDF_PATH', 43, 'Speicherort und -name der PDF-Datei', '1. Wo sollen PDF-Dateien gespeichert werden (!! muss beschreibbar sein !!)?<br />2. speichern ja|nein (1|0)<br />Standard: " . DIR_FS_CATALOG . DIR_WS_INCLUDES . "pdf/|1<br />')", 
                                    'RL_INVOICE3_SEND_ATTACH' => "('RL_INVOICE3_SEND_ATTACH', 43, 'Anhänge', 'Welche PDFs sollen noch angehängt werden; bei mehreren Dateien | (pipe) als Trenner verwenden)')", 
                                    'RL_INVOICE3_SEND_ORDERSTATUS_CHANGE' => "('RL_INVOICE3_SEND_ORDERSTATUS_CHANGE', 43, 'Rechnungsneuversand', 'Bei welcher Änderung des Bestellstatus soll die Rechnung [nochmals] versendet werden')", 
                                    'RL_INVOICE3_SEND_PDF' => "('RL_INVOICE3_SEND_PDF', 43, 'Rechnung bei Bestellung', 'Soll die Rechnung gleich bei der Bestellung gesendet werden?')", 
                                    'RL_INVOICE3_TABLE_TEMPLATE' => "('RL_INVOICE3_TABLE_TEMPLATE', 43, 'Template für Artikel- und Summentabelle', 'Template für Artikel- und Summentabelle<br />Definition ist in includes/pdf/rl_invoice3_def.php<br />Standard: 30|30|30|60<br />Standard: amazon|amazon_templ|total_col_1|total_opt_1<br />')",
                                    'RL_INVOICE3_WITHOUTINVOICE' => "('RL_INVOICE3_WITHOUTINVOICE', 43, 'Rechnungsadresse nicht drucken', 'Rechnungsadresse nicht drucken')",
                                    'RL_INVOICE3_TEMPLATE_ONLY_FIRST_PAGE' => "('RL_INVOICE3_TEMPLATE_ONLY_FIRST_PAGE', 43, 'PDF-Template auf 1.Seite', 'PDF-Template nur auf 1.Seite drucken')",
                                    'RL_INVOICE3_DELTA_2PAGE' => "('RL_INVOICE3_DELTA_2PAGE', 43, 'Abstand 2.Seite', 'Zusätzlicher Abstand auf 2. Seite')",
                                    );
               foreach ($confDiffAdd as $value) {
                   $sql = $ins . $confArrMultiAdd[$value];
                   $this->db->Execute($sql);
               }
            }
            // link to config if new values added
            $link = HTTP_SERVER . DIR_WS_ADMIN . 'configuration.php?gID=' . $group;
            zen_redirect($link);
            die('LINK');
        }
        
    }
    function SetWidths($w) {
        // Set the array of column widths
        $this->widths = $w;
        $this->widthSum = 0;
        foreach ($w as $value) {
            $this->widthSum += $value;
        }
    }
    function SetAligns($a) {
        // Set the array of column alignments
        $this->aligns = $a;
    }
    function mr($data) {
        $such = array("\t", "&nbsp;", chr(160), '&euro;');
        $ers = array('   ', ' ', ' ', '€');
        return str_replace($such, $ers, $data);
    }
    function Row($data) {
        // Calculate the height of the row
        $this->xyz = $data[0] . ' :: ' . $data[1] . ' :: ' . $data[2];
        $y1 = $this->pdf->getY();
        $nb = 0;
        for ($i = 0;$i < count($data);$i++) {
            $nb = max($nb, $this->NbLines($this->widths[$i], $data[$i]));
        }
        $h = 3 * $nb;
        // Issue a page break first if needed
        $this->CheckPageBreak($h);
        // Draw the cells of the row
        for ($i = 0;$i < count($data);$i++) {
            $w = $this->widths[$i];
            $a = isset($this->aligns[$i]) ? $this->aligns[$i] : 'L';
            // Save the current position
            $x = $this->pdf->GetX();
            $y = $this->pdf->GetY();
            if($w > 0){
                // Draw the border
                ###$this->pdf->Rect($x, $y, $w, $h);
                $recArr[] = array('x' => $x, 'y' => $y, 'w' => $w);
                // Print the text
                $mc = $this->pdf->MultiCell($w, $this->pdf->FontSize * $this->lineHeight[0], $this->mr($data[$i]), 0, $a);
                $h1[] = $mc[0];
                $h2[] = $mc[1];
                #$this->pdf->MultiCell($w, 3, $this->mr($data[$i]), 'LR', $a);
                // Put the position to the right of the cell
                $this->pdf->SetXY($x + $w, $y);
            }
        }
        $y2 = $this->pdf->getY();
        $h = max($h2) - min($h1);
        foreach($recArr as $key => $v) {
            $this->pdf->Rect($v['x'], $v['y'], $v['w'], $h);
        }
        // Go to the next line
        $this->CheckPageBreak($h);
        $this->pdf->Ln($h);
    }
    function CheckPageBreak($h) {
        // If the height h would cause an overflow, add a new page immediately
        if (($this->pdf->GetY() + $h + 12) > $this->pdf->PageBreakTrigger) {
            $this->pdf->SetXY($this->margin['left'], $this->pdf->GetY() + $this->t1Opt['fontSize'] / 2);
            $this->pdf->Cell($this->widthSum-20, 6, RL_INVOICE3_SUBTOTAL, '', 0, 'R');
            $subT = $this->mr(html_entity_decode($this->currencies->format($this->subtotal, true, $this->order->info['currency'], $this->order->info['currency_value'])));
            $this->pdf->Cell(20, 6, $subT, '', 2, 'R');
            
            $this->pdf->addPage($this->pdf->CurOrientation);
            if(RL_INVOICE3_TEMPLATE_ONLY_FIRST_PAGE=='false'){
                $this->pdf->useTemplate($this->tplidx2); 
                $this->pdf->SetXY($this->margin['left'], intval($this->pdf->GetY()) + intval($this->delta2page[0]));
            }
            
            
            $this->pdf->Cell($this->widthSum-20, 6, RL_INVOICE3_BALANCE, '', 0, 'R');
            $this->pdf->Cell(20, 6, $subT, '', 2, 'R');
            $this->pdf->SetXY($this->margin['left'], $this->pdf->GetY() + $this->t1Opt['fontSize'] / 2);
        }
    }
    function NbLines($w, $txt) {
        // Computes the number of lines a MultiCell of width w will take
        $cw = $this->CurrentFont['cw'];
        if ($w == 0) $w = $this->w - $this->rMargin - $this->x;
        $wmax = ($w - 2 * $this->cMargin) * 1000 / $this->pdf->FontSize;
        $s = str_replace("\r", '', $txt);
        $nb = strlen($s);
        if ($nb > 0 and $s[$nb - 1] == "\n") $nb--;
        $sep = - 1;
        $i = 0;
        $j = 0;
        $l = 0;
        $nl = 1;
        while ($i < $nb) {
            $c = $s[$i];
            if ($c == "\n") {
                $i++;
                $sep = - 1;
                $j = $i;
                $l = 0;
                $nl++;
                continue;
            }
            if ($c == ' ') $sep = $i;
            $l+= $cw[$c];
            if ($l > $wmax) {
                if ($sep == - 1) {
                    if ($i == $j) $i++;
                } else $i = $sep + 1;
                $sep = - 1;
                $j = $i;
                $l = 0;
                $nl++;
            } else $i++;
        }
        return $nl;
    }
    function checkFonts() {
        $ok = false;
        if (is_array($this->fonts)) {
            $ok = true;
        } else {
            return false;
        }
        foreach($this->fonts as $key => $fontPath) {
            if (!file_exists($fontPath)) {
                $ok = false;
                $this->fonts[$key] = 'ERROR: ' . $fontPath . ' font not found: ';
            }
        }
        return $ok;
    }
    function getDefault($var = 'NIX', $def, $exp = '|') {
        $def = (array)$def;
        $tmp = explode($exp, trim($var));
        if (is_array($def)) {
            $i = 0;
            foreach($def as $key => $val) {
                if (isset($tmp[$i]) && $tmp[$i] != '' && $tmp[$i] != '#') {
                    $def[$key] = $tmp[$i];
                }
                $i++;
            }
        }
        $c = count($def);
        if ($count = 1) {
            #$def = $def[0];
            
        }
        return $def;
    }
    function getDefaultCheck($var = 'NIX', $def, $exp = '|') {
        $tmp = explode($exp, trim($var));
        $i = 0;
        foreach($def as $key => $val) {
            if (isset($tmp[$i]) && $tmp[$i] != '' && $tmp[$i] != '#') {
                $def[$key] = $tmp[$i];
            }
            $i++;
        }
        return $def;
    }
    function makeAddr() {
        #echo rldp($this->order, 'ADR');
        $x['delivery'] = htmlspecialchars_decode(str_replace('<br>', "\n", zen_address_format($this->order->delivery['format_id'], $this->order->delivery, 1, '', '<br>')));
        if (strlen($x['delivery']) < 9) {
            $x['delivery'] = htmlspecialchars_decode(str_replace('<br>', "\n", zen_address_format($this->order->customer['format_id'], $this->order->customer, 1, '', '<br>')));
        }
        $x['billing'] = htmlspecialchars_decode(str_replace('<br>', "\n", zen_address_format($this->order->billing['format_id'], $this->order->billing, 1, '', '<br>')));
        $this->pdf->SetFont($this->fonts2['general'], '', 16);
        $this->pdf->SetXY($this->address1Pos['X'], $this->address1Pos['Y']);
        $this->pdf->Cell($this->addressWidth['addr1'], 5, LIEFERADRESSE, $this->addressBorder['addr1'], 2, 'L');
        $this->pdf->MultiCell($this->addressWidth['addr1'], 5, $x['delivery'], $this->addressBorder['addr1'], 1, 'L');
        $this->pdf->SetXY($this->address2Pos['X'], $this->address2Pos['Y']);
        $this->pdf->Cell($this->addressWidth['addr2'], 5, RECHNUNGSADRESSE, $this->addressBorder['addr2'], 2, 'L');
        $this->pdf->MultiCell($this->addressWidth['addr2'], 5, $x['billing'], $this->addressBorder['addr2'], 1, 'L');
        
    }
    function makeInvoiceNumber() {
        $hoehe=$this->t1Opt['lineHeightInvoiceNumber'];
        $this->pdf->SetFont($this->fonts2['general'], '', $this->t1Opt['fontSizeInvoiceNumber']); 
            
        $this->pdf->SetY($this->delta['addrInvoice'] + $this->pdf->GetY());
        $dat = str_replace('@DATE@', strftime(DATE_FORMAT_SHORT), RL_INVOICE3_CITY);
        $tmp = ENTRY_ORDER_ID . sprintf("%s%05d", RL_INVOICE3_ORDER_ID_PREFIX, $this->oID);
        $this->pdf->Cell($this->maxWidth, $hoehe, $tmp, '', 1, 'L');
        
        $tmp = RL_INVOICE3_ENTRY_DATE_INVOICE . " " . zen_date_short(date("Y-m-d H:i", time()));
        $this->pdf->Cell($this->maxWidth, $hoehe, $tmp, '', 0, 'L');
        $this->pdf->SetX(20);
        $this->pdf->Cell($this->maxWidth, $hoehe, $dat, '', 2, 'R');
        
      $this->pdf->SetX($this->margin['left']);
        $tmp = ENTRY_DATE_PURCHASED . " " . zen_date_short($this->order->info['date_purchased']);
        $this->pdf->Cell($this->maxWidth, $hoehe, $tmp, '', 0, 'L');
        $this->pdf->SetX(20);
        $this->pdf->Cell($this->maxWidth, $hoehe, $dat, '', 2, 'R');
        
      $this->pdf->SetX($this->margin['left']);
        $tmp = RL_INVOICE3_PAYMENT_METHOD . " " . $this->order_check->fields['payment_method'];
        $this->pdf->Cell($this->maxWidth, $hoehe, $tmp, '', 0, 'L');
    }
    


    function getUniqueCode($prefix = 'product_', $length = 25){
        $code = uniqid($prefix);
        $code = substr($code, 0, $length);
        return $code;
    }

    function createRandomInt($min = 1, $max = 9999){
        return rand($min, $max);
    }
    
    function makeProductTestData($count = 50){
        $productData = array();
        for($i=0; $i<=$count; $i++){
            $tmp['qty'] = $this->createRandomInt(1, 100);
            $tmp['id'] =$this->getUniqueCode('', 3);
            $tmp['name'] =$this->getUniqueCode();
            $tmp['model'] =$this->getUniqueCode('MO_', 10);
            $tmp['tax'] = $this->createRandomInt(5, 30);
            $tmp['price'] = $this->createRandomInt(30) / 100;
            $tmp['onetime_charges'] = $this->createRandomInt(0,10);
            $tmp['final_price'] = $this->createRandomInt(30) / 100;
            $tmp['product_is_free'] = $this->createRandomInt(0, 1);
            $productData[] = $tmp;
        }
        return $productData;
    }
    
    function getProductData($p = false) {
        $data = array();
        $i = 0;
        if($p) {
            $this->order->products = $p;
        }
        foreach($this->order->products as $key => $val) {
            $data[$i]['qty'] = $val['qty'];
            $data[$i]['model'] = $val['model'];
            $data[$i]['name'] = strip_tags($val['name']);
            $data[$i]['qty_name'] = strip_tags($val['qty'] . '* ' . $val['name']);
            $data[$i]['qty_name_model'] = strip_tags($val['qty'] . '* ' . $val['name'] . ' (' . $val['model'] . ')');
            $data[$i]['tax'] = zen_display_tax_value($val['tax']) . '%';
            if (isset($val['attributes'])) {
                foreach($val['attributes'] as $key2 => $val2) {
                    $data[$i]['name'].= "\n\t" . $val2['option'] . ': ' . $val2['value'];
                    $data[$i]['qty_name'].= "\n\t" . $val2['option'] . ': ' . $val2['value'];
                    $data[$i]['qty_name_model'].= "\n\t" . $val2['option'] . ': ' . $val2['value'];
                }
            }
            $data[$i]['singleE']    = $this->mr(html_entity_decode($this->currencies->format($val['final_price'], true, $this->order->info['currency'], $this->order->info['currency_value'])));
            $data[$i]['singleI']    = $this->mr(html_entity_decode($this->currencies->format($val['final_price'] + $val['final_price'] * $val['tax'] / 100, true, $this->order->info['currency'], $this->order->info['currency_value'])));
            $data[$i]['extraE']     = $this->mr(html_entity_decode($this->currencies->format($val['onetime_charges'], true, $this->order->info['currency'], $this->order->info['currency_value'])));
            $data[$i]['extraI']     = $this->mr(html_entity_decode($this->currencies->format($val['onetime_charges'] + $val['tax'] * $val['onetime_charges'] / 100, true, $this->order->info['currency'], $this->order->info['currency_value'])));
            $data[$i]['sumE']       = $this->mr(html_entity_decode($this->currencies->format($val['qty'] * ($val['final_price']) + $val['onetime_charges'], true, $this->order->info['currency'], $this->order->info['currency_value'])));
            $data[$i]['sumI']       = $this->mr(html_entity_decode($this->currencies->format($val['qty'] * ($val['final_price'] + $val['final_price'] * $val['tax'] / 100) + ($val['onetime_charges'] + $val['tax'] * $val['onetime_charges'] / 100), true, $this->order->info['currency'], $this->order->info['currency_value'])));
            $data[$i]['subtotalE']  = $val['qty'] * ($val['final_price']) + $val['onetime_charges'];
            $data[$i]['subtotalI']  = $val['qty'] * ($val['final_price'] + $val['final_price'] * $val['tax'] / 100) + ($val['onetime_charges'] + $val['tax'] * $val['onetime_charges'] / 100);
            $i++;
        }
        #rldp($data, 'DATA');
        #die();
        return $data;
    }
    function getTotalData() {
        $data = array();
        $i = 0;
        foreach($this->order->totals as $key => $val) {
            $data[$i]['title'] = strip_tags(html_entity_decode($val['title']));
            $data[$i]['text'] = $this->mr(html_entity_decode($val['text']));
            $data[$i]['class'] = $val['class'];
            $i++;
        }
        return $data;
    }
    function makeProducts($p = null) {
        $productData = $this->getProductData($p);
        $this->pdf->SetFont($this->fonts2['table'], '');
        $this->pdf->SetFontSize($this->t1Opt['fontSize']);
        $this->pdf->SetY($this->delta['invoiceProducts'] + $this->pdf->GetY());
        $this->pdf->SetX($this->margin['left']);
        // table-header
        $this->pdf->SetFillColor(199);
        foreach($this->t1Col as $key => $value) {
            if (is_null($this->t1Opt['cols'][$key]['width'])) {
                $wi = 10;
            } else {
                $wi = $this->t1Opt['cols'][$key]['width'];
            }
            if($wi > 0){
                $this->pdf->Cell($wi, $this->t1Opt['fontSize'] / 2, $value, '1', 0, $this->t1Opt['cols'][$key]['justification'], 1);
            }
        }
        $this->pdf->SetFont($this->fonts2['general']);
        $this->pdf->SetXY($this->margin['left'], $this->pdf->GetY() + $this->t1Opt['fontSize'] / 2);
        $i = 0;
        $width = array();
        $allign = array();
        foreach($this->t1Col as $key => $value) {
            $width[] = $value;
            $allign[] = $this->t1Opt['cols'][$key]['justification'];
        }
        $this->SetAligns($allign);
        foreach($productData as $pKey => $pValue) {
            $mValue = array();
            $width = array();
            foreach($this->t1Col as $key => $value) {
                if (is_null($this->t1Opt['cols'][$key]['width'])) {
                    $width[] = 10;
                } else {
                    $width[] = $this->t1Opt['cols'][$key]['width'];
                }
                $mValue[] = $pValue[$key];
            }
            $this->SetWidths($width);
            $this->subtotal += $mValue[$this->subtotalColumn];
            $this->Row($mValue);
        }
    }
    function makeHC($txt) {
        $this->pdf->Cell(122, 8, $txt, 0);
    }
    function makeTotal() {
        $totalData = $this->getTotalData();
        $this->pdf->SetFont($this->fonts2['general'], '');
        $this->pdf->SetFontSize($this->t1Opt['fontSize']);
        $this->pdf->SetFillColor(199);
        $this->pdf->SetX($this->margin['left']);
        $w = 0;
        foreach($this->widths as $value) {
            $w+= $value;
        }
        $leftR = $w + $this->pdf->lMargin;
        $leftL = $w + $this->pdf->lMargin;
        $i = 0;
        $m = 1;
        $lineWidth = $this->lineThick[0];
        foreach($totalData as $key => $value) {
            $y = $i % 2;
            $x = round($this->pdf->GetStringWidth($value['title']), 1);
            $m = max($m, $x);
            $leftL = $leftR - 20 - $m;
            if ($value['class'] == 'ot_total') {
                $this->pdf->SetLineWidth($lineWidth);
                $this->pdf->line($leftL, $this->pdf->GetY(), $leftR, $this->pdf->GetY());
                $this->pdf->setY($this->pdf->GetY() + $lineWidth);
            }
            #$this->pdf->Cell(160.5, $this->t1Opt['fontSize'] / 2, $value['title'], '0', 0, 'R', $y);
            $this->pdf->Cell($this->widthSum-20, $this->t1Opt['fontSize'] / 2, $value['title'], '0', 0, 'R', $y);
            $this->pdf->Cell(20, $this->t1Opt['fontSize'] / 2, $value['text'], '0', 0, 'R', $y);
            $this->pdf->SetXY($this->margin['left'], $this->pdf->GetY() + $this->t1Opt['fontSize'] / 2);
            $i++;
        }
        // paint lines
        $this->pdf->SetLineWidth($lineWidth);
        $this->pdf->line($leftL, $this->pdf->GetY(), $leftR, $this->pdf->GetY());
    }
    function isMultiLingual() {
        global $db;
        $sql = "SHOW  TABLES  LIKE  '" . TABLE_CONFIGURATION_LANGUAGE . "'";
        $res = $db->Execute($sql);
        if ($res->RecordCount() == 0) {
            return false;
        } else {
            return true;
        }
    }
    function makeDebugInfo() {
        if ($this->debug['debug'] == 1) {
            $this->pdf->addPage();
            $this->pdf->SetXY(10, 10);
            $this->pdf->SetFontSize(8);
            $this->pdf->MultiCell(0, 3, $this->debugInfo, 1);
        }
    }
    function getPDFFileName() {
        $pdfName = $this->oID . '_' . md5($this->order->customer['email_address']) . ".pdf";
        return $this->pdfPath['path'] . $pdfName;
    }
    function getPDFAttachments($param = 'ALL') {
        $attachArray = array();
        $tmp = $this->getPDFFileName();
        if (file_exists($tmp)) {
            $ft = str_replace($this->pdfPath['path'], '', $tmp);
            $attachArray[] = array('file' => $this->getPDFFileName(), 'mime_type' => 'pdf', 'name' => RL_INVOICE3_INVLINK, 'fn' => $ft);
        }
        if ($param == 'ALL') {
            if (isset($this->t1Opt['attachLang'][$_SESSION['languages_id']])){
                foreach ($this->t1Opt['attachLang'][$_SESSION['languages_id']] as $value) {
                    $attachements[] = $value;
                }
            } else {
                $attachements = $value;
            }
            foreach($attachements as $value) {
                if (file_exists($value)) {
                    $attachArray[] = array('file' => $value, 'mime_type' => 'pdf', 'name' => basename($value));
                    continue;
                }
                $file = DIR_FS_CATALOG . DIR_WS_INCLUDES . 'pdf/' . $value;
                if (file_exists($file)) {
                    $attachArray[] = array('file' => $file, 'mime_type' => 'pdf', 'name' => $value);
                }
            }
            #rldp($attachArray, '$attachArray');
            #die('$attachArray');
        }
        return $attachArray;
    }
    function writePDF($onlyFile = false, $test = false) {
        $pdfName = $this->oID . ".pdf";
        if (!$onlyFile) {
            $this->pdf->Output($pdfName, "I");
        }
        if ($this->pdfPath['save'] == 1) {
            if($test){
                $fn = DIR_WS_ADMIN . DIR_WS_IMAGES . 'TestInvoice.pdf';
                $fnn = DIR_FS_ADMIN . DIR_WS_IMAGES . 'TestInvoice.pdf';
                $this->pdf->Output($fnn, "F");
            } else {
                $this->pdf->Output($this->getPDFFileName(), "F");
            }
        }
        $this->pdf->_closeParsers();
        return $fn;
    }
    function createPdfFile($onlyFile = false) {
        if (file_exists($this->getPDFFileName())) {
            #$onlyFile =
        }
        $this->makeAddr();
        $this->makeInvoiceNumber();
        $this->makeProducts();
        $this->makeTotal();
        $this->writePDF($onlyFile);
    }
}