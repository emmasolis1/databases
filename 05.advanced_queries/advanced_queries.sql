use BD_Universidad

----------------- PARTE C ------------------
-- Ejercicio 1
select distinct e.NombreP, e.Apellido1, g.SiglaCurso
from Asistente a join Estudiante e on a.Cedula=e.Cedula join Grupo g on e.Cedula=g.CedAsist

-- Ejercicio 2
/* Nota: en los resultados NO se incluye la cedula porque es redundante y el ejercicio no lo pedía,
originalmente yo lo tenia pero como no se pide me da miedo ponerlo y luego me rebajen puntos por poner algo que no se pidio;
de cualquier forma es solo agregar abajo en la primer linea del select un 'Lleva.CedEstudiante'. */
select Lleva.SiglaCurso, Lleva.NumGrupo, Lleva.Semestre, Lleva.Semestre, Lleva.Anno, Lleva.Nota, Pertenece_a.NivelPlanEstudios
from Lleva left join Pertenece_a on Pertenece_a.SiglaCurso=Lleva.SiglaCurso
where Lleva.CedEstudiante=(select Estudiante.Cedula
						from Estudiante
						where Estudiante.NombreP='Gabriel' and Estudiante.Apellido1='Sánchez')
order by Pertenece_a.NivelPlanEstudios, Lleva.SiglaCurso


----------------- PARTE D ------------------
-- Ejercicio 3
select Profesor.Titulo, count(Profesor.Titulo) as CantidadPosesores
from Profesor
group by Profesor.Titulo
order by CantidadPosesores desc

-- Ejercicio 4
select distinct Estudiante.Cedula, avg(Lleva.Nota) as PromedioNota
from Estudiante, Lleva
where Lleva.CedEstudiante=Estudiante.Cedula
group by Estudiante.Cedula
order by Estudiante.Cedula

-- Ejercicio 5
select distinct Participa_en.NumProy, sum(Participa_en.Carga) as TotalCarga
from Participa_en
group by Participa_en.NumProy

-- Ejercicio 6
select Pertenece_a.SiglaCurso, count(Pertenece_a.SiglaCurso) as CantidadCarrerasLoTienen
from Pertenece_a
group by Pertenece_a.SiglaCurso 
having count(Pertenece_a.SiglaCurso) >= 2

-- Ejercicio 7
select Facultad.Nombre, count(Carrera.Codigo) as CantCarreras
from Facultad left join Escuela on Facultad.Codigo=Escuela.CodFacultad left join Carrera on Escuela.Codigo=Carrera.CodEscuela
group by Facultad.Nombre
order by CantCarreras desc


-- Ejercicio 8
select Grupo.NumGrupo, Grupo.SiglaCurso, Grupo.Semestre, Grupo.Anno, count(Lleva.CedEstudiante) as CantEstuMatriculados
from Grupo left join Lleva on Grupo.NumGrupo=Lleva.NumGrupo and Grupo.SiglaCurso=Lleva.SiglaCurso and Grupo.Semestre=Lleva.Semestre and Grupo.Anno=Lleva.Anno
where Grupo.SiglaCurso like 'CI%'
group by Grupo.NumGrupo, Grupo.SiglaCurso, Grupo.Semestre, Grupo.Anno

-- Ejercicio 9
select Grupo.NumGrupo, Grupo.SiglaCurso, Grupo.Semestre, Grupo.Anno, min(Lleva.Nota) as NotaMinima, max(Lleva.Nota) as NotaMaxima, avg(Lleva.Nota) as PromedioNota
from Grupo join LLeva on Grupo.NumGrupo=Lleva.NumGrupo and Grupo.SiglaCurso=Lleva.SiglaCurso and Grupo.Semestre=Lleva.Semestre and Grupo.Anno=Lleva.Anno
group by Grupo.NumGrupo, Grupo.SiglaCurso, Grupo.Semestre, Grupo.Anno
having min(Lleva.Nota) >= 70