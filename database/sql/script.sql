-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema acompanhantes
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema acompanhantes
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `acompanhantes` DEFAULT CHARACTER SET utf8 ;
USE `acompanhantes` ;

-- -----------------------------------------------------
-- Table `acompanhantes`.`tb_estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `acompanhantes`.`tb_estado` (
  `co_estado` INT NOT NULL AUTO_INCREMENT,
  `uf` VARCHAR(2) NULL,
  `nome` VARCHAR(60) NULL,
  `situacao` TINYINT NULL,
  PRIMARY KEY (`co_estado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `acompanhantes`.`tb_cidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `acompanhantes`.`tb_cidade` (
  `co_cidade` INT NOT NULL AUTO_INCREMENT,
  `co_estado` INT NOT NULL,
  `nome` VARCHAR(60) NULL,
  `situacao` TINYINT NULL,
  `ibge` VARCHAR(10) NULL,
  PRIMARY KEY (`co_cidade`),
  INDEX `fk_tb_cidade_tb_estado_idx` (`co_estado` ASC),
  CONSTRAINT `fk_tb_cidade_tb_estado`
    FOREIGN KEY (`co_estado`)
    REFERENCES `acompanhantes`.`tb_estado` (`co_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `acompanhantes`.`tb_bairro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `acompanhantes`.`tb_bairro` (
  `co_bairro` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(60) NULL,
  `situacao` TINYINT NULL,
  `co_cidade` INT NOT NULL,
  PRIMARY KEY (`co_bairro`),
  INDEX `fk_tb_bairro_tb_cidade1_idx` (`co_cidade` ASC),
  CONSTRAINT `fk_tb_bairro_tb_cidade1`
    FOREIGN KEY (`co_cidade`)
    REFERENCES `acompanhantes`.`tb_cidade` (`co_cidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `acompanhantes`.`tb_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `acompanhantes`.`tb_usuario` (
  `co_usuario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(60) NULL,
  `dt_nasc` DATE NULL,
  `co_bairro` INT NOT NULL,
  `co_perfil` INT NULL,
  `sexo` VARCHAR(1) NULL,
  `situacao` TINYINT NULL,
  `email` VARCHAR(60) NULL,
  `senha` VARCHAR(45) NULL,
  PRIMARY KEY (`co_usuario`),
  INDEX `fk_tb_usuario_tb_bairro1_idx` (`co_bairro` ASC),
  CONSTRAINT `fk_tb_usuario_tb_bairro1`
    FOREIGN KEY (`co_bairro`)
    REFERENCES `acompanhantes`.`tb_bairro` (`co_bairro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `acompanhantes`.`tb_etinia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `acompanhantes`.`tb_etinia` (
  `co_etinia` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `situacao` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`co_etinia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `acompanhantes`.`tb_cabelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `acompanhantes`.`tb_cabelo` (
  `co_cabelo` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `situacao` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`co_cabelo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `acompanhantes`.`tb_olhos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `acompanhantes`.`tb_olhos` (
  `co_olhos` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `situacao` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`co_olhos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `acompanhantes`.`tb_anuncio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `acompanhantes`.`tb_anuncio` (
  `co_anuncio` INT NOT NULL,
  `co_usuario` INT NOT NULL,
  `idade` INT NULL,
  `peso` DECIMAL(4,1) NULL,
  `cartao` TINYINT NULL DEFAULT 1 COMMENT '0 - nao\n1 - sim',
  `altura` DECIMAL(3,2) NULL,
  `horario` INT NULL DEFAULT 1 COMMENT '1 - 24 horas\n2 - matutino\n3 - verpertino\n4 - noturno',
  `viagem` TINYINT NULL DEFAULT 1 COMMENT '0 - nao\n1 - sim',
  `local` TINYINT NULL COMMENT '0 - nao mora so\n1 - mora so\n',
  `atende` INT NULL DEFAULT 3 COMMENT '1 - homem\n2 - mulher\n3 - casal\n',
  `anal` TINYINT NULL DEFAULT 0 COMMENT '0 - nao\n1 - sim',
  `oralsem` TINYINT NULL DEFAULT 0 COMMENT '0 - nao\n1 - sim',
  `beijo` TINYINT NULL DEFAULT 0 COMMENT '0 - nao\n1 - sim',
  `acessorios` TINYINT NULL,
  `situacao` TINYINT NULL DEFAULT 1 COMMENT '0 - inativo\n1 - ativo',
  `co_etinia` INT NOT NULL,
  `co_cabelo` INT NOT NULL,
  `co_olhos` INT NOT NULL,
  PRIMARY KEY (`co_anuncio`),
  INDEX `fk_tb_anuncio_tb_usuario1_idx` (`co_usuario` ASC),
  INDEX `fk_tb_anuncio_tb_etinia1_idx` (`co_etinia` ASC),
  INDEX `fk_tb_anuncio_tb_cabelo1_idx` (`co_cabelo` ASC),
  INDEX `fk_tb_anuncio_tb_olhos1_idx` (`local` ASC),
  CONSTRAINT `fk_tb_anuncio_tb_usuario1`
    FOREIGN KEY (`co_usuario`)
    REFERENCES `acompanhantes`.`tb_usuario` (`co_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_anuncio_tb_etinia1`
    FOREIGN KEY (`co_etinia`)
    REFERENCES `acompanhantes`.`tb_etinia` (`co_etinia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_anuncio_tb_cabelo1`
    FOREIGN KEY (`co_cabelo`)
    REFERENCES `acompanhantes`.`tb_cabelo` (`co_cabelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_anuncio_tb_olhos1`
    FOREIGN KEY (`co_olhos`)
    REFERENCES `acompanhantes`.`tb_olhos` (`co_olhos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `acompanhantes`.`tb_idiomas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `acompanhantes`.`tb_idiomas` (
  `co_idioma` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `situacao` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`co_idioma`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `acompanhantes`.`rl_anuncio_idiomas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `acompanhantes`.`rl_anuncio_idiomas` (
  `co_anuncio` INT NOT NULL,
  `co_idioma` INT NOT NULL,
  PRIMARY KEY (`co_anuncio`, `co_idioma`),
  INDEX `fk_tb_anuncio_has_tb_idiomas_tb_idiomas1_idx` (`co_idioma` ASC),
  INDEX `fk_tb_anuncio_has_tb_idiomas_tb_anuncio1_idx` (`co_anuncio` ASC),
  CONSTRAINT `fk_tb_anuncio_has_tb_idiomas_tb_anuncio1`
    FOREIGN KEY (`co_anuncio`)
    REFERENCES `acompanhantes`.`tb_anuncio` (`co_anuncio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_anuncio_has_tb_idiomas_tb_idiomas1`
    FOREIGN KEY (`co_idioma`)
    REFERENCES `acompanhantes`.`tb_idiomas` (`co_idioma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
