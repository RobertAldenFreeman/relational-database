-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Account` (
  `account_id` TINYINT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NOT NULL,
  `balance` FLOAT NULL,
  PRIMARY KEY (`account_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Person` (
  `person_id` TINYINT NOT NULL AUTO_INCREMENT,
  `ssn` INT NOT NULL,
  `age` TINYINT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `date_of_birth` VARCHAR(45) NOT NULL,
  `degree` VARCHAR(45) NOT NULL,
  `account` TINYINT NOT NULL,
  PRIMARY KEY (`person_id`, `account`),
  UNIQUE INDEX `ssn_UNIQUE` (`ssn` ASC) VISIBLE,
  INDEX `Person_account_FK_idx` (`account` ASC) VISIBLE,
  CONSTRAINT `Person_account_FK`
    FOREIGN KEY (`account`)
    REFERENCES `mydb`.`Account` (`account_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Registered_User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Registered_User` (
  `user_id` TINYINT NOT NULL AUTO_INCREMENT,
  `person` TINYINT NOT NULL,
  `username` CHAR(10) NOT NULL,
  `password` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`user_id`, `person`),
  INDEX `Registered_User_PK_FK_idx` (`person` ASC) VISIBLE,
  CONSTRAINT `Registered_User_PK_FK`
    FOREIGN KEY (`person`)
    REFERENCES `mydb`.`Person` (`person_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Address` (
  `address_id` TINYINT NOT NULL AUTO_INCREMENT,
  `billing` VARCHAR(100) NOT NULL,
  `shipping` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`address_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`User_Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User_Address` (
  `user_address_id` TINYINT NOT NULL AUTO_INCREMENT,
  `registered_user` TINYINT NOT NULL,
  `address` TINYINT NOT NULL,
  PRIMARY KEY (`user_address_id`, `registered_user`, `address`),
  INDEX `UserAddress_Address_FK_idx` (`address` ASC) VISIBLE,
  INDEX `UserAddress_RegisteredUser_FK_idx` (`registered_user` ASC) VISIBLE,
  CONSTRAINT `UserAddress_RegisteredUser_FK`
    FOREIGN KEY (`registered_user`)
    REFERENCES `mydb`.`Registered_User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `UserAddress_Address_FK`
    FOREIGN KEY (`address`)
    REFERENCES `mydb`.`Address` (`address_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product` (
  `product_id` TINYINT NOT NULL AUTO_INCREMENT,
  `current_version` VARCHAR(45) NOT NULL,
  `version` VARCHAR(45) NULL,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Website`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Website` (
  `web_id` TINYINT NOT NULL AUTO_INCREMENT,
  `product_page` VARCHAR(100) NULL,
  `homepage` VARCHAR(100) NULL,
  PRIMARY KEY (`web_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Client` (
  `client_id` TINYINT NOT NULL,
  `registered_user` TINYINT NOT NULL,
  `complaint` TINYINT NULL,
  `purchase` VARCHAR(45) NULL,
  `receipt` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`client_id`, `registered_user`),
  INDEX `registered_user_idx` (`registered_user` ASC) VISIBLE,
  CONSTRAINT `registered_user`
    FOREIGN KEY (`registered_user`)
    REFERENCES `mydb`.`Registered_User` (`user_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Employee` (
  `employee_id` TINYINT NOT NULL AUTO_INCREMENT,
  `registered_user` TINYINT NOT NULL,
  `uniform` VARCHAR(100) NULL,
  `employed` TINYINT(1) NOT NULL,
  PRIMARY KEY (`employee_id`, `registered_user`),
  INDEX `Employee_PK_FK_idx` (`registered_user` ASC) VISIBLE,
  CONSTRAINT `Employee_PK_FK`
    FOREIGN KEY (`registered_user`)
    REFERENCES `mydb`.`Registered_User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Complaint`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Complaint` (
  `complaint_id` TINYINT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(300) NULL,
  `resolved` BIT NOT NULL,
  `client` TINYINT NOT NULL,
  PRIMARY KEY (`complaint_id`, `client`),
  INDEX `client_idx` (`client` ASC) VISIBLE,
  CONSTRAINT `client`
    FOREIGN KEY (`client`)
    REFERENCES `mydb`.`Client` (`client_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ad` (
  `ad_id` TINYINT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `expenditure` FLOAT NOT NULL,
  PRIMARY KEY (`ad_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Office`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Office` (
  `office_id` TINYINT NOT NULL AUTO_INCREMENT,
  `rent` FLOAT NULL,
  `utilities` FLOAT NULL,
  `maintenance` FLOAT NULL,
  PRIMARY KEY (`office_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Computer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Computer` (
  `computer_id` TINYINT NOT NULL AUTO_INCREMENT,
  `office` TINYINT NOT NULL,
  `company` VARCHAR(45) NULL,
  `client` VARCHAR(45) NULL,
  `personal` BIT NOT NULL,
  PRIMARY KEY (`computer_id`, `office`),
  INDEX `Office_FK_PK_idx` (`office` ASC) VISIBLE,
  CONSTRAINT `Office_FK_PK`
    FOREIGN KEY (`office`)
    REFERENCES `mydb`.`Office` (`office_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Software_As_a_Service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Software_As_a_Service` (
  `software_as_a_service_id` TINYINT NOT NULL AUTO_INCREMENT,
  `reissue_date` VARCHAR(45) NOT NULL,
  `subscription_number` VARCHAR(45) NOT NULL,
  `expiration_date` INT NOT NULL,
  PRIMARY KEY (`software_as_a_service_id`),
  UNIQUE INDEX `subscription_number_UNIQUE` (`subscription_number` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Sale` (
  `sale_id` TINYINT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(300) NULL,
  `time` DATETIME NOT NULL,
  `department` TINYINT NOT NULL,
  PRIMARY KEY (`sale_id`, `department`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Supplies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Supplies` (
  `supplies_id` TINYINT NOT NULL AUTO_INCREMENT,
  `office` VARCHAR(45) NOT NULL,
  `furnishings` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`supplies_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`IT_Service_Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`IT_Service_Order` (
  `service_id` TINYINT NOT NULL AUTO_INCREMENT,
  `notes` VARCHAR(200) NULL,
  `total` FLOAT NOT NULL,
  PRIMARY KEY (`service_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tax`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tax` (
  `tax_id` TINYINT NOT NULL AUTO_INCREMENT,
  `property` DECIMAL(3,2) NULL,
  `sales` DECIMAL(3,2) NULL,
  `employment` DECIMAL(3,2) NULL,
  PRIMARY KEY (`tax_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Department` (
  `department_id` TINYINT NOT NULL AUTO_INCREMENT,
  `accounts_and_finance` BIT NOT NULL,
  `research_and_development` BIT NOT NULL,
  `sales_and_marketing` BIT NOT NULL,
  `it_services` BIT NOT NULL,
  `human_resources` BIT NOT NULL,
  PRIMARY KEY (`department_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pay`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pay` (
  `pay_id` TINYINT NOT NULL AUTO_INCREMENT,
  `employee` TINYINT NOT NULL,
  `hours` FLOAT NOT NULL,
  `salary` FLOAT NULL,
  `wage` FLOAT NULL,
  PRIMARY KEY (`pay_id`, `employee`),
  INDEX `Employee_FK_PK_idx` (`employee` ASC) VISIBLE,
  CONSTRAINT `Pay_Employee_FK_PK`
    FOREIGN KEY (`employee`)
    REFERENCES `mydb`.`Employee` (`employee_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bonus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bonus` (
  `bonus_id` TINYINT NOT NULL AUTO_INCREMENT,
  `employee` TINYINT NOT NULL,
  `signing` FLOAT NULL,
  `holiday` FLOAT NULL,
  PRIMARY KEY (`bonus_id`, `employee`),
  INDEX `Employee_FK_PK_idx` (`employee` ASC) VISIBLE,
  CONSTRAINT `Bonus_Employee_FK_PK`
    FOREIGN KEY (`employee`)
    REFERENCES `mydb`.`Employee` (`employee_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Benefits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Benefits` (
  `benefit_id` TINYINT NOT NULL AUTO_INCREMENT,
  `employee` TINYINT NOT NULL,
  `medical` FLOAT NULL,
  `dental` FLOAT NULL,
  PRIMARY KEY (`benefit_id`, `employee`),
  INDEX `Employee_FK_PK_idx` (`employee` ASC) VISIBLE,
  CONSTRAINT `Benefits_Employee_FK_PK`
    FOREIGN KEY (`employee`)
    REFERENCES `mydb`.`Employee` (`employee_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Supervisor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Supervisor` (
  `supervisor_id` TINYINT NOT NULL AUTO_INCREMENT,
  `employee` TINYINT NOT NULL,
  PRIMARY KEY (`supervisor_id`, `employee`),
  INDEX `Supervisor_Employee_FK_PK_idx` (`employee` ASC) VISIBLE,
  CONSTRAINT `Supervisor_Employee_FK_PK`
    FOREIGN KEY (`employee`)
    REFERENCES `mydb`.`Employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Host`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Host` (
  `hosts_id` TINYINT NOT NULL,
  `website` TINYINT NOT NULL,
  `ad` TINYINT NOT NULL,
  PRIMARY KEY (`hosts_id`, `website`, `ad`),
  INDEX `Web_Hosts_FK_idx` (`website` ASC) VISIBLE,
  INDEX `Ad_Hosts_idx` (`ad` ASC) VISIBLE,
  CONSTRAINT `Web_Hosts_FK`
    FOREIGN KEY (`website`)
    REFERENCES `mydb`.`Website` (`web_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Ad_Hosts`
    FOREIGN KEY (`ad`)
    REFERENCES `mydb`.`Ad` (`ad_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`IT_Sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`IT_Sales` (
  `it_sale_id` TINYINT NOT NULL AUTO_INCREMENT,
  `service_order` TINYINT NOT NULL,
  `sale` TINYINT NOT NULL,
  PRIMARY KEY (`it_sale_id`, `service_order`, `sale`),
  INDEX `Sale_IT_Sales_idx` (`sale` ASC) VISIBLE,
  CONSTRAINT `Service_Order_IT_Sales`
    FOREIGN KEY (`service_order`)
    REFERENCES `mydb`.`IT_Service_Order` (`service_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `Sale_IT_Sales`
    FOREIGN KEY (`sale`)
    REFERENCES `mydb`.`Sale` (`sale_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Subscription_Sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Subscription_Sale` (
  `subscription_sales_id` TINYINT NOT NULL AUTO_INCREMENT,
  `software_as_a_service` TINYINT NOT NULL,
  `sale` TINYINT NOT NULL,
  PRIMARY KEY (`subscription_sales_id`, `software_as_a_service`, `sale`),
  INDEX `Sale_Subscription_Sale_idx` (`sale` ASC) VISIBLE,
  INDEX `Subscription_Subscription_Sale_idx` (`software_as_a_service` ASC) VISIBLE,
  CONSTRAINT `Sale_Subscription_Sale`
    FOREIGN KEY (`sale`)
    REFERENCES `mydb`.`Sale` (`sale_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `Subscription_Subscription_Sale`
    FOREIGN KEY (`software_as_a_service`)
    REFERENCES `mydb`.`Software_As_a_Service` (`software_as_a_service_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Product_Sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product_Sale` (
  `product_sale_id` TINYINT NOT NULL AUTO_INCREMENT,
  `product` TINYINT NOT NULL,
  `sale` TINYINT NOT NULL,
  PRIMARY KEY (`product_sale_id`, `product`, `sale`),
  INDEX `Sale_Product_Sale_idx` (`sale` ASC) VISIBLE,
  INDEX `Product_Product_Sale_FK_idx` (`product` ASC) VISIBLE,
  CONSTRAINT `Sale_Product_Sale_FK`
    FOREIGN KEY (`sale`)
    REFERENCES `mydb`.`Sale` (`sale_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `Product_Product_Sale_FK`
    FOREIGN KEY (`product`)
    REFERENCES `mydb`.`Product` (`product_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Supplies_Tax`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Supplies_Tax` (
  `supplies_tax_id` TINYINT NOT NULL AUTO_INCREMENT,
  `supplies` TINYINT NOT NULL,
  `tax` TINYINT NOT NULL,
  PRIMARY KEY (`supplies_tax_id`, `tax`, `supplies`),
  INDEX `Supplies_Supplies_Tax_FK_idx` (`supplies` ASC) VISIBLE,
  INDEX `Tax_Supplies_Tax_FK_idx` (`tax` ASC) VISIBLE,
  CONSTRAINT `Supplies_Supplies_Tax_FK`
    FOREIGN KEY (`supplies`)
    REFERENCES `mydb`.`Supplies` (`supplies_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Tax_Supplies_Tax_FK`
    FOREIGN KEY (`tax`)
    REFERENCES `mydb`.`Tax` (`tax_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Product_Tax`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product_Tax` (
  `product_tax_id` TINYINT NOT NULL AUTO_INCREMENT,
  `product` TINYINT NOT NULL,
  `tax` TINYINT NOT NULL,
  PRIMARY KEY (`product_tax_id`, `product`, `tax`),
  INDEX `Product_Product_Tax_FK_idx` (`product` ASC) VISIBLE,
  INDEX `Tax_Product_Tax_idx` (`tax` ASC) VISIBLE,
  CONSTRAINT `P_P_Tax_FK`
    FOREIGN KEY (`product`)
    REFERENCES `mydb`.`Product` (`product_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `Tax_Product_Tax`
    FOREIGN KEY (`tax`)
    REFERENCES `mydb`.`Tax` (`tax_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Product_Advertisement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product_Advertisement` (
  `product_advertisement_id` TINYINT NOT NULL AUTO_INCREMENT,
  `product` TINYINT NOT NULL,
  `ad` TINYINT NOT NULL,
  PRIMARY KEY (`product_advertisement_id`, `ad`, `product`),
  INDEX `Product_Product_Ad_FK_idx` (`product` ASC) VISIBLE,
  INDEX `Ad_Product_Ad_FK_idx` (`ad` ASC) VISIBLE,
  CONSTRAINT `Product_Product_Ad_FK`
    FOREIGN KEY (`product`)
    REFERENCES `mydb`.`Product` (`product_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `Ad_Product_Ad_FK`
    FOREIGN KEY (`ad`)
    REFERENCES `mydb`.`Ad` (`ad_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Desk`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Desk` (
  `desk_id` TINYINT NOT NULL AUTO_INCREMENT,
  `employee` TINYINT NOT NULL,
  `computer` TINYINT NOT NULL,
  `office` TINYINT NOT NULL,
  PRIMARY KEY (`desk_id`, `employee`, `office`, `computer`),
  INDEX `Employee_Desk_FK_PK_idx` (`employee` ASC) VISIBLE,
  INDEX `Computer_Desk_FK_PK_idx` (`computer` ASC) VISIBLE,
  INDEX `Office_Desk_FK_PK_idx` (`office` ASC) VISIBLE,
  CONSTRAINT `Employee_Desk_FK_PK`
    FOREIGN KEY (`employee`)
    REFERENCES `mydb`.`Employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Computer_Desk_FK_PK`
    FOREIGN KEY (`computer`)
    REFERENCES `mydb`.`Computer` (`computer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Office_Desk_FK_PK`
    FOREIGN KEY (`office`)
    REFERENCES `mydb`.`Office` (`office_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Employee_Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Employee_Department` (
  `employee_department_id` TINYINT NOT NULL AUTO_INCREMENT,
  `employee` TINYINT NOT NULL,
  `department` TINYINT NOT NULL,
  PRIMARY KEY (`employee_department_id`, `department`, `employee`),
  INDEX `Employee_Employee_Department_FK_PK_idx` (`employee` ASC) VISIBLE,
  INDEX `Department_Employee_Department_idx` (`department` ASC) VISIBLE,
  CONSTRAINT `Employee_Employee_Department_FK_PK`
    FOREIGN KEY (`employee`)
    REFERENCES `mydb`.`Employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Department_Employee_Department`
    FOREIGN KEY (`department`)
    REFERENCES `mydb`.`Department` (`department_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Department_Sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Department_Sale` (
  `department_sale_id` TINYINT NOT NULL AUTO_INCREMENT,
  `department` TINYINT NOT NULL,
  `sale` TINYINT NOT NULL,
  PRIMARY KEY (`department_sale_id`, `department`, `sale`),
  INDEX `Sale_Department_Sale_idx` (`sale` ASC) VISIBLE,
  INDEX `Department_Department_Sale_idx` (`department` ASC) VISIBLE,
  CONSTRAINT `Sale_Department_Sale`
    FOREIGN KEY (`sale`)
    REFERENCES `mydb`.`Sale` (`sale_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Department_Department_Sale`
    FOREIGN KEY (`department`)
    REFERENCES `mydb`.`Department` (`department_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
