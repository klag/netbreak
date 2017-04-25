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
-- Database: `netbreakusers`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `admins`
--

CREATE TABLE IF NOT EXISTS `admins` (
  `idAdmin` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) NOT NULL,
  `Surname` varchar(20) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Password` varchar(20) NOT NULL,
  PRIMARY KEY (`idAdmin`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dump dei dati per la tabella `admins`
--

INSERT INTO `admins` (`idAdmin`, `Name`, `Surname`, `Email`, `Password`) VALUES
(1, 'Marco', 'Casagrande', 'marco.casagrande.5@studenti.unipd.it', 'skitinudo'),
(2, 'Davide', 'Scarparo', 'davide.scarparo@studenti.unipd.it', 'viafasulla99');

-- --------------------------------------------------------

--
-- Struttura della tabella `clients`
--

CREATE TABLE IF NOT EXISTS `clients` (
  `idClient` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) NOT NULL,
  `Surname` varchar(20) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Password` varchar(20) NOT NULL,
  `Avatar` varchar(50) NOT NULL,
  `Registration` date NOT NULL,
  `isDeveloper` tinyint(1) NOT NULL,
  `AboutMe` text NOT NULL,
  `Citizenship` varchar(20) NOT NULL,
  `LinkToSelf` varchar(20) NOT NULL,
  `PayPal` varchar(19) NOT NULL,
  PRIMARY KEY (`idClient`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dump dei dati per la tabella `clients`
--

INSERT INTO `clients` (`idClient`, `Name`, `Surname`, `Email`, `Password`, `Avatar`, `Registration`, `isDeveloper`, `AboutMe`, `Citizenship`, `LinkToSelf`, `PayPal`) VALUES
(1, 'Dan', 'Ser', 'ds@gmail.com', 'danser', 'http://avatarfigo.com', '2017-03-08', 1, 'Sono Dan Ser', 'Non lo so', 'http://danser.com', '1111-2222-3333-4444'),
(2, 'Andrea', 'Scalabrin', 'andrea.scalabrin@gmail.com', 'faccioilcss', 'https://pistolanelcassetto.it', '2017-04-02', 0, '', '', '', '');

-- --------------------------------------------------------

--
-- Struttura della tabella `moderationlog`
--

CREATE TABLE IF NOT EXISTS `moderationlog` (
  `idEntry` int(11) NOT NULL AUTO_INCREMENT,
  `idClient` int(11) NOT NULL,
  `idAdmin` int(11) NOT NULL,
  `Timestamp` timestamp NOT NULL,
  `ModType` int(11) NOT NULL,
  `Report` text NOT NULL,
  PRIMARY KEY (`idEntry`),
  KEY `idCliente` (`idClient`),
  KEY `idAdmin` (`idAdmin`),
  KEY `TipoModerazione` (`ModType`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dump dei dati per la tabella `moderationlog`
--

INSERT INTO `moderationlog` (`idEntry`, `idClient`, `idAdmin`, `Timestamp`, `ModType`, `Report`) VALUES
(1, 1, 1, '2017-04-05 22:00:00', 1, 'Sospeso per traffici sospetti'),
(2, 1, 2, '2017-04-06 22:00:00', 3, 'Risolte le accuse di traffici sospetti');

-- --------------------------------------------------------

--
-- Struttura della tabella `moderationtypes`
--

CREATE TABLE IF NOT EXISTS `moderationtypes` (
  `idModType` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) NOT NULL,
  `Description` text NOT NULL,
  PRIMARY KEY (`idModType`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dump dei dati per la tabella `moderationtypes`
--

INSERT INTO `moderationtypes` (`idModType`, `Name`, `Description`) VALUES
(1, 'SospUtente', 'Sospensione dell''utente dall''utilizzo dei microservizi di API Market'),
(2, 'SospPagamenti', 'Sospensione dell''utente dai pagamenti di API Market per l''uso dei propri microservizi registrati'),
(3, 'RevSospUtente', 'Revoca la sospensione dell''utente dall''utilizzo dei microservizi di API Market');

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `moderationlog`
--
ALTER TABLE `moderationlog`
  ADD CONSTRAINT `moderationlog_ibfk_1` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `moderationlog_ibfk_2` FOREIGN KEY (`idAdmin`) REFERENCES `admins` (`idAdmin`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `moderationlog_ibfk_3` FOREIGN KEY (`ModType`) REFERENCES `moderationtypes` (`idModType`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
