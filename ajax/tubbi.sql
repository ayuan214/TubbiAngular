-- phpMyAdmin SQL Dump
-- version 4.2.10
-- http://www.phpmyadmin.net
--
-- Host: localhost:8889
-- Generation Time: Aug 09, 2015 at 05:08 AM
-- Server version: 5.5.38
-- PHP Version: 5.6.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `tubbi`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_detail`(IN `lat_local` FLOAT, IN `long_local` FLOAT)
    NO SQL
SELECT 
	store.City, 
	store.Latitude, 
	store.Location, 
	store.Longitude, 
	store.Name,  
	store.SID, 
	store.State, 
	store.Rating, 
	store.Search_Icon,
    store.bizID,
	store.Ch_Name,	
	round((((acos(sin((lat_local*pi()/180)) * sin((store.Latitude*pi()/180))
					+cos((lat_local*pi()/180)) * cos((store.Latitude*pi()/180)) * cos(((long_local- store.Longitude)*pi()/180))))*180/pi())*60*1.1515)) AS Distance 
FROM store 
WHERE 
	((((acos(sin((lat_local*pi()/180)) * sin((store.Latitude*pi()/180))
+cos((lat_local*pi()/180)) * cos((store.Latitude*pi()/180)) * cos(((long_local- store.Longitude)*pi()/180))))*180/pi())*60*1.1515))
ORDER BY Distance ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_detail1`(IN `lat_local` FLOAT, IN `long_local` FLOAT)
    NO SQL
SELECT 
	store.City, 
	store.Latitude, 
	store.Location, 
	store.Longitude, 
	store.Name,  
	store.SID, 
	store.State, 
	store.Rating, 
	store.Search_Icon,
    store.bizID,
	store.Ch_Name,	
	round((((acos(sin((lat_local*pi()/180)) * sin((store.Latitude*pi()/180))
					+cos((lat_local*pi()/180)) * cos((store.Latitude*pi()/180)) * cos(((long_local- store.Longitude)*pi()/180))))*180/pi())*60*1.1515)) AS Distance 
FROM store 
ORDER BY Distance ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_city`(IN `cityin` VARCHAR(255) CHARSET utf8)
    NO SQL
select * from testa
where city=cityin$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_store_detail`(IN `asr_results` VARCHAR(255) CHARSET utf8, IN `lat_local` FLOAT, IN `long_local` FLOAT, IN `language_local` VARCHAR(30) CHARSET utf8)
    NO SQL
SELECT 
	store.City, 
	store.Latitude, 
	store.Location, 
	store.Longitude, 
	store.Name,  
	store.SID, 
	store.State, 
	store.Rating, 
	store.Search_Icon,
    store.bizID,
	store.Ch_Name,
	K.Ch_keyword,	
	round((((acos(sin((lat_local*pi()/180)) * sin((store.Latitude*pi()/180))
					+cos((lat_local*pi()/180)) * cos((store.Latitude*pi()/180)) * cos(((long_local- store.Longitude)*pi()/180))))*180/pi())*60*1.1515)) AS Distance 
FROM store inner join stor_key_rel R on store.SID = R.SID 
inner join keywords K On R.kid = K.kid 

WHERE 
	case language_local when 'en-US' then Keyword =asr_results 
    when 'cmn-Hant-TW' then Ch_Keyword =asr_results
    end

