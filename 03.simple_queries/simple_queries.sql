use BD_Universidad

-- Exercise a: nombre, apellidos, # oficina y fecha nombramiento de profesores.
select NombreP, Apellido1, Apellido2, Oficina, FechaNomb
from Profesor

-- Exercise b: cedula y nombre estudiantes que han llevado el curso ART2.
select Estudiante.Cedula, Estudiante.NombreP, Estudiante.Apellido1, Estudiante.Apellido2, Lleva.Nota, Lleva.SiglaCurso
from Estudiante, Lleva
where Lleva.SiglaCurso='ART2' and Lleva.CedEstudiante=Estudiante.Cedula -- Informal join, possible change.

-- Exercise c: # carne y nombre de estudiantes con notas 60<x<80, sin que se repitan los registros.
SELECT DISTINCT Estudiante.Carne, Estudiante.NombreP, Estudiante.Apellido1, Estudiante.Apellido2
FROM Estudiante, Lleva
WHERE Estudiante.Cedula = Lleva.CedEstudiante AND Lleva.Nota BETWEEN 60 AND 80;

-- Exercise d: sigla de cursos que tengan como requisito CI1312.
select Curso.Sigla
from Curso, Requiere_De
where Curso.Sigla=Requiere_De.SiglaCursoRequeridor and Requiere_De.SiglaCursoRequisito='CI1312'

-- Exersise e: Nota maxima, minima y promedia de las notas del curso CI1221.
select max(Lleva.Nota) as 'Nota Maxima', min(Lleva.Nota) as 'Nota Minima', avg(Lleva.Nota) as 'Promedio de Notas'
from Lleva, Estudiante
where Lleva.SiglaCurso='CI1221' and Lleva.CedEstudiante=Estudiante.Cedula

-- Exersise f: nombre de escuelas y sus carreras ordenas ambas por nombre.
select Escuela.Nombre, Carrera.Nombre
from Escuela, Carrera
where Carrera.CodEscuela=Escuela.Codigo
order by Escuela.Nombre, Carrera.Nombre

-- Exercise g: cantidad de profesores en computacion identificando la escuela solo por nombre.
select count(Trabaja_en.CedProf)
from Trabaja_en, Profesor
where Trabaja_en.CedProf=Profesor.Cedula and Trabaja_en.CodEscuela=(select Escuela.Codigo
																	from Escuela
																	where Escuela.Nombre like '%ó%')

-- Exercise h: cedula de los estudiantes que no estan empadronados en ninguna escuela.
select Estudiante.Cedula
from Estudiante
where not exists	(select Empadronado_en.CedEstudiante
					from Empadronado_en
					where Estudiante.Cedula = Empadronado_en.CedEstudiante)

-- Exercise i: sigla, # grupo, semestre, año, asistente y horas asignadas al asistente de todos los grupos.
select Grupo.SiglaCurso, Grupo.NumGrupo, Grupo.Semestre, Grupo.Anno, Grupo.CedAsist, Asistente.NumHoras
from Grupo left join Asistente on Grupo.CedAsist=Asistente.Cedula -- Se usa este tipo de join porque solo ocupamos unir los datos de las horas asignadas con los de las tablas de la izquierda que ya tenemos, por eso el left join.

-- Exercise j: nombre de estudiantes cuyo 1 apellido termina en a.
select Estudiante.NombreP, Estudiante.Apellido1
from Estudiante
where Estudiante.Apellido1 like '%a'
-- Como cambiaria para incluir tambien a los que tienen nombre que empiezan con m.
-- where Estudiante.Apellido1 like '%a' or Estudiante.NombreP like 'M%'
-- Como cambiar para incluir a los que primer apellido empieza con M y termina con A.
--where Estudiante.Apellido1 like 'M%a'

-- Exercise k: nombre de los estudiantes con exactamente 6 caracteres.
select Estudiante.NombreP
from Estudiante
where Estudiante.NombreP like '______'

-- Exercise l: nombre de estudiantes y profesores hombres, deben salir en una misma tabla.
select Profesor.NombreP
from Profesor
where Profesor.Sexo like '%M%'
union all
select Estudiante.NombreP
from Estudiante
where Estudiante.Sexo like '%m%'

-- Exercise m: Carn� y Nombre de estudiantes que no tienen telefono registrado.
select Estudiante.Carne, Estudiante.NombreP
from Estudiante
where Estudiante.Teléfono is NULL

