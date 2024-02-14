set statistics io, time on 
select country, count(*) from kundeumsatz
group by country

create or alter view vdemo2 with schemabinding
as
select country, count_big(*) Anz from dbo.kundeumsatz
group by country

USE [Northwind]
GO

SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO

/****** Object:  Index [ClusteredIndex-20240213-123748]    Script Date: 14.02.2024 14:58:44 ******/
CREATE UNIQUE CLUSTERED INDEX [ClusteredIndex-20240213-123748] ON [dbo].[vdemo2]
(
	[country] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO



--auch der "normalen Abfrage" kann SQL Server (Ent) die Sicht unterschieben
--allerdings! Jede DML Aktion auf der Tabelle muss 
--die Ergebnisdaten der Sicht = CL IX aktualsieren!!

--Zudem sehr viele Randbedingunen

select country, count(*) from kundeumsatz
group by country

select * from vdemo2