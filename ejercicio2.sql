/*2. Crea una tabla llamada "Usuarios" con las columnas: "id" (entero, clave
primaria), "nombre" (texto) y "edad" (entero).*/

    CREATE TABLE IF NOT EXISTS Usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255),
    edad INTEGER
    );

/*****************************************************/
/*3. Inserta dos registros en la tabla "Usuarios".*/

    INSERT INTO Usuarios (nombre, edad)
    VALUES ('Juanfran',27),
    ('Carlos', 25);

/*****************************************************/
/*4. Actualiza la edad de un usuario en la tabla "Usuarios".*/

    UPDATE usuarios
    SET edad = 27
    WHERE id =2;

/*****************************************************/
/*5. Elimina un usuario de la tabla "Usuarios".*/
    
    DELETE FROM usuarios
    WHERE id = 2;

/*****************************************************/
/*6. Crea una tabla llamada "Ciudades" con las columnas: "id" (entero, clave
primaria), "nombre" (texto) y "pais" (texto).*/

    CREATE TABLE Ciudades (
      id SERIAL PRIMARY KEY,
      nombre VARCHAR(255),
      pais VARCHAR(255)
    );

/*****************************************************/
/*7. Inserta al menos tres registros en la tabla "Ciudades".*/

    INSERT INTO Ciudades (nombre, pais)
    VALUES ('Madrid', 'España'),
    ('Braga', 'Portugal'),
    ('Praga', 'República Checa'),
    ('Rotterdam', 'Países Bajos'),
    ('Frankfurt', 'Alemania');

/*****************************************************/
/*8. Crea una foreign key en la tabla "Usuarios" que se relacione con la columna "id"
de la tabla "Ciudades".*/

    ALTER TABLE usuarios
    ADD COLUMN ciudad_id INTEGER,
    ADD FOREIGN KEY (ciudad_id) REFERENCES ciudades(id);

/*****************************************************/
/*9. Realiza una consulta que muestre los nombres de los usuarios junto con el
nombre de su ciudad y país (utiliza un LEFT JOIN).*/

    SELECT u.nombre, c.nombre, c.pais
    FROM public.usuarios AS u
    LEFT JOIN public.ciudades AS c
    ON u.ciudad_id = c.id;

/*****************************************************/
/*10. Realiza una consulta que muestre solo los usuarios que tienen una ciudad
asociada (utiliza un INNER JOIN).*/

    SELECT u.nombre, c.nombre, c.pais
    FROM public.usuarios AS u
    INNER JOIN public.ciudades AS c
    ON u.ciudad_id = c.id;