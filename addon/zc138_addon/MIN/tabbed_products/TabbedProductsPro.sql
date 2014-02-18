SET @gid=0;
SELECT @gid:=configuration_group_id
FROM configuration_group
WHERE configuration_group_title LIKE '%Tabbed Products Config%'
LIMIT 1;
DELETE FROM configuration WHERE configuration_group_id = @gid;
DELETE FROM configuration_group WHERE configuration_group_id = @gid;
SET @gid=0;
SELECT @gid:=configuration_group_id
FROM configuration_group
WHERE configuration_group_title LIKE '%TPP - Config%'
LIMIT 1;
DELETE FROM configuration WHERE configuration_group_id = @gid;
DELETE FROM configuration_group WHERE configuration_group_id = @gid;
DELETE FROM configuration_group WHERE configuration_group_title LIKE '%Tabbed Products Config%';
DELETE FROM configuration_group WHERE configuration_group_title LIKE '%TPP - Config%';
DELETE FROM configuration WHERE configuration_description LIKE 'Set this to 1%' LIMIT 12;
DELETE FROM configuration WHERE configuration_title LIKE 'TPP - %' LIMIT 12;
INSERT INTO configuration_group VALUES (NULL, 'TPP - Config', 'Tabbed Products Pro - Config', '1', '1');
SET @gid=last_insert_id();
UPDATE configuration_group SET sort_order = @gid WHERE configuration_group_id = @gid;
INSERT INTO configuration VALUES(NULL, 'TPP - Global Enable Tabs', 'GLOBAL_ENABLE_TABS', '1', 'Set this to 1 if you want to enable the global use of tabs on your products', @gid, 1, '2008-01-14 20:11:07', '2007-01-12 22:07:11', NULL, 'zen_cfg_select_option(array(''0'', ''1''),'),
				(NULL, 'TPP - Global Main Image On Tab', 'GLOBAL_MAIN_IMAGE_ON_TAB', '0', 'Set this to 1 if you want all products to have the Main Image on the first (Product Description) tab', @gid, 2, '2008-01-14 20:18:34', '2007-01-12 22:07:11', NULL, 'zen_cfg_select_option(array(''0'', ''1''),'),
				(NULL, 'TPP - Global Product Description Tab', 'GLOBAL_PROD_DESC_ON_TAB', '1', 'Set this to 1 if you want all products to have the Main Product Description on its own tab', @gid, 3, '2008-01-14 20:18:34', '2007-01-12 22:07:11', NULL, 'zen_cfg_select_option(array(''0'', ''1''),'),
				(NULL, 'TPP - Global Attributes on Tab', 'GLOBAL_ATTRIBUTES_ON_TAB', '0', 'Set this to 1 if you want the Attributes to appear on their own tab. This will only show up if the product has attributes to show. If there are no attributes, the tab will not show up.', @gid, 4, '2008-01-14 20:19:22', '2007-01-12 22:07:11', NULL, 'zen_cfg_select_option(array(''0'', ''1''),'),
                (NULL, 'TPP - Global Attributes on Add-to-Cart Tab', 'GLOBAL_ATTRIBUTES_ON_ATC_TAB', '0', 'Set this to 1 if you want the Attributes to appear on the Add-To-Cart tab. They will only show up if the product has attributes to show. YOU MUST ALSO LEAVE THE Global Attributes on Tab OPTION ENABLED. This will override the standalone tab and show the attributes on the Add-To-Cart tab only. If the Add-To-Cart tab is set to false, this will be ignored and the attributes will follow their own tab settings.', @gid, 5, '2008-01-14 20:19:22', '2007-01-12 22:07:11', NULL, 'zen_cfg_select_option(array(''0'', ''1''),'),
				(NULL, 'TPP - Global Details On Tabs', 'GLOBAL_DETAILS_ON_TAB', '1', 'Set this to 1 if you want the Product Details to appear on their own tab (weight, model number, etc). This will only show up if the product has details enabled. If there are no product details, the tab will not show up. ', @gid, 6, '2008-01-15 15:34:07', '0001-01-01 00:00:00', NULL, 'zen_cfg_select_option(array(''0'', ''1''),'),
				(NULL, 'TPP - Global Add To Cart Tab', 'GLOBAL_ADD_TO_CART_ON_TAB', '0', 'Set this to 1 if you want the add to cart button to be on its own tab. Note this includes Add To Cart button and Qty Discounts table.', @gid, 7, '2008-01-14 19:29:49', '2007-01-12 22:07:11', NULL, 'zen_cfg_select_option(array(''0'', ''1''),'),
				(NULL, 'TPP - Global Additional Images Tab', 'GLOBAL_ADDL_IMAGES_ON_TAB', '1', 'Set this to 1 if you want the additional images for a product on its own tab. This will only show up if the product has additional images to show. If there are no additional images, the tab will not show up.', @gid, 8, '2008-01-14 20:19:09', '2007-01-12 22:07:11', NULL, 'zen_cfg_select_option(array(''0'', ''1''),'),
				(NULL, 'TPP - Global Customers Also Purchased Tab', 'GLOBAL_CUST_ALSO_PURCH_ON_TAB', '1', 'Set this to 1 if you want the Customers Also Purchased module on its own tab. This will only show up if the product has other products to show. If there are no other products, the tab will not show up.', @gid, 9, '2008-01-14 20:19:15', '2007-01-12 22:07:11', NULL, 'zen_cfg_select_option(array(''0'', ''1''),'),
				(NULL, 'TPP - Global Cross Sell Tab', 'GLOBAL_CROSS_SELL_ON_TAB', '0', 'Set this to 1 if you want the Cross Sell module on its own tab. This will only work if Cross Sell contrib is already installed and the product has cross sell items set up. Otherwise it will just not show up.', @gid, 10, '2007-01-12 22:07:11', '2007-01-12 22:07:11', NULL, 'zen_cfg_select_option(array(''0'', ''1''),'),
				(NULL, 'TPP - Global Reviews Tab', 'GLOBAL_REVIEWS_ON_TAB', '1', 'Set this to 1 if you want the Product Reviews to show up on its own tab. This will always show up even if there are no reviews. The Review module has its own "No reviews found" so it defaults.', @gid, 11, '2008-01-14 20:19:36', '2007-01-12 22:07:11', NULL, 'zen_cfg_select_option(array(''0'', ''1''),'),
				(NULL, 'TPP - Show Tab Headers', 'SHOW_TAB_HEADERS', '1', 'Set this to 1 if you want a header bar to appear under the tabs, above the tab content', @gid, 12, '2007-01-12 22:07:11', '2007-01-12 22:07:11', NULL, 'zen_cfg_select_option(array(''0'', ''1''),');