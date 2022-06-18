﻿ulesannded tegi Jelena Artemjeva
-- db loomine
create database TARpv21
*andmebaas on loodud

-- db kustutamine
DRop DataBASE TARpv21

--- teeme tabeli nimega sugu
use TARpv21;
create table Gender
(
Id int NOT NULL primary key Identity (1,1),
Gender nvarchar(10) not null
)
*tabel on loodud 


create table Person
(
Id int not null primary key identity (1,1),
Name nvarchar(25),
Email nvarchar(30),
GenderId int
)
*tabel isiku on loodud


--- andmete sisestamine tabelisse
insert into Gender (Gender)
values ('Female')
insert into Gender (Gender)
values ('Male')
*tabel gender on loodud

--- nüüd saab kasutada ainult Gender tabelis olevaid väärtuseid
---forgein key lisamine
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)
*forgein key on lisanud

-- sisestame andmed
insert into Person (Name, Email, GenderId)
values ('Supermees', 's@s.com', 2)
insert into Person (Name, Email, GenderId)
values ('Wonderwoman', 'w@w.com', 1)
insert into Person (Name, Email, GenderId)
values ('Batman', 'b@b.com', 2)
insert into Person (Name, Email, GenderId)
values ('Aquaman', 'a@a.com', 2)
insert into Person (Name, Email, GenderId)
values ('Catwoman', 'c@c.com', 1)
insert into Person (Name, Email, GenderId)
values ('Antman', 'ant"ant.com', 2)
insert into Person (Name, Email, GenderId)
values ('Spiderman', 'spider@spiderman.com', 2)
select * from person
*andmed on lisatud tabeli person


-- vaatame tabeli andmeid
select * from Person

--- väärvõtme piirangu maha võtmine
alter table Person
drop constraint tblPerson_GenderId_FK

-- sisestame väärtuse tabelisse
insert into Gender (Gender)
values ('Unknown')
-- lisame väärvõtme uuesti
alter table Person
add constraint DF_Person_GenderId
default 3 for GenderId
*foreign key kustatamine ja uuesti lisamine



---- 2 tund - select laused 

select * from Person
select * from Gender

insert into Person (Id, Name, Email)
values (8, 'Test', 'Test')

---lisame uue veeru tabelisse
alter table Person
add Age nvarchar(10)

--uuendame andmeid
update Person
set Age = 149
where Id = 8
*uus verg ja vanus on lisatud

-- veerule AGE piirnagu panemine
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 150)

insert into Person (Id, Name, Email, GenderId, Age)
values (9, 'Test', 'Test', 2, 160)
*check piirang on lisatud


--rea kustutamine
select * from Person
go
delete from Person where Id = 8
go
select * from Person
*8.rida on kustutatud 

--- lisame veeru City juurde
alter table Person
add City nvarchar(25)
---numerdatud select laused 


-- 1. tahame tead kõiki, kes elavad Tallinnas
select * from Person where City = 'Tallinn'
-- 2. kõik, kes ei ela Gothamis
select * from Person where City <> 'Tallinn'
select * from Person where City != 'Tallinn'
*select laused on tehtud

-- 3. näitab teatud vanusega inimesi
select *from Person where Age = 100 or 
Age = 50 or Age = 20
select * from Person where Age in (100, 50, 20)
*tehtud


--- 4. näitab teatud vanusevahemikus olevaid inimesi
select * from Person where Age between 30 and 50
*tehtud

--- 5 wildcard e näitab kõik g-tähega linnad
select * from Person where City like 'n%'
select * from Person where Email like '%@%'
*tehtud

-- 6 n'itab kõiki, kellel ei ole @-märki emailis
select * from Person where Email not like '%@%'
*tehtud

--- 7 näitab, kelle on emailis ees ja peale @-märki
-- ainult üks täht
select * from Person where Email like '_@_.com'
*tehtud

--- 8 kõik, kellel ei ole nimes esimene täht W, A ja S
select * from Person where Name like '[^WAS]%'
*tehtud

--- 9 kes elavad Tallinnas ja Istabulis
select * from Person where (City = 'Tallinn' or City = 'Istanbul')
*tehtud

--- 10 kõik, kes elevad välja toodud linnades ja on vanemad kui 40 a
select * from Person where (City = 'Riga' or City = 'Moscow')
and Age >= 40
*tehtud

-- 11 kuvab tähestikulises järjekorras inimesi ja võtab aluseks Name veeru
select * from Person order by Name
--- kuva vastupidises järjestuses
select * from Person order by Name desc
*tehtud

---12 võtab kolm esimest rida
select top 3 * from Person
*tehtud

--- 13 kolm esimest, aga tabeli järjestus on Age ja siis Name
select * from Person
select top 3 Age, Name from Person
*tehtud
--- 14 näitab esimesed 50% tabelis
select top 50 percent * from Person
*tehtud
-- 15 järjestab vanuse järgi isikud
select * from Person order by cast(Age as int)
select * from Person order by Age
*tehtud
-- 16 k�ikide isikute koondvanus
select sum(cast(Age as int)) from Person
*tehtud
--- 17 kuvab kõige nooremat isikut
select min(cast(Age as int)) from Person
*tehtud
--- 18 kõige vanem isik
select max(cast(Age as int)) from Person

select City, sum(cast(Age as int)) as TotalAge from Person group by City
*tehtud
--- 19 kuidas saab koodiga muuta andmetääpi ja selle pikkust
alter table Person
alter column Name nvarchar(30)
*tehtud
-- 20 kuvab esimeses reas välja toodud järjestuses 
--  ning muudab Age-i TotalAges-ks
--  järjestab City-s olevate nimede järgi ning alles siis GenderId järgi
--- отображает в суммарное количество возраста в каждом городе и упорядочивает по ГендерИД
select City, GenderId, Sum(cast(Age as int)) as TotalAge from Person
group by City, GenderId order by City
*tehtud
--- 21 näitab, et mitu rida on selles tabelis
--- сколько рядов в таблице 
select count(*) from Person
*tehtud
--- 22 näitab tulemust, et mitu inimest on GenderId väärtusega 2 konkreetses linnas
--- arvutab vanuse kokku konkreetses linnas 
--- показать значения, сколько человек с гендерид 2 в конкретных городах и вычисляет сумму возраста
select GenderId, City, sum(cast(Age as int)) as TotalAge, count(Id) as [Total Person(s)]
from Person
where GenderId = '2'
group by GenderId, City
*tehtud

--- tund 3

--- n'itab 'ra, et mitu inimest on vanemad, kui 41 ja kui palju igas linnas neid elab
select GenderId, City, sum(cast(Age as int)) as TotalAge, count(Id) as [Total Person(s)]
from Person
group by GenderId, City having sum(cast(Age as int)) > 15

--- loome uued tabelid
create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)

create table Employees
(
Id int primary key,
Name nvarchar(50),
Gender nvarchar(10),
Salary nvarchar(50),
DepartmentId int
)

*2 tabelid on loodud

---sisestame andmed
insert into Department (DepartmentName, Location, DepartmentHead)
values ('IT', 'London', 'Rick')
insert into Department (DepartmentName, Location, DepartmentHead)
values ('Payroll', 'Delhi', 'Ron')
insert into Department (DepartmentName, Location, DepartmentHead)
values ('HR', 'New York', 'Christie')
insert into Department (DepartmentName, Location, DepartmentHead)
values ('Other Deparment', 'Sydney', 'Cindrella')

select * from Department

insert into Employees (Name, Gender, Salary, DepartmentId)
values ('Tom', 'Male', 4000, 1)
insert into Employees (Name, Gender, Salary, DepartmentId)
values ('Pam', 'Female', 3000, 1)
insert into Employees (Name, Gender, Salary, DepartmentId)
values ('John', 'Male', 3500, 1)
insert into Employees (Name, Gender, Salary, DepartmentId)
values ('Sam', 'Male', 4500, 2)
insert into Employees (Name, Gender, Salary, DepartmentId)
values ('Todd', 'Male', 2800, 1)
insert into Employees (Name, Gender, Salary, DepartmentId)
values ('Ben', 'Male', 7000, 1)
insert into Employees (Name, Gender, Salary, DepartmentId)
values ('Sara', 'Female', 4800, 3)
insert into Employees (Name, Gender, Salary, DepartmentId)
values ('Valarie', 'Female', 5500, 1)
insert into Employees (Name, Gender, Salary, DepartmentId)
values ('James', 'Male', 6500, NULL)
insert into Employees (Name, Gender, Salary, DepartmentId)
values ('Russell', 'Male', 8800, NULL)

