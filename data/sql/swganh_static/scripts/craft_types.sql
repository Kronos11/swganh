-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.1.63-community - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL version:             7.0.0.4053
-- Date/time:                    2012-10-14 17:59:16
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;

-- Dumping structure for table swganh_static.craft_types
DROP TABLE IF EXISTS `craft_types`;
CREATE TABLE IF NOT EXISTS `craft_types` (
  `id` int(11) unsigned NOT NULL DEFAULT '0',
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table swganh_static.craft_types: ~20 rows (approximately)
/*!40000 ALTER TABLE `craft_types` DISABLE KEYS */;
INSERT INTO `craft_types` (`id`, `description`) VALUES
	(1, 'weapons'),
	(2, 'armor'),
	(4, 'food'),
	(8, 'clothing'),
	(16, 'vehicle'),
	(32, 'droid'),
	(64, 'chemical'),
	(128, 'tissue'),
	(256, 'creatures'),
	(512, 'furniture'),
	(1024, 'installation'),
	(2048, 'lightsaber'),
	(4096, 'generic'),
	(8192, 'genetics'),
	(16384, 'tailor,mandalorian'),
	(32768, 'armor,mandalorian'),
	(65536, 'droid,mandalorian'),
	(131072, 'starship components'),
	(262144, 'ship tools'),
	(524288, 'misc');
/*!40000 ALTER TABLE `craft_types` ENABLE KEYS */;
/*!40014 SET FOREIGN_KEY_CHECKS=1 */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