AND ((((acos(sin((lat_local*pi()/180)) * sin((store.Latitude*pi()/180))
+cos((lat_local*pi()/180)) * cos((store.Latitude*pi()/180)) * cos(((long_local- store.Longitude)*pi()/180))))*180/pi())*60*1.1515))
ORDER BY Distance ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_store_detail1`(IN `category_id` INT, IN `lat_local` FLOAT, IN `long_local` FLOAT, IN `language_local` VARCHAR(30) CHARSET utf8)
    NO SQL
SELECT 
	store.City, 
	store.Latitude, 
	store.Location, 
	store.Longitude, 
	store.Name,  
	store.SID, 
	store.State, 
	store.Rating, 
	store.Search_Icon,
    store.bizID,
	store.Ch_Name,
	K.Ch_keyword,	
	round((((acos(sin((lat_local*pi()/180)) * sin((store.Latitude*pi()/180))
					+cos((lat_local*pi()/180)) * cos((store.Latitude*pi()/180)) * cos(((long_local- store.Longitude)*pi()/180))))*180/pi())*60*1.1515)) AS Distance 
FROM store inner join stor_key_rel R on store.SID = R.SID 
inner join keywords K On R.kid = K.kid
WHERE 
	case language_local when 'en-US' then Keyword = (select name from category where cid=category_id)
    when 'cmn-Hant-TW' then Ch_Keyword =(select ch_name from category where cid=category_id)
    end
ORDER BY Distance ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_store_detail_no_utf8`(IN `asr_results` VARCHAR(255), IN `lat_local` FLOAT, IN `long_local` FLOAT, IN `language_local` VARCHAR(255))
    NO SQL
    DETERMINISTIC
SELECT 
	store.City, 
	store.Latitude, 
	store.Location, 
	store.Longitude, 
	store.Name,  
	store.SID, 
	store.State, 
	store.Rating , 
	store.Search_Icon , 
	store.Ch_Name,
	K.Ch_keyword,	
	(((acos(sin((lat_in*pi()/180)) * sin((store.Latitude*pi()/180))
					+cos((lat_in*pi()/180)) * cos((store.Latitude*pi()/180)) * cos(((long_in- store.Longitude)*pi()/180))))*180/pi())*60*1.1515) AS Distance 
FROM store inner join stor_key_rel R on store.SID = R.SID 
inner join keywords K On R.kid = K.kid 
WHERE 
	case language_in when 'en-US' then Keyword =keyword_in 
    when 'cmn-Hant-TW' then Ch_Keyword =keyword_in 
    end
AND ((((acos(sin((lat_in*pi()/180)) * sin((store.Latitude*pi()/180))
+cos((lat_in*pi()/180)) * cos((store.Latitude*pi()/180)) * cos(((long_in- store.Longitude)*pi()/180))))*180/pi())*60*1.1515))
ORDER BY Distance ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `test`(IN `var1` VARCHAR(255) CHARSET utf8, IN `var2` VARCHAR(255) CHARSET utf8, IN `languagein` VARCHAR(255) CHARSET utf8)
SELECT 'abc',languagein,var1,var2,city FROM testa 


where 

case languagein
	when 'en-US' then city = var1
    when 'cmn-Hant-TW' then city = var2
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `test123`(IN `asr_result` VARCHAR(255) CHARSET utf8)
    NO SQL
SELECT 
	store.City, 
	store.Latitude, 
	store.Location, 
	store.Longitude, 
	store.Name,  
	store.SID, 
	store.State, 
	store.Rating , 
	store.Search_Icon , 
	store.Ch_Name,
    1000 AS Distance
