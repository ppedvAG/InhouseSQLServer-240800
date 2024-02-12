drop table slf
drop view vslf

create table slf(id int identity, stadt int, land int)

insert into slf
select 10,100
UNION ALL
select 20, 200
UNION ALL
select 30, 300

select * from slf

create view vslf with schemabinding --jetzt musste genau arbeiten!! ätsch
as
select id, stadt , land from dbo.slf

select * from vslf

alter table slf add Fluss int
update slf set fluss = id * 1000


select * from sys.views

select * from [INFORMATION_SCHEMA].[VIEWS]
where VIEW_DEFINITION like '%schemabinding%'




--Prozeduren.. Warum?
--ähnlich wie Windows Batchdateien
--Proz kann INS UP DEL SEL .. enthalten

--aufruf

exec procname 100

create or alter proc gpdemo @par1 int, @par2 int
as
Code
(INS UP DEL SEL SEL SEL..)



create or alter proc gpdemo @zahl1 int
as
select @zahl1 *100
GO

exec gpdemo 10

--Prozeduren sind schneller, weil Plan kompiliert vorliegt auch nach Neustart
--beim ersten Aufruf


select * from orders where orderid = 10250


select * from slf
select * from vslf --fluss

alter table slf drop column land

select * from vslf