select * from Employeesˇ

*lisatud kõik

--- saan ainult selles tabelis olevad veerud
select distinct Name, DepartmentId from Employees

--- arvutame k]ikide palgad kokku
select sum(cast(Salary as int)) from Employees
--- k]ige v'iksema palga saaja
select min(cast(Salary as int)) from Employees


alter table Employees
add City nvarchar(25)
--- naeme linnade kaupa palga kuufondi
select City, sum(cast(Salary as int)) as TotalSalary from Employees group by City
--- koondsumma, et kui palju saavad naised ja 
--- mehede kuus palka ning eristab linnade kauapa ning ka soo j'rgi
select City, Gender, sum(cast(Salary as int)) as Totalsalary from Employees group by City, Gender

--- nagu eelmine, aga sama nimega linnad on koos
select City, Gender, sum(cast(Salary as int)) as Totalsalary 
from Employees 
group by City, Gender
order by City

select Gender, City, sum(cast(Salary as int)) as Totalsalary 
from Employees 
group by City, Gender
order by City

--- loeb 'ra, et mitu inimest on nimekirjas
select count(*) from Employees

--- mitu inimest on soo ja linna j'rgi
select Gender, City, sum(cast(Salary as int)) as TotalSalary, 
count (Id) as [Total Employee(s)]
from Employees
group by Gender, City
--- mitu t;;tajat on meessoost
select Gender, City, sum(cast(Salary as int)) as TotalSalary, 
count (Id) as [Total Employee(s)]
from Employees
where Gender = 'Male'
group by Gender, City

--- mitu t;;tajat on meessoost
select Gender, City, sum(cast(Salary as int)) as TotalSalary, 
count (Id) as [Total Employee(s)]
from Employees
group by Gender, City having Gender='Male'

--- s[ntaksi viga viga ei ole, aga loogika viga
select * from Employees where  sum(cast(Salary as int)) > 4000

-- korrektne viis teha palgav]rdluse p'ringut
select Gender, City, sum(cast(Salary as int)) as TotalSalary, 
count (Id) as [Total Employee(s)]
from Employees 
group by Gender, City
having sum(cast(Salary as int)) > 5000

--- 4 tund

alter table Employees
add City nvarchar(25)


alter table Employees
add DepartmentId
int null


--- inner join
--- kuvab neid, kellel on DepartmentName all olemas v��rtus
--- kokku on andmeid 10 rida, aga n�itas kaheksa
select Name, Gender, Salary
from Employees
inner join Department
on Employees.DepartmentId = Department.Id

--- left join
--- kuidas saada k�ik andmed k�tte
select Name, Gender, Salary, DepartmentId
from Employees
left join Department
on Employees.DepartmentId = Department.Id

---
--- kuidas saada Departmenti alla uus t�hi rida
select Name, Gender, Salary, DepartmentId, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id

--- kuidas saada k�ikide tabelite v��rtused �hte p�ringusse
select Name, Gender, Salary, DepartmentId, DepartmentName
from Employees
full outer join Department
on Employees.DepartmentId = Department.Id

--- cross join v�tab kaks allpool olevat tabelit kokku 
--- ja korrutab need omavahel l�bi
select Name, Gender, Salary, DepartmentName
from Employees
cross join Department

--- p�ringu sisu
select ColumnList
from LeftTable
joinType RightTable
on JoinCondition


--- inner join
--- ridadel, millel v��rtust ei ole, siis neid ei n�ita
select Name, Gender, Salary, DepartmentName
from Employees
inner join Department
on Department.Id = Employees.DepartmentId

--- kuidas kuvada ainult need isikud, kellel on DepartmentName NULL
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

--- teine variant
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null


--- kuidas saame Department tabelis oleva rea, kus on NULL
select Name, Gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

--- m�lema tabeli mitte-kattuvate v��rtustega read kuvab v�lja
select Name, Gender, Salary, DepartmentName
from Employees
full join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null
or Department.Id is null;

-- saame muuta tabeli nime
sp_rename 'Department1' , 'Department'


--- kasutame Employees tabeli asemel l�hendit E ja M
--- Teeme tabelisisese join-i ja n�ema, kes on kelle �lemus
select E.Name as Employee, M.Name as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

alter table Employees
add ManagerId int

--- kuvab ainult ManagerId all olevate isikute v��rtuseid
select E.Name as Employee, M.Name as Manager
from Employees E
inner join Employees M
on E.ManagerId = M.Id


--- k�ik saavad k�ikide �lemused olla
select E.Name as asdasdasdasd, M.Name as Manager
from Employees E
cross join Employees M

--- kuvab No manager kuna NULL asemel ei ole string v��rtust
--- kui panna NULL asemele v��rtuse, siis kuvab seda stringi
select isnull(NULL, 'No Manager') as Manager

--- neil, kellel ei ole �lemust, siis paneb neile No Manager teksti
select E.Name as Employee, isnull(M.Name, 'No Manager') as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id


--- case kasutamine p�ringus
select E.Name as Employee, case when M.Name is null then 'No Manager'
else M.Name end as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id


--- lisame tabelid
alter table Employees
add MiddleName nvarchar(30)
*tehtud

alter table Employees
add LastName nvarchar(30)
*tehtud

update Employees set FirstName = 'Tom', MiddleName = 'Nick', LastName = 'Jones'
where Id = 1
update Employees set FirstName = 'Pam', MiddleName = NULL, LastName = 'Anderson'
where Id = 2
update Employees set FirstName = 'John', MiddleName = NULL, LastName = NULL
where Id = 3
update Employees set FirstName = 'Sam', MiddleName = NULL, LastName = 'Smith'
where Id = 4
update Employees set FirstName = NULL, MiddleName = 'Todd', LastName = 'Someone'
where Id = 5
update Employees set FirstName = 'Ben', MiddleName = 'Ten', LastName = 'Sven'
where Id = 6
update Employees set FirstName = 'Sara', MiddleName = NULL, LastName = 'Connor'
where Id = 7
update Employees set FirstName = 'Valarie', MiddleName = 'Balerine', LastName = NULL
where Id = 8
update Employees set FirstName = 'James', MiddleName = '007', LastName = 'Bond'
where Id = 9
update Employees set FirstName = NULL, MiddleName = NULL, LastName = 'Crowe'
where Id = 10

*lisatud veerud - last name ja middlename ning täidetud ka.

*coalesce - функция которая возращает что-то, мне не дали записать
--- igast reast v�tab esimeses veerus t�idetud lahtri ja kuvab ainult seda
select Id, coalesce(MiddleName, LastName, FirstName) as Name
from Employees

select * from Employees
select * from Department


create table IndianCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

create table UKCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

insert into IndianCustomers (Name, Email) values ('Raj', 'R@R.com')
insert into IndianCustomers (Name, Email) values ('Sam', 'S@s.com')

insert into UKCustomers (Name, Email) values ('Ben', 'B@B.com')
insert into UKCustomers (Name, Email) values ('Sama', 'S@S.com')

select * from IndianCustomers
select * from UKCustomers

--- kasutame union all, n�itab k�iki ridu
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers


--- korduvate v��rtustega read pannakse �hte ja ei korrata
select Id, Name, Email from IndianCustomers
union
select Id, Name, Email from UKCustomers

--- nimede t�hestikulise j�rjekorra alusel saab j�rjestada
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers
order by Name


--PROTSEEDURID--

--- loome stored procedure, mis kuvab vaate
create procedure spGetEmployees
as begin
	select FirstName, Gender from Employees
end

spGetEmployees
exec spGetEmployees
execute spGetEmployees
*tehtud

--- näitab firstname, gender, departamentid kasutaja poolt sisestatud andmetega @gender, @departamentid 

create proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
as begin
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end
*tehtud

--- k�ik esimeses osakonnas meessoost t��tavad isikud
spGetEmployeesByGenderAndDepartment 'Male', 1
*tehtud

--- valet j�rjestust ei tohi olla, aga kui soovid, 
--- siis tuleb muutuja nimetused ette kirjutada
spGetEmployeesByGenderAndDepartment @DepartmentId =  1, @Gender = 'Male'



--- procedure muutmine
alter proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
with encryption -- v�tme peale panek
as begin
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end
*tehtud

