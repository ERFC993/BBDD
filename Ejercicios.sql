/*
	Ejercicio 1
    Posicionarse en la base de datos de PUBS.
*/
    
    use pubs;


/*
	Ejercicio 2
    Mostrar todos los autores.
*/

	select * 
	from authors;

/*
	Ejercicio 3
    Mostrar todas las editoriales.
*/

	select * 
	from publishers;
    
/*
	Ejercicio 4
    Mostrar la estructura de STORES.
*/

	describe stores;
    
/*
	Ejercicio 5
    Mostrar la estructura de SALES.
*/

	describe sales;    
    
/*
	Ejercicio 6
    Mostrar el código, nombre completo y fecha de ingreso de los
	empleados que trabajan para la editorial 877. Tener en cuenta que el
	nombre completo es el resultado de la concatenación del nombre y
	apellido. Las columnas deben estar apodadas según las siguientes
	leyendas: "Número de Empleado", "Nombre de Empleado" y "Fecha
	de Inicio".
*/

	select	emp_id 					as 'Numero de Empleado',
			concat(fname," ",lname) as 'Nombre de Empleado',
            hire_date 				as 'Fecha de Inicio'
	from 	employee
    where 	pub_id like '%877';
    
/*
	Ejercicio 7
    Mostrar el título, precio bruto y precio con IVA de los libros. Ninguna
	columna debe contener valores nulos. las columnas deben estar
	apodadas por las siguientes palabras: Título, Precio y Precio lVA.
*/
    
    select 	title 				as 'Titulo',
			price 				as 'Precio',
            round(price)*1.21	as 'Precio IVA'
	from 	titles
    where 	price is not null and title is not null;
    
/*
	Ejercicio 8
    Mostrar los tipos de libros existentes
*/    

	select 	type 	as 'Tipo'
    from 	titles;
    
/*
	Ejercicio 9
    Listar los países de residencia de las editoriales. Evitar las
	repeticiones.
*/    

	select 	distinct(country) 	as 'Pais'
    from 	publishers;
    
/*
	Ejercicio 10
    Listar las ciudades y estados de residencia de los autores. Evitar
	las repeticiones.
*/
    select 	*	from 	publishers;
    
/*
	Ejercicio 11
    Listar todos los empleados de la editorial número 877. Ordenar por
	nivel de trabajo descendente y por fecha de incorporación
	ascendente.
*/    
    select	*
    from 	employee
    where 	pub_id like '%877'
    order by job_lvl desc, hire_date;
    
/*
	Ejercicio 12
    Listar el número, apellido, nombre y teléfono de los autores que NO
	tengan contrato y que su estado de residencia sea California (CA).
*/

	select 	au_id 		as	'Numero',
			au_lname	as	'Apellido',
            au_fname 	as	'Nombre',
            phone		as	'Telefono'
    from authors
    where 	contract=0 and state='CA';
    
/*
	Ejercicio 13
    Listar los empleados cuyo año de incorporación fue 1990 y cuyo
	nivel de trabajo esté entre 100 Y 200.
*/
    
    select 	*
    from	employee
--  where	year(hire_date)=1990 and job_lvl<201 and 99<job_lvl;
    where year(hire_date)=1990 and job_lvl between 100 and 200;
    
/*
	Ejercicio 14
    Listar los libros vendidos cuya condición de pago es sobre
	facturación y cuya cantidad de venta esté entre 13 y 40. No utilizar el
	operador BETWEEN.
*/    
    select 	*
    from	sales
-- 	where	payterms='ON invoice' and qty between 13 and 40;     
    where 	payterms like '%ON invoice' and qty>12 and qty<41;
    
/*
	Ejercicio 15
    Listar número y nombre de las editoriales cuyo estado de
	residencia contenga valor nulo.
*/
    select 	pub_id 		as 	'Numero',
			pub_name	as	'Nombre'
	from 	publishers
    where	state is null;

/*
	Ejercicio 16
    Listar el título y precio de los libros de cocina cuyo título no figure
	la palabra "sushi". Ordenar por precio descendente.
*/

	select 	title	as	'Titulo',
			price	as	'Precio'
	from	titles
    where	type like '%cook%' and title not like '%sushi%'
    order by price desc;
    
