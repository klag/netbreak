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
-- Database: `netbreaktransactions`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `apikeys`
--

CREATE TABLE IF NOT EXISTS `apikeys` (
  `idAPIKey` int(11) NOT NULL AUTO_INCREMENT,
  `idClient` int(11) NOT NULL,
  `idMS` int(11) NOT NULL,
  `Policy` int(11) NOT NULL,
  `Remaining` int(11) NOT NULL,
  PRIMARY KEY (`idAPIKey`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dump dei dati per la tabella `apikeys`
--

INSERT INTO `apikeys` (`idAPIKey`, `idClient`, `idMS`, `Policy`, `Remaining`) VALUES
(1, 55, 1, 3, 100),
(2, 145, 3, 2, 999);

-- --------------------------------------------------------

--
-- Struttura della tabella `purchases`
--

CREATE TABLE IF NOT EXISTS `purchases` (
  `idPurchase` int(11) NOT NULL AUTO_INCREMENT,
  `idAPIKey` int(11) NOT NULL,
  `idClient` int(11) NOT NULL,
  `Timestamp` timestamp NOT NULL,
  `Price` int(11) NOT NULL,
  `Amount` int(11) NOT NULL,
  PRIMARY KEY (`idPurchase`),
  KEY `idAPIKey` (`idAPIKey`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dump dei dati per la tabella `purchases`
--

INSERT INTO `purchases` (`idPurchase`, `idAPIKey`, `idClient`, `Timestamp`, `Price`, `Amount`) VALUES
(1, 1, 55, '2017-04-04 22:00:00', 60, 100),
(2, 2, 145, '2017-04-03 22:00:00', 20, 200),
(3, 2, 145, '2017-04-05 22:00:00', 90, 900);

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `purchases`
--
ALTER TABLE `purchases`
  ADD CONSTRAINT `purchases_ibfk_1` FOREIGN KEY (`idAPIKey`) REFERENCES `apikeys` (`idAPIKey`) ON DELETE NO ACTION ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
