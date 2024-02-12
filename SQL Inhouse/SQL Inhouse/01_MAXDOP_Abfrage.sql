/* 
Standardmäßig wird ein Kostenschwellenwert von 5 eingestellt
Der maxdop wird seit SQL 2019 auf =Anzahl der Kerne max 8 eingestellt
Davor auf 0 = Alle

Wichtig! 
der Kostenschwellenwert ist deutlich zu niedrig angesetzt
in der Praxis findet man häufig bei OLTP den Wert bei ca 50
						        bei OLAP ca 50

Ab diesen Wert wird der SQL Server versuchen einen Abfrage mit mehreren Threads zu lösen

Wichtig!
Viele Kerne bedeuten nicht unbedingt schneller!!
Paralellisierung kostet Verwaltungsaufwand. Je mehr Threads desto höher die Kosten

Mittlerweile läßt sich uch pro Datenbank ein MAXDOP Wert setzen

*/

USE [NwindBig]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0; 

set statistics time on

SELECT	
		Customers.Country, Customers.City
		, sum([Order Details].UnitPrice* [Order Details].Quantity) as Umsatz
FROM    
		Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                         Products ON [Order Details].ProductID = Products.ProductID
GROUP BY 	
		Customers.Country, Customers.City
OPTION 
		(MAXDOP 1)
--, CPU-Zeit = 1703 ms, verstrichene Zeit = 1787 ms.


SELECT	
		Customers.Country, Customers.City
		, sum([Order Details].UnitPrice* [Order Details].Quantity) as Umsatz
FROM    
		Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                         Products ON [Order Details].ProductID = Products.ProductID
GROUP BY 	
		Customers.Country, Customers.City
OPTION 
		(MAXDOP 4)
--, CPU-Zeit = 1969 ms, verstrichene Zeit = 658 ms.



SELECT	
		Customers.Country, Customers.City
		, sum([Order Details].UnitPrice* [Order Details].Quantity) as Umsatz
FROM    
		Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                         Products ON [Order Details].ProductID = Products.ProductID
GROUP BY 	
		Customers.Country, Customers.City
OPTION 
		(MAXDOP 8)
--,CPU-Zeit = 3312 ms, verstrichene Zeit = 548 ms.



SELECT	
		Customers.Country, Customers.City
		, sum([Order Details].UnitPrice* [Order Details].Quantity) as Umsatz
FROM    
		Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                         Products ON [Order Details].ProductID = Products.ProductID
GROUP BY 	
		Customers.Country, Customers.City
OPTION 
		(MAXDOP 6)
-- , CPU-Zeit = 2642 ms, verstrichene Zeit = 596 ms.