/*
	Ejercicio 17
    Listar todos los empleados cuyo nombre empiece con la letra P y
	termine con la letra O, y su apellido termine con la letra O.
*/
            
    select 	*
    from 	employee
	where 	fname like 'P%o' and lname like '%o';

/*
	Ejercicio 18
    Listar todos los autores cuya dirección termine con un número y
    que la segunda letra de su apellido sea R.
*/
    select 	*
    from 	authors    
    where	address rlike '[0-9]$' and au_lname like '_r%';
    
/*
	Ejercicio 19
    Mostrar todos los empleados cuyo nombre empiece con la letra P
	ó A. La segunda letra no sea A y la última letra esté entre la H y la Z.
*/
    select 	*
    from 	employee
    where	fname rlike '^[p,a][^a].*[h-z]$';
    
/*
	Ejercicio 20
    Listar todas las facturas que su condición de pago es a 30 días que
	hayan facturado durante el año 1992 y 1993 ó los que su condición
	de pago es a 60 días que han facturado durante el segundo
	semestre del año 1994. Ordenar la consulta por código de libro.
*/    

	select		*
    from 		sales
    where		payterms='Net 30' and year(ord_date) between 1992 and 1993 
				or (payterms='Net 60' and year(ord_date)=1994 and month(ord_date)>6)
	order by 	title_id;

/*
	Ejercicio 21
    Contar la cantidad de autores que su estado de residencia sea
	California (CA). Poner un apodo al nombre de columna.
*/
    select count(state)	as	'Cantidad de autores que viven en California' 
    from authors
    where state='CA';
    
/*
	Ejercicio 22
    Mostrar la fecha de inicio de facturación y el último número de
	comprobante emitido. Poner un apodo a cada columna.
*/
    select	min(ord_date) 	as	'Fecha de Inicio',
			max(ord_num)	as	'Ultimo numero de comprobante'
	from 	sales;
    
/*
	Ejercicio 23
    Contar la cantidad de países que residen alguna editorial.
*/
    select 	count(distinct(country)) as 'Cantidad de paises'
    from	publishers;
    
/*
	Ejercicio 24
    Listar las categorías de libros y el valor promedio para cada tipo de
	libro.
*/
    select		type 				as 	'Categoria',
				round(avg(price),2)	as	'Precio Promedio'
    from		titles
    group by	type;
    
/*
	Ejercicio 25
    ldem ejercicio 24 pero no incluir dentro de la lista los libros que no
	tienen decidida una categoría.
*/
    
    select		type				as 	'Categoria',
				avg(round(price))	as	'Precio promedio'
    from 		titles
    where		type <> ''
    group by	type;
    
/*
	Ejercicio 26
    Listar los locales que hayan vendido más de 100 libros.
*/
    select		stor_id		as	Negocio,
				sum(qty)	as 	Cantidad	  			 
    from		sales
    group by	stor_id
    having 		Cantidad>100;
    
    
/*
	Ejercicio 27
    Listar la cantidad de ejemplares vendidos de cada libro en cada tienda. 
    Poner apodos a las columnas.
*/
    
	select	title_id Titulo,
			stor_id	 Tienda,
            sum(qty) Vendido
	from	sales
    group by Titulo, Tienda;
    
/*
	Ejercicio 28
    Listar el valor promedio de los libros agrupados por tipo de libro
	cuyo promedio esté entre 12 y 14. Poner alias a los encabezados.
	Ordenar la consulta por promedio.
*/
    select	type Tipo,
			round(avg(price),2) ValorPromedio
    from 	titles
    group by Tipo
    having 	ValorPromedio between 12 and 14
    order by ValorPromedio;
    
/*
	Ejercicio 29
    Listar las categorías de libros junto con el precio del libro más
	caro, el más barato y la cantidad de libros existentes para esa
	categoría. Mostrar solo aquellas categorías de libros cuyo precio de
	los libros económicos sea inferior a $10 Y cuya cantidad de libros
	pertenecientes sean mayor a 2.
*/
    
    select	type Categoria,
			max(price) PrecioCaro,
            min(price) PrecioBarato,
            count(title_id) Cantidad
	from	titles
    group by Categoria
    having 	PrecioBarato<10 and Cantidad>2;
    
/*
	Ejercicio 30.
	Contar la cantidad de empleados que trabajen en la compañía.
*/
    select	count(emp_id) CantidadEmpleado
    from	employee;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    