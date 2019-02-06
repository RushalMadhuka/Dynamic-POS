CREATE DATABASE dynamic_pos;

CREATE TABLE `users` (
  `user_id` INT(1) UNSIGNED AUTO_INCREMENT ,
  `first_name` VARCHAR(50) NOT NULL ,
  `last_name` VARCHAR(50) NOT NULL ,
  `email` VARCHAR(25) NOT NULL ,
  `password` VARCHAR(32) NOT NULL ,
  `account_level` VARCHAR(5) NOT NULL , /* Admin and user */
  `created_user` VARCHAR(25) NOT NULL ,
  `last_login_datetime` DATETIME NOT NULL , 
  `created_datetime` DATETIME NOT NULL , /* time format "2018-06-27 03:11:15" or CURRENT_TIMESTAMP */
  `blocked` BOOLEAN NOT NULL , /* Blocked and Unblocked */
  `status` BOOLEAN NOT NULL , /* Active and Inactive */
  PRIMARY KEY (`user_id`)
);

CREATE TABLE `company_info` (
	`id` int unsigned auto_increment,
    `com_name` varchar(50) not null,    
    `com_address` varchar(50) not null,
    `phone_no` varchar(10) not null,
    primary key (`id`)
);

CREATE TABLE `tax_rate` (
	`id` int unsigned auto_increment,
	`sales_nbt_rate` DECIMAL(5,2) not null,
    `sales_vat_rate` DECIMAL(5,2) not null,
	`purch_nbt_rate` DECIMAL(5,2) not null,    
    `purch_vat_rate` DECIMAL(5,2) not null,
    primary key (`id`)
);

CREATE TABLE `categories` (
  `category_code` VARCHAR(15) NOT NULL ,
  `desc` VARCHAR(50) ,
  `created_user` VARCHAR(25) NOT NULL,
  `created_datetime` DATETIME NOT NULL ,
  PRIMARY KEY (`category_code`)
);

CREATE TABLE `mfr` (
  `mfr_code` VARCHAR(25) NOT NULL ,
  `desc` VARCHAR(50) ,
  `created_user` VARCHAR(25) NOT NULL,
  `created_datetime` DATETIME NOT NULL ,
  PRIMARY KEY (`mfr_code`)
);

CREATE TABLE `uom` (
  `uom_code` VARCHAR(6) NOT NULL ,
  `allowed_decimal` BOOLEAN NOT NULL ,
  `desc` VARCHAR(50) ,
  `created_user` VARCHAR(25) NOT NULL ,
  `created_datetime` DATETIME NOT NULL ,
  PRIMARY KEY (`uom_code`)
);

CREATE TABLE `disc_rate` (
  `disc_id` INT(2) UNSIGNED AUTO_INCREMENT ,
  `disc_value` DECIMAL(5,2) UNIQUE NOT NULL ,
  `desc` VARCHAR(50) ,
  `created_user` VARCHAR(25) NOT NULL ,
  `created_datetime` DATETIME NOT NULL ,
  PRIMARY KEY (`disc_id`)
);

CREATE TABLE `vendor` (
  `vendor_id` INT UNSIGNED AUTO_INCREMENT ,
  `company_name` VARCHAR(50) UNIQUE NOT NULL ,
  `address` VARCHAR(50) ,
  `address_2` VARCHAR(50) ,
  `country` VARCHAR(25) ,
  `city` VARCHAR(25) ,
  `region` VARCHAR(25) ,
  `postal_code` VARCHAR(15) ,
  `phone_no` VARCHAR(10) ,
  `phone_no_2` VARCHAR(10) ,
  `contact_person` VARCHAR(50) ,
  `fax` VARCHAR(10) ,
  `email` VARCHAR(50) ,
  `re-mark` VARCHAR(50) ,
  `created_user` VARCHAR(25) NOT NULL ,
  `created_datetime` DATETIME NOT NULL,
  `blocked` BOOLEAN NOT NULL ,
  PRIMARY KEY (`vendor_id`)
);

CREATE TABLE `customer` (
  `customer_id` INT UNSIGNED AUTO_INCREMENT ,
  `company_name` VARCHAR(50) UNIQUE NOT NULL ,
  `address` VARCHAR(50) ,
  `address_2` VARCHAR(50) ,
  `country` VARCHAR(25) ,
  `city` VARCHAR(25) ,
  `region` VARCHAR(25) ,
  `postal_code` VARCHAR(15) ,
  `phone_no` VARCHAR(10) ,
  `phone_no_2` VARCHAR(10) ,
  `contact_person` VARCHAR(50) ,
  `fax` VARCHAR(10) ,
  `email` VARCHAR(50) ,
  `re-mark` VARCHAR(50) ,
  `created_user` VARCHAR(25) NOT NULL ,
  `created_datetime` DATETIME NOT NULL,
  `blocked` BOOLEAN NOT NULL ,
  PRIMARY KEY (`customer_id`)
);

