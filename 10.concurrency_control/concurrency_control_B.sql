------ Escenario 1: Read Uncommited ------
--- Pregunta 5
set implicit_transactions off;
begin transaction t2;
PRINT @@TRANCOUNT
Select * from sys.sysprocesses
where open_tran = 1;
Update Lleva
set Nota = Nota*(0.8)
where Nota is not null;

--- Pregunta 7
rollback transaction t2;


------ Escenario 2: Read Commited ------
--- Pregunta 11
set implicit_transactions off;
begin transaction t4;
Update Lleva
set Nota = Nota*(0.8)
where Nota is not null;

--- Pregunta 13
Select * from sys.sysprocesses
where open_tran = 1
commit transaction t4;


------ Escenario 3: Repetable Read ------
--- Pregunta 17
set implicit_transactions off;
begin transaction t6;
Insert into Lleva
(CedEstudiante, SiglaCurso,
NumGrupo, Semestre, Anyo, Nota)
values('1111111111', 'CI-0127', 1, 1,
'2019', 85);
commit transaction t6;


------ Escenario 4: Serializable ------
--- Pregunta 21
set implicit_transactions off;
begin transaction t8;
Insert into Lleva
(CedEstudiante, SiglaCurso,
NumGrupo, Semestre, Anyo, Nota)
values('2222222222', 'CI-0120', 1, 1,
'2019', 85);

--- Pregunta 23
commit transaction t8;
