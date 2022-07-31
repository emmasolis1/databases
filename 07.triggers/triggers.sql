-- Ejercicio 1
create trigger deleteStudent
on Estudiante INSTEAD OF DELETE -- Considero que es necesario usar el INSTEAD OF porque no puedo borrar una tabla de Asistente si ya no tengo forma de acceder a su llave principa, es decir si borro Estudiante primero.
AS
declare @cedula char(10)
select @cedula=est.cedula
from deleted est
BEGIN
	-- First delete this student from the courses he assist and other places where he is referenced.
    update Grupo set cedAsist=NULL where cedAsist=@cedula
    delete from LLEVA where cedEstudiante=@cedula;
    delete from EMPADRONADO_EN where cedEstudiante=@cedula;
    -- Second delete from Asistente
    delete from Asistente where cedula=@cedula;
    -- Finally delete from Estudiante
    delete from Estudiante where cedula=@cedula;
    END
-- Prueba de funcionamiento
select * from ESTUDIANTE
select * from ASISTENTE
select * from GRUPO
delete from ESTUDIANTE where cedula='0118130888'
select * from ESTUDIANTE
select * from ASISTENTE
select * from GRUPO


-- Ejercicio 2
create trigger keepISAonProfesor
on Profesor INSTEAD OF INSERT
AS
declare @cedula char(10)
select @cedula=persona.cedula
from inserted persona
if exists(select cedula from ESTUDIANTE where cedula=@cedula)
	begin
    	print 'No se puede ingresar este profesor porque ya existe como un estudiante'
    end
else
	begin
    	INSERT INTO PROFESOR(
            [cedula],
            [email],
            [nombre],
            [apellido1],
            [apellido2],
            [sexo],
            [fechaNac],
            [direccion],
            [telefono],
            [categoria],
            [fechaNomb],
            [titulo],
            [oficina])
        SELECT  cedula, email, nombre, apellido1, apellido2, sexo, fechaNac, direccion, telefono, categoria, fechaNomb, titulo, oficina
        FROM INSERTED
            print 'Profesor ingresado correctamente'
    END;

create trigger keepISAonEstudiante
on Estudiante INSTEAD OF INSERT
AS
declare @cedula char(10)
select @cedula=persona.cedula
from inserted persona
if exists(select cedula from PROFESOR where cedula=@cedula)
	begin
        print 'No se puede ingresar este estudiante porque ya existe como un profesor'
    end
else
	begin
        INSERT INTO ESTUDIANTE(
            [cedula],
            [email],
            [nombre],
            [apellido1],
            [apellido2],
            [sexo],
            [fechaNac],
            [direccion],
            [telefono], 
            [carne],
            [estado])
        SELECT  cedula, email, nombre, apellido1, apellido2, sexo, fechaNac, direccion, telefono, carne, estado
        FROM INSERTED
        PRINT 'Estudiante ingresado correctamente'
    END;
    
-- Prueba de funcionamiento
select * from ESTUDIANTE
select * from PROFESOR
insert into PROFESOR values('1234567890', 'pruebaEstudiante@ucr.ac.cr', 'Maria', 'Zuniga', 'NULL', 'M', '1970-10-09', 'Costa Rica', '34984454',	'Catedratico', '1995-03-03', 'Doctor', '232')
insert into ESTUDIANTE values('5345345323', 'edgar.casasola@ucr.ac.cr', 'Edgar', 'Casasola', 'NULL', 'M', '1970-10-09', 'Costa Rica', '34984464', 'A54321', 'activo')

    