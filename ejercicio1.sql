/*1.1. Crear una tabla llamada "Clientes" con las columnas: id (entero, clave primaria),
nombre (texto) y email (texto).*/

        CREATE TABLE IF NOT EXISTS Clientes (
        id SERIAL PRIMARY KEY,
        nombre VARCHAR(255),
        email VARCHAR(255)	
        );

/**********************************************************************************/
/*1.2. Insertar un nuevo cliente en la tabla "Clientes" con id=1, nombre="Juan" y
email="juan@example.com".*/

        INSERT INTO public.clientes(nombre, email)
        VALUES('Juan', 'juan@example.com');

/**********************************************************************************/
/*1.3. Actualizar el email del cliente con id=1 a "juan@gmail.com".*/

        UPDATE public.clientes
        SET email = 'juan@gmail.com'
        WHERE id = 1;

/**********************************************************************************/
/*1.4. Eliminar el cliente con id=1 de la tabla "Clientes".*/

        DELETE FROM public.clientes
        WHERE id = 1;

/**********************************************************************************/
/*1.5. Crear una tabla llamada "Pedidos" con las columnas: id (entero, clave primaria),
cliente_id (entero, clave externa referenciando a la tabla "Clientes"), producto
(texto) y cantidad (entero).*/

        CREATE TABLE IF NOT EXISTS pedidos (
        id SERIAL PRIMARY KEY,
        cliente_id INTEGER,
        producto VARCHAR(255),
        cantidad INT,
        CONSTRAINT FK_clienteID FOREIGN KEY (cliente_id) REFERENCES clientes(id)
        );

/**********************************************************************************/
/*1.6. Insertar un nuevo pedido en la tabla "Pedidos" con id=1, cliente_id=1,
producto="Camiseta" y cantidad=2.*/

/*Previamente insertamos una entrada en la tabla clientes ya que en el ejercicio 1.4. se borró la única entrada*/

        INSERT INTO public.pedidos(cliente_id, producto, cantidad)
        VALUES(1, 'Camiseta', 2);

/**********************************************************************************/
/*1.7. Actualizar la cantidad del pedido con id=1 a 3.*/

        UPDATE public.pedidos
        SET cantidad = 3
        WHERE id = 1;

/**********************************************************************************/
/*1.8. Eliminar el pedido con id=1 de la tabla "Pedidos".*/

        DELETE FROM public.pedidos
        WHERE id = 1;

/**********************************************************************************/
/* 1.9. Crear una tabla llamada "Productos" con las columnas: id (entero, clave
primaria), nombre (texto) y precio (decimal).*/

        CREATE TABLE IF NOT EXISTS public.productos (
        id SERIAL PRIMARY KEY,
        name VARCHAR(255),
        precio DECIMAL
        );

/**********************************************************************************/
/* 1.10. Insertar varios productos en la tabla "Productos" con diferentes valores.*/

        INSERT INTO public.productos (name, precio)
        VALUES ('jamón ibérico de bellota', 23.50),
        ('queso curado', 10.50),
        ('oreja de cerdo',4.63),
        ('lomo alto', 17.60),
        ('pechuga de pollo',6.99);

/**********************************************************************************/
/*1.11. Consultar todos los clientes de la tabla "Clientes".*/

        SELECT * FROM public.clientes;

/**********************************************************************************/
/*1.12 Consultar todos los pedidos de la tabla "Pedidos" junto con los nombres de los
clientes correspondientes.*/

        SELECT 
        c.nombre,
        p.producto,
        p.cantidad
        FROM public.pedidos p
        LEFT JOIN public.clientes c
        ON c.id = p.cliente_id;

/**********************************************************************************/
/*1.13. Consultar los productos de la tabla "Productos" cuyo precio sea mayor a $50.*/

        SELECT *
        from public.productos
        WHERE precio > 50;

/**********************************************************************************/
/*1.14. Consultar los pedidos de la tabla "Pedidos" que tengan una cantidad mayor o
igual a 5.*/

        SELECT *
        FROM public.pedidos
        WHERE cantidad >= 5;

/**********************************************************************************/
/*1.15. Consultar los clientes de la tabla "Clientes" cuyo nombre empiece con la letra
"A".*/

        SELECT *
        FROM public.clientes
        WHERE nombre ILIKE 'a%';

/**********************************************************************************/
/*1.16. Realizar una consulta que muestre el nombre del cliente y el total de pedidos
realizados por cada cliente.*/

        SELECT
        public.clientes.nombre,
        SUM(public.pedidos.cantidad)
        FROM public.clientes
        LEFT JOIN public.pedidos
        ON public.clientes.id = public.pedidos.cliente_id
        GROUP BY public.clientes.nombre;

/**********************************************************************************/
/*1.17. Realizar una consulta que muestre el nombre del producto y la cantidad total de
pedidos de ese producto.*/

        SELECT
        public.productos.name,
        SUM(public.pedidos.cantidad)
        FROM public.productos
        LEFT JOIN public.pedidos
        ON public.pedidos.producto = public.productos.name
        GROUP BY public.productos.name;

/**********************************************************************************/
/*1.18. Agregar una columna llamada "fecha" a la tabla "Pedidos" de tipo fecha.*/

        ALTER TABLE public.pedidos
        ADD fecha DATE;

/**********************************************************************************/
/*1.19. Agregar una clave externa a la tabla "Pedidos" que haga referencia a la tabla
"Productos" en la columna "producto".*/

/* Para poder hacer esta operacion primero tenemos que eliminar la columna id de la tabla productos que 
sirve como PRIMARY KEY*/

        ALTER TABLE productos
        DROP COLUMN id;

/*Seguidamente tenemos que convertir la columna name de la tabla productos en PRIMARY KEY*/

        ALTER TABLE productos
        ADD PRIMARY KEY (name);

/* Por último, modificamos la columna producto de la tabla pedidos para que sea una FOREIGN KEY que haga 
referencia a la nueva PRIMARY KEY de la tabla productos: name*/

        ALTER TABLE public.pedidos
        ADD FOREIGN KEY (producto) REFERENCES public.productos(name);

/**********************************************************************************/
/*1.20. Realizar una consulta que muestre los nombres de los clientes, los nombres de
los productos y las cantidades de los pedidos donde coincida la clave externa.*/

        SELECT c.nombre, p.producto, p.cantidad
        FROM public.clientes AS c
        INNER JOIN public.pedidos AS p
        ON c.id = p.cliente_id;