-- criação do banco de dados para o cenário E-commerce

CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- criar tabela cliente

CREATE TABLE IF NOT EXISTS clients(
	idClient INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(10),
    Minit CHAR(3),
    Lname VARCHAR(20),
    CPF CHAR(11) NOT NULL,
    Address VARCHAR(300),
    CONSTRAINT unique_cpf_client UNIQUE (cpf)
);
    
ALTER TABLE clients AUTO_INCREMENT=1;
    
-- DESC clients;
    
-- criar tabela produto
    
CREATE TABLE IF NOT EXISTS product(
	idProduct INT AUTO_INCREMENT PRIMARY KEY,
	Pname VARCHAR(30),
	classification_kids BOOL DEFAULT FALSE,
	category ENUM ('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') NOT NULL,
	avaliação FLOAT DEFAULT 0,
    size VARCHAR(10)
);
ALTER TABLE product AUTO_INCREMENT=1;   
-- criar tabela pedido
     
CREATE TABLE IF NOT EXISTS orders(
	idOrder INT AUTO_INCREMENT PRIMARY KEY,
	IdOrderClient INT,
	orderStatus ENUM('Cancelado', 'Confirmado', 'Em processamento') DEFAULT 'Em Processamento',
	orderDescription VARCHAR(255),
	sendValue FLOAT DEFAULT 10,
    paymentCash BOOL DEFAULT FALSE,
    idPayment INT UNIQUE,
    CONSTRAINT fk_orders_client FOREIGN KEY (idOrderClient) REFERENCES clients (idClient)
		ON UPDATE CASCADE
        ON DELETE SET NULL
);

ALTER TABLE orders AUTO_INCREMENT=1;
    
-- DESC orders;
   
-- criar tabela pagamento
    
CREATE TABLE IF NOT EXISTS payments (
    idClient INT,
    idPayment INT,
    typePayment ENUM('Boleto', 'Cartão', 'Dois cartões'),
    limitAvailable FLOAT,
    PRIMARY KEY (idClient , idPayment),
    CONSTRAINT fk_payments_orders FOREIGN KEY (idPayment) REFERENCES orders (idPayment)
);   
    
-- criar tabela estoque
    
CREATE TABLE IF NOT EXISTS productStorage (
    idProdStorage INT AUTO_INCREMENT PRIMARY KEY,
    storageLocation VARCHAR(255),
    quantity INT DEFAULT 0
);

ALTER TABLE productStorage AUTO_INCREMENT=1;
-- DESC productStorage;
    
-- criar tabela fornecedor
    
CREATE TABLE IF NOT EXISTS supplier(
	idSupplier INT AUTO_INCREMENT PRIMARY KEY,
	socialName VARCHAR(255),
	CNPJ CHAR(15) NOT NULL,
    contact CHAR(11) NOT NULL,
    CONSTRAINT unique_supplier UNIQUE (CNPJ)
	);

ALTER TABLE supplier AUTO_INCREMENT=1;   
 
-- criar tabela vendedor
    
CREATE TABLE IF NOT EXISTS seller(
	idSeller INT AUTO_INCREMENT PRIMARY KEY,
	socialName VARCHAR(255),
    AbstName VARCHAR (255),
	CNPJ CHAR(15),
    CPF CHAR(9),
    location VARCHAR(255),
    contact CHAR(11) NOT NULL,
    CONSTRAINT unique_cnpj_seller UNIQUE (CNPJ),
    CONSTRAINT unique_cpf_seller UNIQUE (CPF)
);

ALTER TABLE seller AUTO_INCREMENT=1;     

-- criar tabela produto/vendedor
    
CREATE TABLE IF NOT EXISTS productSeller(
	idPSeller INT,
	idProduct INT,
    prodQuantity INT DEFAULT 1,
    PRIMARY KEY (idPseller, idProduct),
    CONSTRAINT fk_product_seller FOREIGN KEY (idPseller) REFERENCES seller(idSeller),
    CONSTRAINT fk_product_product FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);

CREATE TABLE productOrder(
		idPOproduct INT,
        idPOorder INT,
        poQuantity INT DEFAULT 1,
        poStatus ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
        PRIMARY KEY (idPOproduct, idPOorder),
		CONSTRAINT fk_productorder_seller FOREIGN KEY (idPOproduct) REFERENCES product(idProduct),
		CONSTRAINT fk_productorder_product FOREIGN KEY (idPOorder) REFERENCES orders(idOrder)
);

CREATE TABLE storageLocation(
	idLproduct INT,
    idLstorage INT,
    location VARCHAR(255) NOT NULL,
    PRIMARY KEY (idLproduct, idLstorage),
    CONSTRAINT fk_storage_location_product FOREIGN KEY (idLproduct) REFERENCES product(idProduct),
    CONSTRAINT fk_storage_location_storage FOREIGN KEY (idLstorage) REFERENCES productStorage(idProdStorage)
);

CREATE TABLE IF NOT EXISTS productSupplier(
	idPsSupplier INT,
    idPsProduct INT,
    quantity INT NOT NULL,
    PRIMARY KEY (idPsSupplier, idPsProduct),
    CONSTRAINT fk_product_supplier_supplier FOREIGN KEY (idPsSupplier) REFERENCES supplier(idSupplier),
    CONSTRAINT fk_product_supplier_product FOREIGN KEY (idPsProduct) REFERENCES product(idProduct)
);
 -- SHOW TABLES; 
 -- SHOW DATABASES;
 -- USE information_schema;
 -- SHOW TABLES;
 -- DESC REFERENTIAL_CONSTRAINTS;
 -- SELECT * FROM REFERENTIAL_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = 'ecommerce';
