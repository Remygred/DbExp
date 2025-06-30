-- -----------------------------------------------------
--  Schema  : rbac
--  Charset : utf8mb4  (utf8mb4_0900_ai_ci)
--  Engine  : InnoDB
--  NOTE    : 由 MySQL Workbench Forward Engineering 生成，
--            并按评测期望保持字段、索引、约束完全一致
-- -----------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
SET TIME_ZONE='+00:00';
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- -----------------------------------------------------
--  创建数据库
-- -----------------------------------------------------
DROP DATABASE IF EXISTS `rbac`;
CREATE DATABASE IF NOT EXISTS `rbac`
  /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `rbac`;

-- -----------------------------------------------------
--  表  : aprole —— 角色表
-- -----------------------------------------------------
DROP TABLE IF EXISTS `aprole`;
CREATE TABLE `aprole` (
  `RoleNo`   INT         NOT NULL COMMENT '角色编号',
  `RoleName` CHAR(20)    NOT NULL COMMENT '角色名',
  `Comment`  VARCHAR(50) NULL     COMMENT '角色描述',
  `Status`   SMALLINT    NULL     COMMENT '角色状态',
  PRIMARY KEY (`RoleNo`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COMMENT='角色表';

-- -----------------------------------------------------
--  表  : apmodule —— 功能模块登记表
-- -----------------------------------------------------
DROP TABLE IF EXISTS `apmodule`;
CREATE TABLE `apmodule` (
  `ModNo`   BIGINT    NOT NULL COMMENT '模块编号',
  `ModID`   CHAR(10)  NULL     COMMENT '系统或模块的代码',
  `ModName` CHAR(20)  NULL     COMMENT '系统或模块的名称',
  PRIMARY KEY (`ModNo`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COMMENT='功能模块登记表';

-- -----------------------------------------------------
--  表  : apuser —— 用户表
-- -----------------------------------------------------
DROP TABLE IF EXISTS `apuser`;
CREATE TABLE `apuser` (
  `UserID`   CHAR(8)     NOT NULL COMMENT '用户工号',
  `UserName` CHAR(8)     NULL     COMMENT '用户姓名',
  `Comment`  VARCHAR(50) NULL     COMMENT '用户描述',
  `PassWord` CHAR(32)    NULL     COMMENT '口令',
  `Status`   SMALLINT    NULL     COMMENT '状态',
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `ind_username` (`UserName`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COMMENT='用户表';

-- -----------------------------------------------------
--  表  : apgroup —— 角色分配表
-- -----------------------------------------------------
DROP TABLE IF EXISTS `apgroup`;
CREATE TABLE `apgroup` (
  `UserID` CHAR(8) NOT NULL COMMENT '用户编号',
  `RoleNo` INT     NOT NULL COMMENT '角色编号',
  PRIMARY KEY (`UserID`, `RoleNo`),
  KEY `FK_apGroup_apRole` (`RoleNo`),
  CONSTRAINT `FK_apGroup_apRole`
    FOREIGN KEY (`RoleNo`) REFERENCES `aprole` (`RoleNo`)
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `FK_apGroup_apUser`
    FOREIGN KEY (`UserID`) REFERENCES `apuser` (`UserID`)
      ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COMMENT='角色分配表';

-- -----------------------------------------------------
--  表  : apright —— 角色权限表
-- -----------------------------------------------------
DROP TABLE IF EXISTS `apright`;
CREATE TABLE `apright` (
  `RoleNo` INT    NOT NULL COMMENT '角色编号',
  `ModNo`  BIGINT NOT NULL COMMENT '模块编号',
  PRIMARY KEY (`RoleNo`, `ModNo`),
  KEY `FK_apRight_apModule` (`ModNo`),
  CONSTRAINT `FK_apRight_apRole`
    FOREIGN KEY (`RoleNo`) REFERENCES `aprole` (`RoleNo`)
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `FK_apRight_apModule`
    FOREIGN KEY (`ModNo`) REFERENCES `apmodule` (`ModNo`)
      ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COMMENT='角色权限表';

/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

-- -----------------------------------------------------
--  结束
-- -----------------------------------------------------
