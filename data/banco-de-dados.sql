SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `sistematt` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `sistematt`;

-- -----------------------------------------------------
-- Table `sistematt`.`roles`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sistematt`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `role` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistematt`.`users`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sistematt`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(100) NOT NULL ,
  `email` VARCHAR(100) NOT NULL ,
  `username` VARCHAR(45) NOT NULL ,
  `password` CHAR(128) NOT NULL ,
  `salt` CHAR(128) NOT NULL ,
  `role_id` INT NOT NULL ,
  `status` INT(1) NOT NULL DEFAULT 1 ,
  PRIMARY KEY (`id`) ,
  INDEX `users_role_id` (`role_id` ASC) ,
  CONSTRAINT `users_role_id`
    FOREIGN KEY (`role_id` )
    REFERENCES `sistematt`.`roles` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistematt`.`login _attempts`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sistematt`.`login _attempts` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `user_id` INT NOT NULL ,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY (`id`, `user_id`) ,
  INDEX `login _attempts_user_id` (`user_id` ASC) ,
  CONSTRAINT `login _attempts_user_id`
    FOREIGN KEY (`user_id` )
    REFERENCES `sistematt`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistematt`.`recoveries`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sistematt`.`recoveries` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `user_id` INT NOT NULL ,
  `token` VARCHAR(255) NOT NULL ,
  `status` INT(1) NOT NULL DEFAULT 0 ,
  PRIMARY KEY (`id`, `user_id`) ,
  INDEX `passwords_user_id` (`user_id` ASC) ,
  CONSTRAINT `passwords_user_id`
    FOREIGN KEY (`user_id` )
    REFERENCES `sistematt`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
