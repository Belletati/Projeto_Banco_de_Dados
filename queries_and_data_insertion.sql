-- inserção de dados e queries
USE ecommerce;

SHOW TABLES;

DESC clients;

INSERT INTO clients (Fname, Minit, Lname, CPF, Address) VALUES
							('Maria','M','Silva', 12346789, 'rua silva de prata 29, Carangola - Cidade das flores'),
							('Matheus','O','Pimentel', 987654321,'rua alemeda 289, Centro - Cidade das flores'),
							('Ricardo','F','Silva', 45678913,'avenida alemeda vinha 1009, Centro - Cidade das flores'),
							('Julia','S','França', 789123456,'rua lareijras 861, Centro - Cidade das flores'),
							('Roberta','G','Assis', 98745631,'avenidade koller 19, Centro - Cidade das flores'),
							('Isabela','M','Cruz', 654789123,'rua alemeda das flores 28, Centro - Cidade das flores');


INSERT INTO product (Pname, classification_kids, category, avaliação, size) VALUES
							('Fone de ouvido', FALSE,'Eletrônico','4', NULL),
							('Barbie Elsa', TRUE,'Brinquedos','3', NULL),
							('Body Carters', TRUE,'Vestimenta','5', NULL),
							('Microfone Vedo - Youtuber', FALSE,'Eletrônico','4', NULL),
							('Sofá retrátil', FALSE,'Móveis','3','3x57x80'),
							('Farinha de arroz', FALSE,'Alimentos','2', NULL),
							('Fire Stick Amazon', FALSE,'Eletrônico','3', NULL);

SELECT * FROM clients;
SELECT * FROM product;


-- DELETE FROM orders WHERE idOrderClient IN (1,2,3,4);
INSERT INTO orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) VALUES 
							 (1, DEFAULT,'compra via aplicativo', NULL, 1),
                             (2, DEFAULT,'compra via aplicativo', 50, 0),
                             (3,'Confirmado', NULL, NULL, 1),
                             (4, DEFAULT,'compra via web site', 150, 0);
					
SELECT * FROM orders;


INSERT INTO productOrder (idPOproduct, idPOorder, poQuantity, poStatus) VALUES
							(1, 2, 2, NULL),
							(2, 2, 1, NULL),
							(3, 1, 1, NULL);


INSERT INTO productStorage (storageLocation,quantity) VALUES 
							('Rio de Janeiro', 1000),
                            ('Rio de Janeiro', 500),
                            ('São Paulo', 10),
                            ('São Paulo', 100),
                            ('São Paulo', 10),
                            ('Brasília', 60);


INSERT INTO storageLocation (idLproduct, idLstorage, location) VALUES
							(1, 2, 'RJ'),
							(2, 6, 'GO');


INSERT INTO supplier (SocialName, CNPJ, contact) VALUES 
							('Almeida e filhos', 123456789123456,'21985474'),
                            ('Eletrônicos Silva',854519649143457,'21985484'),
                            ('Eletrônicos Valma', 934567893934695,'21975474');
                            
SELECT * FROM supplier;

INSERT INTO productSupplier (idPsSupplier, idPsProduct, quantity) VALUES
							(1, 1, 500),
							(1, 2, 400),
							(2, 4, 633),
							(3, 3, 5),
							(2, 5, 10);


INSERT INTO seller (SocialName, AbstName, CNPJ, CPF, location, contact) VALUES 
							('Tech eletronics', NULL, 123456789456321, NULL, 'Rio de Janeiro', 219946287),
							('Botique Durgas', NULL, NULL, 123456783, 'Rio de Janeiro', 219567895),
							('Kids World', NULL, 456789123654485, NULL, 'São Paulo', 1198657484);

SELECT * FROM seller;
DESC productSeller;

INSERT INTO productSeller (idPseller, idProduct, prodQuantity) VALUES 
							(1, 6, 80),
							(2, 7, 10);
-- queries SQL

SELECT * FROM productSeller;
SELECT COUNT(*) FROM clients;
SELECT * FROM clients c, orders o WHERE c.idClient = idOrderClient;
SELECT Fname,Lname, idOrder, orderStatus FROM clients c, orders o WHERE c.idClient = idOrderClient;
SELECT CONCAT(Fname,' ',Lname) AS Client, idOrder AS Request, orderStatus AS Status FROM clients c, orders o WHERE c.idClient = idOrderClient;
INSERT INTO orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) VALUES 
							 (2, DEFAULT, 'compra via aplicativo', NULL, 1);
SELECT COUNT(*) FROM clients c, orders o 
			WHERE c.idClient = idOrderClient;
SELECT * FROM orders
			WHERE idOrder <= 3
            ORDER BY IdOrderClient DESC;

-- recuperação de pedido com produto associado
SELECT * FROM clients c 
			INNER JOIN orders o ON c.idClient = o.idOrderClient
			INNER JOIN productOrder p ON p.idPOorder = o.idOrder;
SELECT c.idClient, Fname, COUNT(*) AS Number_of_orders FROM clients c 
			LEFT JOIN orders o ON c.idClient = o.idOrderClient
			GROUP BY idClient
            HAVING Number_of_orders > 1;
            
-- Quantos pedidos foram realizados pelos clientes?
SELECT c.idClient, Fname, COUNT(*) AS Number_of_orders FROM clients c 
			INNER JOIN orders o ON c.idClient = o.idOrderClient
			GROUP BY idClient;
            
            