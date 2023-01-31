-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           8.0.29 - MySQL Community Server - GPL
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.3.0.6602
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para tex
DROP DATABASE IF EXISTS `tex`;
CREATE DATABASE IF NOT EXISTS `tex` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `tex`;

-- Copiando estrutura para tabela tex.tb_enderecos
DROP TABLE IF EXISTS `tb_enderecos`;
CREATE TABLE IF NOT EXISTS `tb_enderecos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dt_cadastro` datetime DEFAULT NULL,
  `dt_atualizacao` datetime DEFAULT NULL,
  `id_cliente` int DEFAULT NULL,
  `cep` varchar(9) DEFAULT NULL,
  `endereco` varchar(45) DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  `uf` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pessoas_end_idx` (`id_cliente`),
  CONSTRAINT `fk_pessoas_end` FOREIGN KEY (`id_cliente`) REFERENCES `tb_pessoas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela tex.tb_enderecos: ~5 rows (aproximadamente)
INSERT IGNORE INTO `tb_enderecos` (`id`, `dt_cadastro`, `dt_atualizacao`, `id_cliente`, `cep`, `endereco`, `cidade`, `uf`) VALUES
	(3, '2023-01-31 08:27:10', NULL, 1, '89010000', 'Rua 15 de Novembro', 'Blumenau', 'SC'),
	(4, '2023-01-31 08:29:12', '2023-01-31 08:31:05', 2, '89010000', 'Rua 15 de Novembro', 'Blumenau', 'SC'),
	(5, '2023-01-31 08:31:05', NULL, 2, '88037375', 'Rua Stuttgart', 'Florianópolis', 'SC'),
	(6, '2023-01-31 09:18:37', '2023-01-31 09:19:03', 3, '88160076', 'Rua Marechal Floriano Peixoto', 'Biguaçu', 'SC'),
	(8, '2023-01-31 09:19:03', NULL, 3, '88806693', 'Rua Ernesto Che Guevara', 'Criciúma', 'SC'),
	(9, '2023-01-31 09:24:00', NULL, 4, '11065101', 'Rua Euclides da Cunha', 'Santos', 'SP'),
	(10, '2023-01-31 09:24:01', NULL, 4, '89107000', 'Rua Waldo Klemann, 339', 'Pomerode', 'SC'),
	(12, '2023-01-31 09:26:16', '2023-01-31 09:26:47', 5, '11065101', 'Rua Euclides da Cunha', 'Santos', 'SP'),
	(13, '2023-01-31 09:26:47', NULL, 5, '07727585', 'Rua Rio de Janeiro', 'Caieiras', 'SP'),
	(14, '2023-01-31 09:27:15', NULL, 6, '89107000', 'Rua abc 123', 'Pomerode', 'SC');

-- Copiando estrutura para tabela tex.tb_pessoas
DROP TABLE IF EXISTS `tb_pessoas`;
CREATE TABLE IF NOT EXISTS `tb_pessoas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dt_cadastro` datetime DEFAULT NULL,
  `dt_atualizacao` datetime DEFAULT NULL,
  `nome_pessoa` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela tex.tb_pessoas: ~0 rows (aproximadamente)
INSERT IGNORE INTO `tb_pessoas` (`id`, `dt_cadastro`, `dt_atualizacao`, `nome_pessoa`) VALUES
	(1, '2023-01-30 18:57:34', '2023-01-31 08:26:24', 'TESTE'),
	(2, '2023-01-31 08:29:12', '2023-01-31 08:31:05', 'teste 123'),
	(3, '2023-01-31 09:18:37', '2023-01-31 09:19:03', 'TESTE GRAVANDO VÍDEO...'),
	(4, '2023-01-31 09:24:00', NULL, 'gravando 2'),
	(5, '2023-01-31 09:26:16', '2023-01-31 09:26:47', 'gravando 3'),
	(6, '2023-01-31 09:27:15', NULL, 'abc');

-- Copiando estrutura para tabela tex.tb_usuarios
DROP TABLE IF EXISTS `tb_usuarios`;
CREATE TABLE IF NOT EXISTS `tb_usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dt_cadastro` datetime DEFAULT NULL,
  `dt_atualizacao` datetime DEFAULT NULL,
  `ds_login` varchar(45) NOT NULL,
  `ds_senha` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela tex.tb_usuarios: ~0 rows (aproximadamente)
INSERT IGNORE INTO `tb_usuarios` (`id`, `dt_cadastro`, `dt_atualizacao`, `ds_login`, `ds_senha`) VALUES
	(1, '2023-01-27 02:22:16', NULL, 'ADMIN', '74FFC874ADA0A28DBADBEFB0FF97A58DB731837C');

-- Copiando estrutura para trigger tex.tb_enderecos_BEFORE_INSERT
DROP TRIGGER IF EXISTS `tb_enderecos_BEFORE_INSERT`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `tb_enderecos_BEFORE_INSERT` BEFORE INSERT ON `tb_enderecos` FOR EACH ROW BEGIN
	set new.dt_cadastro	:=	now();
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger tex.tb_enderecos_BEFORE_UPDATE
DROP TRIGGER IF EXISTS `tb_enderecos_BEFORE_UPDATE`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `tb_enderecos_BEFORE_UPDATE` BEFORE UPDATE ON `tb_enderecos` FOR EACH ROW BEGIN
	set new.dt_atualizacao	:=	now();
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger tex.tb_pessoas_BEFORE_INSERT
DROP TRIGGER IF EXISTS `tb_pessoas_BEFORE_INSERT`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `tb_pessoas_BEFORE_INSERT` BEFORE INSERT ON `tb_pessoas` FOR EACH ROW BEGIN
	set new.dt_cadastro	:=	now();
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger tex.tb_pessoas_BEFORE_UPDATE
DROP TRIGGER IF EXISTS `tb_pessoas_BEFORE_UPDATE`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `tb_pessoas_BEFORE_UPDATE` BEFORE UPDATE ON `tb_pessoas` FOR EACH ROW BEGIN
	set new.dt_atualizacao	:=	now();
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger tex.tb_usuarios_BEFORE_INSERT
DROP TRIGGER IF EXISTS `tb_usuarios_BEFORE_INSERT`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `tb_usuarios_BEFORE_INSERT` BEFORE INSERT ON `tb_usuarios` FOR EACH ROW BEGIN
	set new.dt_cadastro := now();
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger tex.tb_usuarios_BEFORE_UPDATE
DROP TRIGGER IF EXISTS `tb_usuarios_BEFORE_UPDATE`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `tb_usuarios_BEFORE_UPDATE` BEFORE UPDATE ON `tb_usuarios` FOR EACH ROW BEGIN
	set new.dt_atualizacao :=	now();
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
