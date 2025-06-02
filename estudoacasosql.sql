


CREATE DATABASE supermercado_db;


USE supermercado_db;


CREATE TABLE tbl_CATEGORIA (
    id_categoria int not null primary key auto_increment, 
    nome_categoria VARCHAR(50) NOT NULL UNIQUE   
);

CREATE TABLE tbl_FORNECEDOR (
    id_fornecedor int not null primary key auto_increment, 
    nome_fornecedor VARCHAR(100) NOT NULL,        
    contato_fornecedor VARCHAR(100),              
    telefone_fornecedor VARCHAR(20)               
);

CREATE TABLE tbl_COLABORADOR (
    id_colaborador int not null primary key auto_increment,           
    cpf_colaborador VARCHAR(14) NOT NULL UNIQUE,             
    nome VARCHAR(50) NOT NULL,                                             
    cargo VARCHAR(50),                                       
    data_contratacao DATE NOT NULL                           
);

CREATE TABLE tbl_COLABORADOR_TELEFONE (
    id_telefone_colaborador int not null primary key auto_increment, 
    id_colaborador_fk INT NOT NULL,                         
    numero_telefone VARCHAR(20) NOT NULL,                   
    

    UNIQUE (id_colaborador_fk, numero_telefone), 


    FOREIGN KEY (id_colaborador_fk) REFERENCES tbl_COLABORADOR(id_colaborador)
        ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE tbl_CLIENTE (
    id_cliente int not null primary key auto_increment,            
    cpf_cliente VARCHAR(14) UNIQUE,                       
	nome VARCHAR(50),                                                                                         
    rua VARCHAR(100),                                    
    numero VARCHAR(10),                                   
    complemento VARCHAR(50),                              
    bairro VARCHAR(50),                                   
    cidade VARCHAR(50),                                   
    estado CHAR(2),                                       
    cep VARCHAR(9),                                       
    idade DATE                                  
);

CREATE TABLE tbl_CLIENTE_TELEFONE (
    id_telefone_cliente int not null primary key auto_increment,     
    id_cliente_fk INT NOT NULL,                             
    numero_telefone VARCHAR(20) NOT NULL,                   
    
    UNIQUE (id_cliente_fk, numero_telefone), 


    FOREIGN KEY (id_cliente_fk) REFERENCES tbl_CLIENTE(id_cliente)
);

CREATE TABLE tbl_PRODUTO (
	id_produto int not null primary key auto_increment,             
    codigo_barras VARCHAR(13) NOT NULL UNIQUE,             
    nome_produto VARCHAR(45) NOT NULL,                    
    preco_venda DECIMAL(10, 2) NOT NULL, 
    quantidade_estoque INT NOT NULL,                
    
    id_categoria_fk INT NOT NULL,                          
    id_fornecedor_fk INT NOT NULL,                         
    

    FOREIGN KEY (id_categoria_fk) REFERENCES tbl_CATEGORIA(id_categoria),
    
    FOREIGN KEY (id_fornecedor_fk) REFERENCES tbl_FORNECEDOR(id_fornecedor)
);


CREATE TABLE tbl_VENDA (
    id_venda int not null primary key auto_increment,                  
    data_hora_venda DATETIME NOT NULL,                       
    forma_pagamento VARCHAR(50) NOT NULL,                                                                     
    
    id_colaborador_fk INT NOT NULL,                           
    id_cliente_fk INT,                                        
    
   
    FOREIGN KEY (id_colaborador_fk) REFERENCES tbl_COLABORADOR(id_colaborador),
    
    FOREIGN KEY (id_cliente_fk) REFERENCES tbl_CLIENTE(id_cliente)
);


CREATE TABLE tbl_ITEM_VENDA (
    id_item_vendaint int not null primary key auto_increment,       
    
    id_venda_fk INT NOT NULL,                           
    id_produto_fk INT NOT NULL,                         
    
    quantidade_vendida INT NOT NULL, 
    preco_unitario_na_venda DECIMAL(10, 2) NOT NULL, 
    
    
    UNIQUE (id_venda_fk, id_produto_fk), 

    
    FOREIGN KEY (id_venda_fk) REFERENCES tbl_VENDA(id_venda)
        ON DELETE CASCADE ON UPDATE CASCADE,
    
    FOREIGN KEY (id_produto_fk) REFERENCES tbl_PRODUTO(id_produto)
        ON DELETE RESTRICT ON UPDATE CASCADE
);


INSERT INTO tbl_CATEGORIA (nome_categoria) VALUES
('Frutas, Verduras e Legumes'),
('Laticínios e Frios'),
('Padaria'),
('Bebidas'),
('Limpeza'),
('Higiene Pessoal'),
('Congelados');

INSERT INTO tbl_FORNECEDOR (nome_fornecedor, contato_fornecedor, telefone_fornecedor) VALUES
('Verde Vida Alimentos', 'Ana Paula', '11987654321'),  
('Laticínios do Campo', 'João Silva', '21998765432'),   
('Pães Delícia Ltda', 'Maria Oliveira', '31987651234'), 
('Dist. de Bebidas Sol', 'Carlos Pereira', '41998761234'), 
('Limpeza Total SA', NULL, '51987659876');             


INSERT INTO tbl_COLABORADOR (cpf_colaborador, nome, cargo, data_contratacao) VALUES
('123.456.789-00', 'Pedro', 'Caixa', '2022-03-15'),
('987.654.321-00', 'Ana', 'Gerente', '2020-01-10'),
('456.789.123-00', 'Lucas', 'Repositor', '2023-06-01');

INSERT INTO tbl_COLABORADOR_TELEFONE (id_colaborador_fk, numero_telefone) VALUES
(1, '11987654321'),
(1, '1133334444'),
(2, '21998765432');

INSERT INTO tbl_CLIENTE (cpf_cliente, nome, rua, numero, bairro, cidade, estado, cep, idade) VALUES
('111.222.333-44', 'Mariana', 'Rua das Flores', '123', 'Centro', 'São Paulo', 'SP', '01000-000', '1990-05-20'),
('555.666.777-88', 'Roberto', 'Av. Principal', '456', 'Jardim', 'Rio de Janeiro', 'RJ', '20000-000', '1985-11-10'),
(NULL, 'Cliente', 'Não Identificado', NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO tbl_CLIENTE_TELEFONE (id_cliente_fk, numero_telefone) VALUES
(1, '11999998888'),
(1, '1122221111'),
(2, '21977776666');

INSERT INTO tbl_PRODUTO (codigo_barras, nome_produto, preco_venda, quantidade_estoque, id_categoria_fk, id_fornecedor_fk) VALUES
('7891234567890', 'Maçã Brasileira', 9.90, 100, 1, 1),
('7890987654321', 'Leite Integral 1L', 2.80, 200, 2, 2),
('7891122334455', 'Pão Francês KG', 12.00, 50, 3, 3),
('7895544332211', 'Refrigerante Cola 2L', 7.00, 150, 4, 4),
('7890001112233', 'Detergente Líquido', 3.50, 80, 5, 5),
('7896655443322', 'Sabonete Glicerinado', 2.80, 120, 6, 5),
('7891112223344', 'Sorvete Creme 1L', 25.00, 40, 7, 2);


INSERT INTO tbl_VENDA (data_hora_venda, forma_pagamento, id_colaborador_fk, id_cliente_fk) VALUES
('2025-05-31 09:30:00', 'Débito', 1, 1),
('2025-05-31 10:15:00', 'Crédito', 1, 2),
('2025-05-31 11:00:00', 'Dinheiro', 3, 3), 
('2025-05-31 11:30:00', 'Pix', 2, 1);


INSERT INTO tbl_ITEM_VENDA (id_venda_fk, id_produto_fk, quantidade_vendida, preco_unitario_na_venda) VALUES
(1, 1, 1.0, 9.90),  
(1, 2, 2.0, 4.50),  
(2, 3, 0.5, 12.00), 
(2, 4, 1.0, 7.00),  
(3, 5, 3.0, 3.50),  
(4, 1, 0.8, 9.90);


show tables;
select * from tbl_venda;
select codigo_barras from tbl_produto;
select id_categoria, nome_categoria from tbl_categoria;

#drop database supermercado_db;