FROM store inner join stor_key_rel R on store.SID = R.SID 
inner join keywords K On R.kid = K.kid
where K.keyword=asr_result$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Test_store`()
    NO SQL
SELECT 
	'store.' City, 
	'store.' Latitude, 
	'store.' Location, 
	'store.' Longitude, 
	'store.' Name,  
	'store.' SID, 
	'store.' State, 
	'store.' Rating , 
	'abc.' Search_Icon , 
	'store.' Ch_Name,
	'K.' Ch_keyword,	
	1000 AS Distance
        from store order by 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `wam2`(OUT param1 INT)
BEGIN
DECLARE start INT unsigned DEFAULT 1;
DECLARE finish INT unsigned DEFAULT 10;

SELECT COUNT(*) INTO param1 FROM testa;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `cid` int(11) NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 DEFAULT NULL,
  `desc` varchar(300) CHARACTER SET utf8mb4 DEFAULT NULL,
  `ch_name` varchar(50) CHARACTER SET utf8mb4 DEFAULT NULL,
  `ch_desc` varchar(300) CHARACTER SET utf8mb4 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`cid`, `name`, `desc`, `ch_name`, `ch_desc`) VALUES
(1, 'All', 'All categories', '全部', '全部'),
(2, 'Schezwan', 'Schezwan', '川菜', '川菜'),
(3, 'Taiwanese', 'Taiwanese', '台灣小吃', '台灣小吃'),
(4, 'Beijing', 'Beijing', '京菜', '京菜'),
(5, 'Cantonese', 'Cantonese', '廣東菜', '廣東菜');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customerNumber` int(11) NOT NULL,
  `customerName` varchar(50) NOT NULL,
  `contactLastName` varchar(50) NOT NULL,
  `contactFirstName` varchar(50) NOT NULL,
  `addressLine1` varchar(50) NOT NULL,
  `addressLine2` varchar(50) DEFAULT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) DEFAULT NULL,
  `postalCode` varchar(15) DEFAULT NULL,
  `country` varchar(50) NOT NULL,
  `salesRepEmployeeNumber` int(11) DEFAULT NULL,
  `creditLimit` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customerNumber`, `customerName`, `contactLastName`, `contactFirstName`, `addressLine1`, `addressLine2`, `city`, `state`, `postalCode`, `country`, `salesRepEmployeeNumber`, `creditLimit`) VALUES
(103, 'Atelier graphique', 'Schmitt', 'Carine ', '54, rue Royale', NULL, 'Nantes', NULL, '44000', 'France', 1370, 21000),
(112, 'Signal Gift Stores', 'King', 'Jean', '8489 Strong St.', NULL, 'Las Vegas', 'NV', '83030', 'USA', 1166, 71800),
(114, 'Australian Collectors, Co.', 'Ferguson', 'Peter', '636 St Kilda Road', 'Level 3', 'Melbourne', 'Victoria', '3004', 'Australia', 1611, 117300),
(119, 'La Rochelle Gifts', 'Labrune', 'Janine ', '67, rue des Cinquante Otages', NULL, 'Nantes', NULL, '44000', 'France', 1370, 118200),
(121, 'Baane Mini Imports', 'Bergulfsen', 'Jonas ', 'Erling Skakkes gate 78', NULL, 'Stavern', NULL, '4110', 'Norway', 1504, 81700),
(124, 'Mini Gifts Distributors Ltd.', 'Nelson', 'Susan', '5677 Strong St.', NULL, 'San Rafael', 'CA', '97562', 'USA', 1165, 210500),
(125, 'Havel & Zbyszek Co', 'Piestrzeniewicz', 'Zbyszek ', 'ul. Filtrowa 68', NULL, 'Warszawa', NULL, '01-012', 'Poland', NULL, 0),
(128, 'Blauer See Auto, Co.', 'Keitel', 'Roland', 'Lyonerstr. 34', NULL, 'Frankfurt', NULL, '60528', 'Germany', 1504, 59700),
(129, 'Mini Wheels Co.', 'Murphy', 'Julie', '5557 North Pendale Street', NULL, 'San Francisco', 'CA', '94217', 'USA', 1165, 64600),
(131, 'Land of Toys Inc.', 'Lee', 'Kwai', '897 Long Airport Avenue', NULL, 'NYC', 'NY', '10022', 'USA', 1323, 114900),
(141, 'Euro+ Shopping Channel', 'Freyre', 'Diego ', 'C/ Moralzarzal, 86', NULL, 'Madrid', NULL, '28034', 'Spain', 1370, 227600),
(146, 'Saveley & Henriot, Co.', 'Saveley', 'Mary ', '2, rue du Commerce', NULL, 'Lyon', NULL, '69004', 'France', 1337, 123900),
(148, 'Dragon Souveniers, Ltd.', 'Natividad', 'Eric', 'Bronz Sok.', 'Bronz Apt. 3/6 Tesvikiye', 'Singapore', NULL, '079903', 'Singapore', 1621, 103800),
(151, 'Muscle Machine Inc', 'Young', 'Jeff', '4092 Furth Circle', 'Suite 400', 'NYC', 'NY', '10022', 'USA', 1286, 138500),
(157, 'Diecast Classics Inc.', 'Leong', 'Kelvin', '7586 Pompton St.', NULL, 'Allentown', 'PA', '70267', 'USA', 1216, 100600),
(161, 'Technics Stores Inc.', 'Hashimoto', 'Juri', '9408 Furth Circle', NULL, 'Burlingame', 'CA', '94217', 'USA', 1165, 84600),
(166, 'Handji Gifts& Co', 'Victorino', 'Wendy', '106 Linden Road Sandown', '2nd Floor', 'Singapore', NULL, '069045', 'Singapore', 1612, 97900),
(167, 'Herkku Gifts', 'Oeztan', 'Veysel', 'Brehmen St. 121', 'PR 334 Sentrum', 'Bergen', NULL, 'N 5804', 'Norway  ', 1504, 96800),
(168, 'American Souvenirs Inc', 'Franco', 'Keith', '149 Spinnaker Dr.', 'Suite 101', 'New Haven', 'CT', '97823', 'USA', 1286, 0),
(173, 'Cambridge Collectables Co.', 'Tseng', 'Jerry', '4658 Baden Av.', NULL, 'Cambridge', 'MA', '51247', 'USA', 1188, 43400),
(175, 'Gift Depot Inc.', 'King', 'Julie', '25593 South Bay Ln.', NULL, 'Bridgewater', 'CT', '97562', 'USA', 1323, 84300),
(177, 'Osaka Souveniers Co.', 'Kentary', 'Mory', '1-6-20 Dojima', NULL, 'Kita-ku', 'Osaka', ' 530-0003', 'Japan', 1621, 81200),
(181, 'Vitachrome Inc.', 'Frick', 'Michael', '2678 Kingston Rd.', 'Suite 101', 'NYC', 'NY', '10022', 'USA', 1286, 76400),
(186, 'Toys of Finland, Co.', 'Karttunen', 'Matti', 'Keskuskatu 45', NULL, 'Helsinki', NULL, '21240', 'Finland', 1501, 96500),
(187, 'AV Stores, Co.', 'Ashworth', 'Rachel', 'Fauntleroy Circus', NULL, 'Manchester', NULL, 'EC2 5NT', 'UK', 1501, 136800),
(189, 'Clover Collections, Co.', 'Cassidy', 'Dean', '25 Maiden Lane', 'Floor No. 4', 'Dublin', NULL, '2', 'Ireland', 1504, 69400),
(198, 'Auto-Moto Classics Inc.', 'Taylor', 'Leslie', '16780 Pompton St.', NULL, 'Brickhaven', 'MA', '58339', 'USA', 1216, 23000),
(201, 'UK Collectables, Ltd.', 'Devon', 'Elizabeth', '12, Berkeley Gardens Blvd', NULL, 'Liverpool', NULL, 'WX1 6LT', 'UK', 1501, 92700),
(202, 'Canadian Gift Exchange Network', 'Tamuri', 'Yoshi ', '1900 Oak St.', NULL, 'Vancouver', 'BC', 'V3F 2K1', 'Canada', 1323, 90300),
(204, 'Online Mini Collectables', 'Barajas', 'Miguel', '7635 Spinnaker Dr.', NULL, 'Brickhaven', 'MA', '58339', 'USA', 1188, 68700),
(205, 'Toys4GrownUps.com', 'Young', 'Julie', '78934 Hillside Dr.', NULL, 'Pasadena', 'CA', '90003', 'USA', 1166, 90700),
(206, 'Asian Shopping Network, Co', 'Walker', 'Brydey', 'Suntec Tower Three', '8 Temasek', 'Singapore', NULL, '038988', 'Singapore', NULL, 0),
(211, 'King Kong Collectables, Co.', 'Gao', 'Mike', 'Bank of China Tower', '1 Garden Road', 'Central Hong Kong', NULL, NULL, 'Hong Kong', 1621, 58600),
(219, 'Boards & Toys Co.', 'Young', 'Mary', '4097 Douglas Av.', NULL, 'Glendale', 'CA', '92561', 'USA', 1166, 11000),
(239, 'Collectable Mini Designs Co.', 'Thompson', 'Valarie', '361 Furth Circle', NULL, 'San Diego', 'CA', '91217', 'USA', 1166, 105000),
(240, 'giftsbymail.co.uk', 'Bennett', 'Helen ', 'Garden House', 'Crowther Way 23', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK', 1501, 93900),
(242, 'Alpha Cognac', 'Roulet', 'Annette ', '1 rue Alsace-Lorraine', NULL, 'Toulouse', NULL, '31000', 'France', 1370, 61100),
(247, 'Messner Shopping Network', 'Messner', 'Renate ', 'Magazinweg 7', NULL, 'Frankfurt', NULL, '60528', 'Germany', NULL, 0),
(249, 'Amica Models & Co.', 'Accorti', 'Paolo ', 'Via Monte Bianco 34', NULL, 'Torino', NULL, '10100', 'Italy', 1401, 113000),
(250, 'Lyon Souveniers', 'Da Silva', 'Daniel', '27 rue du Colonel Pierre Avia', NULL, 'Paris', NULL, '75508', 'France', 1337, 68100);

-- --------------------------------------------------------

--
-- Table structure for table `keywords`
--

CREATE TABLE `keywords` (
  `KID` char(10) NOT NULL DEFAULT '',
  `Keyword` varchar(256) CHARACTER SET utf8mb4 DEFAULT NULL,
  `Ch_Keyword` varchar(256) CHARACTER SET utf8mb4 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `keywords`
--

INSERT INTO `keywords` (`KID`, `Keyword`, `Ch_Keyword`) VALUES
('1', 'Schezwan', '川菜'),
('2', 'Taiwanese', '台灣小吃'),
('3', 'Beijing', '京菜'),
('4', 'Cantonese', '廣東菜');

-- --------------------------------------------------------

--
-- Table structure for table `store`
--

CREATE TABLE `store` (
  `SID` char(10) NOT NULL DEFAULT '',
  `Name` varchar(32) DEFAULT NULL,
  `Ch_Name` varchar(32) CHARACTER SET utf8 DEFAULT NULL,
  `Location` varchar(32) DEFAULT NULL,
  `City` varchar(32) DEFAULT NULL,
  `State` varchar(32) DEFAULT NULL,
  `Latitude` decimal(10,8) DEFAULT NULL,
  `Longitude` decimal(11,8) DEFAULT NULL,
  `bizID` varchar(128) DEFAULT NULL,
  `Rating` varchar(500) DEFAULT NULL,
  `Search_Icon` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `store`
--

INSERT INTO `store` (`SID`, `Name`, `Ch_Name`, `Location`, `City`, `State`, `Latitude`, `Longitude`, `bizID`, `Rating`, `Search_Icon`) VALUES
('A001', 'Din Tai Fung', '鼎泰豐', '1108 S Baldwin Ave', 'Arcadia', 'CA', 34.12765000, -118.05440100, 'din-tai-fung-arcadia-5', 'img/4starshalf_rz.png', 'img/tubbi_rz.png'),
('A002', 'Ma Ma''s Lu', '一口福', '153 E Garvey Ave', 'Monterey Park', 'CA', 34.06296400, -118.12147900, 'mamas-lu-dumpling-house-monterey-park-4', 'img/4stars_rz.png', 'img/tubbi_rz.png'),
('A003', 'NBC Seafood Restaurant', '海寶潮粵', '404 S Atlantic Blvd', 'Monterey Park', 'CA', 34.05799900, -118.13327200, 'nbc-seafood-restaurant-monterey-park', 'img/3stars_rz.png', 'img/tubbi_rz.png'),
('A004', 'Elite Restaurant', '名流山莊', '700 S Atlantic Blvd', 'Monterey Park', 'CA', 34.05368900, -118.13586200, 'elite-restaurant-monterey-park', 'img/3starshalf_rz.png', 'img/tubbi_rz.png'),
('A005', 'Lunasia', 'Lunasia', '500 W Main St', 'Alhambra', 'CA', 34.09237800, -118.13221700, 'lunasia-chinese-cuisine-alhambra', 'img/3starshalf_rz.png', 'img/tubbi_rz.png'),
('A006', 'ABC Cafe', 'ABC Cafe', '100 N Garfield Ave', 'Monterey Park', 'CA', 34.06334700, -118.12261900, 'abc-cafe-monterey-park', 'img/3stars_rz.png', 'img/tubbi_rz.png'),
('A007', 'New Capital Seafood', 'New Capital Seafood', '140 W Valley Blvd', 'San Gabriel', 'CA', 34.07732600, -118.10038200, 'new-capital-seafood-restaurant-rowland-heights', 'img/3starshalf_rz.png', 'img/tubbi_rz.png'),
('A008', 'Why Thirsty', 'Why Thirsty', '7248 Rosemead Blvd', 'San Gabriel', 'CA', 34.12913400, -118.07258400, 'why-thirsty-san-gabriel', 'img/5stars_rz.png', 'img/tubbi_rz.png'),
('A009', 'Sinbala', '辛巴樂', '651 W Duarte Rd', 'Arcadia', 'CA', 34.12694200, -118.05362900, 'sinbala-restaurant-arcadia-2', 'img/4stars_rz.png', 'img/tubbi_rz.png'),
('A010', 'Half & Half Tea House', '伴伴堂', '120 N San Gabriel Blvd', 'San Gabriel', 'CA', 34.10422600, -118.09037000, 'half-and-half-tea-house-san-gabriel', 'img/3starshalf_rz.png', 'img/tubbi_rz.png'),
('A011', 'Old Country Cafe', 'Old Country Cafe', '2 E Valley Blvd', 'Alhambra', 'CA', 34.07829800, -118.12282300, 'old-country-cafe-alhambra', 'img/4stars_rz.png', 'img/tubbi_rz.png'),
('A012', 'Huge Tree Pastry', 'Huge Tree Pastry', '423 N Atlantic Blvd', 'Monterey Park', 'CA', 34.06793300, -118.13452000, 'huge-tree-pastry-monterey-park', 'img/4stars_rz.png', 'img/tubbi_rz.png'),
('A013', 'Chengdu Taste', '滋味成都', '8548 Valley Blvd', 'Rosemead', 'CA', 34.08002800, -118.08223000, 'chengdu-taste-alhambra', 'img/3starshalf_rz.png', 'img/tubbi_rz.png'),
('A014', 'Spicy City', 'Spicy City', '140 W Valley Blvd', 'San Gabriel', 'CA', 34.07815700, -118.10213700, 'spicy-city-san-gabriel', 'img/4starshalf_rz.png', 'img/tubbi_rz.png'),
('A015', 'Yunnan Garden', '雲南過橋園', '301 N Garfield Ave', 'Monterey Park', 'CA', 34.06508500, -118.12316200, 'yunnan-restaurant-monterey-park-2', 'img/4starshalf_rz.png', 'img/tubbi_rz.png');

-- --------------------------------------------------------

--
-- Table structure for table `stor_key_rel`
--

CREATE TABLE `stor_key_rel` (
  `RID` char(10) NOT NULL DEFAULT '',
  `SID` char(10) NOT NULL DEFAULT '',
  `KID` char(10) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stor_key_rel`
