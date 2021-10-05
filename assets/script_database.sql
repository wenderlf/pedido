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


INSERT INTO `controle_pedido`.`cliente` 
       (`nome`,`cidade`, `uf`)
VALUES
       ('ANDRE SOUZA', 'GOIÂNIA', 'GO'),
       ('PAULO AUGUSTO', '', 'GO'),
       ('MARIA PAULA', 'GOIANÉSIA', 'GO'),
       ('AMÉLIA SANTOS', 'ANÁPOLIS', 'GO'),
       ('CÁSSIA MARIA', 'SÃO PAULO', 'SP'),
       ('ANA MARTINS', 'MONTE APRAZÍVEL', 'SP'),
       ('JOSÉ ALVES', 'FLORIANÓPOLIS', 'SC'),
       ('JOÃO DAMACENO', 'BLUMENAU', 'SC'),
       ('PEDRO MODESTO', 'NITERÓI', 'RJ'),
       ('LUZIA PEREIRA', 'RIO DE JANEIRO', 'RJ'),
       ('AFONSO CARDOSO', 'FORTALEZA', 'CE'),
       ('JOÃO JOSÉ SILVA', 'MANAUS', 'AM'),
       ('CLÁUDIO MARCIANO', 'GOIANÉSIA', 'GO'),
       ('LUISA NEVES', 'GOIANÉSIA', 'GO'),
       ('FLÁVIA TAVARES', 'ANÁPOLIS', 'GO'),
       ('CARLOS MARIANO', 'ANÁPOLIS', 'GO'),
       ('LOURDES APARECIDA', 'GOIÂNIA', 'GO'),
       ('KÁSSIA AMARAL', 'GOIÂNIA', 'GO'),
       ('AUGUSTO TELLES', 'GOIÂNIA', 'GO'),
       ('PEDRO SILVA', 'GOIÂNIA', 'GO');

INSERT INTO `controle_pedido`.`produto` 
       (`descricao`,`preco_venda`)
VALUES
       ('CHICLETE', '0.10'),
       ('HALLS CEREJA', '1.19'),
       ('CHOCOLATE MEIO AMARGO', '0.50'),
       ('CHOCOLATE', '0.49'),
       ('CAIXA DE CHOCOLATE', '5.99'),
       ('PIRULITO SABOR MORANGO', '1.99'),
       ('PIRULITO SABOR UVA', '1.99'),
       ('PACOTE DE BALAS DE GOMA', '2.19'),
       ('CAIXA DE CHICLETE', '8.00'),
       ('DOCE DE LEITE EM BARRA', '3.00'),
       ('ÁGUA MINERAL', '1.49'),
       ('CHOCOLATE BRANCO', '0.60'),
       ('POTE DE SORVETE', '9.99'),
       ('AÇAÍ 300GR', '8.99'),
       ('TRIDENT EXTRA FORTE', '0.99'),
       ('DADINHO SABOR CHOCOLATE E CARAMELO', '1.50'),
       ('SUCO SABOR LARANJA', '2.20'),
       ('SUCO SABOR UVA', '3.10'),
       ('BALA SABOR CARAMELO', '0.80'),
       ('PICOLÉ SABOR CHOCOLATE', '4.00');
