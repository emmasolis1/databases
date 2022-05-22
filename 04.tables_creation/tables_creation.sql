use [database_name]

------------------ PUNTO 3 ------------------- 
-- Estudiante
create table ESTUDIANTE
	(cedula		char(10)		not null,
	email		varchar(50),	
	nombre		varchar(20)		not null,
	apellido1	varchar(20)		not null,
	apellido2	varchar(20),
	sexo		char(1)			not null,
	fechaNac	date			not null,
	direccion	varchar(50),
	telefono	varchar(11),
	carne		char(6),
	estado		varchar(8)		not null,
	primary key (cedula)
	);

-- Profesor
create table PROFESOR
	(cedula		char(10)		not null,
	email		varchar(50),	
	nombre		varchar(20)		not null,
	apellido1	varchar(20)		not null,
	apellido2	varchar(20),
	sexo		char(1)			not null,
	fechaNac	date			not null,
	direccion	varchar(50),
	telefono	varchar(11),
	categoria	varchar(20),
	fechaNomb	date			not null,
	titulo		varchar(15),
	oficina		tinyint,
	primary key (cedula)
	);

-- Asistente
create table ASISTENTE
	(cedula		char(10)		not null,
	numHoras	tinyint,
	primary key (cedula),
	foreign key (cedula) references ESTUDIANTE
	);

-- Curso
create table CURSO
	(sigla		varchar(8)		not null,
	nombre		varchar(40)		not null,
	creditos	tinyint			not null,
	primary key (sigla)
	);

-- Grupo
create table GRUPO
	(siglaCurso	varchar(8)		not null,
	numGrupo	tinyint			not null,
	semestre	tinyint			not null,
	anyo		date			not null,
	cedProfesor	char(10)		not null,
	carga		tinyint			not null	default 0,
	cedAsist	char(10)		not null,
	primary key (siglaCurso, numGrupo, semestre, anyo),
	foreign key (siglaCurso) references CURSO
		on delete no action,
	foreign key (cedProfesor) references PROFESOR
		on update cascade,
	foreign key (cedAsist) references ASISTENTE
	);

-- Lleva
create table LLEVA
	(cedEstudiante		char(10)		not null,
	siglaCurso			varchar(8)		not null,
	numGrupo			tinyint			not null,
	semestre			tinyint			not null,
	anyo				date			not null,
	nota				float,			check (nota >= 0 and nota <= 100),
	primary key (cedEstudiante, siglaCurso, numGrupo, semestre, anyo),
	foreign key (cedEstudiante) references ESTUDIANTE,
	foreign key (siglaCurso, numGrupo, semestre, anyo) references GRUPO
	);

-- Carrera
create table CARRERA
	(codigo				varchar(10)		not null,
	nombre				varchar(50)		not null,
	anyoCreacion		date,
	primary key (codigo)
	);

-- Empadronado en
create table EMPADRONADO_EN
	(cedEstudiante		char(10)		not null,
	codCarrera			varchar(10)		not null,
	fechaIngreso		date,
	fechaGraduacion		date,
	primary key (cedEstudiante, codCarrera),
	foreign key (cedEstudiante) references ESTUDIANTE
		on delete cascade,
	foreign key (codCarrera) references CARRERA
	);

-- Pertenece a
create table PERTENECE_A
	(siglaCurso			varchar(8)		not null,
	codCarrera			varchar(10)		not null,
	nivelPlanEstudios	tinyint,
	primary key (siglaCurso, codCarrera),
	foreign key (siglaCurso) references CURSO,
	foreign key (codCarrera) references CARRERA
	);


------------------ PUNTO 4 ------------------- 

-- Insertar en Estudiante
insert into ESTUDIANTE
values ('4945784456', 'emmanuel.mendezperez@tec.ac.cr', 'Emmanuel', 'Mendez', 'Perez', 'M', '20010515', 'San Jose', '73463435', 'B96543', 'activo');

insert into ESTUDIANTE (cedula, email, nombre, apellido1, sexo, fechaNac, direccion, telefono, carne, estado)
values ('1234567890', 'pruebaEstudiante@costarica.cr', 'Maria', 'Zuniga', 'M', '20010515', 'USA', '34545456', 'A12345', 'inactivo');

select *
from ESTUDIANTE

-- Insertar en Profesor
insert into PROFESOR
values ('8945453454', 'joe.hidalgo@costarica.cr', 'joe', 'Hidalgo', 'Cespedes', 'M', '19700322', 'Coronado', '65654342', 'Catedratico', '20000303', 'Master', 230);

insert into PROFESOR (cedula, email, nombre, apellido1, sexo, fechaNac, direccion, telefono, categoria, fechaNomb, titulo, oficina)
values ('5345345323', 'mario.casasola@costarica.cr', 'mario', 'Casasola', 'M', '19701009', 'Costa Rica', '34545454', 'Catedratico', '19950303', 'Doctor', 231);

