-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: mysql-server
-- Üretim Zamanı: 23 Oca 2021, 22:56:07
-- Sunucu sürümü: 10.5.8-MariaDB-1:10.5.8+maria~focal
-- PHP Sürümü: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `vinewood`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `accessories`
--

CREATE TABLE `accessories` (
  `id` int(11) NOT NULL,
  `Owner` int(11) NOT NULL DEFAULT -1,
  `Slot` int(11) NOT NULL DEFAULT 0,
  `Model` int(11) NOT NULL DEFAULT 0,
  `Bone` int(11) NOT NULL DEFAULT 0,
  `fOffSetX` float NOT NULL DEFAULT 0,
  `fOffSetY` float NOT NULL DEFAULT 0,
  `fOffSetZ` float NOT NULL DEFAULT 0,
  `fRotX` float NOT NULL DEFAULT 0,
  `fRotY` float NOT NULL DEFAULT 0,
  `fRotZ` float NOT NULL DEFAULT 0,
  `fScaleX` float NOT NULL DEFAULT 0,
  `fScaleY` float NOT NULL DEFAULT 0,
  `fScaleZ` float NOT NULL DEFAULT 0,
  `MaterialColor1` int(11) NOT NULL DEFAULT 0,
  `MaterialColor2` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `arrestpoints`
--

CREATE TABLE `arrestpoints` (
  `id` int(11) NOT NULL,
  `X` float NOT NULL DEFAULT 0,
  `Y` float NOT NULL DEFAULT 0,
  `Z` float NOT NULL DEFAULT 0,
  `virtualWorld` int(11) NOT NULL DEFAULT 0,
  `interior` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `buildings`
--

CREATE TABLE `buildings` (
  `id` int(11) NOT NULL,
  `Name` varchar(124) COLLATE latin5_bin NOT NULL,
  `Type` int(11) NOT NULL DEFAULT 0,
  `Exterior_Door_X` float NOT NULL DEFAULT 0,
  `Exterior_Door_Y` float NOT NULL DEFAULT 0,
  `Exterior_Door_Z` float NOT NULL DEFAULT 0,
  `Interior_Door_X` int(11) NOT NULL DEFAULT 0,
  `Interior_Door_Y` int(11) NOT NULL DEFAULT 0,
  `Interior_Door_Z` int(11) NOT NULL DEFAULT 0,
  `Interior` int(11) NOT NULL DEFAULT 0,
  `VW` int(11) NOT NULL DEFAULT 0,
  `Locked` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin5 COLLATE=latin5_bin;

--
-- Tablo döküm verisi `buildings`
--

INSERT INTO `buildings` (`id`, `Name`, `Type`, `Exterior_Door_X`, `Exterior_Door_Y`, `Exterior_Door_Z`, `Interior_Door_X`, `Interior_Door_Y`, `Interior_Door_Z`, `Interior`, `VW`, `Locked`) VALUES
(1, 'Los Santos Police Department', 1, 1172.17, -1323.35, 15.403, 2032, 2074, 3024, 1, 5, 0),
(2, 'LSTV', 4, 1310.11, -1366.8, 13.5064, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `business`
--

CREATE TABLE `business` (
  `id` int(11) NOT NULL,
  `Owner` varchar(124) COLLATE latin5_bin NOT NULL DEFAULT '0',
  `Price` int(11) NOT NULL DEFAULT 0,
  `Type` int(11) DEFAULT 0,
  `Name` varchar(124) COLLATE latin5_bin NOT NULL DEFAULT 'Yok',
  `ExtX` float NOT NULL DEFAULT 0,
  `ExtY` float NOT NULL DEFAULT 0,
  `ExtZ` float NOT NULL DEFAULT 0,
  `IntX` float NOT NULL DEFAULT 0,
  `IntY` float NOT NULL DEFAULT 0,
  `IntZ` float NOT NULL DEFAULT 0,
  `Interior` int(11) NOT NULL DEFAULT 0,
  `VW` int(11) NOT NULL DEFAULT 0,
  `Locked` int(11) NOT NULL DEFAULT 0,
  `Safe` int(11) NOT NULL DEFAULT 0,
  `Worker1` int(11) NOT NULL DEFAULT 0,
  `Worker2` int(11) NOT NULL DEFAULT 0,
  `Worker3` int(11) NOT NULL DEFAULT 0,
  `Worker4` int(11) NOT NULL DEFAULT 0,
  `Worker5` int(11) NOT NULL DEFAULT 0,
  `Worker6` int(11) NOT NULL DEFAULT 0,
  `Worker7` int(11) NOT NULL DEFAULT 0,
  `Worker8` int(11) NOT NULL DEFAULT 0,
  `Worker9` int(11) NOT NULL DEFAULT 0,
  `Worker10` int(11) NOT NULL DEFAULT 0,
  `Worker1Payday` int(11) NOT NULL DEFAULT 0,
  `Worker2Payday` int(11) NOT NULL DEFAULT 0,
  `Worker3Payday` int(11) NOT NULL DEFAULT 0,
  `Worker4Payday` int(11) NOT NULL DEFAULT 0,
  `Worker5Payday` int(11) NOT NULL DEFAULT 0,
  `Worker6Payday` int(11) NOT NULL DEFAULT 0,
  `Worker7Payday` int(11) NOT NULL DEFAULT 0,
  `Worker8Payday` int(11) NOT NULL DEFAULT 0,
  `Worker9Payday` int(11) NOT NULL DEFAULT 0,
  `Worker10Payday` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin5 COLLATE=latin5_bin;

--
-- Tablo döküm verisi `business`
--

INSERT INTO `business` (`id`, `Owner`, `Price`, `Type`, `Name`, `ExtX`, `ExtY`, `ExtZ`, `IntX`, `IntY`, `IntZ`, `Interior`, `VW`, `Locked`, `Safe`, `Worker1`, `Worker2`, `Worker3`, `Worker4`, `Worker5`, `Worker6`, `Worker7`, `Worker8`, `Worker9`, `Worker10`, `Worker1Payday`, `Worker2Payday`, `Worker3Payday`, `Worker4Payday`, `Worker5Payday`, `Worker6Payday`, `Worker7Payday`, `Worker8Payday`, `Worker9Payday`, `Worker10Payday`) VALUES
(5, '35', 0, 1, '7/24', 1833.52, -1842.58, 13.5781, 1390.45, -31.9336, 1000.92, 2, 2, 0, 205608548, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(6, '44', 0, 3, 'Pawn Shop', 1978.77, -1761.8, 13.5469, 365.222, 1008.47, 2130.23, 2, 2, 0, 1270, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `characters`
--

CREATE TABLE `characters` (
  `id` int(11) NOT NULL,
  `Admin` int(11) NOT NULL DEFAULT 0,
  `Nickname` varchar(124) COLLATE latin5_bin NOT NULL DEFAULT 'Yok',
  `Character_Name` varchar(124) COLLATE latin5_bin NOT NULL,
  `Password` varchar(124) COLLATE latin5_bin NOT NULL,
  `Created` int(11) NOT NULL DEFAULT 0,
  `Age` int(11) NOT NULL DEFAULT 0,
  `Sex` int(11) NOT NULL DEFAULT 0,
  `SkinColor` int(11) NOT NULL DEFAULT 0,
  `Origin` int(11) NOT NULL DEFAULT 0,
  `Skin` int(11) NOT NULL DEFAULT 1,
  `Interior` int(11) NOT NULL DEFAULT 0,
  `VW` int(11) NOT NULL DEFAULT 0,
  `HP` float NOT NULL DEFAULT 100,
  `Armour` float NOT NULL DEFAULT 0,
  `X` float NOT NULL DEFAULT 1742.99,
  `Y` float NOT NULL DEFAULT -1861.49,
  `Z` float NOT NULL DEFAULT 13.5775,
  `A` float NOT NULL DEFAULT 90,
  `IsDead` int(11) NOT NULL DEFAULT 0,
  `KillerPlayer` int(11) NOT NULL DEFAULT 0,
  `KillerWeapon` int(11) NOT NULL DEFAULT 0,
  `KilledAt` varchar(64) COLLATE latin5_bin DEFAULT NULL,
  `DeathSecondsLeft` int(11) NOT NULL DEFAULT 0,
  `Money` int(11) NOT NULL DEFAULT 1500,
  `Level` int(11) NOT NULL DEFAULT 1,
  `Hour` int(11) NOT NULL DEFAULT 0,
  `Minute` int(11) NOT NULL DEFAULT 0,
  `Identity` int(11) NOT NULL DEFAULT 0,
  `Ban` int(11) NOT NULL DEFAULT 0,
  `Warn` int(11) NOT NULL DEFAULT 0,
  `Tenant_House_ID` int(11) NOT NULL DEFAULT -1,
  `Tenant_Price` int(11) NOT NULL DEFAULT 0,
  `Bank_Account_No` int(11) NOT NULL DEFAULT 0,
  `Bank_Cash` int(11) NOT NULL DEFAULT 0,
  `Bank_Saving` int(11) NOT NULL DEFAULT 0,
  `Faction` int(11) NOT NULL DEFAULT 0,
  `FactionRank` int(11) NOT NULL DEFAULT 0,
  `Cuffed` int(11) NOT NULL DEFAULT 0,
  `Jail` int(11) NOT NULL DEFAULT 0,
  `JailTimeLeft` int(11) NOT NULL DEFAULT 0,
  `OldSkin` int(11) NOT NULL DEFAULT 1,
  `Cigaratte` int(11) NOT NULL DEFAULT 0,
  `Lighter` int(11) NOT NULL DEFAULT 0,
  `Boombox` int(11) NOT NULL DEFAULT 0,
  `Toolkit` int(11) NOT NULL DEFAULT 0,
  `SkeletonKey` int(11) NOT NULL DEFAULT 0,
  `Bat` int(11) NOT NULL DEFAULT 0,
  `Flower` int(11) NOT NULL DEFAULT 0,
  `Phone` int(11) NOT NULL DEFAULT 0,
  `PhoneNumber` int(11) NOT NULL DEFAULT 0,
  `AccSlot1` int(11) NOT NULL DEFAULT 0,
  `AccSlot2` int(11) NOT NULL DEFAULT 0,
  `AccSlot3` int(11) NOT NULL DEFAULT 0,
  `AccSlot4` int(11) NOT NULL DEFAULT 0,
  `AccSlot5` int(11) NOT NULL DEFAULT 0,
  `AccSlot6` int(11) NOT NULL DEFAULT 0,
  `AccSlot7` int(11) NOT NULL DEFAULT 0,
  `AccSlot8` int(11) NOT NULL DEFAULT 0,
  `AccSlot9` int(11) NOT NULL DEFAULT 0,
  `AccSlot10` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin5 COLLATE=latin5_bin;

--
-- Tablo döküm verisi `characters`
--

INSERT INTO `characters` (`id`, `Admin`, `Nickname`, `Character_Name`, `Password`, `Created`, `Age`, `Sex`, `SkinColor`, `Origin`, `Skin`, `Interior`, `VW`, `HP`, `Armour`, `X`, `Y`, `Z`, `A`, `IsDead`, `KillerPlayer`, `KillerWeapon`, `KilledAt`, `DeathSecondsLeft`, `Money`, `Level`, `Hour`, `Minute`, `Identity`, `Ban`, `Warn`, `Tenant_House_ID`, `Tenant_Price`, `Bank_Account_No`, `Bank_Cash`, `Bank_Saving`, `Faction`, `FactionRank`, `Cuffed`, `Jail`, `JailTimeLeft`, `OldSkin`, `Cigaratte`, `Lighter`, `Boombox`, `Toolkit`, `SkeletonKey`, `Bat`, `Flower`, `Phone`, `PhoneNumber`, `AccSlot1`, `AccSlot2`, `AccSlot3`, `AccSlot4`, `AccSlot5`, `AccSlot6`, `AccSlot7`, `AccSlot8`, `AccSlot9`, `AccSlot10`) VALUES
(1, 7, 'Inked', 'Inked_Test', '601f1889667efaebb33b8c12572835da3f027f78', 1, 31, 1, 2, 1, 21, 0, 0, 88, 0, 2320.06, -1533.56, 25.3438, 22.4075, 0, 0, 0, 'nowhere', -12, 829, 1, 3, 16, 748656, 0, 0, -1, 0, 6779000, 150, 0, -1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 742982, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(2, 7, 'Rakowice', 'Rakowice_Test', '601f1889667efaebb33b8c12572835da3f027f78', 1, 24, 1, 1, 1, 281, 0, 0, 110, 0, 1265.12, -1231.94, 16.0387, 304.045, 0, 46, -1, 'El Corona', 0, 1765, 1, 3, 23, 134054, 0, 0, -1, 0, 8229534, 100, 0, 4, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 150862, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(3, 0, 'Kazi', 'Charles_McCarry', '601f1889667efaebb33b8c12572835da3f027f78', 1, 74, 1, 1, 68, 23, 0, 0, 81, 0, 1926.61, -1748.52, 13.0273, 16.524, 0, 0, 0, 'nowhere', 0, 1038, 1, 2, 28, 954256, 0, 0, -1, 0, 5282452, 50, 0, -1, 1, 0, 0, 0, 1, 20, 1, 1, 1, 1, 1, 1, 1, 680146, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(4, 0, 'Yeromi', 'Jean_Klitch', '601f1889667efaebb33b8c12572835da3f027f78', 1, 26, 2, 1, 131, 56, 0, 0, 27, 0, 1911.77, -1583.11, 29.05, 64.7294, 0, 0, 0, 'NULL', 0, 3333, 1, 2, 25, 788193, 0, 0, -1, 0, 8991710, 50, 0, -1, 1, 0, 0, 0, 1, 176, 1, 1, 1, 1, 0, 0, 1, 475973, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(5, 0, 'AdnanYVS', 'Michael_Ontru', '601f1889667efaebb33b8c12572835da3f027f78', 1, 20, 2, 2, 12, 195, 0, 0, 82, 0, 1829.66, -1787.62, 13.5469, 353.587, 0, 0, 0, 'NULL', 0, 24369, 1, 1, 15, 517924, 0, 0, -1, 0, 6504306, 50, 0, -1, 1, 0, 0, 0, 1, 17, 1, 1, 1, 1, 1, 0, 1, 213844, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(6, 1, 'Anarchist', 'Anarchist_Test', '601f1889667efaebb33b8c12572835da3f027f78', 0, 0, 0, 0, 0, 1, 0, 0, 100, 0, 1742.99, -1861.49, 13.5775, 90, 0, 0, 0, NULL, 0, 1500, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(7, 0, 'Yabgu', 'Deshawn_Olori', '601f1889667efaebb33b8c12572835da3f027f78', 1, 18, 1, 2, 1, 7, 0, 0, 96, 0, 1878.85, -1884.18, 12.9779, 164.512, 0, 0, 0, 'nowhere', -50, 1881, 1, 4, 9, 797658, 0, 0, -1, 0, 7710034, 0, 0, -1, 0, 0, 0, 0, 1, 20, 0, 1, 0, 0, 1, 0, 1, 759460, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(8, 0, 'Corporal', 'Jeomi_Mitch', '601f1889667efaebb33b8c12572835da3f027f78', 0, 21, 2, 1, 0, 56, 0, 0, 100, 0, 1836.68, -1888.38, 13.4222, 0, 0, 0, 0, 'NULL', 0, 1008, 1, 0, 55, 626171, 0, 0, -1, 0, 1896171, 0, 0, -1, 0, 0, 0, 0, 1, 20, 0, 0, 1, 1, 0, 0, 1, 704410, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(9, 0, 'Cyrus', 'Cyrus_Test', '601f1889667efaebb33b8c12572835da3f027f78', 1, 22, 1, 1, 1, 113, 2, 2, 95, 0, 1392.13, -27.6542, 1000.92, 345.648, 0, 0, 0, 'nowhere', 0, 1710, 1, 4, 8, 564872, 0, 0, -1, 0, 1453140, 0, 0, -1, 0, 0, 0, 0, 1, 12, 1, 1, 1, 1, 1, 0, 1, 129988, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10, 7, 'DanielEastwood', 'Daniel_Eastwood', '601f1889667efaebb33b8c12572835da3f027f78', 0, 0, 0, 0, 0, 1, 0, 0, 100, 0, 1742.99, -1861.49, 13.5775, 90, 0, 0, 0, NULL, 0, 1500, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11, 5, 'Debrone', 'Daniel_Hgiah', '601f1889667efaebb33b8c12572835da3f027f78', 0, 0, 0, 0, 0, 1, 0, 0, 100, 0, 1742.99, -1861.49, 13.5775, 90, 0, 0, 0, NULL, 0, 1500, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(12, 0, 'Frex', 'Michael_Frex', '601f1889667efaebb33b8c12572835da3f027f78', 1, 25, 1, 1, 0, 23, 2, 2, 240, 0, 578.744, -517.552, 1500.92, 117.207, 0, 0, 0, 'NULL', 0, 36033, 1, 2, 38, 658269, 0, 0, -1, 0, 1907342, 100, 0, -1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 921455, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(13, 7, 'gky', 'gky_Test', '601f1889667efaebb33b8c12572835da3f027f78', 1, 20, 1, 1, 70, 270, 0, 0, 242, 0, 1438.28, -1631.03, 13.5469, 63.563, 0, 40, -1, 'Idlewood', 0, 197148, 9999999, 7, 58, 374743, 0, 0, -1, 0, 8753190, 0, 0, -1, 0, 0, 0, 0, 1, 20, 1, 1, 1, 1, 1, 0, 1, 802547, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(14, 7, 'Glorfin', 'Glorfin_Test', '601f1889667efaebb33b8c12572835da3f027f78', 1, 31, 1, 1, 0, 23, 0, 0, 78, 0, 1876.01, -1758.88, 14.1564, 293.668, 0, 2, 31, 'Pershing Square', 0, 769, 1, 1, 17, 127202, 0, 0, -1, 0, 5706142, 0, 0, -1, 0, 0, 0, 0, 1, 19, 1, 0, 0, 0, 0, 0, 1, 744323, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(15, 7, 'IPSIR', 'IPSIR_Test', '601f1889667efaebb33b8c12572835da3f027f78', 1, 28, 1, 1, 1, 23, 0, 0, 100, 0, 2264.41, -1506.91, 21.4538, 319.332, 0, 0, 0, 'NULL', 0, 1500, 1, 0, 39, 994753, 0, 0, -1, 0, 7325587, 0, 0, -1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(16, 4, 'magicfezz', 'magicfezz_Test', '601f1889667efaebb33b8c12572835da3f027f78', 0, 31, 1, 1, 1, 1, 0, 0, 98, 0, 1856.11, -1925.76, 13.5469, 157.029, 0, 0, 0, 'NULL', 0, 68322, 1, 1, 14, 129161, 0, 0, 5, 1, 5955300, 0, 0, -1, 0, 0, 0, 0, 1, 17, 1, 1, 1, 1, 1, 0, 1, 278639, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(17, 0, 'Maglor', 'Harold_Itfa', '601f1889667efaebb33b8c12572835da3f027f78', 1, 25, 1, 1, 0, 23, 0, 0, 13, 0, 1557.32, -1161.49, 23.4208, 333.058, 0, 0, 0, 'nowhere', 0, 1205, 1, 1, 32, 497507, 0, 0, -1, 0, 9292126, 0, 0, -1, 1, 0, 0, 0, 1, 20, 0, 0, 0, 0, 1, 1, 1, 945760, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(18, 0, 'Marjelas', 'Marjelas', '601f1889667efaebb33b8c12572835da3f027f78', 1, 31, 1, 1, 1, 23, 0, 0, 168, 0, 1991.92, -1673.91, 13.0787, 55.078, 0, 0, 0, 'NULL', 0, 2031, 1, 3, 6, 966694, 0, 0, -1, 0, 5791703, 150, 0, 4, 1, 0, 0, 0, 1, 39, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(19, 7, 'Odin', 'Odin_Test', '601f1889667efaebb33b8c12572835da3f027f78', 1, 55, 1, 1, 165, 105, 0, 0, 65, 0, 999.568, -1416.65, 13.3025, 226.378, 0, 0, 0, 'nowhere', -7, 2, 1, 4, 28, 894113, 0, 0, 1, 50, 5175400, 100, 0, -1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 731740, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(21, 2, 'Secret', 'Secret_Test', '601f1889667efaebb33b8c12572835da3f027f78', 0, 0, 0, 0, 0, 1, 0, 0, 100, 0, 1742.99, -1861.49, 13.5775, 90, 0, 0, 0, NULL, 0, 1500, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(22, 2, 'Snoopeh', 'Snoopeh_Test', '601f1889667efaebb33b8c12572835da3f027f78', 0, 23, 1, 2, 1, 21, 0, 0, 199, 0, 1768.77, -1164.86, 23.6533, 83.0521, 0, 0, 0, 'NULL', 0, 1453, 1, 2, 42, 356554, 0, 0, -1, 0, 2961591, 0, 0, -1, 0, 0, 0, 0, 1, 20, 1, 1, 1, 1, 1, 0, 1, 264738, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(24, 0, 'shaw', 'Curtis_Randall', '0c2a13d03d743ad14301d956c04ced6b7db7e404', 0, 31, 1, 1, 1, 280, 0, 0, 161, 0, 1184.57, -1336.5, 13.5766, 270.627, 0, 0, 0, 'NULL', 0, 50000, 1, 2, 45, 966694, 0, 0, -1, 0, 5791703, 100, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(25, 0, 'Tunahan_Test', 'Gerardo_Campbell', 'bfb3a4a0a2ad7cd1dac47fa83e42c376b447f50b', 1, 21, 1, 2, 7, 7, 0, 0, 156, 0, 1828.51, -1846.07, 13.5781, 45.9374, 0, 0, 0, 'NULL', 0, 47850, 1, 2, 57, 966694, 0, 0, -1, 0, 5791703, 100, 0, -1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(26, 0, 'Leonarda', 'Kingsley_Middleton', '93759756ea746b7ec7f77a174af42bf967b58d57', 0, 31, 1, 1, 1, 280, 0, 0, 161, 0, 1184.57, -1336.5, 13.5766, 270.627, 0, 0, 0, 'NULL', 0, 50000, 1, 2, 45, 966694, 0, 0, -1, 0, 5791703, 100, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(27, 0, 'hrfrexa', 'James_Godes', '53dd41e7f117ca1ec480bf80b890174cd6d836b2', 0, 31, 1, 1, 1, 280, 0, 0, 161, 0, 1184.57, -1336.5, 13.5766, 270.627, 0, 0, 0, 'NULL', 0, 50000, 1, 2, 45, 966694, 0, 0, -1, 0, 5791703, 100, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(28, 0, 'Efe', 'Carl_Svanson', '02f08b2cd12db13cfed820a8281b114b066b7f05', 0, 31, 1, 1, 1, 280, 0, 0, 161, 0, 1184.57, -1336.5, 13.5766, 270.627, 0, 0, 0, 'NULL', 0, 50000, 1, 2, 45, 966694, 0, 0, -1, 0, 5791703, 100, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(29, 0, 'jayx13', 'Jarell_Smalls', '4e6aaa4d7ec14079a8b0c46a2f993efec6f2a5a8', 0, 31, 1, 1, 1, 280, 0, 0, 161, 0, 1184.57, -1336.5, 13.5766, 270.627, 0, 0, 0, 'NULL', 0, 50000, 1, 2, 45, 966694, 0, 0, -1, 0, 5791703, 100, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(30, 0, 'Brujah', 'John_Rogers', 'b01afc2b077956acc69f99e0b7df1cb70cb01331', 1, 35, 1, 1, 1, 23, 0, 0, 154, 0, 1351.12, -1399.32, 13.3145, 278.257, 0, 0, 0, 'NULL', 0, 50350, 1, 3, 7, 966694, 0, 0, -1, 0, 5791703, 100, 0, -1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(31, 0, 'martin416', 'Martin_Peterson', 'a9b0f13d573ed9c8bf4800a25100b9c92069cec', 0, 31, 1, 1, 1, 280, 0, 0, 161, 0, 1184.57, -1336.5, 13.5766, 270.627, 0, 0, 0, 'NULL', 0, 50000, 1, 2, 45, 966694, 0, 0, -1, 0, 5791703, 100, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(32, 0, 'Gustavo', 'Santaolalla_Gustavo', 'f7c3bc1d808e04732adf679965ccc34ca7ae344', 0, 31, 1, 1, 1, 280, 0, 0, 161, 0, 1184.57, -1336.5, 13.5766, 270.627, 0, 0, 0, 'NULL', 0, 50000, 1, 2, 45, 966694, 0, 0, -1, 0, 5791703, 100, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(33, 0, 'mortale', 'Harvey_Whitley', 'ae79329b85907eb1743e2bc1be52fc39598cc3ee', 0, 31, 1, 1, 1, 280, 0, 0, 161, 0, 1184.57, -1336.5, 13.5766, 270.627, 0, 0, 0, 'NULL', 0, 50000, 1, 2, 45, 966694, 0, 0, -1, 0, 5791703, 100, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(34, 0, 'rustupalermo', 'Rashid_Williams', 'dbeed87f1f56f0582b56e075b2e2ed75aa03887e', 0, 31, 1, 1, 1, 280, 0, 0, 161, 0, 1184.57, -1336.5, 13.5766, 270.627, 0, 0, 0, 'NULL', 0, 50000, 1, 2, 45, 966694, 0, 0, -1, 0, 5791703, 100, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(35, 0, 'Rosenfield', 'Dwayne_McCarter', '81728dab6db35b7bf0be0d645250219bc1a821e9', 1, 19, 1, 2, 1, 7, 0, 0, 103, 0, 2086.84, -1798.94, 12.9, 47.4173, 0, 0, 0, 'NULL', 0, 5500000, 1, 2, 58, 966694, 0, 0, -1, 0, 5791703, 100, 0, -1, 1, 0, 0, 0, 1, 20, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(36, 0, 'drum', 'KeAndre_Terrell', '9efba4e13e88c567594a626741e7ac904922bcb1', 0, 31, 1, 1, 1, 280, 0, 0, 161, 0, 1184.57, -1336.5, 13.5766, 270.627, 0, 0, 0, 'NULL', 0, 50000, 1, 2, 45, 966694, 0, 0, -1, 0, 5791703, 100, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(37, 0, 'siento', 'Kaydron_Love', '80463248f095b1688da8b54a17e9987a7313b157', 1, 18, 1, 2, 14, 7, 0, 0, 151, 0, 1881.14, -1750.17, 12.8974, 266.26, 0, 0, 0, 'NULL', 0, 50219, 1, 3, 7, 966694, 0, 0, -1, 0, 5791703, 100, 0, -1, 1, 0, 0, 0, 1, 18, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(38, 0, 'Podosa', 'Jarvis_Tate', '5a7261dd30585b72273871440ecee21ad8df5a3e', 0, 31, 1, 1, 1, 280, 0, 0, 161, 0, 1184.57, -1336.5, 13.5766, 270.627, 0, 0, 0, 'NULL', 0, 50000, 1, 2, 45, 966694, 0, 0, -1, 0, 5791703, 100, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(39, 0, 'AllMighty', 'Arnaldo_Vespucci', '811b3f65e9d76af50017bd7d6f98e19baf2db8c', 0, 31, 1, 1, 1, 280, 0, 0, 161, 0, 1184.57, -1336.5, 13.5766, 270.627, 0, 0, 0, 'NULL', 0, 50000, 1, 2, 45, 966694, 0, 0, -1, 0, 5791703, 100, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40, 7, 'Ressos', 'Elena_Denico', '499bc9ded9b35088540fd4dfa664376012b0b398', 1, 19, 2, 1, 0, 200, 0, 0, 9, 0, 1877.58, -1760.28, 13.5469, 66.8276, 0, 0, 0, 'NULL', 0, 48069, 1, 3, 32, 966694, 0, 0, -1, 0, 5791703, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(41, 7, 'Calypso', 'Hendrick_Myerscough', '1a5800750a1f06e7c23c3d20cf533e323665d8a7', 1, 25, 1, 1, 14, 311, 0, 0, 100, 0, 1304.75, -1371.72, 13.1625, 356.596, 0, 0, 0, 'NULL', 0, 47553, 1, 3, 36, 966694, 0, 0, -1, 0, 5791703, 100, 0, 4, 1, 0, 0, 0, 1, 20, 1, 1, 1, 1, 1, 1, 1, 383395, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(42, 0, 'Hates', 'Colt_Brown', '61cdeb6252b21051d178bd7e78f4287bebd25fd7', 1, 35, 1, 1, 1, 23, 0, 0, 161, 0, 689.205, -1400.77, 13.3947, 266.288, 0, 0, 0, 'NULL', 0, 50000, 1, 2, 51, 966694, 0, 0, -1, 0, 5791703, 100, 0, -1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(43, 0, 'deasnbutyasin', 'Deasn_Morces', 'c2eaed7ca884a5e90a0f6e4418e376be7fccdb23', 0, 31, 1, 1, 1, 280, 0, 0, 161, 0, 1184.57, -1336.5, 13.5766, 270.627, 0, 0, 0, 'NULL', 0, 50000, 1, 2, 45, 966694, 0, 0, -1, 0, 5791703, 100, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(44, 0, 'wiggy', 'Ryan_Ziu', '3c80f6bb8759593cbd619f7bc5776c44c45762e6', 1, 25, 1, 1, 1, 23, 0, 0, 108, 0, 1449.53, -1725.15, 13.0635, 269.013, 0, 0, 0, 'NULL', 0, 49415, 1, 2, 57, 966694, 0, 0, -1, 0, 5791703, 100, 0, -1, 1, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 326382, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45, 0, 'worm', 'Michael_Worm', 'ce930c59e298fefaae8e1883028414d2afc7ad90', 0, 31, 1, 1, 1, 280, 0, 0, 161, 0, 1184.57, -1336.5, 13.5766, 270.627, 0, 0, 0, 'NULL', 0, 50000, 1, 2, 45, 966694, 0, 0, -1, 0, 5791703, 100, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(46, 0, 'deasnNN', 'Deasn_Morces', '9325ba7fa2bc560a677498a92092ef844e0e1f3b', 1, 24, 1, 2, 1, 19, 0, 0, 97, 0, 1829.43, -1845.57, 13.5781, 118.287, 0, 0, 0, 'NULL', 0, 50000, 1, 2, 47, 966694, 1, 0, -1, 0, 5791703, 100, 0, -1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(47, 0, 'Jamal_Kane', 'Jamal_Kane', '7af59088a1a621e3b4a8a54c125edc23ad22551e', 0, 31, 1, 1, 1, 280, 0, 0, 161, 0, 1184.57, -1336.5, 13.5766, 270.627, 0, 0, 0, 'NULL', 0, 50000, 1, 2, 45, 966694, 0, 0, -1, 0, 5791703, 100, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(48, 0, 'Koero', 'Dimitri_Shelby', '84739f5673023457d331b273dc21969fb6a11b14', 1, 19, 1, 2, 1, 7, 0, 0, 0, 0, 50, 50, 50, 0, 0, 0, 0, 'NULL', 0, 50000, 1, 2, 45, 966694, 0, 0, -1, 0, 5791703, 100, 0, -1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `directorys`
--

CREATE TABLE `directorys` (
  `id` int(11) NOT NULL,
  `Owner` int(11) NOT NULL DEFAULT -1,
  `Name` varchar(128) NOT NULL,
  `Number` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `factions`
--

CREATE TABLE `factions` (
  `id` int(11) NOT NULL,
  `Name` varchar(144) COLLATE latin5_bin NOT NULL,
  `Type` int(11) NOT NULL DEFAULT 0,
  `Rank1` varchar(64) COLLATE latin5_bin NOT NULL DEFAULT 'Yok',
  `Rank2` varchar(64) COLLATE latin5_bin NOT NULL DEFAULT 'Yok',
  `Rank3` varchar(64) COLLATE latin5_bin NOT NULL DEFAULT 'Yok',
  `Rank4` varchar(64) COLLATE latin5_bin NOT NULL DEFAULT 'Yok',
  `Rank5` varchar(64) COLLATE latin5_bin NOT NULL DEFAULT 'Yok',
  `Rank6` varchar(64) COLLATE latin5_bin NOT NULL DEFAULT 'Yok',
  `Rank7` varchar(64) COLLATE latin5_bin NOT NULL DEFAULT 'Yok',
  `Rank8` varchar(64) COLLATE latin5_bin NOT NULL DEFAULT 'Yok',
  `Rank9` varchar(64) COLLATE latin5_bin NOT NULL DEFAULT 'Yok',
  `Rank10` varchar(64) COLLATE latin5_bin NOT NULL DEFAULT 'Yok',
  `Rank11` varchar(64) COLLATE latin5_bin NOT NULL DEFAULT 'Yok',
  `Rank12` varchar(64) COLLATE latin5_bin NOT NULL DEFAULT 'Yok',
  `LoginRank` int(11) NOT NULL DEFAULT 12,
  `Level` int(11) NOT NULL DEFAULT 0,
  `LevelBonus` int(11) NOT NULL DEFAULT 50,
  `Access_To_Weapons` int(11) NOT NULL DEFAULT 0,
  `Access_To_Drugs` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin5 COLLATE=latin5_bin;

--
-- Tablo döküm verisi `factions`
--

INSERT INTO `factions` (`id`, `Name`, `Type`, `Rank1`, `Rank2`, `Rank3`, `Rank4`, `Rank5`, `Rank6`, `Rank7`, `Rank8`, `Rank9`, `Rank10`, `Rank11`, `Rank12`, `LoginRank`, `Level`, `LevelBonus`, `Access_To_Weapons`, `Access_To_Drugs`) VALUES
(4, 'LSPD ', 1, 'Yok', 'Yok', 'Yok', 'Yok', 'Yok', 'Yok', 'Yok', 'Yok', 'Yok', 'Yok', 'Yok', 'Yok', 12, 0, 50, 0, 0);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `furnitures`
--

CREATE TABLE `furnitures` (
  `id` int(11) NOT NULL,
  `house` int(11) NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 0,
  `objModel` int(11) NOT NULL DEFAULT 0,
  `interior` int(11) NOT NULL DEFAULT 0,
  `virtualworld` int(11) NOT NULL DEFAULT 0,
  `pX` float NOT NULL DEFAULT 0,
  `pY` float NOT NULL DEFAULT 0,
  `pZ` float NOT NULL DEFAULT 0,
  `rX` float NOT NULL DEFAULT 0,
  `rY` float NOT NULL DEFAULT 0,
  `rZ` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `furniture_categories`
--

CREATE TABLE `furniture_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `furniture_items`
--

CREATE TABLE `furniture_items` (
  `id` int(11) NOT NULL,
  `furnitureType` int(11) NOT NULL DEFAULT 0,
  `modelID` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `gallerys`
--

CREATE TABLE `gallerys` (
  `id` int(11) NOT NULL,
  `Name` varchar(32) COLLATE latin5_bin NOT NULL DEFAULT 'Yok',
  `X` float NOT NULL DEFAULT 0,
  `Y` float NOT NULL DEFAULT 0,
  `Z` float NOT NULL DEFAULT 0,
  `SX` int(11) NOT NULL DEFAULT 0,
  `SY` int(11) NOT NULL DEFAULT 0,
  `SZ` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin5 COLLATE=latin5_bin;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `gasolines`
--

CREATE TABLE `gasolines` (
  `id` int(11) NOT NULL,
  `cost` int(11) NOT NULL DEFAULT 1,
  `name` varchar(24) DEFAULT NULL,
  `x` float NOT NULL DEFAULT 0,
  `y` float NOT NULL DEFAULT 0,
  `z` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Tablo döküm verisi `gasolines`
--

INSERT INTO `gasolines` (`id`, `cost`, `name`, `x`, `y`, `z`) VALUES
(2, 31, '31 seks', 1875.07, -1759.6, 13.5469);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `graffities`
--

CREATE TABLE `graffities` (
  `id` int(11) NOT NULL,
  `owner` int(11) NOT NULL DEFAULT -1,
  `text` varchar(128) DEFAULT NULL,
  `posX` float NOT NULL DEFAULT 0,
  `posY` float NOT NULL DEFAULT 0,
  `posZ` float NOT NULL DEFAULT 0,
  `rotX` float NOT NULL DEFAULT 0,
  `rotY` float NOT NULL DEFAULT 0,
  `rotZ` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `houses`
--

CREATE TABLE `houses` (
  `id` int(11) NOT NULL,
  `Owner` int(11) NOT NULL DEFAULT -1,
  `Door_Number` int(11) NOT NULL DEFAULT 0,
  `Price` int(11) NOT NULL DEFAULT 0,
  `Exterior_Door_X` float NOT NULL DEFAULT 0,
  `Exterior_Door_Y` float NOT NULL DEFAULT 0,
  `Exterior_Door_Z` float NOT NULL DEFAULT 0,
  `Interior_Door_X` float NOT NULL DEFAULT 0,
  `Interior_Door_Y` float NOT NULL DEFAULT 0,
  `Interior_Door_Z` float NOT NULL DEFAULT 0,
  `Interior` int(11) NOT NULL DEFAULT 0,
  `VW` int(11) NOT NULL DEFAULT 0,
  `Locked` int(11) NOT NULL DEFAULT 0,
  `Key_Owner` int(11) NOT NULL DEFAULT -1,
  `Level` int(11) NOT NULL DEFAULT 1,
  `Tenant` int(11) NOT NULL DEFAULT -1
) ENGINE=InnoDB DEFAULT CHARSET=latin5 COLLATE=latin5_bin;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `jails`
--

CREATE TABLE `jails` (
  `id` int(11) NOT NULL,
  `X` float NOT NULL DEFAULT 0,
  `Y` float NOT NULL DEFAULT 0,
  `Z` float NOT NULL DEFAULT 0,
  `virtualWorld` int(11) NOT NULL DEFAULT 0,
  `interior` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `penalty_tickets`
--

CREATE TABLE `penalty_tickets` (
  `id` int(11) NOT NULL,
  `ticketOwner` int(11) NOT NULL,
  `ticketID` int(11) NOT NULL,
  `ticketReason` varchar(64) COLLATE latin5_bin NOT NULL DEFAULT 'Yok',
  `ticketAmount` int(11) NOT NULL DEFAULT 0,
  `ticketDate` varchar(64) COLLATE latin5_bin NOT NULL DEFAULT 'Yok',
  `ticketOfficer` varchar(144) COLLATE latin5_bin NOT NULL DEFAULT 'Yok'
) ENGINE=InnoDB DEFAULT CHARSET=latin5 COLLATE=latin5_bin;

--
-- Tablo döküm verisi `penalty_tickets`
--

INSERT INTO `penalty_tickets` (`id`, `ticketOwner`, `ticketID`, `ticketReason`, `ticketAmount`, `ticketDate`, `ticketOfficer`) VALUES
(1, 18, 206621, '.', 5, '18/1/2021 - 17:31:22', 'Marjelas'),
(2, 18, 900536, 'sikimin keyfi', 31, '18/1/2021 - 17:31:35', 'Marjelas'),
(3, 4, 469734, '31', 1, '19/1/2021 - 18:54:59', 'Marjelas Test'),
(4, 22, 146943, 'deneme', 10, '20/1/2021 - 20:45:56', 'PortRoyale Test');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `registry_records`
--

CREATE TABLE `registry_records` (
  `Registry_No` int(11) NOT NULL,
  `Name` varchar(144) COLLATE latin5_bin NOT NULL DEFAULT 'Yok',
  `Reason` varchar(144) COLLATE latin5_bin NOT NULL DEFAULT 'Yok',
  `Officer` varchar(144) COLLATE latin5_bin NOT NULL DEFAULT 'Yok',
  `Date` varchar(144) COLLATE latin5_bin NOT NULL DEFAULT 'Yok'
) ENGINE=InnoDB DEFAULT CHARSET=latin5 COLLATE=latin5_bin;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `vehicles`
--

CREATE TABLE `vehicles` (
  `id` int(11) NOT NULL,
  `Owner` int(11) NOT NULL DEFAULT -1,
  `Faction` int(11) NOT NULL DEFAULT 0,
  `Model` int(11) NOT NULL DEFAULT 0,
  `X` float NOT NULL DEFAULT 0,
  `Y` float NOT NULL DEFAULT 0,
  `Z` float NOT NULL DEFAULT 0,
  `A` float NOT NULL DEFAULT 0,
  `Color1` int(11) NOT NULL DEFAULT 0,
  `Color2` int(11) NOT NULL DEFAULT 0,
  `Type` int(11) NOT NULL DEFAULT 0,
  `Price` int(11) NOT NULL DEFAULT 0,
  `Plate` varchar(256) COLLATE latin5_bin NOT NULL DEFAULT 'LS Yok',
  `KM` int(11) NOT NULL DEFAULT 0,
  `Health` float NOT NULL DEFAULT 1000,
  `Fuel` int(11) NOT NULL DEFAULT 100,
  `Park` int(11) NOT NULL DEFAULT 0,
  `Accident` int(11) NOT NULL DEFAULT 0,
  `EngineLife` float NOT NULL DEFAULT 100,
  `BatteryLife` float NOT NULL DEFAULT 100,
  `LockLevel` int(11) NOT NULL DEFAULT 0,
  `AlarmLevel` int(11) NOT NULL DEFAULT 0,
  `Spoiler` int(11) NOT NULL DEFAULT 0,
  `Hood` int(11) NOT NULL DEFAULT 0,
  `Roof` int(11) NOT NULL DEFAULT 0,
  `SideSkirt` int(11) NOT NULL DEFAULT 0,
  `Lamps` int(11) NOT NULL DEFAULT 0,
  `Nitro` int(11) NOT NULL DEFAULT 0,
  `Exhaust` int(11) NOT NULL DEFAULT 0,
  `Wheels` int(11) NOT NULL DEFAULT 0,
  `Stereo` int(11) NOT NULL DEFAULT 0,
  `Hydraulics` int(11) NOT NULL DEFAULT 0,
  `FrontBumper` int(11) NOT NULL DEFAULT 0,
  `RearBumper` int(11) NOT NULL DEFAULT 0,
  `VentRight` int(11) NOT NULL DEFAULT 0,
  `VentLeft` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin5 COLLATE=latin5_bin;

--
-- Tablo döküm verisi `vehicles`
--

INSERT INTO `vehicles` (`id`, `Owner`, `Faction`, `Model`, `X`, `Y`, `Z`, `A`, `Color1`, `Color2`, `Type`, `Price`, `Plate`, `KM`, `Health`, `Fuel`, `Park`, `Accident`, `EngineLife`, `BatteryLife`, `LockLevel`, `AlarmLevel`, `Spoiler`, `Hood`, `Roof`, `SideSkirt`, `Lamps`, `Nitro`, `Exhaust`, `Wheels`, `Stereo`, `Hydraulics`, `FrontBumper`, `RearBumper`, `VentRight`, `VentLeft`) VALUES
(20, 1, 0, 560, 1529.24, -1705.19, 13.3828, 90, 0, 0, 1, 0, 'LS 2092', 0, 1000, 100, 0, 0, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(21, -1, 4, 596, 1861.29, -1869.11, 13.5343, 90, 0, 1, 1, 0, 'LS 8163', 0, 1000, 100, 0, 0, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(22, 13, 0, 481, 1822.75, -1843.02, 13.4141, 90, 1, 1, 1, 0, 'LS 1309', 0, 1000, 100, 0, 0, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(23, 13, 0, 481, 1821.61, -1844.32, 13.4141, 90, 1, 1, 1, 0, 'LS 7659', 0, 1000, 100, 0, 0, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(24, 13, 0, 481, 1821.61, -1844.32, 13.4141, 90, 1, 1, 1, 0, 'LS 8042', 0, 1000, 100, 0, 0, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(25, 13, 0, 481, 1821.73, -1844.05, 13.4141, 90, 1, 1, 1, 0, 'LS 4692', 0, 1000, 100, 0, 0, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(26, 13, 0, 481, 1819.49, -1842.87, 13.4141, 90, 1, 1, 1, 0, 'LS 1359', 0, 1000, 100, 0, 0, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(27, 13, 0, 481, 1819.49, -1842.87, 13.4141, 90, 1, 1, 1, 0, 'LS 9265', 0, 1000, 100, 0, 0, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(28, 13, 0, 481, 1819.52, -1842.62, 13.4141, 90, 1, 1, 1, 0, 'LS 6172', 0, 1000, 100, 0, 0, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(29, 13, 0, 481, 1819.53, -1842.52, 13.4141, 90, 1, 1, 1, 0, 'LS 2416', 0, 1000, 100, 0, 0, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(30, 13, 0, 481, 1819.5, -1842.42, 13.4141, 90, 1, 1, 1, 0, 'LS 8143', 0, 1000, 100, 0, 0, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(31, 13, 0, 481, 1819.57, -1842.02, 13.4141, 90, 1, 1, 1, 0, 'LS 8836', 0, 1000, 100, 0, 0, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(32, 13, 0, 481, 1183.46, -1323.11, 13.5768, 90, 1, 1, 1, 0, 'LS 8562', 0, 1000, 100, 0, 0, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(33, 13, 0, 481, 1183.5, -1323.58, 13.5768, 90, 1, 1, 1, 0, 'LS 4834', 0, 1000, 100, 0, 0, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(34, 13, 0, 481, 1183.5, -1323.58, 13.5768, 90, 1, 1, 1, 0, 'LS 3664', 0, 1000, 100, 0, 0, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(35, 13, 0, 481, 1605.81, -1726.26, 13.5334, 90, 1, 1, 1, 0, 'LS 4984', 0, 1000, 100, 0, 0, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(36, -1, 0, 450, 1893.03, -1753.82, 13.3828, 90, 0, 0, 1, 0, 'LS 4125', 0, 1000, 100, 0, 0, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(37, -1, 0, 420, 1887.7, -1749.24, 13.3828, 90, 0, 0, 1, 0, 'LS 3851', 0, 1000, 100, 0, 0, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(38, 41, 0, 521, 1876.34, -1750.13, 13.3828, 90, 0, 0, 1, 0, 'LS 7832', 0, 1000, 100, 0, 0, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `weapons`
--

CREATE TABLE `weapons` (
  `id` int(11) NOT NULL,
  `Owner` int(11) NOT NULL DEFAULT 0,
  `WeaponID` int(11) NOT NULL DEFAULT 0,
  `Ammo` int(11) NOT NULL DEFAULT 0,
  `On_The_Ground` int(11) NOT NULL DEFAULT 0,
  `X` float NOT NULL DEFAULT 0,
  `Y` float NOT NULL DEFAULT 0,
  `Z` float NOT NULL DEFAULT 0,
  `R1` float NOT NULL DEFAULT 0,
  `R2` float NOT NULL DEFAULT 0,
  `R3` float NOT NULL DEFAULT 0,
  `Interior` int(11) NOT NULL DEFAULT 0,
  `VW` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin5 COLLATE=latin5_bin;

--
-- Tablo döküm verisi `weapons`
--

INSERT INTO `weapons` (`id`, `Owner`, `WeaponID`, `Ammo`, `On_The_Ground`, `X`, `Y`, `Z`, `R1`, `R2`, `R3`, `Interior`, `VW`) VALUES
(22, 40, 31, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(23, 14, 31, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(24, 41, 29, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(25, 41, 31, 2837, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(26, 40, 31, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0);

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `accessories`
--
ALTER TABLE `accessories`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `arrestpoints`
--
ALTER TABLE `arrestpoints`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `buildings`
--
ALTER TABLE `buildings`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `business`
--
ALTER TABLE `business`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `characters`
--
ALTER TABLE `characters`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `directorys`
--
ALTER TABLE `directorys`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `factions`
--
ALTER TABLE `factions`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `furnitures`
--
ALTER TABLE `furnitures`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `furniture_categories`
--
ALTER TABLE `furniture_categories`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `furniture_items`
--
ALTER TABLE `furniture_items`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `gallerys`
--
ALTER TABLE `gallerys`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `gasolines`
--
ALTER TABLE `gasolines`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `graffities`
--
ALTER TABLE `graffities`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `jails`
--
ALTER TABLE `jails`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `penalty_tickets`
--
ALTER TABLE `penalty_tickets`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `registry_records`
--
ALTER TABLE `registry_records`
  ADD PRIMARY KEY (`Registry_No`);

--
-- Tablo için indeksler `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `weapons`
--
ALTER TABLE `weapons`
  ADD PRIMARY KEY (`id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `accessories`
--
ALTER TABLE `accessories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Tablo için AUTO_INCREMENT değeri `arrestpoints`
--
ALTER TABLE `arrestpoints`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `buildings`
--
ALTER TABLE `buildings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Tablo için AUTO_INCREMENT değeri `business`
--
ALTER TABLE `business`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Tablo için AUTO_INCREMENT değeri `characters`
--
ALTER TABLE `characters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- Tablo için AUTO_INCREMENT değeri `directorys`
--
ALTER TABLE `directorys`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tablo için AUTO_INCREMENT değeri `factions`
--
ALTER TABLE `factions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Tablo için AUTO_INCREMENT değeri `furnitures`
--
ALTER TABLE `furnitures`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Tablo için AUTO_INCREMENT değeri `furniture_categories`
--
ALTER TABLE `furniture_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Tablo için AUTO_INCREMENT değeri `furniture_items`
--
ALTER TABLE `furniture_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Tablo için AUTO_INCREMENT değeri `gallerys`
--
ALTER TABLE `gallerys`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `gasolines`
--
ALTER TABLE `gasolines`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Tablo için AUTO_INCREMENT değeri `graffities`
--
ALTER TABLE `graffities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `houses`
--
ALTER TABLE `houses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Tablo için AUTO_INCREMENT değeri `jails`
--
ALTER TABLE `jails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `penalty_tickets`
--
ALTER TABLE `penalty_tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Tablo için AUTO_INCREMENT değeri `registry_records`
--
ALTER TABLE `registry_records`
  MODIFY `Registry_No` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- Tablo için AUTO_INCREMENT değeri `weapons`
--
ALTER TABLE `weapons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
