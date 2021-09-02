CREATE DATABASE  IF NOT EXISTS `database_sms` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `database_sms`;
-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: database_sms
-- ------------------------------------------------------
-- Server version	8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `idClientes` int NOT NULL AUTO_INCREMENT,
  `NombreCliente` varchar(45) NOT NULL,
  `Tipo` int DEFAULT NULL,
  `NombreUsuario` varchar(50) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `FechaNacimiento` date NOT NULL,
  `Correo` varchar(100) NOT NULL,
  `Ruc` varchar(45) NOT NULL,
  `NumeroTelefono` varchar(45) NOT NULL,
  `Direccion` varchar(100) NOT NULL,
  `Mensajeria_idMensajeria` int DEFAULT NULL,
  PRIMARY KEY (`idClientes`),
  KEY `fk_Clientes_Mensajeria1_idx` (`Mensajeria_idMensajeria`),
  CONSTRAINT `fk_Clientes_Mensajeria1` FOREIGN KEY (`Mensajeria_idMensajeria`) REFERENCES `mensajeria` (`idMensajeria`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Lupe Tereza',NULL,'Lupe','$2a$10$u0z1ZHdUW4wF285sMMk1wOocCd4dIH0AqlCWHBO0NDRJFTSagx15G','2000-10-19','lupe@gmail.com','124564768921','0982356384','Quito',NULL);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fotosusuario`
--

DROP TABLE IF EXISTS `fotosusuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fotosusuario` (
  `idFotos` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int NOT NULL,
  `NombreFoto` varchar(45) DEFAULT NULL,
  `Data` longblob,
  `Type` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`idFotos`),
  KEY `fk_Foto_usuario_idx` (`idUsuario`),
  CONSTRAINT `fk_UserFoto` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuarios`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fotosusuario`
--

LOCK TABLES `fotosusuario` WRITE;
/*!40000 ALTER TABLE `fotosusuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `fotosusuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mensajeria`
--

DROP TABLE IF EXISTS `mensajeria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mensajeria` (
  `idMensajeria` int NOT NULL AUTO_INCREMENT,
  `MensajesEnviados` int NOT NULL,
  `SaldoCliente` varchar(45) NOT NULL,
  `SolicitudesExitosas` int NOT NULL,
  `SolicitudesPendientes` int NOT NULL,
  `SolicitudesFallidas` int NOT NULL,
  `CantidadNumeros` int NOT NULL,
  `CopiaSeguridad` varchar(200) NOT NULL,
  PRIMARY KEY (`idMensajeria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mensajeria`
--

LOCK TABLES `mensajeria` WRITE;
/*!40000 ALTER TABLE `mensajeria` DISABLE KEYS */;
/*!40000 ALTER TABLE `mensajeria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int unsigned NOT NULL,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('GmsHjOdMKxPsDnm77YpeUAL-bZ4oksCt',1630623150,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{},\"passport\":{}}');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipousuario`
--

DROP TABLE IF EXISTS `tipousuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipousuario` (
  `idTipoUsuario` int NOT NULL,
  `UsuarioAdministrador` int DEFAULT NULL,
  `UsuarioSinPrivilegios` int DEFAULT NULL COMMENT 'usuario administardor =1\nusuaario nomal =2',
  `Usuarios_idUsuarios` int NOT NULL,
  PRIMARY KEY (`idTipoUsuario`),
  KEY `fk_tipo_usuario_Usuarios_idx` (`Usuarios_idUsuarios`),
  CONSTRAINT `fk_tipo_usuario_Usuarios` FOREIGN KEY (`Usuarios_idUsuarios`) REFERENCES `usuarios` (`idUsuarios`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipousuario`
--

LOCK TABLES `tipousuario` WRITE;
/*!40000 ALTER TABLE `tipousuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipousuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `idUsuarios` int NOT NULL AUTO_INCREMENT,
  `NombreCliente` varchar(45) NOT NULL,
  `Tipo` int DEFAULT NULL,
  `Correo` varchar(100) NOT NULL,
  `NombreUsuario` varchar(50) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `FechaNacimiento` date NOT NULL,
  `NumeroTelefono` varchar(45) NOT NULL,
  `Ruc` varchar(45) NOT NULL,
  `Direccion` varchar(100) NOT NULL,
  `FechaCreacionUsuario` date DEFAULT NULL,
  PRIMARY KEY (`idUsuarios`),
  KEY `fk_Nombre_usuario_idx` (`NombreUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (3,'Eric Jimenez',NULL,'eric@gmail.com','Eric','$2a$10$edWSyw7E5cgEPxRhe4Y6lOoBlRkGjNoX/vpkkGz4Xbqx38l4hZlNS','2001-02-20','0981343052','1245647689','Bario juna solis',NULL),(4,'Jose Daniel',NULL,'jose@gmail.com','Jose','$2a$10$OvbVeUL5SAiVRtq9SKYLJOXINNq.XK32B8/lb7MUfDYt5nltPuMf.','2005-06-24','0981343034','124564762345','Av.Jose pirras',NULL),(5,'Eddy Torres',NULL,'eddy@gmail.com','ETorres','$2a$10$p8kh0bwU0.TC.VOe2MdLa.rf/xUHPFFNRBece01NPlX.yiMQGXkUC','1998-04-08','0998821066','12456476234','loja',NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios_has_mensajeria`
--

DROP TABLE IF EXISTS `usuarios_has_mensajeria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios_has_mensajeria` (
  `Usuarios_idUsuarios` int NOT NULL,
  `Mensajeria_idMensajeria` int NOT NULL,
  `UsuarioEmisor` varchar(50) NOT NULL,
  `FechaCreacion` date NOT NULL,
  `EstadoEnvio` varchar(45) NOT NULL,
  `NumeroCaracteres` varchar(45) NOT NULL,
  PRIMARY KEY (`Usuarios_idUsuarios`,`Mensajeria_idMensajeria`),
  KEY `fk_Usuarios_has_Mensajeria_Mensajeria1_idx` (`Mensajeria_idMensajeria`),
  CONSTRAINT `fk_Usuarios_has_Mensajeria_Mensajeria1` FOREIGN KEY (`Mensajeria_idMensajeria`) REFERENCES `mensajeria` (`idMensajeria`),
  CONSTRAINT `fk_Usuarios_has_Mensajeria_Usuarios1` FOREIGN KEY (`Usuarios_idUsuarios`) REFERENCES `usuarios` (`idUsuarios`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios_has_mensajeria`
--

LOCK TABLES `usuarios_has_mensajeria` WRITE;
/*!40000 ALTER TABLE `usuarios_has_mensajeria` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios_has_mensajeria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'database_sms'
--

--
-- Dumping routines for database 'database_sms'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-09-02  5:06:50