-- показывает количество сотрудников по полу
create proc spGetEmployeeCountByGender
@Gender nvarchar(20),
@EmployeeCount int output
as begin
	select @EmployeeCount = count(Id) from Employees where Gender = @Gender
end
*tehtud

-- annab teada, palju on meessoost isikuid ning kuvab vastava stringi
-- zapusk protseduri

declare @TotalCount int
exec spGetEmployeeCountByGender 'Female', @TotalCount out
if(@TotalCount = 0)
	print '@TotalCount is null'
else
	print '@TotalCount is not null'
print @TotalCount
*tehtud

-- annab teada, palju on meessoost isikuid
declare @TotalCount int
exec spGetEmployeeCountByGender @EmployeeCount = @TotalCount out, @Gender = 'Male'
print @TotalCount

--- sp s�ltuvuse vaatamine
sp_depends spGetEmployeeCountByGender
--- sp sisu vaatamine
sp_help spGetEmployeeCountByGender
--- tabeli sisu
sp_help Employees
--- kui soovid sp teksti n�ha
sp_helptext spGetEmployeeCountByGender

sp_depends Employees


---- annab kogu tabeli ridade arvu
create proc spTotalCount2
@TotalCount int output
as begin
	select @TotalCount = count(Id) from Employees
end
--- k�ivitame sp
declare @TotalEmployees int
execute spTotalCount2 @TotalEmployees output
select @TotalEmployees

--- mis id all on keegi nime j�rgi
create proc spGetNameById1
@Id int,
@FirstName nvarchar(50) output
as begin
	select @FirstName = FirstName from employees where Id = @Id
end

--- k�ivitame sp
declare @FirstName nvarchar(50)
execute spGetNameById1 6, @FirstName output
print 'Name of the employee = ' + @FirstName

--
create proc spGetNameById2
@Id int
as begin
	return (select FirstName from Employees where Id = @Id)
end
-- tuleb veatead kuna kutsusime v�lja int-i, aga Tom on string
declare @EmployeeName nvarchar(50)
exec @EmployeeName = spGetNameById2 1
print 'Name of the employee = ' + @EmployeeName

select * from Employees