CREATE TABLE `items` (
  `item_code` VARCHAR(15) NOT NULL,
  `item_name` VARCHAR(50) NOT NULL ,
  `uom_code` VARCHAR(6) NOT NULL ,
  `category_code` VARCHAR(15) NOT NULL ,
  `mfr_code` VARCHAR(25) NOT NULL ,
  `sales_disc_rate` DECIMAL(5,2) NOT NULL ,
  `purch_disc_rate` DECIMAL(5,2) NOT NULL ,
  `unit_cost` DECIMAL(11,2) NOT NULL ,
  `unit_price` DECIMAL(11,2) NOT NULL ,  
  `created_user` VARCHAR(25) NOT NULL ,
  `created_datetime` DATETIME NOT NULL ,
  `blocked` BOOLEAN NOT NULL ,
  PRIMARY KEY (`item_code`) ,
  KEY `FK` (`uom_code`)
);
/* ------------------------------------------------------------------ purchase -------------------------------------------- */

CREATE TABLE `pi_detail` (
  `id` INT UNSIGNED AUTO_INCREMENT ,
  `pi_no` VARCHAR(8) NOT NULL ,
  `pi_date` DATE ,
  `vendor_id` INT NOT NULL ,
  `item_code` VARCHAR(15) NOT NULL ,
  `warehouse_code` VARCHAR(15) NOT NULL,
  `unit_cost` DECIMAL(8,2) NOT NULL ,
  `qty` DECIMAL(8,2) NOT NULL ,
  `uom_code` VARCHAR(6) NOT NULL ,  
  `gross_amount` DECIMAL(11,2) NOT NULL,
  `disc_rate` DECIMAL(5,2) NOT NULL,
  `disc_amount` DECIMAL(11,2) NOT NULL,
  `tax_amount` DECIMAL(11,2) NOT NULL,
  `net_amount` DECIMAL(11,2) NOT NULL,
  `created_user` VARCHAR(25) NOT NULL ,
  `created_datetime` DATETIME NOT NULL ,
  PRIMARY KEY (`id`, `pi_no`) ,
  KEY `FK` (`vendor_id`, `item_code`)
);


CREATE TABLE `si_detail` (
  `id` INT UNSIGNED AUTO_INCREMENT ,
  `si_no` VARCHAR(8) NOT NULL ,
  `si_date` DATE ,
  `customer_id` INT NOT NULL ,
  `item_code` VARCHAR(15) NOT NULL ,
  `warehouse_code` VARCHAR(15) NOT NULL,
  `payment_method` VARCHAR(8) NOT NULL,
  `unit_price` DECIMAL(8,2) NOT NULL ,
  `qty` DECIMAL(8,2) NOT NULL ,
  `uom_code` VARCHAR(6) NOT NULL ,  
  `gross_amount` DECIMAL(11,2) NOT NULL,
  `disc_rate` DECIMAL(5,2) NOT NULL,
  `disc_amount` DECIMAL(11,2) NOT NULL,
  `tax_amount` DECIMAL(11,2) NOT NULL,
  `net_amount` DECIMAL(11,2) NOT NULL,
  `created_user` VARCHAR(25) NOT NULL ,
  `created_datetime` DATETIME NOT NULL ,
  PRIMARY KEY (`id`, `si_no`) ,
  KEY `FK` (`customer_id`, `item_code`)
);


CREATE TABLE `pi_no_pool` (
  `pi_no` VARCHAR(8) ,
  PRIMARY KEY (`pi_no`)
);

CREATE TABLE `si_no_pool` (
  `si_no` VARCHAR(8) ,
  PRIMARY KEY (`si_no`)
);

CREATE TABLE `ip_no_pool` (
  `ip_no` VARCHAR(8) ,
  PRIMARY KEY (`ip_no`)
);
CREATE TABLE `pc_no_pool` (
  `pc_no` VARCHAR(8) ,
  PRIMARY KEY (`pc_no`)
);
CREATE TABLE `ja_no_pool` (
  `ja_no` VARCHAR(8) ,
  PRIMARY KEY (`ja_no`)
);

