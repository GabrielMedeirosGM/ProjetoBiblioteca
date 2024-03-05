/* Criação do Schema */ 

CREATE SCHEMA BIBLIOTECA;

/* entrar no schema criado */
USE BIBLIOTECA;

/*Tabelas */

CREATE TABLE LIVROS ( 
ID_LIVRO INT NOT NULL, 
NOME_LIVRO VARCHAR(100) NOT NULL,
AUTORIA VARCHAR(100) NOT NULL,
EDITORA VARCHAR(100) NOT NULL,
CATEGORIA VARCHAR(100) NOT NULL,
PREÇO DECIMAL(5,2) NOT NULL,

PRIMARY KEY (ID_LIVRO)
);

CREATE TABLE ESTOQUE (
    ID_LIVRO INT NOT NULL,
    QTD_ESTOQUE INT NOT NULL,
 PRIMARY KEY (ID_LIVRO)
);

CREATE TABLE VENDAS (
    ID_PEDIDO INT NOT NULL,
    ID_VENDEDOR INT NOT NULL,
    ID_LIVRO INT NOT NULL,
    QTD_VENDIDA INT NOT NULL,
    DATA_VENDA DATE NOT NULL,
 PRIMARY KEY (ID_VENDEDOR,ID_PEDIDO)
);

CREATE TABLE VENDEDORES (
    ID_VENDEDOR INT NOT NULL,
    NOME_VENDEDOR VARCHAR(255) NOT NULL,
 PRIMARY KEY (ID_VENDEDOR)
);

/*Relação das Tabelas - Chave Estrangeira*/

ALTER TABLE ESTOQUE ADD CONSTRAINT CE_ESTOQUE_LIVROS
FOREIGN KEY (ID_LIVRO) 
REFERENCES LIVROS (ID_LIVRO)
ON DELETE NO ACTION /* IRÁ GERAR UM ERRO QUANDO ALTERAR UM LIVRO NA TABELA MAS NAO ESTIVER REGISTRADO NA TABELA LIVROS */
ON UPDATE NO ACTION; /* IRÁ GERAR UM ERRO QUANDO ALTERAR UM LIVRO NA TABELA MAS NAO ESTIVER REGISTRADO NA TABELA LIVROS */

ALTER TABLE VENDAS ADD CONSTRAINT CE_VENDAS_LIVROS
FOREIGN KEY (ID_LIVRO)
REFERENCES LIVROS (ID_LIVRO)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE VENDAS ADD CONSTRAINT CE_VENDAS_VENDEDORES
FOREIGN KEY (ID_VENDEDOR)
REFERENCES VENDEDORES (ID_VENDEDOR)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Desativar CE para inserir dados */ 

SET FOREIGN_KEY_CHECKS = 0; /* Comando possibila desativar as relações das tabelas, também desativando as chaves estrangeiras ( CE ) */


/* INSERINDO DADOS - INSERT */ 

INSERT INTO LIVROS VALUES( 
1, 
"Percy Jacson e o Ladrão de Raiso",
"Rick Riordan",
"Intrínseca", 
"Aventura",
"34.65");

INSERT INTO LIVROS VALUES
(2,    'A Volta ao Mundo em 80 Dias',    'Júlio Verne',         'Principis',     'Aventura',    21.99),
(3,    'O Cortiço',                     'Aluísio de Azevedo',  'Panda Books',   'Romance',    47.8),
(4,    'Dom Casmurro',                     'Machado de Assis',    'Via Leitura',   'Romance',    19.90),
(5,    'Memórias Póstumas de Brás Cubas',    'Machado de Assis',    'Antofágica',    'Romance',    45),
(6,    'Quincas Borba',                 'Machado de Assis',    'L&PM Editores', 'Romance',    48.5),
(7,    'Ícaro',                             'Gabriel Pedrosa',     'Ateliê',          'Poesia',    36),
(8,    'Os Lusíadas',                     'Luís Vaz de Camões',  'Montecristo',   'Poesia',    18.79),
(9,    'Outros Jeitos de Usar a Boca',    'Rupi Kaur',          'Planeta',          'Poesia',    34.8);

INSERT INTO VENDEDORES 
VALUES
(1,'Paula Rabelo'),
(2,'Juliana Macedo'),
(3,'Roberto Barros'),
(4,'Barbara Jales');

INSERT INTO VENDAS 
VALUES 
(1, 3, 7, 1, '2020-11-02'),
(2, 4, 8, 2, '2020-11-02'),
(3, 4, 4, 3, '2020-11-02'),
(4, 1, 7, 1, '2020-11-03'),
(5, 1, 6, 3, '2020-11-03'),
(6, 1, 9, 2, '2020-11-04'),
(7, 4, 1, 3, '2020-11-04'),
(8, 1, 5, 2, '2020-11-05'),
(9, 1, 2, 1, '2020-11-05'),
(10, 3, 8, 2, '2020-11-11'),
(11, 1, 1, 4, '2020-11-11'),
(12, 2, 10, 10, '2020-11-11'),
(13, 1, 12, 5, '2020-11-18'),
(14, 2, 4, 1, '2020-11-25'),
(15, 3, 13, 2,'2021-01-05'),
(16, 4, 13, 1, '2021-01-05'),
(17, 4, 4, 3, '2021-01-06'),
(18, 2, 12, 2, '2021-01-06');

INSERT INTO ESTOQUE 
VALUES
(1,  7),
(2,  10),
(3,  2),
(8,  4),
(10, 5),
(11, 3),
(12, 3);


