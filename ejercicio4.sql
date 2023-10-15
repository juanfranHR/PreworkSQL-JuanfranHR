/*1. Crea una tabla llamada "Pedidos" con las columnas: "id" (entero, clave
primaria), "id_usuario" (entero, clave foránea de la tabla "Usuarios") y
"id_producto" (entero, clave foránea de la tabla "Productos").*/

    CREATE TABLE IF NOT EXISTS Pedidos(
    id SERIAL PRIMARY KEY,
    id_usuario INTEGER,
    id_producto INTEGER,
    CONSTRAINT FK_usuario FOREIGN KEY (id_usuario) 
      REFERENCES public.usuarios(id),
    CONSTRAINT FK_producto FOREIGN KEY (id_producto)
      REFERENCES public.productos(id)
    );

/*************************************************************************************************************/
/*2. Inserta al menos tres registros en la tabla "Pedidos" que relacionen usuarios con
productos.*/

    INSERT INTO public.pedidos (id_usuario, id_producto)
    VALUES (1,1), (1,4), (3,1), (3,3), (4,3), (4,2)

/*************************************************************************************************************/
/*3. Realiza una consulta que muestre los nombres de los usuarios y los nombres de
los productos que han comprado, incluidos aquellos que no han realizado
ningún pedido (utiliza LEFT JOIN y COALESCE).*/

    SELECT u.nombre AS nombre, 
    COALESCE(p.nombre,'No ha realizado ningún pedido') AS producto
    FROM public.usuarios AS u
    LEFT JOIN public.productos AS p
    ON u.id = p.usuario_id;

/*************************************************************************************************************/
/*4. Realiza una consulta que muestre los nombres de los usuarios que han
realizado un pedido, pero también los que no han realizado ningún pedido
(utiliza LEFT JOIN).*/

/*Además de mostrar los usuarios que han realizado pedidos cuenta el número de pedidos que han realizado*/
    SELECT u.nombre AS nombre, 
    COUNT(p.id_usuario) AS NumeroPedidos
    FROM public.usuarios AS u
    LEFT JOIN public.pedidos AS p
    ON u.id = p.id_usuario
    GROUP BY u.nombre;

/*************************************************************************************************************/
/*5. Agrega una nueva columna llamada "cantidad" a la tabla "Pedidos" y actualiza
los registros existentes con un valor (utiliza ALTER TABLE y UPDATE)*/

    ALTER TABLE pedidos
    ADD COLUMN cantidad INTEGER;

    UPDATE pedidos
    SET cantidad = CASE id
      WHEN 1 THEN 2
      WHEN 2 THEN 4
      WHEN 3 THEN 3
      WHEN 4 THEN 1
      WHEN 5 THEN 15
      WHEN 6 THEN 43
      END