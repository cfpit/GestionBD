-- Funciones de Agrupacion
        use pubs;
-- 1. Listar la cantidad de libros de la base.
SELECT COUNT(*) FROM titles;

-- 2. Listar la suma de precios de todos los titulos.
SELECT TRUNCATE(SUM(price), 2) FROM titles;

-- 3. Listar el promedio de horas trabajadas por todos los empleados.
SELECT AVG(job_lvl) FROM employee;

-- 4. Listar el precio del titulo mas caro.
SELECT MAX(price) FROM titles;

-- 5. Listar el precio del titulo mas barato.
SELECT MIN(price) FROM titles;

-- 6. Listar el nombre del titulo mas barato.
SELECT  title 
FROM    titles 
WHERE   price = (SELECT MIN(price) FROM titles);

-- 7. Listar el nombre y apellido del autor que escribio el titulo mas reciente.
SELECT  CONCAT(a.au_fname, ' ', a.au_lname) as autor
FROM    authors a
INNER JOIN titleauthor ta ON a.au_id = ta.au_id
INNER JOIN titles t ON ta.title_id = t.title_id
WHERE   t.pubdate = (SELECT MAX(pubdate) FROM titles);

-- 6. Mostrar el nombre de las editoriales que no hayan publicado ningún libro. 
SELECT pub_name
FROM publishers
WHERE pub_id NOT IN (SELECT DISTINCT pub_id FROM titles);

-- tabla ppal: publishers
SELECT          p.pub_name editorial
                -- ,t.*
FROM            publishers p 
LEFT JOIN       titles t 
ON              p.pub_id = t.pub_id
WHERE           t.title_id IS NULL;

-- 7. Mostrar el nombre de los libros que nunca fueron vendidos.
SELECT          t.title libro
                -- ,s.*
FROM            titles t
LEFT JOIN       sales s ON t.title_id = s.title_id
WHERE           s.stor_id IS NULL;
