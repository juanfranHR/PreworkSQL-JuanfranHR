/*1. Crea una tabla llamada "Productos" con las columnas: "id" (entero, clave
primaria), "nombre" (texto) y "precio" (numérico).*/

    CREATE TABLE Productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255),
    precio INTEGER);

/*************************************************************************************************************/
/*2. Inserta al menos cinco registros en la tabla "Productos".*/

    INSERT INTO public.productos (nombre, precio)
    VALUES ('lámpara', 55),
    ('sillón', 350),
    ('mesa redonda', 125),
    ('reloj de cuco', 415),
    ('estantería', 65);

/*************************************************************************************************************/
/*3. Actualiza el precio de un producto en la tabla "Productos".*/

    UPDATE Productos
    SET precio = 55
    WHERE id = 5;

/*************************************************************************************************************/
/*4. Elimina un producto de la tabla "Productos".*/

    DELETE FROM Productos
    WHERE id = 5;

/*************************************************************************************************************/
/*5. Realiza una consulta que muestre los nombres de los usuarios junto con los
nombres de los productos que han comprado (utiliza un INNER JOIN con la
tabla "Productos").*/

/*Primero vamos a relacionar ambas tablas añadiendo en la tabla Productos una columna que guarde
el id del usuario y sea una FOREIGN KEY*/
        ALTER TABLE public.productos
        ADD COLUMN usuario_id INTEGER;

        ALTER TABLE public.productos
        ADD CONSTRAINT FK_usuario_id FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id);
        
/*Después realizamos la consulta con INNER JOIN*/
        SELECT u.nombre AS Nombre, p.nombre AS producto
        FROM public.usuarios AS u
        INNER JOIN public.productos AS p
        ON u.id = p.usuario_id;