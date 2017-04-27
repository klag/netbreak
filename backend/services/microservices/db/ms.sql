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
-- Database: `netbreakms`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `idMS` int(11) NOT NULL AUTO_INCREMENT,
  `idCategory` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) NOT NULL,
  `Image` varchar(50) NOT NULL,
  PRIMARY KEY (`idCategory`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dump dei dati per la tabella `categories`
--

INSERT INTO `categories` (`idCategory`, `Name`, `Image`) VALUES
(1, 'Giochi', 'https://categorie/giochi'),
(2, 'Multimedia', 'https://categorie/multimedia'),
(3, 'Notizie', 'https://categorie/notizie'),
(4, 'Database', 'https://categorie/database'),
(6, 'Geo', 'https://categorie/geo');

-- --------------------------------------------------------

--
-- Struttura della tabella `join-mscat`
--

CREATE TABLE IF NOT EXISTS `join-mscat` (
  `idMS` int(11) NOT NULL,
  `idCategory` int(11) NOT NULL,
  PRIMARY KEY (`idMS`,`idCategory`),
  KEY `idMS` (`idMS`),
  KEY `idCategoria` (`idCategory`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struttura della tabella `microservices`
--

CREATE TABLE IF NOT EXISTS `microservices` (
  `idMS` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) NOT NULL,
  `Description` text NOT NULL,
  `Version` int(11) NOT NULL,
  `LastUpdate` date NOT NULL,
  `idDeveloper` int(11) NOT NULL,
  `Logo` varchar(50) NOT NULL,
  `DocPDF` text NOT NULL,
  `DocExternal` varchar(50) NOT NULL,
  `Profit` int(11) NOT NULL,
  `isActive` tinyint(1) NOT NULL,
  `SLAGuaranteed` double NOT NULL,
  `Policy` int(11) NOT NULL,
  PRIMARY KEY (`idMS`),
  KEY `Policy` (`Policy`),
  KEY `Policy_2` (`Policy`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dump dei dati per la tabella `microservices`
--

INSERT INTO `microservices` (`Name`, `Description`, `Version`, `LastUpdate`, `idDeveloper`, `Logo`, `DocPDF`, `DocExternal`, `Profit`, `isActive`, `SLAGuaranteed`, `Policy`) VALUES
('CalcService', '-', 1, '2017-04-06', 7, 'https://hello/logo.it', 'Stampa su console Hello World', 'https://hello/doc.it', 5, 1, 2, 3),
('InteractionService', 'fa interazioni', 2, '2017-04-05', 5, 'GoodbyeWorldInterface {}', 'https://goodbye/logo.it', 'Non stampa ancora', 'https://goodbye/doc.it', 3, 0, 2, 1),
('JavaService', 'test di un java embedded', 5, '2017-04-01', 7, 'GetMeteoInterface {\r\nreturn "Pioggia"\r\n}', 'https://meteo/logo.it', 'Ritorna il meteo pioggia', 'https://meteo/doc.it', 1, 1, 2, 2),
('ProfileService', 'ritorna profili', 5, '2017-04-01', 7, 'GetMeteoInterface {\r\nreturn "Pioggia"\r\n}', 'https://meteo/logo.it', 'Ritorna il meteo pioggia', 'https://meteo/doc.it', 1, 1, 2, 2);


-- --------------------------------------------------------

-- --------------------------------------------------------

--
-- Struttura della tabella `interfaces`
--

CREATE TABLE IF NOT EXISTS `interfaces` (
  `IdMS` int(11) NOT NULL,
  `idInterface` int(11) NOT NULL AUTO_INCREMENT,
  `Interf` text NOT NULL,
  `Loc` varchar(50) NOT NULL,
  `Protoc` varchar(50) NOT NULL,
   PRIMARY KEY (`idInterface`),
   FOREIGN KEY (IdMS) REFERENCES microservices(IdMs)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `interfaces`
--

INSERT INTO `interfaces` (`idMS`, `Interf`, `Loc`, `Protoc`) VALUES
(1, 'type op: void {
  .a: int
  .b: int
}

interface DivInterface {
  RequestResponse:
    div( op )( double ),
    divanddouble(op)( double ) 
}', 'socket://localhost:8000', 'http' ),
(1, 'type op: void {
  .a: int
  .b: int
}

interface SubInterface {
  RequestResponse:
    sub( op )( double ),
    subanddouble(op)( double )
}', 'socket://localhost:8000', 'http' ),
(1, 'type op: void {
  .a: int
  .b: int
}

interface SumInterface {
  RequestResponse:
    sum( op )( double ),
    sumanddouble(op)( double )
}', 'socket://localhost:8000', 'http' ),
(4, 'type Request:void {
  .destination:string
  .content:string
}

interface FaxInterface {
OneWay:
    faxwithnoresponse( Request ) 
RequestResponse:
  fax(Request)( string )
}', 'socket://localhost:9202', 'sodep' ),
(4, 'type mailreq:void {
  .mail:string
  .content:string
}

interface MailInterface {
  OneWay:
    mailwithnoresponse( mailreq ) 
  RequestResponse:
    mail(mailreq)( string )
}', 'socket://localhost:9202', 'sodep' ),
(4, 'interface HelloInterface {
  RequestResponse:
    sayhello( string )( string ),
    saysuperhello(string)(string),
    sayagreeting(int)(string),
}', 'socket://localhost:9500', 'http' ),
(5, 'interface JavaInterface {
  RequestResponse: 
    getA(void)( string ), 
    getB(void)(string),
    getC(void)(string)
}', 'socket://localhost:8310', 'http' ),
(6, 'type persone: void {
  .persona[0, *]: void {
    .nome:string
    .cognome:string
  }
}


type nomecognome:void {
  .nome:string
  .cognome:string
}


interface ProfileInterface { 
  RequestResponse: 
  getUsers( void )( persone ),  
  insertUser(nomecognome)(void)
}', 'socket://localhost:8030', 'http' );

-- --------------------------------------------------------

--
-- Struttura della tabella `policies`
--

CREATE TABLE IF NOT EXISTS `policies` (
  `idPolicy` int(11) NOT NULL AUTO_INCREMENT,
  `MarketIncomePerc` int(11) NOT NULL,
  `Name` varchar(20) NOT NULL,
  PRIMARY KEY (`idPolicy`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dump dei dati per la tabella `policies`
--

INSERT INTO `policies` (`idPolicy`, `MarketIncomePerc`, `Name`) VALUES
(1, 3, 'Per Chiamata'),
(2, 4, 'Per Tempo'),
(3, 5, 'Per Traffico');

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `join-mscat`
--
ALTER TABLE `join-mscat`
  ADD CONSTRAINT `join-mscat_ibfk_1` FOREIGN KEY (`idMS`) REFERENCES `microservices` (`idMS`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `join-mscat_ibfk_2` FOREIGN KEY (`idCategory`) REFERENCES `categories` (`idCategory`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `microservices`
--
ALTER TABLE `microservices`
  ADD CONSTRAINT `microservices_ibfk_1` FOREIGN KEY (`Policy`) REFERENCES `policies` (`idPolicy`) ON DELETE NO ACTION ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
