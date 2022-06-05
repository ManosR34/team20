SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema team20
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `team20` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema team20
-- -----------------------------------------------------
USE `team20` ;

-- -----------------------------------------------------
-- Table `team20`.`executive`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `team20`.`executive` (
  `exe_id` INT NOT NULL,
  `name` VARCHAR(30) NULL,
  PRIMARY KEY (`exe_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team20`.`organization`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `team20`.`organization` (
  `org_id` INT NOT NULL,
  `abbreviation` VARCHAR(10) NULL,
  `name` VARCHAR(45) NULL,
  `zip` INT NULL,
  `street` VARCHAR(45) NULL,
  `city` VARCHAR(35) NULL,
  PRIMARY KEY (`org_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team20`.`program`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `team20`.`program` (
  `prog_id` INT NOT NULL,
  `name` VARCHAR(70) NULL,
  `department` VARCHAR(55) NULL,
  PRIMARY KEY (`prog_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team20`.`researcher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `team20`.`researcher` (
  `res_id` INT NOT NULL,
  `first_name` VARCHAR(20) NULL,
  `last_name` VARCHAR(20) NULL,
  `gender` VARCHAR(10) NULL,
  `birth_date` DATE NULL,
  `join_date` DATE NULL,
  `org_id` INT NULL,
  PRIMARY KEY (`res_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team20`.`task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `team20`.`task` (
  `task_id` INT NOT NULL,
  `title` VARCHAR(45) NULL,
  `amount` INT NULL,
  `start` DATE NULL,
  `end` DATE NULL,
  `abstract` VARCHAR(45) NULL,
  `exe_id` INT NULL,
  `prog_id` INT NULL,
  `org_id` INT NULL,
  `res_id` INT NULL,
  PRIMARY KEY (`task_id`),
  INDEX `fk_task_executive_idx` (`exe_id` ASC) VISIBLE,
  INDEX `fk_task_organization1_idx` (`org_id` ASC) VISIBLE,
  INDEX `fk_task_program1_idx` (`prog_id` ASC) VISIBLE,
  INDEX `fk_task_researcher1_idx` (`res_id` ASC) VISIBLE,
  CONSTRAINT `fk_task_executive`
    FOREIGN KEY (`exe_id`)
    REFERENCES `team20`.`executive` (`exe_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_task_organization1`
    FOREIGN KEY (`org_id`)
    REFERENCES `team20`.`organization` (`org_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_task_program1`
    FOREIGN KEY (`prog_id`)
    REFERENCES `team20`.`program` (`prog_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_task_researcher1`
    FOREIGN KEY (`res_id`)
    REFERENCES `team20`.`researcher` (`res_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team20`.`company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `team20`.`company` (
  `org_id` INT NOT NULL,
  `fund` INT NULL,
  PRIMARY KEY (`org_id`),
  CONSTRAINT `fk_company_organization1`
    FOREIGN KEY (`org_id`)
    REFERENCES `team20`.`organization` (`org_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team20`.`university`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `team20`.`university` (
  `org_id` INT NOT NULL,
  `public_budget` INT NULL,
  PRIMARY KEY (`org_id`),
  CONSTRAINT `fk_university_organization1`
    FOREIGN KEY (`org_id`)
    REFERENCES `team20`.`organization` (`org_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team20`.`research_center`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `team20`.`research_center` (
  `org_id` INT NOT NULL,
  `public_budget` INT NULL,
  `private_budget` INT NULL,
  PRIMARY KEY (`org_id`),
  CONSTRAINT `fk_research_center_organization1`
    FOREIGN KEY (`org_id`)
    REFERENCES `team20`.`organization` (`org_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team20`.`science`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `team20`.`science` (
  `sc_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`sc_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team20`.`science_task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `team20`.`science_task` (
  `sc_id` INT NOT NULL,
  `task_id` INT NOT NULL,
  PRIMARY KEY (`sc_id`, `task_id`),
  INDEX `fk_science_task_task1_idx` (`task_id` ASC) VISIBLE,
  CONSTRAINT `fk_science_task_task1`
    FOREIGN KEY (`task_id`)
    REFERENCES `team20`.`task` (`task_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_science_task_science1`
    FOREIGN KEY (`sc_id`)
    REFERENCES `team20`.`science` (`sc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team20`.`delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `team20`.`delivery` (
  `task_id` INT NOT NULL,
  `title` VARCHAR(45) NULL,
  `abstract` VARCHAR(45) NULL,
  `delivery_date` DATE NULL,
  PRIMARY KEY (`task_id`),
  CONSTRAINT `fk_delivery_task1`
    FOREIGN KEY (`task_id`)
    REFERENCES `team20`.`task` (`task_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team20`.`work_on`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `team20`.`work_on` (
  `task_id` INT NOT NULL,
  `res_id` INT NOT NULL,
  PRIMARY KEY (`task_id`, `res_id`),
  INDEX `fk_work_on_researcher1_idx` (`res_id` ASC) VISIBLE,
  CONSTRAINT `fk_work_on_task1`
    FOREIGN KEY (`task_id`)
    REFERENCES `team20`.`task` (`task_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_work_on_researcher1`
    FOREIGN KEY (`res_id`)
    REFERENCES `team20`.`researcher` (`res_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team20`.`evaluation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `team20`.`evaluation` (
  `eval_id` INT NOT NULL,
  `grade` INT NULL,
  `date` DATE NULL,
  PRIMARY KEY (`eval_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team20`.`task_res_eval`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `team20`.`task_res_eval` (
  `task_id` INT NOT NULL,
  `res_id` INT NOT NULL,
  `eval_id` INT NOT NULL,
  PRIMARY KEY (`task_id`, `res_id`, `eval_id`),
  INDEX `fk_task_res_eval_evaluation1_idx` (`eval_id` ASC) VISIBLE,
  INDEX `fk_task_res_eval_researcher1_idx` (`res_id` ASC) VISIBLE,
  CONSTRAINT `fk_task_res_eval_evaluation1`
    FOREIGN KEY (`eval_id`)
    REFERENCES `team20`.`evaluation` (`eval_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_task_res_eval_task1`
    FOREIGN KEY (`task_id`)
    REFERENCES `team20`.`task` (`task_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_task_res_eval_researcher1`
    FOREIGN KEY (`res_id`)
    REFERENCES `team20`.`researcher` (`res_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team20`.`phone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `team20`.`phone` (
  `org_id` INT NOT NULL,
  `phone_number` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`org_id`, `phone_number`),
  CONSTRAINT `fk_phone_organization1`
    FOREIGN KEY (`org_id`)
    REFERENCES `team20`.`organization` (`org_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
