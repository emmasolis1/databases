-- Ejercicio 1
create trigger limiteMatricula
on Lleva instead of insert
AS
declare @numCreditosActual decimal, @creditosForThis decimal,
    @cedula char(10), @sigla VARCHAR(8), @numeroGrupo tinyint, @semester tinyint, @anno date
select @cedula = ins.cedEstudiante, @sigla = ins.siglaCurso, @numeroGrupo=ins.numGrupo, @semester=ins.semestre, @anno=ins.anyo
from inserted ins
begin
declare @cursor_lleva CURSOR
for select creditosForThis from (select Curso.Creditos from Curso Where Curso.sigla=@sigla);
open cursor_lleva;
fetch next from cursor_lleva into @cedula, @sigla, @numeroGrupo, @semester, @anno;
while @@fetch_status = 0
    begin
        fetch next from cursor_lleva into @cedula, @sigla, @numeroGrupo, @semester, @anno;
        @numCreditosActual = @numCreditosActual + @creditosForThis;
    end;
close cursor_lleva;
deallocate cursor_lleva;
-- Comprobacion para ver si puede matricular
if @numCreditosActual <= 18
    begin
        insert values (@cedula, @sigla, @numeroGrupo, @semester, @anno) into Lleva
    end;
else 
    print 'No se puede matricular este estudiante porque no se permite llevar una carga mayor a 18 creditos.'
end;

-- Ejercicio 3
create view EstudiantesPorGrupo
as
select Grupo.siglaCurso, Grupo.numGrupo, Grupo.semestre, Grupo.anyo, count(cedEstudiante) as 'cantidadEstudiantes'
from Grupo JOIN Lleva ON Lleva.siglaCurso = Grupo.siglaCurso 
	and Lleva.numGrupo = Grupo.numGrupo 
	and Lleva.semestre = Grupo.semestre 
	and Lleva.anyo = Grupo.anyo
group by
	Grupo.siglaCurso,
	Grupo.numGrupo,
	Grupo.semestre,
	Grupo.anyo


-- Prueba de funcionamiento
select * from EstudiantesPorGrupo
select * from Profesor
select * from Estudiante
select * from Lleva
select * from Grupo

insert into Lleva (cedEstudiante, siglaCurso, numGrupo, semestre, anyo)
values ('0123456789', 'CI-0118', '1', '2', '2022');
insert into Lleva (cedEstudiante, siglaCurso, numGrupo, semestre, anyo)
values ('0123456789', 'CI-0120', '1', '2', '2022');

delete from Lleva
where cedEstudiante = '0123456789'
    and siglaCurso = 'CI-0118'
    and numGrupo = '1'
    and semestre = '2'
    and anyo = '2022'
select * from EstudiantesPorGrupo

