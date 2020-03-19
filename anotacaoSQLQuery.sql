--use AdventureWorks2017;
-------------------------------------------------
--SELECT: selecionar campos de coluna(s)

SELECT * 
FROM Person.Person;

SELECT Title 
FROM Person.Person;

SELECT FirstName, LastName
FROM Person.Person;
-------------------------------------------------
--DISTINCT: selecionar campos de coluna(s) sem valores repetidos

SELECT DISTINCT FirstName
FROM Person.Person;

SELECT DISTINCT LastName
FROM Person.Person;
-------------------------------------------------
--WHERE: adiciona uma condição

SELECT *
FROM Person.Person
WHERE FirstName ='Eduardo';

SELECT *
FROM Person.Person
WHERE FirstName ='Eduardo' and LastName = 'Adams';

SELECT *
FROM Person.Person
WHERE FirstName ='Eduardo' or FirstName = 'Ken';
-------------------------------------------------
--COUNT: traz um conjunto de linhas que estão de acordo com a condição

SELECT COUNT(*)
FROM Person.Person;

SELECT COUNT(DISTINCT FirstName)
FROM Person.Person;
-------------------------------------------------
--TOP: procura só os primeiros campos da tabela

SELECT TOP 10 *
FROM Person.Person;

SELECT TOP 10 FirstName
FROM Person.Person;
-------------------------------------------------
--ORDER BY: ordena os resultados de forma crescente ou decrescente

SELECT *
FROM Person.Person
ORDER BY FirstName asc;

SELECT *
FROM Person.Person
ORDER BY FirstName desc;

SELECT *
FROM Person.Person
ORDER BY FirstName asc, LastName desc;
-------------------------------------------------
--BETWEEN: é usado para encontrar ou não buscar(NOT) o valor entre um valor mínimo e valor máximo

SELECT *
FROM Production.Product
WHERE ListPrice BETWEEN 1000 and 1500;

SELECT *
FROM Production.Product
WHERE ListPrice NOT BETWEEN 1000 and 1500;
-------------------------------------------------
--IN: usado junto com WHERE, para verificar se o valor correspondem com qualquer valor passado na lista de valores

SELECT *
FROM Person.Person
WHERE BusinessEntityID IN (2,7,13);

SELECT *
FROM Person.Person
WHERE BusinessEntityID NOT IN (2,7,13);
-------------------------------------------------
--LIKE: pesquisa com uma string incompleta na tabela

--começa com a palavra
SELECT *
FROM Person.Person
WHERE FirstName LIKE 'Fran%';

--termina com a palavra
SELECT *
FROM Person.Person
WHERE FirstName LIKE '%ardo';

--tenha a palavra em qualquer lugar
SELECT *
FROM Person.Person
WHERE FirstName LIKE '%essa%';

--também usa _ para limitar o caracter, um _ equivale 1 caracter

--procura um caracter antes da palavra 'du' e procura caracteres ilimitados depois da palavra
SELECT *
FROM Person.Person
WHERE FirstName LIKE '_du%';

--procura caracteres ilimitados antes da palavra 'du' e procura um caracter depois da palavra
SELECT *
FROM Person.Person
WHERE FirstName LIKE '%ard_';
-------------------------------------------------
--AS: renomeia as colunas ou nomeia colunas criadas a partir de pesquisas

--Renomeia colunas
SELECT FirstName AS PrimeiroNome
FROM Person.Person;

SELECT FirstName AS 'PrimeiroNome'
FROM Person.Person;

SELECT FirstName AS 'Primeiro Nome'
FROM Person.Person;

--Dá nome para uma nova coluna
SELECT COUNT(FirstName) AS 'Primeiro Nome'
FROM Person.Person;

-------------------------------------------------
--MIN(mínimo) MAX(máximo) SUM(soma) AVG(média): 
--agregam ou combinam dados em uma tabela

SELECT TOP 10 SUM(LineTotal)
FROM Sales.SalesOrderDetail;

SELECT TOP 10 MIN(LineTotal)
FROM Sales.SalesOrderDetail;

SELECT TOP 10 MAX(LineTotal)
FROM Sales.SalesOrderDetail;

SELECT TOP 10 AVG(LineTotal)
FROM Sales.SalesOrderDetail;
-------------------------------------------------
--GROUP BY: divide o resultado da sua pesquisa em grupos

SELECT SpecialOfferID, SUM(UnitPrice) AS Grupo
FROM Sales.SalesOrderDetail
GROUP BY SpecialOfferID;

SELECT FirstName, COUNT(FirstName) AS CONTAGEM
FROM Person.Person
GROUP BY FirstName;
--Agrupou as informações iguais da coluna SpecialOfferID e somou a coluna UnitPrice e colocou em uma nova coluna com o nome 'soma'
--------------------------------------------------
--HAVING: usado para juntar o GROUP BY para filtrar resultados de um agrupamento

SELECT ProductID, COUNT(ProductID) AS TOTAL, AVG(LineTotal) AS MEDIA
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING ProductID > 900
ORDER BY ProductID;

--Diferença entre HAVING e WHERE: HAVING é aplicado depois que os dados ja foram agrupados, enquanto o WHERE é aplicado antes do agrupamento
SELECT FirstName, COUNT(FirstName) AS QUANTIDADE
FROM Person.Person
WHERE Title = 'Mr.'
GROUP BY FirstName
HAVING COUNT(FirstName) > 10;
--------------------------------------------------
--JOIN: puxa uma tabela para poder fazer a interação com outra tabela
--INNER JOIN: retorna apenas os resultados que correspondem (existem) tanto na Tabela A como Tabela B

--Procura colunas em comum
SELECT TOP 10 *
FROM Person.Person
ORDER BY BusinessEntityID;

SELECT TOP 10 *
FROM Person.EmailAddress;

--é declarado as colunas usadas
SELECT p.BusinessEntityID, p.FirstName, p.LastName, pe.EmailAddress
--dá um apelido para a primeira tabela
FROM Person.Person AS p
--dá um apelido para a segunda tabela (Obs: não necessita do AS), depois é declarado uma condição juntando duas colunas em comum usando o ON
INNER JOIN Person.EmailAddress pe ON p.BusinessEntityID = pe.BusinessEntityID;

SELECT 
prod.Name AS Nome, 
prod.ListPrice AS Preço,
prod_sub.Name AS 'Nome Subcategoria'
FROM Production.Product AS prod
INNER JOIN Production.ProductSubcategory prod_sub ON prod.ProductSubcategoryID = prod_sub.ProductSubcategoryID;

--Também pode juntar todas as tabelas
--Tabela 1
SELECT *
FROM Person.BusinessEntityAddress;
--Tabela 2
SELECT *
FROM Person.Address;
--Juntas
SELECT *
FROM Person.BusinessEntityAddress BA
INNER JOIN Person.Address PA ON BA.AddressID = PA.AddressID;
--------------------------------------------------
--