select *
from PROFESOR

-- Insertar en Asistente
insert into ASISTENTE
values('1234567890', 4)

insert into ASISTENTE (cedula, numHoras)
values('4945784456', 20)

select *
from ASISTENTE

-- Insertar en Curso
insert into CURSO
values('CI-0118', 'Programacion Paralela', 4)

insert into CURSO(nombre, sigla, creditos)
values('Bases de Datos I', 'CI-0120', 4)

select *
from CURSO

-- Insertar en Grupo
insert into GRUPO
values('CI-0120', 1, 2, '2022', '5345345323', 4, '1234567890')

insert into GRUPO
values('CI-0118', 1, 2, '2022', '8945453454', 4, '4945784456')

select *
from GRUPO

-- Insertar en relacion Lleva
insert into LLEVA (cedEstudiante, siglaCurso, numGrupo, semestre, anyo, nota)
values ('4945784456', 'CI-0120', 1, 2, '2022', 100)

insert into LLEVA (cedEstudiante, siglaCurso, numGrupo, semestre, anyo)
values ('1234567890', 'CI-0118', 1, 2, '2022')

select *
from LLEVA

-- Insertar en Carrera
insert into CARRERA
values ('Bach01Comp', 'Bachillerato en Ciencias de la Computacion', '1981')

insert into CARRERA
values ('Bach01IngE', 'Bachillerato en Ingenier�a El�ctrica', '1988')

select *
from Carrera

-- Insertar en relacion Empadronado En
insert into EMPADRONADO_EN(cedEstudiante, codCarrera, fechaIngreso, fechaGraduacion)
values ('4945784456', 'Bach01Comp', '2019', '2023')

insert into EMPADRONADO_EN(cedEstudiante, codCarrera, fechaIngreso, fechaGraduacion)
values ('1234567890', 'Bach01IngE', '2015', '2022')

select *
from EMPADRONADO_EN

use [database_name]
-- Insertar en relacion Pertenece A
insert into PERTENECE_A(siglaCurso, codCarrera, nivelPlanEstudios)
values('CI-0118', 'Bach01Comp', 2)

insert into PERTENECE_A(siglaCurso, codCarrera, nivelPlanEstudios)
values('CI-0120', 'Bach01Comp', 2)

select *
from PERTENECE_A


------------------ PUNTO 5 ------------------- 

-- ON DELETE CASCADE

-- primero insertamos un valor de prueba en la tabla Estudiante y Empradronado En
insert into ESTUDIANTE (cedula, email, nombre, apellido1, sexo, fechaNac, direccion, telefono, carne, estado)
values ('0987654321', 'pruebaEstudiante@costarica.cr', 'Maria', 'Zuniga', 'M', '20010515', 'USA', '34545456', 'A54321', 'inactivo');
insert into EMPADRONADO_EN(cedEstudiante, codCarrera, fechaIngreso, fechaGraduacion)
values ('0987654321', 'Bach01IngE', '2015', '2022')

-- vemos como se encuentran ambas tablas
select *
from ESTUDIANTE
select *
from EMPADRONADO_EN

-- hacemos el respectivo delete de la tupla en Estudiante para ver si se actualiza el borrado en Empadronado En
delete from ESTUDIANTE
where cedula='0987654321'

-- comprobamos si el borrado se hizo
select *
from ESTUDIANTE
select *
from EMPADRONADO_EN

-- ON DELETE NO ACTION

-- insertamos valores de prueba
insert into CURSO(nombre, sigla, creditos)
values('Programacion I', 'CI-0110', 4)
insert into GRUPO
values('CI-0110', 1, 2, '2022', '8945453454', 4, '4945784456')

-- vemos el estado inicial de las tablas
select *
from CURSO
select *
from GRUPO

-- vemos el estado de las tablas luego de hacer un borrado en Curso
delete from CURSO
where sigla='CI-0110'
select *
from CURSO
select *
from GRUPO

-- ON UPDATE CASCADE

-- insertamos unos valores de prueba
insert into PROFESOR (cedula, email, nombre, apellido1, sexo, fechaNac, direccion, telefono, categoria, fechaNomb, titulo, oficina)
values ('6427363634', 'paula.ramirez@costarica.cr', 'paula', 'Ramirez', 'F', '19701009', 'Costa Rica', '34545454', 'Catedratico', '19950303', 'Doctor', 231);
insert into GRUPO
values('CI-0110', 1, 2, '2018', '6427363634', 4, '4945784456')

-- vemos el estado inicial de las tablas
select *
from PROFESOR
select *
from GRUPO

-- vemos como se encuentran las tablas luego de actualizar la cedula del profesor, deberia actualizar su cedula en el grupo
update PROFESOR
set cedula='7324137344'
where cedula='6427363634' 
select *
from PROFESOR
select *
from GRUPO

