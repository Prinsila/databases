-- MySQL Script generated by MySQL Workbench
-- Wed Jun  5 22:51:46 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(32) NOT NULL,
  `user_id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`user_id`));


-- -----------------------------------------------------
-- Table `mydb`.`list`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`list` (
  `list_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `list_name` VARCHAR(32) NOT NULL,
  `purpose` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`list_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`item` (
  `item_id` INT NOT NULL AUTO_INCREMENT,
  `list_id` INT NOT NULL,
  `item_name` VARCHAR(45) NOT NULL,
  `is_completed` TINYINT NULL DEFAULT 0,
  `due_date` DATETIME NULL,
  `itemcol` VARCHAR(45) NULL,
  PRIMARY KEY (`item_id`),
  INDEX `list_id _idx` (`list_id` ASC) VISIBLE,
  CONSTRAINT `list_id `
    FOREIGN KEY (`list_id`)
    REFERENCES `mydb`.`list` (`list_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`tag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tag` (
  `tag_id` INT NOT NULL AUTO_INCREMENT,
  `tagname` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`tag_id`));


-- -----------------------------------------------------
-- Table `mydb`.`itemTag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`itemTag` (
  `item_id` INT NOT NULL AUTO_INCREMENT,
  `tag_id` INT NOT NULL,
  PRIMARY KEY (`item_id`, `tag_id`),
  CONSTRAINT `item_id`
    FOREIGN KEY (`item_id`)
    REFERENCES `mydb`.`item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tag_id`
    FOREIGN KEY (`item_id` , `tag_id`)
    REFERENCES `mydb`.`tag` (`tag_id` , `tag_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`remainder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`remainder` (
  `remainder_id` INT NOT NULL AUTO_INCREMENT,
  `item_id` INT NOT NULL,
  `remainder_time` DATETIME NOT NULL,
  `is_sent` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`remainder_id`),
  INDEX `item_id_idx` (`item_id` ASC) VISIBLE,
  CONSTRAINT `item_id`
    FOREIGN KEY (`item_id`)
    REFERENCES `mydb`.`item` (`item_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