CREATE TABLE `sa_no_pool` (
  `sa_no` VARCHAR(8) ,
  PRIMARY KEY (`sa_no`)
);
/* -------------------------------------------------------- fffff --------------------------------- */
CREATE TABLE `petty_cash` (
  `id` INT UNSIGNED AUTO_INCREMENT,
  `pc_no` VARCHAR(8) NOT NULL,
  `pc_date` DATE NOT NULL,
  `remark` VARCHAR(100),
  `amount` DECIMAL(11,2) NOT NULL,  
  `created_date` DATETIME NOT NULL,
  `created_user` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`id`,`pc_no`)
);

CREATE TABLE `inbound_payment` (
  `id` INT UNSIGNED AUTO_INCREMENT,
  `ip_no` VARCHAR(8) NOT NULL,
  `ip_date` DATE NOT NULL,
  `remark` VARCHAR(100),
  `amount` DECIMAL(11,2) NOT NULL,  
  `created_date` DATETIME NOT NULL,
  `created_user` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`id`,`ip_no`)
);


/* ------------------------------------------------------- JL ------------------------------ */

CREATE TABLE `gl_cash_book` (
  `id` INT UNSIGNED AUTO_INCREMENT,
  `tx_no` VARCHAR(8) NOT NULL,
  `tx_date` DATE NOT NULL,
  `tx_type` VARCHAR(50) NOT NULL,
  `desc` VARCHAR(50),
  `remark` VARCHAR(50),
  `debit` DECIMAL(11,2) NOT NULL,
  `credit` DECIMAL(11,2) NOT NULL,
  `created_date` DATETIME NOT NULL,
  `created_user` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`id`),
  KEY `FK` (`tx_no`)
);

CREATE TABLE `gl_sales_credit` (
  `id` INT UNSIGNED AUTO_INCREMENT,
  `tx_no` VARCHAR(8) NOT NULL,
  `tx_date` DATE NOT NULL,
  `tx_type` VARCHAR(50) NOT NULL,
  `desc` VARCHAR(50),
  `remark` VARCHAR(50),
  `debit` DECIMAL(11,2) NOT NULL,
  `credit` DECIMAL(11,2) NOT NULL,
  `created_date` DATETIME NOT NULL,
  `created_user` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`id`),
  KEY `FK` (`tx_no`)
);

CREATE TABLE `gl_trade_sales` (
  `id` INT UNSIGNED AUTO_INCREMENT,
  `tx_no` VARCHAR(8) NOT NULL,
  `tx_date` DATE NOT NULL,
  `tx_type` VARCHAR(50) NOT NULL,
  `desc` VARCHAR(50),
  `remark` VARCHAR(50),
  `debit` DECIMAL(11,2) NOT NULL,
  `credit` DECIMAL(11,2) NOT NULL,
  `created_date` DATETIME NOT NULL,
  `created_user` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`id`),
  KEY `FK` (`tx_no`)
);

CREATE TABLE `gl_inventory` (
  `id` INT UNSIGNED AUTO_INCREMENT,
  `tx_no` VARCHAR(8) NOT NULL,
  `tx_date` DATE NOT NULL,  
  `item_code` VARCHAR(15) NOT NULL,
  `tx_type` VARCHAR(50) NOT NULL,
  `warehouse_code` VARCHAR(15) NOT NULL,
  `desc` VARCHAR(50) ,  
  `unit_cost` DECIMAL(8,2) NOT NULL,
  `debit_qty` DECIMAL(11,2) NOT NULL,
  `credit_qty` DECIMAL(11,2) NOT NULL,  
  `debit_amount` DECIMAL(11,2) NOT NULL,
  `credit_amount` DECIMAL(11,2) NOT NULL,
  `created_date` DATETIME NOT NULL,
  `created_user` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`id`) ,
  KEY `FK` (`tx_no`, `item_code`)
);

CREATE TABLE `gl_wastage` (
  `id` INT UNSIGNED AUTO_INCREMENT,
  `tx_no` VARCHAR(8) NOT NULL,
  `tx_date` DATE NOT NULL,
  `tx_type` VARCHAR(50) NOT NULL,
  `desc` VARCHAR(50),
  `remark` VARCHAR(50),
  `debit` DECIMAL(11,2) NOT NULL,
  `credit` DECIMAL(11,2) NOT NULL,
  `created_date` DATETIME NOT NULL,
  `created_user` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`id`),
  KEY `FK` (`tx_no`)
);

