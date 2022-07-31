-- Ejercicio 1
create procedure MatricularEstudiante(
	@cedula		as char(10),
	@siglaCurso as varchar(8),
	@numGrupo	as tinyint,
	@semestre	as tinyint,
	@anyo		as date,
	@nota		as float = NULL,
	@config		as bit)
as
begin
	declare @Empadronado_Conf bit=1;
	if @config=1	--Se matricula sin importar si el curso pertenece a alguna carrera del estudiante
		begin
			select @Empadronado_Conf = count(*)
			from  Empadronado_En empadronado JOIN Pertenece_A pertenece on empadronado.CodCarrera = pertenece.CodCarrera join Estudiante estudiante on estudiante.Cedula=empadronado.CedEstudiante
			where empadronado.CedEstudiante = @cedula and pertenece.SiglaCurso = @siglaCurso
		end;
	if @Empadronado_Conf=1	--Se matricula solo si el curso pertenece a alguna carrera del estudiante
		begin
			insert into LLEVA 
			values (@cedula, @siglaCurso, @numGrupo, @semestre, @anyo, @nota)
		end;
	else
		begin
			print 'No se puede matricular el estudiante porque este curso no pertenece a su carrera'
		end;
end;

select * from Estudiante
select * from LLEVA
exec MatricularEstudiante @cedula='0123456789', @siglaCurso='CI-0110', @numGrupo=1, @semestre=2, @anyo='2022', @config=0
select * from Estudiante
select * from LLEVA


-- Ejercicio 2
create function DiferenciaPromNiv(@nivel1 decimal, @nivel2 decimal, @carreraCodigo varchar)
returns decimal as
begin 
	-- Calcular primer promedio
	declare @primerPromedio decimal, @segundoPromedio decimal;
		set @primerPromedio = (select AVG(LLEVA.nota) from Lleva, PERTENECE_A where PERTENECE_A.codCarrera=@carreraCodigo and PERTENECE_A.nivelPlanEstudios=@nivel1);
		set @segundoPromedio = (select AVG(LLEVA.nota) from Lleva, PERTENECE_A where PERTENECE_A.codCarrera=@carreraCodigo and PERTENECE_A.nivelPlanEstudios=@nivel2);
	return ABS(@primerPromedio - @segundoPromedio);
end;

select dbo.DiferenciaPromNiv(2, 2, 'Bachi01Comp') as 'diferencia' 


-- Ejercicio 3
create procedure ActualizarCreditos (@carreraCodigo varchar(10), @porcentajeAumento decimal (5,2))
as
begin
	update CURSO set creditos = round(creditos * (1 + (@porcentajeAumento / 100)), 0)
	from CURSO join PERTENECE_A ON CURSO.sigla = PERTENECE_A.siglaCurso
	where PERTENECE_A.codCarrera = @carreraCodigo
end

select * from CURSO
exec ActualizarCreditos @carreraCodigo='Bach01Comp', @porcentajeAumento=50
select * from CURSO

