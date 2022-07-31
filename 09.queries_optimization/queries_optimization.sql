--Introduccion
SELECT * INTO dbo.SalesOrderHeader FROM Sales.SalesOrderHeader;
SELECT * INTO dbo.SalesOrderDetail FROM Sales.SalesOrderDetail;
SELECT * INTO dbo.SalesPerson FROM Sales.SalesPerson;

-- Ejercicio 1
SELECT ProductID
FROM Sales.SalesOrderDetail;
SELECT ProductID
FROM dbo.SalesOrderDetail;

CREATE INDEX index1 ON dbo.SalesOrderDetail (ProductID);

DROP INDEX index1 ON dbo.SalesOrderDetail;
--------------------------------------------------------------------------------------------------------

-- Ejercicio 2
SELECT count(*)
FROM dbo.SalesOrderHeader
WHERE DATEPART(YEAR, OrderDate) = '2014';

SELECT count(*)
FROM dbo.SalesOrderHeader
WHERE OrderDate >= '20140101' AND OrderDate < '20150101';

CREATE INDEX index2 ON dbo.SalesOrderHeader (OrderDate);

DROP INDEX index2 ON dbo.SalesOrderHeader;

--------------------------------------------------------------------------------------------------------

-- Ejercicio 3
SELECT *
FROM dbo.SalesOrderHeader
WHERE TotalDue BETWEEN 500 AND 40000;

CREATE INDEX index3 ON dbo.SalesOrderHeader (TotalDue);

SELECT TotalDue
FROM dbo.SalesOrderHeader
WHERE TotalDue BETWEEN 500 AND 40000;

SELECT SalesOrderID, TotalDue
FROM dbo.SalesOrderHeader
WHERE TotalDue BETWEEN 500 AND 40000;

DROP INDEX index3 ON dbo.SalesOrderHeader;

CREATE INDEX index4 ON dbo.SalesOrderHeader (TotalDue, SalesOrderID);

SELECT SalesOrderID, TotalDue
FROM dbo.SalesOrderHeader
WHERE ABS(TotalDue) BETWEEN 500 AND 40000;

SELECT SalesOrderID, TotalDue
FROM dbo.SalesOrderHeader
WHERE TotalDue BETWEEN 500 AND 40000;
SELECT SalesOrderID, TotalDue
FROM dbo.SalesOrderHeader
WHERE ABS(TotalDue) BETWEEN 500 AND 40000;

DROP INDEX index4 ON dbo.SalesOrderHeader;

--------------------------------------------------------------------------------------------------------

-- Ejercicio 4
SELECT h.SalesOrderID, d.SalesOrderDetailID, h.SalesPersonID
FROM Sales.SalesOrderHeader h
 JOIN Sales.SalesOrderDetail d
 ON d.SalesOrderID = h.SalesOrderID
 JOIN Sales.SalesPerson p
 ON p.BusinessEntityID = h.SalesPersonID;
SELECT h.SalesOrderID, d.SalesOrderDetailID, h.SalesPersonID
FROM dbo.SalesOrderHeader h
 JOIN dbo.SalesOrderDetail d
 ON d.SalesOrderID = h.SalesOrderID
 JOIN dbo.SalesPerson p
 ON p.BusinessEntityID = h.SalesPersonID;

CREATE INDEX index5 ON dbo.SalesOrderDetail (SalesOrderID, SalesOrderDetailID);
CREATE INDEX index6 ON dbo.SalesOrderHeader(SalesOrderID);
CREATE INDEX index7 ON dbo.SalesPerson(BusinessEntityID);
CREATE CLUSTERED INDEX index8 ON dbo.SalesOrderHeader(SalesPersonID);

DROP INDEX index5 ON dbo.SalesOrderDetail;
DROP INDEX index6 ON dbo.SalesOrderHeader;
DROP INDEX index7 ON dbo.SalesPerson;
DROP INDEX index8 ON dbo.SalesOrderHeader;

--------------------------------------------------------------------------------------------------------

-- Ejercicio 5
SELECT SalesOrderID, SalesPersonID, ShipDate
FROM dbo.SalesOrderHeader
WHERE SalesPersonID IN
(SELECT BusinessEntityID
FROM dbo.SalesPerson
WHERE TerritoryID > 5)
 AND ShipDate > '2014-01-01'

SELECT SalesOrderID, SalesPersonID, ShipDate
FROM dbo.SalesOrderHeader
JOIN dbo.SalesPerson
ON BusinessEntityID = SalesPersonID
WHERE dbo.SalesPerson.TerritoryID > 5 AND ShipDate > '2014-01-01';

CREATE CLUSTERED INDEX index8 ON dbo.SalesOrderHeader(ShipDate);
CREATE INDEX index9 ON dbo.SalesOrderHeader(SalesOrderID);
CREATE INDEX index10 ON dbo.SalesOrderHeader(SalesPersonID);
CREATE INDEX index11 ON dbo.SalesPerson(BusinessEntityID);

DROP INDEX index8 ON dbo.SalesOrderHeader;
DROP INDEX index9 ON dbo.SalesOrderHeader;
DROP INDEX index10 ON dbo.SalesOrderHeader;
DROP INDEX index11 ON dbo.SalesPerson;