-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 07, 2017 alle 16:39
-- Versione del server: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `netbreaksla`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `slasurveys`
--

CREATE TABLE IF NOT EXISTS `slasurveys` (
  `idSLASurvey` int(11) NOT NULL AUTO_INCREMENT,
  `idAPIKey` int(11) NOT NULL,
  `Timestamp` timestamp NOT NULL,
  `ResponseTime` double NOT NULL,
  `isCompliant` tinyint(1) NOT NULL,
  PRIMARY KEY (`idSLASurvey`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dump dei dati per la tabella `slasurveys`
--

INSERT INTO `slasurveys` (`idSLASurvey`, `idAPIKey`, `Timestamp`, `ResponseTime`, `isCompliant`) VALUES
(1, 1, '2017-04-06 20:52:20', 0.12, 1),
(2, 2, '2017-04-06 20:52:44', 4.46, 0),
(3, 1, '2017-04-06 20:53:23', 0.67, 1);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
