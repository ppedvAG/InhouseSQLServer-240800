--Weniger Batches sind besser als viele
--Weniger TX sind besser als viele
--weniger Batches mit nochweniger TX sind noch besser

--im Vergleich zu GO 20000


set statistics io, time off


create table t4 ( id int identity, spx char(4100))

declare @i as int = 1
begin tran
while @i <= 20000
begin 
		insert into t4(spx) values ('xy')
		set @i+=1
end
commit



--Als Batch mit go 20000 ca 20 Sek
--Als Schleife ca 8 Sek
--als Schleife mit einer! expliziten TX .. 1 sek