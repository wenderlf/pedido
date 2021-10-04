CREATE SCHEMA `controle_pedido` DEFAULT CHARACTER SET utf8;

CREATE TABLE `controle_pedido`.`cliente` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `cidade` VARCHAR(50) NOT NULL,
  `uf` CHAR(2) NOT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE `controle_pedido`.`produto` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(100) NOT NULL,
  `preco_venda` DOUBLE NOT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE `controle_pedido`.`pedido` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `data_emissao` DATETIME NOT NULL,
  `codigo_cliente` INT NOT NULL,
  `valor_total` DOUBLE NOT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE `controle_pedido`.`produto_pedido` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `codigo_pedido` INT NOT NULL,
  `codigo_produto` INT NOT NULL,
  `quantidade` DOUBLE NOT NULL,
  `valor_unitario` DOUBLE NOT NULL,
  `valor_total` DOUBLE NOT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

ALTER TABLE `controle_pedido`.`cliente` 
ADD UNIQUE INDEX `cliente_nome_unq` (`nome` ASC) VISIBLE;

ALTER TABLE `controle_pedido`.`produto` 
ADD UNIQUE INDEX `produto_descricao_unq` (`descricao` ASC) VISIBLE;

ALTER TABLE `controle_pedido`.`pedido` 
ADD INDEX `fk_cliente_pedido_idx` (`codigo_cliente` ASC) VISIBLE;

ALTER TABLE `controle_pedido`.`pedido` 
ADD CONSTRAINT `fk_cliente_pedido`
  FOREIGN KEY (`codigo_cliente`)
  REFERENCES `controle_pedido`.`cliente` (`codigo`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `controle_pedido`.`produto_pedido` 
ADD INDEX `fk_pedido_produto_pedido_idx` (`codigo_pedido` ASC) VISIBLE;

ALTER TABLE `controle_pedido`.`produto_pedido` 
ADD CONSTRAINT `fk_pedido_produto_pedido`
  FOREIGN KEY (`codigo_pedido`)
  REFERENCES `controle_pedido`.`pedido` (`codigo`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
ALTER TABLE `controle_pedido`.`produto_pedido` 
ADD INDEX `fk_produto_produto_pedido_idx` (`codigo_produto` ASC) VISIBLE;

ALTER TABLE `controle_pedido`.`produto_pedido` 
ADD CONSTRAINT `fk_produto_produto_pedido`
  FOREIGN KEY (`codigo_produto`)
  REFERENCES `controle_pedido`.`produto` (`codigo`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