CREATE TABLE `sa_detail` (
  `sa_no` VARCHAR(8) NOT NULL,
  `sa_date` DATE NOT NULL,
  `action_type` VARCHAR(15),
  `warehouse_code` VARCHAR(15) NOT NULL,
  `remark` VARCHAR(50),
  `item_code` VARCHAR(15) NOT NULL,
  `unit_cost` DECIMAL(8,2) NOT NULL,
  `qty` DECIMAL(11,2) NOT NULL,
  `amount` DECIMAL(11,2) NOT NULL,  
  `created_date` DATETIME NOT NULL,
  `created_user` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`sa_no`)
);

CREATE TABLE `warehouse` (
  `warehouse_code` VARCHAR(15) NOT NULL,
  `desc` VARCHAR(50),
  `blocked` BOOLEAN NOT NULL,
  `created_date` DATETIME NOT NULL,
  `created_user` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`warehouse_code`)
);

CREATE TABLE `gl_other_expense` (
  `id` INT UNSIGNED AUTO_INCREMENT,
  `tx_no` VARCHAR(8) NOT NULL,
  `tx_date` DATE NOT NULL,
  `tx_type` VARCHAR(50) NOT NULL,
  `desc` VARCHAR(50),  
  `debit` DECIMAL(11,2) NOT NULL,
  `credit` DECIMAL(11,2) NOT NULL,
  `created_date` DATETIME NOT NULL,
  `created_user` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`id`),
  KEY `FK` (`tx_no`)
);

CREATE TABLE `gl_other_income` (
  `id` INT UNSIGNED AUTO_INCREMENT,
  `tx_no` VARCHAR(8) NOT NULL,
  `tx_date` DATE NOT NULL,
  `tx_type` VARCHAR(50) NOT NULL,
  `desc` VARCHAR(50),  
  `debit` DECIMAL(11,2) NOT NULL,
  `credit` DECIMAL(11,2) NOT NULL,
  `created_date` DATETIME NOT NULL,
  `created_user` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`id`),
  KEY `FK` (`tx_no`)
);

CREATE TABLE `gl_capital` (
  `id` INT UNSIGNED AUTO_INCREMENT,
  `tx_no` VARCHAR(8) NOT NULL,
  `tx_date` DATE NOT NULL,
  `tx_type` VARCHAR(50) NOT NULL,
  `desc` VARCHAR(50),
  `remark` VARCHAR(50),  
  `debit` DECIMAL(11,2) NOT NULL,
  `credit` DECIMAL(11,2) NOT NULL,
  `created_date` DATETIME NOT NULL,
  `created_user` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`id`,`tx_no`)
);

CREATE TABLE `gl_asset` (
  `id` INT UNSIGNED AUTO_INCREMENT,
  `tx_no` VARCHAR(8) NOT NULL,
  `tx_date` DATE NOT NULL,
  `tx_type` VARCHAR(50) NOT NULL,
  `desc` VARCHAR(50),
  `remark` VARCHAR(50),
  `debit` DECIMAL(11,2) NOT NULL,
  `credit` DECIMAL(11,2) NOT NULL,
  `created_date` DATETIME NOT NULL,
  `created_user` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`id`,`tx_no`)
);

CREATE TABLE `gl_drawing` (
  `id` INT UNSIGNED AUTO_INCREMENT,
  `tx_no` VARCHAR(8) NOT NULL,
  `tx_date` DATE NOT NULL,
  `tx_type` VARCHAR(50) NOT NULL,
  `desc` VARCHAR(50),
  `remark` VARCHAR(50),  
  `debit` DECIMAL(11,2) NOT NULL,
  `credit` DECIMAL(11,2) NOT NULL,
  `created_date` DATETIME NOT NULL,
  `created_user` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`id`,`tx_no`)
);

INSERT INTO `tax_rate` (`id`, `sales_nbt_rate`, `sales_vat_rate`, `purch_nbt_rate`, `purch_vat_rate`) VALUES (NULL, '0.00', '0.00', '0.00', '0.00');
INSERT INTO `users` (`user_id`, `first_name`, `last_name`, `email`, `password`, `account_level`, `created_user`, `last_login_datetime`, `created_datetime`, `blocked`, `status`) VALUES (NULL, 'Rushal', 'madhuka', 'admin', '5f4dcc3b5aa765d61d8327deb882cf99', 'Admin', 'Admin', '2019-02-06 06:06:18', '2018-07-30 14:06:09', '0', '1');