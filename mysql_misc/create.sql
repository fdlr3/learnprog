-- MySQL Script generated by MySQL Workbench
-- Sat Apr 11 20:32:01 2020
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
-- Table `mydb`.`Lang`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Lang` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Lang` (
  `ID_Lang` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(255) NOT NULL,
  `Description` TEXT NULL,
  `Image_path` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`ID_Lang`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Tag` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Tag` (
  `ID_Tag` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) NULL,
  PRIMARY KEY (`ID_Tag`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Article` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Article` (
  `ID_Article` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(255) UNIQUE NOT NULL,
  `HTML_Content` TEXT NOT NULL,
  `Date` DATETIME NOT NULL,
  `FK_Lang` INT NOT NULL,
  `FK_Tag` INT NOT NULL,
  PRIMARY KEY (`ID_Article`, `FK_Lang`, `FK_Tag`),
  INDEX `fk_Section_Lang1_idx` (`FK_Lang` ASC),
  INDEX `fk_Article_Tag1_idx` (`FK_Tag` ASC),
  CONSTRAINT `fk_Section_Lang1`
    FOREIGN KEY (`FK_Lang`)
    REFERENCES `mydb`.`Lang` (`ID_Lang`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Article_Tag1`
    FOREIGN KEY (`FK_Tag`)
    REFERENCES `mydb`.`Tag` (`ID_Tag`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

insert into Lang  values(NULL, 'Python', 'description', 'img_src');
insert into Lang  values(NULL, 'C', 'description', 'img_src');
insert into Lang  values(NULL, 'C++', 'description', 'img_src');
insert into Lang  values(NULL, 'Javascript', 'description', 'img_src');
insert into Lang  values(NULL, 'HTML', 'description', 'img_src');
insert into Lang  values(NULL, 'CSS', 'description', 'img_src');

insert into Tag values(NULL, 'OOP');
insert into Tag values(NULL, 'Basics');
insert into Tag values(NULL, 'Advanced');
insert into Tag values(NULL, 'Sockets');
insert into Tag values(NULL, 'FILE IO');
insert into Tag values(NULL, 'REST');

DELIMITER $$
DROP PROCEDURE IF EXISTS fill_Articles$$
CREATE PROCEDURE fill_Articles(IN _count INT)
	BEGIN
		DECLARE i INT DEFAULT 0;	
        DECLARE x INT DEFAULT 0;		
		-- Title
		DECLARE title VARCHAR(255);
		-- HTML_Content		
		DECLARE html VARCHAR(1000);
        -- Date		
		DECLARE datum DATETIME;
		-- FK_Lang
		DECLARE Lang_id INT;
		DECLARE Lang_count INT;
		-- FK_Tag
		DECLARE Tag_id INT;
		DECLARE Tag_count INT;
        
        -- get counts
        SELECT count(*) INTO Lang_count FROM Lang;
        SELECT count(*) INTO Tag_count FROM Tag;
		SET title = "";
        SET html = "";
        
		START TRANSACTION;
		WHILE i < _count DO
            
			-- get random foreign keys
            SET Lang_id = FLOOR(RAND() * Lang_count) + 1;
            SET Tag_id = FLOOR(RAND() * Tag_count) + 1;
			
			SET datum = TIMESTAMPADD(SECOND, FLOOR(RAND() * TIMESTAMPDIFF(SECOND, '2000-10-10 13:01:01', '2020-09-10 13:01:01')), '2000-10-10 13:01:01');
            
            WHILE x < 50 DO
				SET title = CONCAT(title, CHAR(FLOOR(65.5 + (RAND() * 25))));
                SET x = x + 1;
            END WHILE;
            SET x = 0;
            
            WHILE x < 500 DO
				SET html = CONCAT(html, CHAR(FLOOR(65.5 + (RAND() * 25))));
                SET x = x + 1;
            END WHILE;
            SET x = 0;
            
			INSERT INTO Article 
			VALUES(NULL, title, html, datum, Lang_id, Tag_id);
			
            SET title = "";
			SET html = "";
			SET i = i + 1;
		END WHILE;
        COMMIT;
	END $$
DELIMITER ;

call fill_Articles(500);