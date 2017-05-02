-- --------------------------------------------------------
-- Host:                         apimmicroservicesinstance.ccsrygwsp8kn.eu-west-2.rds.amazonaws.com
-- Versione server:              5.7.16-log - MySQL Community Server (GPL)
-- S.O. server:                  Linux
-- HeidiSQL Versione:            9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dump della struttura del database MicroservicesDB
CREATE DATABASE IF NOT EXISTS `MicroservicesDB` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `MicroservicesDB`;

-- Dump della struttura di tabella MicroservicesDB.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `IdCategory` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) NOT NULL,
  `Image` varchar(50) NOT NULL,
  PRIMARY KEY (`IdCategory`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella MicroservicesDB.categories: ~5 rows (circa)
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (`IdCategory`, `Name`, `Image`) VALUES
	(1, 'Giochi', 'https://categorie/giochi'),
	(2, 'Multimedia', 'https://categorie/multimedia'),
	(3, 'Notizie', 'https://categorie/notizie'),
	(4, 'Database', 'https://categorie/database'),
	(5, 'Geo', 'https://categorie/geo');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;

-- Dump della struttura di tabella MicroservicesDB.interfaces
CREATE TABLE IF NOT EXISTS `interfaces` (
  `IdInterface` int(11) NOT NULL AUTO_INCREMENT,
  `IdMS` int(11) NOT NULL,
  `Interf` text NOT NULL,
  `Loc` varchar(50) NOT NULL,
  `Protoc` varchar(50) NOT NULL,
  PRIMARY KEY (`IdInterface`),
  KEY `IdMS` (`IdMS`),
  CONSTRAINT `interfaces_ibfk_1` FOREIGN KEY (`IdMS`) REFERENCES `microservices` (`IdMS`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella MicroservicesDB.interfaces: ~9 rows (circa)
/*!40000 ALTER TABLE `interfaces` DISABLE KEYS */;
INSERT INTO `interfaces` (`IdInterface`, `IdMS`, `Interf`, `Loc`, `Protoc`) VALUES
	(1, 1, 'type op: void {\n  .a: int\n  .b: int\n}\n\ninterface DivInterface {\n  RequestResponse:\n    div( op )( double ),\n    divanddouble(op)( double ) \n}', 'socket://localhost:8000', 'http'),
	(2, 1, 'type op: void {\n  .a: int\n  .b: int\n}\n\ninterface SumInterface {\n  RequestResponse:\n    sum( op )( double ),\n    sumanddouble(op)( double )\n}', 'socket://localhost:8000', 'http'),
	(3, 1, 'type op: void {\n	.a: int\n	.b: int\n}\n\ninterface SubInterface {\n  RequestResponse:\n    sub( op )( double ),\n    subanddouble(op)( double )\n}', 'socket://localhost:8000', 'http'),
	(4, 4, 'type Request:void {\n	.destination:string\n	.content:string\n}\n\ninterface FaxInterface {\nRequestResponse:\n	fax(Request)( string )\nOneWay:\n	faxwithnoresponse( Request ) \n}', 'socket://localhost:9202', 'sodep'),
	(5, 4, 'interface HelloInterface {\n  RequestResponse:\n    sayhello( string )( string ),\n    saysuperhello(string)(string),\n    sayagreeting(int)(string),\n}', 'socket://localhost:9500', 'http'),
	(6, 5, 'interface JavaInterface {\n  RequestResponse: \n    getA(void)( string ), \n    getB(void)(string),\n    getC(void)(string)\n}', 'socket://localhost:8310', 'http'),
	(7, 6, 'type persone: void {\n  .persona[0, *]: void {\n    .nome:string\n    .cognome:string\n  }\n}\n\n\ntype nomecognome:void {\n  .nome:string\n  .cognome:string\n}\n\n\ninterface ProfileInterface { \n  RequestResponse: \n  getUsers( void )( persone ),  \n  insertUser(nomecognome)(void)\n}', 'socket://localhost:8030', 'http'),
	(8, 4, 'type mailreq:void {\n  .mail:string\n  .content:string\n}\n\ninterface MailInterface {\n  OneWay:\n    mailwithnoresponse( mailreq ) \n  RequestResponse:\n    mail(mailreq)( string )\n}', 'socket://localhost:9202', 'sodep'),
	(9, 7, 'typedeff goodbye: void {}\r\n\r\ninterface goodbye {}', 'socketf://localhost:8010', 'sodepf');
/*!40000 ALTER TABLE `interfaces` ENABLE KEYS */;

-- Dump della struttura di tabella MicroservicesDB.jnmscat
CREATE TABLE IF NOT EXISTS `jnmscat` (
  `IdMS` int(11) NOT NULL,
  `IdCategory` int(11) NOT NULL,
  PRIMARY KEY (`IdMS`,`IdCategory`),
  KEY `idMS` (`IdMS`),
  KEY `idCategoria` (`IdCategory`),
  CONSTRAINT `jnmscat_ibfk_1` FOREIGN KEY (`IdMS`) REFERENCES `microservices` (`IdMS`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `jnmscat_ibfk_2` FOREIGN KEY (`IdCategory`) REFERENCES `categories` (`IdCategory`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella MicroservicesDB.jnmscat: ~3 rows (circa)
/*!40000 ALTER TABLE `jnmscat` DISABLE KEYS */;
INSERT INTO `jnmscat` (`IdMS`, `IdCategory`) VALUES
	(1, 1),
	(1, 2),
	(4, 2);
/*!40000 ALTER TABLE `jnmscat` ENABLE KEYS */;

-- Dump della struttura di tabella MicroservicesDB.microservices
CREATE TABLE IF NOT EXISTS `microservices` (
  `IdMS` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) NOT NULL,
  `Description` text NOT NULL,
  `Version` int(11) NOT NULL,
  `LastUpdate` date NOT NULL,
  `IdDeveloper` int(11) NOT NULL,
  `Logo` varchar(50) NOT NULL,
  `DocPDF` text NOT NULL,
  `DocExternal` varchar(50) NOT NULL,
  `Profit` int(11) NOT NULL,
  `IsActive` tinyint(1) NOT NULL,
  `SLAGuaranteed` double NOT NULL,
  `Policy` int(11) NOT NULL,
  PRIMARY KEY (`IdMS`),
  KEY `Policy` (`Policy`),
  CONSTRAINT `microservices_ibfk_1` FOREIGN KEY (`Policy`) REFERENCES `policies` (`IdPolicy`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella MicroservicesDB.microservices: ~5 rows (circa)
/*!40000 ALTER TABLE `microservices` DISABLE KEYS */;
INSERT INTO `microservices` (`IdMS`, `Name`, `Description`, `Version`, `LastUpdate`, `IdDeveloper`, `Logo`, `DocPDF`, `DocExternal`, `Profit`, `IsActive`, `SLAGuaranteed`, `Policy`) VALUES
	(1, 'CalcService', 'Esegue servizi di calcolo matematico', 1, '2017-04-06', 7, 'https://calcservice/logo.it', 'Sono una doc PDF', 'https://calcservice/doc.it', 5, 1, 2, 3),
	(4, 'InteractionService', 'Fa interazioni', 2, '2017-04-05', 5, 'https://goodbye/logo.it', 'Non stampa ancora', 'https://goodbye/doc.it', 3, 0, 2, 1),
	(5, 'JavaService', 'Test di un java embedded', 5, '2017-04-01', 7, 'https://meteo/logo.it', 'Ritorna il meteo pioggia', 'https://meteo/doc.it', 1, 1, 2, 2),
	(6, 'ProfileService', 'Ritorna profili', 5, '2017-04-01', 7, 'https://meteo/logo.it', 'Ritorna il meteo pioggia', 'https://meteo/doc.it', 1, 1, 2, 2),
	(7, 'GoodbyeServicee', 'Stampa goodbyee', 3, '2017-04-26', 2, 'https://goodbyees/logo.it', 'Un qualchee pdf', 'https://goodbyee/doc.it', 4, 0, 1, 1);
/*!40000 ALTER TABLE `microservices` ENABLE KEYS */;

-- Dump della struttura di tabella MicroservicesDB.policies
CREATE TABLE IF NOT EXISTS `policies` (
  `IdPolicy` int(11) NOT NULL AUTO_INCREMENT,
  `MrktIncomePerc` int(11) NOT NULL,
  `Name` varchar(20) NOT NULL,
  PRIMARY KEY (`IdPolicy`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella MicroservicesDB.policies: ~3 rows (circa)
/*!40000 ALTER TABLE `policies` DISABLE KEYS */;
INSERT INTO `policies` (`IdPolicy`, `MrktIncomePerc`, `Name`) VALUES
	(1, 3, 'Per Chiamata'),
	(2, 4, 'Per Tempo'),
	(3, 5, 'Per Traffico');
/*!40000 ALTER TABLE `policies` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