---- sisseehitatud s�ne funktsioonid
-- konverteerib ascii t�he v��rtuse nr
select ascii('a')
-- kuvab suure A
select char (65

-- kuvab k�ik t�hem�rgid
declare @Start int
set @Start = 1
while (@Start <= 256)
begin
	select char (@Start)
	set @Start = @Start + 1
end

--- eemaldab t�hjad stringid
select ltrim('                                Hello')


--- t�hikute eemaldamine veerust
select ltrim(FirstName) as FirstName, MiddleName, LastName from Employees

select * from Employees


--- 5 tund 
--- teeb uue kooloni paremale poole ja k�ik nimed on paremale �hte viirgu pandud
--- vastavalt upper ja lower-ga saan m�rkide suurust muuta
--- reverse paneb k�ik m�rgid vastupidisesse j�rjekorda
select reverse(upper(ltrim(FirstName))) as FirstName, MiddleName, 
lower(LastName), RTRIM(ltrim(FirstName)) + ' ' + MiddleName + ' ' + LastName as FullName
from Employees

--- n�eb �ra, mitu t�hte on s�nel ja loeb t�hikud ka sisse
select FirstName, len(ltrim(FirstName)) as [Total Characters] from Employees

---- LEFT, RIGHT ja SUBSTRING

-- vasakult poolt neli esimest t�hte
select left('ABCDEF', 4)

--- paremalt poolt neli esimest t�hte
select right('ABCDEF', 4)

---loeb �ra enne @-m�rki olevad t�hem�rgid
select charindex('@', 'sara@aaa.com')

-- esimene nr peale komakohta n�itab, et mitmendast t�hest alustab lugemist 
-- ja teine number n�itab, et mitu t�hem�rki kuvab konsoolis
select substring('pam@bbb.com', 7, 2)

-- @-m�rgist kuvab kolm t�hem�rki ja viimasega saab m��rata pikkust
select substring('pam@bbb.com', charindex('@', 'pam@bbb.com') + 1, 3)

-- peale @-m�rki reguleerib t�hem�rkide pikkuse n�itamist
select substring('pam@bbb.com', charindex('@', 'pam@bbb.com') + 2,
len('pam@bbb.com') - charindex('@', 'pam@bbb.com'))


alter table Employees
add Email nvarchar(20)

update Employees set Email = 'Tom@aaa.com' where Id = 1
update Employees set Email = 'Pam@bbb.com' where Id = 2
update Employees set Email = 'John@aaa.com' where Id = 3
update Employees set Email = 'Sam@bbb.com' where Id = 4
update Employees set Email = 'Todd@bbb.com' where Id = 5
update Employees set Email = 'Ben@ccc.com' where Id = 6
update Employees set Email = 'Sara@ccc.com' where Id = 7
update Employees set Email = 'Valarie@aaa.com' where Id = 8
update Employees set Email = 'James@bbb.com' where Id = 9
update Employees set Email = 'Russel@bbb.com' where Id = 10

-- saame teada domeeninimed emailides
select substring(Email, charindex('@', Email) + 1,
len(Email) - charindex('@', Email)) as EmailDomain
from Employees

select * from Employees

-- lisame *-m�rgi teatud kohtadesse
select FirstName, LastName,
	substring(Email, 1, 2) + replicate('*', 2) + --peale teist t�hem�rki paneb kaks t'rni
	substring(Email, charindex('@', Email), len(Email) - charindex('@', Email)+1) as Email
--- kuni @-m�rgini paneb *-m�rke
from Employees

--- kolm korda n�itab stringis olevat v��rtust
select replicate('asd', 3)

--- t�hikute sisestamine kahe nime vahele
select space(5)

-- 25 t�hikut kahe nime vahel
select FirstName + space(25) + LastName as FullName
from Employees

---PATINDEX
-- sama, mis charindex, aga d�naamilisem ja saab kasutada wildcardi
select Email, PATINDEX('%@bbb.com', Email) as FirstOccurence
from Employees
where PATINDEX('%@bbb.com', Email) > 0 --- leian, k�ik selle domeeni esindajad ja
--- alates mitmendast m'rgist algab @
select * from Employees

--- k�ik .com-d asendatakse .net-ga
select Email, replace(Email, '.com', '.net') as ConvertedEmail
from Employees

--- soovin asendada peale esimest m�rki kolm t�hte viie t�rniga
select FirstName, LastName, Email,
	stuff(Email, 2, 3, '*****') as StuffedEmail
from Employees


--- datetime
create table DateTime
(
c_time time,
c_date date,
c_smalldatetime smalldatetime,
c_datetime datetime,
c_datetime2 datetime2,
c_datetimeoffset datetimeoffset
)

select * from DateTime

-- konkreetse masina kellaaeg
select getdate(), 'GETDATE()'

insert into DateTime
values (getdate(), getdate(), getdate(), getdate(), getdate(), getdate())

update DateTime set c_datetimeoffset = '2022-04-18 13:30:55.8666667 +10:00'
where c_datetimeoffset = '2022-04-18 13:30:55.8666667 +00:00'

select CURRENT_TIMESTAMP, 'CURRENT_TIMESTAMP' --- aja p�ring
select SYSDATETIME(), 'SYSDATETIME' --- veel t�psem aja p�ring
select SYSDATETIMEOFFSET(), 'SYSDATETIMEOFFSET' -- t�pne aeg koos ajalise nihkega UTC suhtes
select GETUTCDATE(), 'GETUTCDATE' --- UTC aeg

-- kui 0, siis on vale. Kui 1, siis on OK
select isdate('asd') --tulemus 0
select isdate(getdate()) --tulemus 1
select isdate('2022-04-18 13:30:55.8666667')  -- annab O
select isdate('2022-04-18 13:30:55.866') -- max sajandiku t�psusega, muid on vastus 0
select day(getdate()) --- annab t�nase p�eva nr-i
select day('01/31/2026')  -- tuvastab �ra t�nase kuup�eva
select month(getdate()) -- annab vastuseks 4 kuna on neljas kuu
select month('01/31/2026') -- annab ette antud kuu nr
select year(getdate())  -- annab vastuseks jooksva aasta
select year('01/31/2026') -- annab vastuseks 2026


select datename(day, '2022-04-18 13:30:55.866') -- annab vastukses 18
select datename(weekday, '2022-04-18 13:30:55.866')  -- annab vastuseks esmasp�ev
select datename(month, '2022-04-18 13:30:55.866')  --- annab vastuseks Aprill

---
create table EmployeesWithDates
(
Id nvarchar(2),
Name nvarchar(20),
DateOfBirth datetime
)

insert into EmployeesWithDates (Id, Name, DateOfBirth)
values (1, 'Sam', '1980-12-30 00:00:00.000')
insert into EmployeesWithDates (Id, Name, DateOfBirth)
values (2, 'Pam', '1982-09-01 12:02:36.260')
insert into EmployeesWithDates (Id, Name, DateOfBirth)
values (3, 'John', '1985-08-22 12:03:30.370')
insert into EmployeesWithDates (Id, Name, DateOfBirth)
values (4, 'Sara', '1979-11-26 12:59:30.670')

select * from EmployeesWithDates

-- kuidas v�tame �hest koolonist andmed ja selle abil loome uued koolonid
select  Name, DateOfBirth, DateName(weekday, DateOfBirth) as [Day],
--- v�tab DateOfBirth koolonist p�eva j�rgi ja kuvab p�eva nimetuse
	Month(DateOfBirth) as MonthNumber,
--- v�tab DoB koolonist kuup�eva ja n�itab nr
	Datename(Month, DateOfBirth) as [MonthName],
--- v�tab DoB koolonist kuu ja kuvab t�htedega
	Year(DateOfBirth) as [Year]
--- v�tab aasta koolonist aasta ja kuvab aasta nr
from EmployeesWithDates


--- 
select datepart(weekday, '2022-04-16 12:02:36.260')
select  datename(month, '2022-04-16 12:02:36.260') -- anna kuu nimetuse
select dateadd(day, 20, '2022-04-16 12:02:36.260') -- lisab t�nasele kp 20 p�eva juurde
select dateadd(day, -20, '2022-04-16 12:02:36.260') -- annab kp, mis oli 20 p�eva tagasi
select datediff(month, '11/30/2021', '04/19/2022')  -- kahe kuu vaheline aeg
select datediff(YEAR, '11/30/2020', '04/19/2022')  --- kuvab kahe aastavahelist aega


--- 
create function fnComputeAge(@DOB datetime)
returns nvarchar(50)
as begin
	declare @tempdate datetime, @years int, @months int, @days int
		select @tempdate = @DOB

		select @years = datediff(year, @tempdate, getdate()) - case when (month(@DOB)
		> month(getdate())) or (month(@DOB) = month(getdate()) and day(@DOB) >
		day(getdate())) then 1 else 0 end
		select @tempdate = dateadd(year, @years, @tempdate)

		select @months = datediff(month, @tempdate, getdate()) - case when day(@DOB) >
		day(getdate()) then 1 else 0 end
		select @tempdate = dateadd(month, @months, @tempdate)

		select @days = datediff(day, @tempdate, getdate())

		declare @Age nvarchar(50)
			set @Age = cast(@years as nvarchar(4)) + ' Years ' 
			+ cast(@months as nvarchar(2)) + ' Months '
			+ cast(@days as nvarchar(2)) + ' Days old '
		return @Age
end

select dbo.fnComputeAge('01/01/1900')

select Id, Name, DateOfBirth, dbo.fnComputeAge(DateOfBirth)
as Age from EmployeesWithDates

--- konverteerib DOB sisu
select Id, Name, DateOfBirth, cast(DateOfBirth as nvarchar) as ConvertedDOB from EmployeesWithDates
select Id, Name, DateOfBirth, convert(nvarchar, DateOfBirth) as ConvertedDOB from EmployeesWithDates


select  cast(getdate() as date) --- n'itab t'nast kp-d
select convert(date, getdate()) --- n'itab t'nast kp-d


select Id, Name, Name + ' - ' + cast(Id as nvarchar) as [Name-Id] from EmployeesWithDates

--- saan erinevalt kuvada kp-sid, kui muudan  DOB j�rel tulevat nr, siis muutub ka kuvamise viis
select Id, Name, DateOfBirth,
convert(nvarchar, DateOfBirth, 105) as ConvertedDOB
from EmployeesWithDates

select Id, Name, DateOfBirth,
convert(nvarchar, DateOfBirth, 126) as ConvertedDOB
from EmployeesWithDates


--- matemaatilised funktsioonid
select abs(-101.5)  -- ABS on aboluutne nr ja tulemuseks saame ilma miinus m�rgita
select ceiling(15.2) -- tagastab 16, kuvab j�rgmise suurema t�isarvu
select ceiling(-15.2) -- annab -15 kuna see on suurem, kui -15.2
select floor(15.2)  -- annab vastuseks 15 kuna arvestab allapoole
select floor(-15.2) -- annab vastuseks -16 kuna arvestab allapoole
select power(2, 4) -- hakkab korrutama 2x2x2x2, esimene arv on l�bi korrutatav arv ja teine mitu korda
select sqrt(81) ---annab vastuse 9

select rand(1) --- annab alati �he ja sama nr. Kui tahad iga kord uut nr, siis �ra pane sulgudesse nr-t
select floor (rand() * 100) -- korrutad sajaga iga suvalise nr

--- 10 suvalist nr-t
declare @Counter int
set @Counter = 1
while (@Counter <= 10)
begin
	print floor(rand() * 1000)
	set @Counter = @Counter + 1
end

select round(850.556, 2) --- �mardab viimase nr j�rgi tuhandikus
select round(850.556, 2, 1) --�mardab viimase nr j�rgi tuhandikus allapoole
select round(850.556, 1) -- �mardab k�ige esimese nr peale komakohta
select round(850.556, 1,1)  --- �mardab allapoole k�ige esimese nr peale komakohta
select round(850.556, -2)  --- kaks esimest nr �mardab suuremaks
select round(850.556, -1) --- n�itab ainult t�isarvu

--- 6 tund SQL

--- vanuse arvutamise funktsioon
create function dbo.CalculateAge (@DOB date)
returns int
as begin
declare @Age int

set @Age = datediff(year, @DOB, getdate()) - 
	case
		when (month(@DOB) > month(getdate())) or
			 (month(@DOB) > month(getdate()) and 
			 day(@DOB) > day(getdate()))
		then 1
		else 0
		end
	return @Age
end

--- kontrollime, kas funktsioon t��tab
execute dbo.CalculateAge '10/08/2020'

select * from EmployeesWithDates

-- p�ring tabeli vastu, kus kuvatakse inimeste vanust
select Id, Name, dbo.CalculateAge(DateOfBirth) as Age
from EmployeesWithDates
where dbo.CalculateAge(DateOfBirth) > 40

--- inline table valued functions

insert into EmployeesWithDates (Id, Name, DateOfBirth,
DepartmentId, Gender)
values (5, 'Todd', '1978-11-29 12:59:30.670', 1, 'Male')


create function fn_EmployeesByGender(@Gender nvarchar(10))
returns table
as
return (select Id, Name, DateOfBirth, DepartmentId, Gender
		from EmployeesWithDates
		where Gender = @Gender)

--- k�ik female t��tajad tahame
select * from fn_EmployeesByGender('Female')

--- t�psustame otsingut where abil
select * from fn_EmployeesByGender('Female')
where Name = 'Pam'

--- kahest erinevast tabelist andmete v�tmine ja koos kuvamine
select Name, Gender, DepartmentName
from fn_EmployeesByGender('Male') E
join Department D on D.Id = E.DepartmentId

-- inline funktsioon
create function fn_InlineFunction_GetEmployees()
returns table as
return (select Id, Name, cast(DateOfBirth as date)
		as DOB
		from EmployeesWithDates)

select * from fn_InlineFunction_GetEmployees()

--- multi-state funktsiooni
create function fn_MultiState_GetEmployees()
returns @Table Table (Id int, Name nvarchar(20), DOB date)
as begin
	insert into @Table
	select Id, Name, cast(DateOfBirth as date) from EmployeesWithDates

	return
end

select * from fn_MultiState_GetEmployees()

-- inline tabeli funktsioonid t��tavad paremini kuna k�sitletakse, 
-- kui vaatena ja v�tavad v�hem ressurssi
-- multi puhul on pm tegemist stored proceduriga 
-- ja kulutab rohkem ressurssi
--- inline funktsiooniga saab muuta andmeid
update fn_InlineFunction_GetEmployees() 
set Name = 'Sam1' where Id = 1
--- multistate funktsiooni abil ei saa muuta andmeid
update fn_MultiState_GetEmployees()
set Name = 'Sam 1' where Id = 1

--- deterministic ja non-deterministic
-- deterministic e ettem��ratletud
select count(*) from EmployeesWithDates
select square(3)

-- non-deterministic ja mitte-ettem��ratletud
select getdate()
select rand()
select CURRENT_TIMESTAMP

create function fn_GetNameById(@id int)
returns nvarchar(30)
as begin
	return (select Name 
	from EmployeesWithDates where Id = @id)
end
-- saame teada, kes asub Id 1 all
select dbo.fn_GetNameById(1)

--- selle abil saab vaadata funktsiooni sisu
sp_helptext fn_GetNameById

--- 
alter function fn_GetNameById(@id int)
returns nvarchar(20)
with schemabinding
as begin 
return (select Name from dbo.EmployeesWithDates
		where Id = @id)
end

-- ei saa kustutada tabeleid 
-- ilma funktsiooni kustutamiseta 
drop table dbo.EmployeesWithDates

--- 7 tund SQL

--- temporary tables

-- # m�rgi abil m��ratlesime �ra temp table-i
-- seda tabelit saab ainult selles p�ringus avada
create table #PersonDetails(Id int, Name nvarchar(20))

insert into #PersonDetails values(1, 'Mike')
insert into #PersonDetails values(2, 'John')
insert into #PersonDetails values(3, 'Todd')
insert into #PersonDetails values('4', 'Test')
insert into #PersonDetails values('asd', 'Test1')

select * from #PersonDetails

-- leiate s�steemis olevaid objekte ja lisaks enda kirjutatud
select Name from sysobjects
where Name like '#PersonDetails%'

--- kustutamine
drop table #PersonDetails


create proc spCreateLocalTempTable
as begin
create table #PersonDetails(Id int, Name nvarchar(20))

insert into #PersonDetails values(1, 'Mike')
insert into #PersonDetails values(2, 'John')
insert into #PersonDetails values(3, 'Todd')

select * from #PersonDetails
end

-- l�bi sp kutsume esile temp table
exec spCreateLocalTempTable


--- globaalne temp table
--- ##-m�rgid tabeli ees t�hendavad globaalset temp table-t
create table ##PersonDetails(Id int, Name nvarchar(20))

--- indeksid
create table EmployeeWithSalary
(
Id int primary key,
Name nvarchar(25),
Salary int,
Gender nvarchar(10)
)

insert into EmployeeWithSalary values(1, 'Sam', 2500, 'Male')
insert into EmployeeWithSalary values(2, 'Pam', 6500, 'Female')
insert into EmployeeWithSalary values(3, 'John', 4500, 'Male')
insert into EmployeeWithSalary values(4, 'Sara', 5500, 'Female')
insert into EmployeeWithSalary values(5, 'Todd', 3100, 'Male')

select * from EmployeeWithSalary

select * from EmployeeWithSalary
where Salary > 5000 and Salary < 7000

--- loome indeksi, mis asetab palga kahanevasse j�rjestusse
create index IX_EmployeeSalary
on EmployeeWithSalary (Salary asc)

-- saame teada, et mis on selle tabeli primaarv�ti ja index
exec sys.sp_helpindex @objname = 'EmployeeWithSalary'

--- v�ga detailne �levaade indeksist
SELECT 
     TableName = t.name,
     IndexName = ind.name,
     IndexId = ind.index_id,
     ColumnId = ic.index_column_id,
     ColumnName = col.name,
     ind.*,
     ic.*,
     col.* 
FROM 
     sys.indexes ind 
INNER JOIN 
     sys.index_columns ic ON  ind.object_id = ic.object_id and ind.index_id = ic.index_id 
INNER JOIN 
     sys.columns col ON ic.object_id = col.object_id and ic.column_id = col.column_id 
INNER JOIN 
     sys.tables t ON ind.object_id = t.object_id 
WHERE 
     ind.is_primary_key = 0 
     AND ind.is_unique = 0 
     AND ind.is_unique_constraint = 0 
     AND t.is_ms_shipped = 0 
ORDER BY 
     t.name, ind.name, ind.index_id, ic.is_included_column, ic.key_ordinal;

--- indeksi kustutamine
drop index EmployeeWithSalary.IX_EmployeeSalary

--- indeksi t��bid:
--- 1. klastrites olevad
--- 2. Mitte-klastris olevad
--- 3. unikaalsed
--- 4. Filtreeritud
--- 5. XML
--- 6. T�istekst
--- 7. Ruumiline
--- 8. Veerus�ilitav
--- 9. Veergude indeks
--- 10. V�lja arvatud veergudega indeksid

--- klastirs olev indeks m��rab �ra tabelis oleva f��silise j�rjestuse
--- ja selle tulemusel saab tabelis olla ainult �ks klastris olev indeks

create table EmployeeCity
(
Id int primary key,
Name nvarchar(50),
Salary int,
Gender nvarchar(10),
City nvarchar(50)
)

exec sp_helpindex EmployeeCity

insert into EmployeeCity values(3, 'John', 4500, 'Male', 'New York')
insert into EmployeeCity values(1, 'Sam', 2500, 'Male', 'London')
insert into EmployeeCity values(4, 'Sara', 5500, 'Female', 'Tokyo')
insert into EmployeeCity values(5, 'Todd', 3100, 'Male', 'Toronto')
insert into EmployeeCity values(2, 'Pam', 6500, 'Female', 'Sydney')

select * from EmployeeCity

--- klastris olev indeks

--- saame luua ainult �he klastris oleva indeksi tabeli peale
--- klastris olev indeks on analoogne telefoni suunakoodile
--- kui soovid teist klastris olevat indeksit juurde luua, siis tuleb eelmine �ra kustutada

create clustered index IX_EmployeeCity_NameTest
on EmployeeCity(Name)

create clustered index IX_EmployeeGenderSalary
on EmployeeCity(Gender desc, Salary asc)
--- kui teed select p�ringu sellele tabelile, siis peaksid n�gema andmeid, mis on j�rjestatud selliselt:
--- esimeseks v�etakse aluseks Gender veerg kahanevas j�rjestuses ja siis Salary veerg t�usvas j�rjestuses

select * from EmployeeCity

-- mitte-klastris olevad indeksid
create nonclustered index IX_EmployeeCity_Name
on EmployeeCity(Name)

-- enne p�ringut kustutamise indeksi nimega IX_EmployeeGenderSalary
select * from EmployeeCity

--- erinevused kahe indeksi vahel
--- 1. ainult �ks klastris olev indeks saab olla tabeli peale,
--- mitte-klastris olevaid indekseid saab olla mitu
--- 2. klastris olevad indeksid on kiiremad kuna indeks peab tagasi viitama tabelile
--- juhul, kui selekteeritud veerg ei ole olemas indeksis
--- 3. klastris olev indeks m��ratleb �ra tabeli ridade salvestusj�rjestuse
--- ja ei n�ua kettal lisa ruumi. Samas mitte klastris olevad indeksid on
--- salvestatud tabelist eraldi ja n�uab lisa ruumi

--- unikaalne ja mitte-unikaalne indeks
create table EmployeeCityFirstName
(
Id int primary key,
FirstName nvarchar(50),
LastName nvarchar(50),
Salary int,
Gender nvarchar(10),
City nvarchar(50)
)

insert into EmployeeCityFirstName values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into EmployeeCityFirstName values(1, 'John', 'Menco', 2500, 'Male', 'London')
--- ei saanud sisestada teist rida kuna Id v��rtus oli sama, aga peab olema uniklaane
--- Id on antud juhul indeks ja nii kaua kuni see on primaarvv�ti

exec sp_helpindex EmployeeCityFirstName

--- indeksi kustutamine koodiga ei ole lubatud, peab tegema k�sitsi indexi kaustast
drop index EmployeeCityFirstName.PK__Employee__3214EC07BFD2F0A2

--- peale indeksi kustutamist sisestame andmed
insert into EmployeeCityFirstName values(1, 'John', 'Menco', 2500, 'Male', 'London')

--- sisetame mitte klastris oleva indeksi
create unique nonclustered index UIX_EmployeeFirstNameLastName
on EmployeeCityFirstName(FirstName, LastName)

-- sisestame andmed
insert into EmployeeCityFirstName values(1, 'John', 'Menco', 2500, 'Male', 'London')
-- annab veateate, et John Menco on juba olemas kuna Lastname ja Firstname peavad olema unikaalsed

-- lisame unikaalse piirnagu
alter table EmployeeCityFirstName
add constraint UQ_EmployeeFirstname_City
unique nonclustered(City)

-- enne n�ite tegemist kustutame tabeli �ra
drop table EmployeeCityFirstName

-- loome uuesti
create table EmployeeCityFirstName
(
Id int primary key,
FirstName nvarchar(50),
LastName nvarchar(50),
Salary int,
Gender nvarchar(10),
City nvarchar(50)
)

insert into EmployeeCityFirstName values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into EmployeeCityFirstName values(2, 'John', 'Menco', 2500, 'Male', 'London')
insert into EmployeeCityFirstName values(3, 'John', 'Menco', 3500, 'Male', 'London')

alter table EmployeeCityFirstName
add constraint UQ_EmployeeFirstname_CityFirstName
unique nonclustered(City)

--- indeksite vaatamine
exec sp_helpconstraint EmployeeCityFirstName

-- 1. primaarv�ti on vaikimisi unikaalne klastris olev indeks, sama unikaalne piirang
-- loob unikaalse mitte-klastris oleva indeksi
-- 2. unikaalset indeksit v�i piirangut ei saa luua olemasolevasse tabelisse, kui tabel
-- juba sisaldab v��rtusi v�tmeveerus
-- 3. vaikimisi korduvaid v��rtusied ei ole veerus lubatud,
-- kui peaks olema unikaalne indeks v�i piirnag. 

create unique index IX_EmployeeFirstNameCity
on EmployeeCityFirstName(City)
with ignore_dup_key

select * from EmployeeCityFirstName

insert into EmployeeCityFirstName values(3, 'John', 'Menco', 3512, 'Male', 'London')
insert into EmployeeCityFirstName values(4, 'John', 'Menco', 3123, 'Male', 'London1')
insert into EmployeeCityFirstName values(4, 'John', 'Menco', 3220, 'Male', 'London1')

--- 8 SQL tund


create nonclustered index IX_EmployeeCityFirstName_Salary
on EmployeeCityFirstName (Salary asc)

select * from EmployeeCityFirstName

--- view

create table EmployeeIndex
(
Id int primary key,
Name nvarchar(20),
Salary int,
Gender nvarchar(20),
DeptNameId int
)

insert into EmployeeIndex values(1, 'John', 5000, 'Male', 3)
insert into EmployeeIndex values(2, 'Mike', 3400, 'Male', 2)
insert into EmployeeIndex values(3, 'Pam', 6000, 'Female', 1)
insert into EmployeeIndex values(4, 'Todd', 4800, 'Male', 4)
insert into EmployeeIndex values(5, 'Sara', 3200, 'Female', 1)
insert into EmployeeIndex values(6, 'Ben', 4800, 'Male', 3)

select * from Department

select EmployeeIndex.Id, Name, Salary, Gender, DepartmentName
from EmployeeIndex
join Department
on EmployeeIndex.DeptNameId = Department.Id

--- loome view, kus kasutame joini
create view vEmployeesByDepartmentIndex
as
select EmployeeIndex.Id, Name, Salary, Gender, DepartmentName
from EmployeeIndex
join Department
on EmployeeIndex.DeptNameId = Department.Id

--- view, kus kasutame joini
select * from vEmployeesByDepartmentIndex
-- view on salvestatud virtuaalne tabel


--- view eelised
-- 1. saab kasutada andmebaasi skeemi keerukuse lihtsustamiseks, mitte IT inimestele
-- 2. saab kasutada rakendamise mehhanismina rea ja veerutaseme turvalisusena

--- view, mis tagastab ainult IT osakonna t��tajad
create view vITDepartment_Employees
as 
select EmployeeIndex.Id, Name, Salary, Gender, DepartmentName
from EmployeeIndex
join Department
on EmployeeIndex.DeptNameId = Department.Id
where Department.DepartmentName = 'IT'

select * from vITDepartment_Employees

--- piirame palga n�gemist kolmandatel isikutel
-- veerru turvalisus e kus j�etakse mingi veerg v�lja
create view vEmployeesDataExceptSalary
as
select EmployeeIndex.Id, Name, Gender, DepartmentName
from EmployeeIndex
join Department
on EmployeeIndex.DeptNameId = Department.Id


select * from vEmployeesDataExceptSalary

--- view, kus saab kasutada ainult koondandmete n�itamiseks
-- view, mis tagastab summeeritud andmeid
create view vEmployeesCountByDepartment
as
select DepartmentName, COUNT(EmployeeIndex.Id) as TotalEmployees
from EmployeeIndex
join Department
on EmployeeIndex.DeptNameId = Department.Id
group by DepartmentName

select * from vEmployeesCountByDepartment

--- kuidas vaadata view sisu
sp_helptext vEmployeesCountByDepartment

--- kui soovid view-d muuta, siis paned: alter view
--- kui soovid kustutada, siis: drop view


--- view uuendused
select * from vEmployeesDataExceptSalary

--- kuidas l�bi view uuendada andmeid
update vEmployeesDataExceptSalary
set FirstName = 'Mikey' where Id = '2'

--- kustutamise jaoks
delete from vEmployeesDataExceptSalary where Id = 2

-- andmete sisestamine
insert into vEmployeesDataExceptSalary values(11, 'Mikey', 'Male', 2)

--- muudame l�bi view kaks veergu korraga
create view vEmployeeDetailsByDepartmentIndex
as
select EmployeeIndex.Id, Name, Salary, Gender, DepartmentName
from EmployeeIndex
join Department
on EmployeeIndex.DeptNameId = Department.Id

select * from vEmployeeDetailsByDepartmentIndex
update vEmployeeDetailsByDepartmentIndex
set DepartmentName = 'HR' where Name = 'John'

---indekseeritud view

create table Product
(
Id int primary key,
Name nvarchar(20),
UnitPrice int
)

insert into Product values(1, 'Books', 20)
insert into Product values(2, 'Pens', 14)
insert into Product values(3, 'Pencils', 11)
insert into Product values(4, 'Clips', 10)

create table ProductSales
(
Id int,
QuantitySold int
)

create view vTotalSalesByProduct
with schemabinding  -- seob k�sitletavaid tabeleid ja ei luba muuta igatepidi
as
select Name,
SUM(ISNULL((QuantitySold * UnitPrice), 0)) as TotalSales,
count_big(*) as TotalTransactions
from dbo.ProductSales
join dbo.Product --kindlasti panna tabeli ette dbo
on Product.Id = ProductSales.Id
group by Name

select * from vTotalSalesByProduct

--- view reeglid
-- 1. view tuleb luua koos schemabinding
-- 2. kui lisafunktsioon select list viitab v�ljendile ja 
-- selle tulemuseks v�ib olla NULL, siis asendusv��rtus peaks olema 
-- t�psustatud e antud juhul nr 0 tuleb lahtrisse

-- loome Indeksi view sisse
create unique clustered index UIX_vTotalSalesByProduct_Name
on vTotalSalesByProduct(Name)

select * from UIX_vTotalSalesByProduct_Name

-- view piirangud

create view vEmployeeDetails
@Gender nvarchar(20)
as
select Id, Name, Gender, DeptNameId
from EmployeeIndex
where Gender = @Gender
-- parameetreid ei saa sisestada view-sse

-- funktsiooni saab panna parameetreid
create function fnEmployeeDetails(@Gender nvarchar(20))
returns table
as return
(Select Id, Name, Gender, DeptNameId
from EmployeeIndex where Gender = @Gender)

select * from dbo.fnEmployeeDetails('Male')

---
create view vEmployeeDetailsSorted
as
select Id, Name, Gender, DeptNameId
from EmployeeIndex
order by Id

-- order by-d ei saa kasutada views
create table ##TestTempTable(Id int, Name nvarchar(20), Gender nvarchar(10))

create table ##TestTempTable values(105, 'Martin', 'Male')
create table ##TestTempTable values(106, 'Joe', 'Female')
create table ##TestTempTable values(107, 'Pam', 'Female')
create table ##TestTempTable values(108, 'James', 'Male')

create view vOnTempTable
as
select Id, Name, Gender
from ##TestTempTable
-- view koos TempTablega ei saa teha

-- view piirangud 42

--- 9 tund SQL

--- trigger

-- triggereid on kolme t��pi
--1. DML trigger
--2. DDL trigger
--3. LOGON trigger

--- trigger on eriliik stored procedure-st. Kui mingi tegevus leiab andmebaasis aset,
--- siis serveris tehakse ka midagi.

--- DML - data manipulation manipulation
--- DML-i peamised k�sud: Insert, Update ja Delete

-- after trigger:  k�ivitub peale mingit tegevust
-- instead trigger: k�ivitub enne triggeri tegevuse toimumist
create database TARpe22

create table EmployeeTrigger
(
Id int primary key,
Name varchar(30),
Salary int,
Gender nvarchar(10),
DepartmentId int
)


insert into EmployeeTrigger values(1, 'John', 5000, 'Male', 3)
insert into EmployeeTrigger values(2, 'Mike', 3400, 'Male', 2)
insert into EmployeeTrigger values(3, 'Pam', 6000, 'Female', 1)
insert into EmployeeTrigger values(4, 'Todd', 4800, 'Male', 4)
insert into EmployeeTrigger values(5, 'Sara', 3200, 'Female', 1)
insert into EmployeeTrigger values(6, 'Ben', 4800, 'Male', 3)

create table EmployeeAudit
(
Id int identity(1, 1) primary key,
AuditData nvarchar(1000)
)


--- n��d teeme triggeri, et kui sisestan uue t��taja EmployeeTrigger tabelisse,
--- siis EmployeeAudit tabelisse tulevad andmed

--trigger
create trigger tr_Employee_ForInsert
on EmployeeTrigger
for insert
as begin
	declare @Id int
	select @Id = Id from inserted

	insert into EmployeeAudit
	values('New employee with Id = ' + cast(@Id as nvarchar(5)) 
	+ ' is added at ' + cast(Getdate() as nvarchar(20)))
end

insert into EmployeeTrigger values(7, 'Jimmy', 1800, 'Male', 3)

select * from EmployeeAudit

--- peale kustutamist tekiks info EmployeeAudit tabelisse
create trigger EmployeeForDelete
on EmployeeTrigger
for delete
as begin
	declare @Id int
	select @Id = Id from deleted
	
	insert into EmployeeAudit
	values('An existing employee with Id = ' + CAST(@Id as nvarchar(5))
	+ ' is deleted at ' + cast(GETDATE()as nvarchar(20)))
end

delete from EmployeeTrigger where Id = 7

select * from EmployeeAudit

--- after trigger
-- kasutavad kahte tabelit, milleks on INSERTED ja DELETED

-- after trigger n�ide
create trigger trEmployeeForUpdate
on EmployeeTrigger
for update
as begin
	select * from deleted
	select * from inserted
end

update EmployeeTrigger set Name = 'Todd', Salary = 2345,
Gender = 'Male' where Id = 4


--- teeme update triggeri korda
create trigger trEmployeeForUpdate
on EmployeeTrigger
for update
as begin
	-- deklareerisime muutujad, mida hakkame kasutama
	Declare @Id int
	declare @OldName nvarchar(30), @NewName nvarchar(30)
	declare @OldSalary int, @NewSalary int
	declare @OldGender nvarchar(10), @NewGender nvarchar(10)
	declare @OldDeptId int, @NewDeptId int
	-- muutuja, millega hakkame ehitama audit build-i
	declare @AuditString nvarchar(1000)
	-- sisestab andmed temp table-sse
	select * into #TempTable
	from inserted

	while(exists(select Id from #TempTable))
	begin
		-- t�hja stringi initsialiserimine
		Set @AuditString = ''

		-- selekteerime esimese rea andmed temp table-st 
		select top 1 @Id = Id, @NewName = Name,
		@NewGender = Gender, @NewSalary = Salary,
		@NewDeptId = DepartmentId
		from #TempTable

		-- selekteerib k�esoleva rea kustutatud tabelist
		select @OldName = Name,
		@OldGender = Gender, @OldSalary = Salary,
		@OldDeptId = DepartmentId
		from deleted where Id = @Id

		--- ehitame audit stringi d�naamiliseks
		set @AuditString = 'Employee with Id = ' + cast(@Id as nvarchar(4))
		+ ' changed '

		if(@OldName <> @NewName)
			set @AuditString = @AuditString + ' Name from ' + @OldName + ' to '
			+ @NewName

		if(@OldGender <> @NewGender)
			set @AuditString = @AuditString + ' Gender from ' + @OldGender + ' to '
			+ @OldGender

		if(@OldSalary <> @NewSalary)
			set @AuditString = @AuditString + ' Salary from ' 
			+ CAST(@OldSalary as nvarchar(10))
			+ ' to ' + CAST(@NewSalary as nvarchar(10))

		if(@OldDeptId <> @NewDeptId)
			set @AuditString = @AuditString + ' DepartmentId from ' 
			+ CAST(@OldDeptId as nvarchar(10))
			+ ' to ' + CAST(@NewDeptId as nvarchar(10))

		insert into EmployeeAudit values(@AuditString)

		-- kustutab kogu info temp table-st
		delete from #TempTable where Id = @Id
	end
end

select * from EmployeeTrigger

update EmployeeTrigger set Name = 'Todd123', Salary = 3456,
Gender = 'Female', DepartmentId = 3 
where Id = 4

select * from EmployeeTrigger
select * from EmployeeAudit


create table Department
(
Id int primary key,
DeptName nvarchar(20)
)

insert into Department values(1, 'IT')
insert into Department values(2, 'Payroll')
insert into Department values(3, 'HR')
insert into Department values(4, 'Admin')


-- enne triggeri tegemist tuleb teha vaade
create view vEmployeeDetails
as
select EmployeeTrigger.Id, Name, Gender, DeptName
from EmployeeTrigger
join Department
on EmployeeTrigger.DepartmentId = Department.Id



---- instead of insert trigger
create trigger trEmployeeDetailsInsteadOfInsert
on vEmployeeDetails
instead of insert
as begin
	declare @DeptId int

	select @DeptId = Department.Id
	from Department 
	join inserted
	on inserted.DeptName = Department.DeptName

	if(@DeptId is null)
	begin
		raiserror('Invalid Department Name. Statement terminated', 16, 1)
		return
	end

	insert into EmployeeTrigger(Id, Name, Gender, DepartmentId)
	select Id, Name, Gender, @DeptId
	from inserted
end
--- raiserror funktsioon
-- selle eesm�rk on v�lja tuua veateade, kui DepartmentName veerus ei ole v��rtust
-- ja ei �hti sisestatud v��rtusega
-- esimene parameeter on veateate sisu, teiene on veatase (nr 16 t�hendab �ldiseid vigu),
-- kolmas on veaolek

insert into vEmployeeDetails values(7, 'Valarie', 'Female', 'assd')

delete from EmployeeTrigger where Id = 7
--- 10 tund SQL
select * from EmployeeTrigger
select * from vEmployeeDetails


update vEmployeeDetails
set DeptName = 'Payroll'
where Id = 2

--- teeme vaate
alter view vEmployeeDetailsUpdate
as
select EmployeeTrigger.Id, Name, Salary, Gender, DeptName
from EmployeeTrigger
join Department
on EmployeeTrigger.DepartmentId = Department.Id

select * from vEmployeeDetailsUpdate
update EmployeeTrigger set DepartmentId = 4
where Id = 4

--- loome triggeri
alter trigger trEmployeeDetailsInsteadOfUpdate
on vEmployeeDetailsUpdate
instead of update
as begin
	if(update(Id))
	begin
		raiserror('Id cannot be changed', 16, 1)
		return
	end

	if(UPDATE(DeptName))
	begin
		declare @DeptId int
		select @DeptId = Department.Id
		from Department
		join inserted
		on inserted.DeptName = Department.DeptName

		if(@DeptId is null)
		begin
			raiserror('Invalid Department Name', 16, 1)
			return
		end

		update EmployeeTrigger set DepartmentId = @DeptId
		from inserted
		join EmployeeTrigger
		on EmployeeTrigger.Id = inserted.Id
	end

	if(update(Gender))
	begin
		update EmployeeTrigger set Gender = inserted.Gender
		from inserted
		join EmployeeTrigger
		on EmployeeTrigger.Id = inserted.Id
	end

	if(UPDATE(Name))
	begin
		update EmployeeTrigger set Name = inserted.Name
		from inserted
		join EmployeeTrigger
		on EmployeeTrigger.Id = inserted.Id
	end

	if(UPDATE(Salary))
	begin
		update EmployeeTrigger set Salary = inserted.Salary
		from inserted
		join EmployeeTrigger
		on EmployeeTrigger.Id = inserted.Id
	end
end

select * from EmployeeTrigger

update vEmployeeDetailsUpdate
set Name = 'Johny', Gender = 'Female', DeptName = 'IT'
where Id = 1

-- harjutus 47
-- 11 tund SQL

--- delete trigger

create trigger trEmployeeDetails_InsteadOfDelete
on vEmployeeDetails
instead of delete
as begin
	delete EmployeeTrigger
	from EmployeeTrigger
	join deleted
	on EmployeeTrigger.Id = deleted.Id
end

delete from vEmployeeDetails where Id = 2
--- kui seda triggerit ei oleks, siis annaks veateate


--- p�ritud tabelid ja CTE
--- CTE - common table expression 

select * from EmployeeTrigger
select * from Department

-- kasutame view-d
create view vEmployeeCount
as
select DepartmentId, DeptName, COUNT(*) as TotalEmployees
from EmployeeTrigger
join Department
on EmployeeTrigger.DepartmentId = Department.Id
group by DeptName, DepartmentId
go
select * from vEmployeeCount
-- saate vaadata Id j�rgi, et kui palju inimesi konkreetses osakonnas t��tab
select DeptName, TotalEmployees
from vEmployeeCount
where TotalEmployees >= 2

--- temp table
select DeptName, DepartmentId, COUNT(*) as TotalEmployees
into #TempEmployeeCount
from EmployeeTrigger
join Department
on EmployeeTrigger.DepartmentId = Department.Id
group by DeptName, DepartmentId

--- p�ring
select DeptName, TotalEmployees
from  #TempEmployeeCount
where TotalEmployees >= 2

--- kasutame kahte tabeli muutujat
declare @EmployeeCount table
(DeptName nvarchar(20), DepartmentId int, TotalEmployees int)
insert @EmployeeCount
select DeptName, DepartmentId, COUNT(*) as TotalEmployees
from EmployeeTrigger
join Department
on EmployeeTrigger.DepartmentId = Department.Id
group by DeptName, DepartmentId

--- p�ring
select DeptName, TotalEmployees
from @EmployeeCount
where TotalEmployees >= 2


--- sisemine p�ring e subquerie
select DeptName, TotalEmployees
from
( -- kui on sulgude sees, siis on tegemist subqueriga
	select DeptName, DepartmentId, COUNT(*) as TotalEmployees
	from EmployeeTrigger
	join Department
	on EmployeeTrigger.DepartmentId = Department.Id
	group by DeptName, DepartmentId
)
as EmployeeCount
where TotalEmployees >= 2


--- kasutame CTE-d
with EmployeeCount(DeptName, DepartmentId, TotalEmployees)
as
	(
	select DeptName, DepartmentId, COUNT(*) as TotalEmployees
	from EmployeeTrigger
	join Department
	on EmployeeTrigger.DepartmentId = Department.Id
	group by DeptName, DepartmentId
	)
select DeptName, TotalEmployees
from EmployeeCount
where TotalEmployees >= 2


--- CTE serveris

-- with alguss�naga m��ratletakse �ra CTE p�ring
with EmployeeCount(DepartmentId, TotalEmployees)
as
(
	select DepartmentId, COUNT(*) as TotalEmployees
	from EmployeeTrigger
	group by DepartmentId
)
select DeptName, TotalEmployees
from Department
join EmployeeCount
on Department.Id = EmployeeCount.DepartmentId
order by TotalEmployees

--- sulgudes m��ratletakse �ra CTE moodustavad veerud
--- NB! CTE-le saab viidata ainult k�skudega SELECT, INSERT, UPDATE v�i DELETE
--- ja see peab j�rgnema kohe peale CTE-d.

with EmployeeCount(DepartmentId, TotalEmployees)
as
(
	select DepartmentId, COUNT(*) as TotalEmployees
	from EmployeeTrigger
	group by DepartmentId
)
select 'Hello' --- see osa on vale
select DeptName, TotalEmployees
from Department
join EmployeeCount
on Department.Id = EmployeeCount.DepartmentId
order by TotalEmployees

--- kasutame mitu CTE-d korraga
with EmployeeCountBy_Payroll_It_Dept(DeptName, Total)
as 
(
	select DeptName, COUNT(EmployeeTrigger.Id) as TotalEmployees
	from EmployeeTrigger
	join Department
	on EmployeeTrigger.DepartmentId = Department.Id
	where DeptName in ('Payroll', 'IT')
	group by DeptName
), --- n��d tuleb teine CTE ja eraldame need komaga
EmployeesCountBy_HR_Admin_Dept(DeptName, Total)
as
(
	select DeptName, COUNT(EmployeeTrigger.Id) as TotalEmployees
	from EmployeeTrigger
	join Department
	on EmployeeTrigger.DepartmentId = Department.Id
	group by DeptName
)
select * from EmployeeCountBy_Payroll_It_Dept
union -- l�bi unioni �hendad kaks CTE-d �ra
select * from EmployeesCountBy_HR_Admin_Dept

--- CTE update

--- loome lihtsa CTE
with Employees_Name_Gender
as
(
select Id, Name, Gender from EmployeeTrigger
)
select * from Employees_Name_Gender

--- teeme update CTE
with Employees_Name_Gender
as
(
select Id, Name, Gender from EmployeeTrigger
)
update Employees_Name_Gender set Gender = 'Male' where Id = 1

--- CTE, mis m�jutab kahe tabeli andmeid korraga
with EmployeesByDepartment
as
(
	select EmployeeTrigger.Id, Name, Gender, DeptName
	from EmployeeTrigger
	join Department
	on Department.Id = EmployeeTrigger.DepartmentId
)
select * from EmployeesByDepartment

--- ainult �hes tabelis tahtsime andmeid muuta
with EmployeesByDepartment
as
(
	select EmployeeTrigger.Id, Name, Gender, DeptName
	from EmployeeTrigger
	join Department
	on Department.Id = EmployeeTrigger.DepartmentId
)
update EmployeesByDepartment set Gender = 'asd' where Id = 1

--- kahes tabelis korraga ei saa andmeid muuta l�bi CTE
with EmployeesByDepartment
as
(
	select EmployeeTrigger.Id, Name, Gender, DeptName
	from EmployeeTrigger
	join Department
	on Department.Id = EmployeeTrigger.DepartmentId
)
update EmployeesByDepartment set Gender = 'asd123', DeptName = 'IT' where Id = 1

-- muudame DeptName
with EmployeesByDepartment
as
(
	select EmployeeTrigger.Id, Name, Gender, DeptName
	from EmployeeTrigger
	join Department
	on Department.Id = EmployeeTrigger.DepartmentId
)
update EmployeesByDepartment set DeptName = 'HR' where Id = 1
--- enne oli enamus t��tajaid IT osakonnas, aga peale seda koodi,
--- muutsime �ra Department tabelis oleva IT osakonna nime HR peale e 
--- n��d on kaks HR osakonda

--- kokkuv�te:
-- 1. kui CTE baseerub �hel tabelil, siis uuendus t��tab korralikult
-- 2. kui CTE baseerub mitmel tabelil ja uuendus m�jutab mitut tabelit, siis tuleb viga
-- 3. kui CTE baseerub mitmel tabelil ja uuendus m�jutab �hte tabelit, siis viga ei tule
-- uuendus saab tehtud, aga mitte alati oodatud tulemusega


--- CTE kordumine
-- kui CTE viitab iseendale

-- kuidas teha tabeli sisu t�hjaks???
truncate table EmployeeTrigger
select * from EmployeeTrigger

insert into EmployeeTrigger values(1, 'Tom', 2)
insert into EmployeeTrigger values(2, 'Josh', NULL)
insert into EmployeeTrigger values(3, 'Mike', 2)
insert into EmployeeTrigger values(4, 'John', 3)
insert into EmployeeTrigger values(5, 'Pam', 1)
insert into EmployeeTrigger values(6, 'Mary', 3)
insert into EmployeeTrigger values(7, 'James', 1)
insert into EmployeeTrigger values(8, 'Sam', 5)
insert into EmployeeTrigger values(9, 'Simon', 1)