/* Inserindo valores fora de ordem */ 
/*valores inseridos estão de forma incorreta ao banco */ 
INSERT INTO LIVROS
VALUES ('Biografia' , 'Anne Frank', 'Diário de Anne Frank' , 'Pe da Letra', 12, 34.90); /*valores inseridos estão de forma incorreta ao banco*/ 

INSERT INTO LIVROS /* definir no INSER INTO as ordem das tabelas corretas como definição, apos definir, jogar os valores de forma correta. Assim corrigindo o seu código. */
(CATEGORIA, AUTORIA, NOME_LIVRO, EDITORA, ID_LIVRO, PREÇO)
VALUES
('Biografia' ,	'Malala Yousafzai', 'Eu sou Malala'       , 'Companhia das Letras', 11, 22.32),
('Biografia' ,	'Michelle Obama'  , 'Minha história'      , 'Objetiva'            ,	12,	57.90),
('Biografia' ,	'Anne Frank'      , 'Diário de Anne Frank', 'Pe Da Letra'         , 13, 34.90);

/* Ativando novamente a relações entre as tabelas, chave estrangeira. */
SET FOREIGN_KEY_CHECKS = 1;


/* Consulta de dados - SELECT * FROM */

SELECT NOME_LIVRO FROM LIVROS;

SELECT ID_LIVRO AS "Código do Livro" FROM LIVROS; /* Nomeando a coluna */ 

/* Filtrando com SELECT E WHERE */

SELECT * FROM LIVROS
WHERE CATEGORIA = "BIOGRAFIA"; /* ESTA FILTRANDO NA TABELA LIVROS, QUANTOS LIVROS EXISTE DA CATEGORIA - BIOGRAFIA

#DESAFIOS

#1. Crie uma tabela com os romances que custam menos de 48 reais. */

SELECT * FROM LIVROS
WHERE CATEGORIA = "ROMANCE"
AND /* ADICIONA UMA CONDIÇÃO PARA A CONSULTA */ 
PREÇO <48;

#2. Poesias que não são nem de Luís Vaz de Camões nem de Gabriel Pedrosa. */
SELECT * FROM LIVROS
WHERE CATEGORIA = "POESIA" AND NOT (AUTORIA ="Luís Vaz de Camões" OR AUTORIA ="Gabriel Pedrosa");
 /* USAMOS AND NOT PARA DESCREVER QUE NAO QUEREMOS, DEPOIS DEFINIMOS O NOME DA TABELA (AUTORIA = NOME DO AUTOR) OR (AUTORIA = NOME DO AUTOR 2 )
 /* OR = OU, COMPLEMENTANDO O COMANDO DO JEITO QUE FOI PEDIDO. Adicionando mais definições */ 
 
#3. Seleção única dos livros - DISTINCT */
SELECT DISTINCT ID_LIVRO FROM VENDAS;

#4. Apenas os livros que foram vendidos pelo vendedor 1 */
SELECT DISTINCT ID_LIVRO FROM VENDAS
WHERE ID_VENDEDOR = 1
ORDER BY ID_LIVRO; /* ordena de forma alfabetica e numerica */

/*Alterando Informações */ 

#1 Exlusão dos Lusídas */

DELETE FROM LIVROS WHERE ID_LIVRO = 8; 

#2 Todos os livros estão com 10% de desconto */ 

UPDATE LIVROS SET PREÇO = 0.9* PREÇO; 

/* Verificando as ALTERAÇOES */

SELECT * FROM LIVROS; 

/* CRIANDO A CONSULTA UNINDO CAMPOS DE TABELAS DIFERENTE */

#1 Queremos o ID do vendedor, nome do Vendedor, Quantidade de vendas */ 
/*COM SELECT */
SELECT VENDAS.ID_VENDEDOR, VENDEDORES.NOME_VENDEDOR, SUM(VENDAS.QTD_VENDIDA) /* SUM= Soma ou agrupa todas as vendas do vendedor */
FROM VENDAS, VENDEDORES 
WHERE  VENDAS.ID_VENDEDOR = VENDEDORES.ID_VENDEDOR
GROUP BY VENDAS.ID_VENDEDOR; /*ADICIONAR O AGRUPAMENTO PELO VENDEDOR  */

/*COM INNER JOIN */

SELECT VENDAS.ID_VENDEDOR, VENDEDORES.NOME_VENDEDOR, SUM(VENDAS.QTD_VENDIDA) /* SUM= Soma ou agrupa todas as vendas do vendedor */
FROM VENDAS INNER JOIN VENDEDORES 
ON VENDAS.ID_VENDEDOR = VENDEDORES.ID_VENDEDOR
GROUP BY VENDAS.ID_VENDEDOR;

#TODOS OS LIVROS DA NOSSA BASE DE DADOS FORAM VENDIDOS? */
		/*LEFT JOIN E RIGHT JOIN */
SELECT LIVROS.NOME_LIVRO, 
		VENDAS.QTD_VENDIDA
FROM LIVROS LEFT JOIN VENDAS 
ON LIVROS.ID_LIVRO = VENDAS.ID_LIVRO
WHERE VENDAS.QTD_VENDIDA IS NULL; 

SELECT VENDAS.ID_LIVRO,
LIVROS.NOME_LIVRO, 
VENDAS.QTD_VENDIDA
FROM LIVROS RIGHT JOIN VENDAS 
ON LIVROS.ID_LIVRO = VENDAS.ID_LIVRO