--

INSERT INTO `stor_key_rel` (`RID`, `SID`, `KID`) VALUES
('001', 'A001', '3'),
('002', 'A002', '2'),
('003', 'A003', '4'),
('004', 'A004', '4'),
('005', 'A005', '4'),
('006', 'A006', '3'),
('007', 'A007', '4'),
('008', 'A008', '2'),
('009', 'A009', '2'),
('010', 'A010', '2'),
('011', 'A011', '2'),
('012', 'A012', '2'),
('013', 'A013', '1'),
('014', 'A014', '1'),
('015', 'A015', '1');

-- --------------------------------------------------------

--
-- Table structure for table `testa`
--

CREATE TABLE `testa` (
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `testa`
--

INSERT INTO `testa` (`city`) VALUES
('arcadia'),
('arcadia'),
('京菜');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
 ADD PRIMARY KEY (`cid`), ADD UNIQUE KEY `cid` (`cid`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
 ADD PRIMARY KEY (`customerNumber`), ADD KEY `salesRepEmployeeNumber` (`salesRepEmployeeNumber`);

--
-- Indexes for table `keywords`
--
ALTER TABLE `keywords`
 ADD PRIMARY KEY (`KID`);

--
-- Indexes for table `store`
--
ALTER TABLE `store`
 ADD PRIMARY KEY (`SID`);

--
-- Indexes for table `stor_key_rel`
--
ALTER TABLE `stor_key_rel`
 ADD PRIMARY KEY (`RID`);
