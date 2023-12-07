﻿create database Academy

use Academy 

--1. Группы (Groups)
--Идентификатор (Id). Уникальный идентификатор группы.
--▷ Тип данных — int.
--▷ Авто приращение.
--▷ Не может содержать null-значения.
--▷ Первичный ключ.
--▷ Первичный ключ. Название (Name). Название группы.
--▷ Тип данных — nvarchar(10).
--▷ Не может содержать null-значения.
--▷ Не может быть пустым.
--▷ Должно быть уникальным.
--■ Рейтинг (Rating). Рейтинг группы.
--▷ Тип данных — int.
--▷ Не может содержать null-значения.
--▷ Должно быть в диапазоне от 0 до 5.
--■ Курс (Year). Курс (год) на котором обучается группа.
--▷ Тип данных — int.
--▷ Не может содержать null-значения.
--▷ Должно быть в диапазоне от 1 до 5.
create table Groups
(
  id int not null primary key identity(1,1),
  Name nvarchar(10) not null check(Name <> '') unique,
  Rating int not null check(Rating>=0 and Rating<=5),
  Year int not null check(Year>=1 and Year<=5)
)

--2. Кафедры (Departments)
--■ Идентификатор (Id). Уникальный идентификатор кафедры.
--▷ Авто приращение.
--▷ Не может содержать null-значения.
--▷ Первичный ключ.
--■ Финансирование (Financing). Фонд финансирования кафедры.
--▷ Не может содержать null-значения.
--▷ Не может быть меньше 0.
--■ Название (Name). Название кафедры.
--▷ Не может содержать null-значения.
--▷ Не может быть пустым.
--▷ Должно быть уникальным.
create table Departments
(
  id int not null primary key identity(1,1),
  Financing money not null check(Financing>=0) default 0,
  Name nvarchar(100) not null check(Name <> '') unique
) 

--3. Факультеты (Faculties)
--■ Идентификатор (Id). Уникальный идентификатор факультета.
--▷ Авто приращение.
--▷ Не может содержать null-значения.
--▷ Первичный ключ.
--Декан (Dean). Декан факультета.
--▷тип данных nvarchar(max)
--▷ Не может содержать null-значения.
--▷ Не может быть пустым.
--■ Название (Name). Название факультета.
--▷ Не может содержать null-значения.
--▷ Не может быть пустым.
--▷ Должно быть уникальным.
create table Faculties
(
	id int not null primary key identity(1,1),
	Dean nvarchar(max) not null check(Dean <> ''),
	Name nvarchar(100) not null check(Name <> '') unique
)

--▷4. Преподаватели (Teachers)
--■ Идентификатор (Id). Уникальный идентификатор преподавателя.
--▷ Авто приращение.
--▷ Не может содержать null-значения.
--▷ Первичный ключ.
--■ Дата трудоустройства (EmploymentDate). Дата приема
--преподавателя на работу.
--▷ Не может содержать null-значения.
--▷ Не может быть меньше 01.01.1990.
--Ассистент (IsAssistant). Является ли преподаватель ассистентом.
--▷тип данных bit
--▷ Не может содержать null-значения.
--▷значение по умолчанию 0
--■ Профессор (IsProfessor). Является ли преподаватель профессором.
--▷тип данных bit
--▷ Не может содержать null-значения.
--▷значение по умолчанию 0
--■ Имя (Name). Имя преподавателя.
--▷ Не может содержать null-значения.
--▷ Не может быть пустым.
--■ Должность (Position). Должность преподавателя.
--▷тип данных nvarchar(max) 
--▷ Не может содержать null-значения.
--▷ Не может быть пустым.
--■ Надбавка (Premium). Надбавка преподавателя.
--▷ Не может содержать null-значения.
--▷ Не может быть меньше 0.
--■ Ставка (Salary). Ставка преподавателя.
--▷ Не может содержать null-значения.
--▷ Не может быть меньше либо равно 0.
--■ Фамилия (Surname). Фамилия преподавателя.
--▷ Не может содержать null-значения.
--▷ Не может быть пустым.
create table Teachers
(
	id int not null primary key identity(1,1),
	EmploymentDate date not null check(EmploymentDate>='1990-01-01'),
	IsAssistant bit not null default 0,
	IsProfessor bit not null default 0,
	Name nvarchar(max) not null check(Name <> ''),
	Position nvarchar(max) not null check(Position <> ''),
	Premium money not null default 0 check(Premium>=0),
	Salary money not null check(Salary>0),
	Surname nvarchar(max) not null check(Surname <> '')
)
--1. Вывести таблицу кафедр, но расположить ее поля в обратном порядке. 
select Name, Financing, id from Departments order by id desc

--2. Вывести названия групп и их рейтинги с уточнением имен полей именем таблицы. 
select Groups.Name as 'Название группы', Rating from Groups

--3. Вывести для преподавателей их фамилию, процент ставки по отношению к надбавке и процент ставки по отношению к зарплате (сумма ставки и надбавки). 
select Surname, (Premium/Salary)*100 as 'Premium %', (Salary/Salary)*100 as 'Salary %' from Teachers

--4. Вывести таблицу факультетов в виде одного поля в следующем формате: "The dean of faculty [faculty] is dean" 
select 'The dean of faculty ' + Name + 'is dean' as 'Faculty Dean' from Faculties

--5. Вывести фамилии преподавателей, которые являются профессорами и ставка которых превышает 1050. 
select Surname from Teachers where IsProfessor = 1 and Salary > 1050

--6. Вывести названия кафедр, фонд финансирования которых меньше 11000 или больше 25000. 
select Name from Departments where Financing < 11000 or Financing > 25000

--7. Вывести Названия Факультетов кроме факультета “Computer Science”. 
select Name from Faculties where Name <> 'Computer Science'

--8. Вывести фамилии и должности преподавателей, которые не являются профессорами. 
select Surname, Position from Teachers where IsProfessor = 0

--9. Вывести фамилии, должности, ставки и надбавки ассистентов, у которых надбавка в диапазоне от 160 до 550. 
select Surname, Position, Salary, Premium from Teachers where IsAssistant = 1 and Premium between 160 and 550

--10.Вывести фамилии и ставки ассистентов. 
select Surname, Salary from Teachers where IsAssistant = 1

--11.Вывести фамилии и должности преподавателей, которые были приняты на работу до 01.01.2000. 
select Surname, Position from Teachers where EmploymentDate < '2000-01-01'

--12.Вывести названия кафедр, которые в алфавитном порядке располагаются до кафедры Software Development". Выводимое поле должно иметь название “Name of Department”. 
select Name as 'Name of Department' from Departments order by Name

--13.Вывести фамилии ассистентов, имеющих зарплату (сумма ставки и надбавки) не более 1200. 
select Surname from Teachers where IsAssistant = 1 and Salary + Premium <= 1200

--14.Вывести названия групп 5-го курса, имеющих рейтинг в диапозоне от 2 до 4 
select Name from Groups where Year = 5 and Rating between 2 and 4

--15. Вывести фамилии ассистентов со ставкой меньше 550 или надбавкой меньше 200. 
select Surname from Teachers where IsAssistant = 1 and (Salary < 550 or Premium < 200)