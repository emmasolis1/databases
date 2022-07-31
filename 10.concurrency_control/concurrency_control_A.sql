------ Escenario 1: Read Uncommited ------
--- Pregunta 4
set implicit_transactions off;
set transaction isolation level read uncommitted;
begin transaction t1;
PRINT @@TRANCOUNT
Select avg(Nota) from Lleva;


--- Pregunta 6
Select avg(Nota) from Lleva;

--- Pregunta 8
Select avg(Nota) from Lleva;
Commit transaction t1;


------ Escenario 2: Read Commited ------
--- Pregunta 10
set implicit_transactions off;
set transaction isolation level read committed;
begin transaction t3;
Select avg(Nota) from Lleva;

--- Pregunta 12
Select max(Nota) from Lleva;

--- Pregunta 14
Commit transaction t3;


------ Escenario 3: Repetable Read ------
--- Pregunta 16
set implicit_transactions off;
set transaction isolation level repeatable read;
begin transaction t5;
Select avg(Nota) from Lleva;

--- Pregunta 18
Select avg(Nota) from Lleva;
commit transaction t5;


------ Escenario 4: Serializable ------
--- Pregunta 20
set implicit_transactions off;
set transaction isolation level serializable;
begin transaction t7;
Select avg(Nota) from Lleva;

--- Pregunta 22
Select avg(Nota) from Lleva;
commit transaction t7;
