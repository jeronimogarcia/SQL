DROP DATABASE IF EXISTS TOTAL_GAMER;
CREATE DATABASE TOTAL_GAMER;
USE TOTAL_GAMER;

-- Simulacion de base de datos de una empresa de venta de productos de computacion con varias sucursales. 

-- Tablas 64-167
-- Comandos Select y Drop
-- Views 205-283
-- Funciones 284-332
-- Store Procedures 333-424
-- Triggers 427-523
-- Creacion Usuarios 524-560
-- Transacciones 561-592

-- Tablas:
/*
- Cargos: especifica que tipo de trabajo hace cada empleado
- Categoria: especifica que tipo de producto corresponde a cada categoria
- Clientes: dato de los clientes registrados por el local
- Compras: las compras realizadas por los clientes registrados
- Detalles de Compras: detalla la compra con la cantidad y producto
- Empleados: datos de los empleados que trabajan en los distintos locales
- Historiales: historial de compra de los clientes registrados
- Locales: informacion de las distintas sucursales
- Productos: informacion de los productos que se venden en los locales
- LocalesProductos: tabla puente entre locales y productos. Detalla la cantidad de stock
- Proveedores: informacion de los proveedores de los locales
- log_empleados: registro de nuevos empleados
- log_productos: registro de nuevos productos
*/

-- Funciones:
/*
- Funcion montoTotal_producto: multiplica el precio por la cantidad de stock
- Funcion montoTotal_local: calcula el monto total de los productos (stock*precio) de un mismo local.
*/

-- Views:
/*
- Vista_compras_cliente: cantidad de compras por cliente ordenados de forma descendente
- Vista_empleado_viejo: empleado mas viejo
- Vista_producto_mas_caro: producto mas caro
- Vista_productos_baratos: productos con precio menor a 10.000 ordenados por precio de forma ascendente
- Vista_productos_categoria: cantidad de productos distintos por categoria ordenados de forma ascendente
*/

-- Store Procedures:
/*
- n_productos_caros_baratos: trae los n productos mas caros o los n productos mas baratos. Segundo parametro = 1 para los mas caros, 0 para los baratos. 
- borrar_empleado: borrar empleado por DNI
- agregar_empleado: insercion de empleado
- productos_categoria: cantidad de productos por categoria ingresando ID de la categoria
- productos_nombreCategoria:  cantidad de productos por categoria ingresando nombre de la categoria
*/

-- Triggers:
/*
- chequeo_empleado_vacio BEFORE: trigger espacios vacios, tira error si se ingresa un espacio vacio
- log_insercion_empleado AFTER: trigger de insercion de empleados, guardo en otro tabla el nuevo empleado. 
- chequeo_precio BEFORE: trigger precio menor a X, salta error si el precio es menor a X monto 
- log_insercion_producto AFTER: trigger de insercion de productos, guardo en otra tabla el nuevo producto.
*/

-- ------------------- Creacion de Tablas --------------------

DROP TABLE IF EXISTS Locales;
CREATE TABLE Locales (
LOCAL_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
DIR_LOC VARCHAR(30) NOT NULL,
CIUDAD_LOC VARCHAR(30) NOT NULL,
LOCAL_TEL VARCHAR(15) NOT NULL UNIQUE,
CP INT(8) NOT NULL
);


DROP TABLE IF EXISTS Cargos;
CREATE TABLE Cargos (
CARGO_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
CARGO_EMPLEADO VARCHAR(20) UNIQUE
);


DROP TABLE IF EXISTS Empleados;
CREATE TABLE Empleados (
EMPLEADO_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
LOCAL_ID INT NOT NULL, FOREIGN KEY (LOCAL_ID) REFERENCES Locales(LOCAL_ID),
CARGO_ID INT NOT NULL, FOREIGN KEY (CARGO_ID) REFERENCES Cargos(CARGO_ID),
NOMBRE_EMP VARCHAR(20) NOT NULL,
APELLIDO_EMP VARCHAR(20) NOT NULL,
DNI INT NOT NULL UNIQUE,
TEL_EMP BIGINT NOT NULL UNIQUE,
FECHA_INGRESO DATE NOT NULL
);


DROP TABLE IF EXISTS Proveedores;
CREATE TABLE Proveedores (
PROV_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
LOCAL_ID INT NOT NULL, FOREIGN KEY (LOCAL_ID) REFERENCES Locales(LOCAL_ID),
NOMBRE_PROV VARCHAR(30) NOT NULL UNIQUE,
DIR_PROV VARCHAR(20) NOT NULL,
TEL_PROV BIGINT NOT NULL UNIQUE,
CIUDAD_PROV VARCHAR(20) NOT NULL,
MAIL_PROV VARCHAR(30) NOT NULL UNIQUE
);


DROP TABLE IF EXISTS Clientes;
CREATE TABLE Clientes (
CLIENTE_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
LOCAL_ID INT NOT NULL, FOREIGN KEY (LOCAL_ID) REFERENCES Locales(LOCAL_ID),
NOMBRE_CLIENTE VARCHAR(20) NOT NULL, 
APELLIDO_CLIENTE VARCHAR(20) NOT NULL, 
TEL_CLIENTE BIGINT NOT NULL UNIQUE,
MAIL_CLIENTE VARCHAR(30) UNIQUE
);


DROP TABLE IF EXISTS Historiales;
CREATE TABLE Historiales (
HISTORIAL_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
CLIENTE_ID INT NOT NULL, FOREIGN KEY (CLIENTE_ID) REFERENCES Clientes(CLIENTE_ID),
FECHA_HIST DATE NOT NULL,
MONTO_HIST DECIMAL(10,2) NOT NULL,
CANT_HIST INT NOT NULL
);


DROP TABLE IF EXISTS Categorias;
CREATE TABLE Categorias (
CATEGORIA_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
NOMBRE_CAT  VARCHAR(20) NOT NULL UNIQUE
);


CREATE TABLE Productos (
PRODUCTO_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
CATEGORIA_ID INT NOT NULL, FOREIGN KEY (CATEGORIA_ID) REFERENCES Categorias(CATEGORIA_ID),
PRECIO_PROD DECIMAL(10,2) NOT NULL,
NOMBRE_PROD varchar(80) NOT NULL UNIQUE
);


DROP TABLE IF EXISTS LocalesProductos;
CREATE TABLE LocalesProductos(
LOCPROD_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
LOCAL_ID INT NOT NULL, FOREIGN KEY(LOCAL_ID) REFERENCES Locales(LOCAL_ID),
PRODUCTO_ID INT NOT NULL, FOREIGN KEY(PRODUCTO_ID) REFERENCES Productos(PRODUCTO_ID),
STOCK INT NOT NULL
);


DROP TABLE IF EXISTS Compras;
CREATE TABLE Compras (
COMPRA_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
CLIENTE_ID INT NOT NULL, FOREIGN KEY (CLIENTE_ID) REFERENCES Clientes(CLIENTE_ID),
FECHA_COMPRA DATE NOT NULL
);


DROP TABLE IF EXISTS DetallesCompras;
CREATE TABLE DetallesCompras (
DETALLE_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
COMPRA_ID INT NOT NULL, FOREIGN KEY (COMPRA_ID) REFERENCES Compras(COMPRA_ID),
PRODUCTO_ID INT NOT NULL, FOREIGN KEY(PRODUCTO_ID) REFERENCES Productos(PRODUCTO_ID),
CANTIDAD INT(2) NOT NULL
);


-- --------------- All Drops Table ---------------------

/*
DROP TABLE IF EXISTS Locales;
DROP TABLE IF EXISTS Empleados;
DROP TABLE IF EXISTS Proveedores;
DROP TABLE IF EXISTS Clientes;
DROP TABLE IF EXISTS Categorias;
DROP TABLE IF EXISTS Productos;
DROP TABLE IF EXISTS Compras;
DROP TABLE IF EXISTS Cargos;
DROP TABLE IF EXISTS Historiales;
DROP TABLE IF EXISTS DetallesCompras;
DROP TABLE IF EXISTS LocalesProductos;
*/


-- --------------- All Select Table ---------------

/*
SELECT * from Locales;
SELECT * from Empleados;
SELECT * from Proveedores;
SELECT * from Clientes;
SELECT * from Categorias;
SELECT * from Productos;
SELECT * from Compras;
SELECT * from Cargos;
SELECT * from Historiales;
SELECT * from DetallesCompras;
SELECT * from LocalesProductos;
*/


-- --------------------Vistas--------------------------

-- Vista de productos con precio menor al promedio ordenados por precio de forma ascendente
DROP VIEW IF EXISTS Vista_Productos_Baratos;
CREATE VIEW
Vista_Productos_Baratos AS
SELECT producto_id, precio_prod AS Precio, nombre_prod AS Producto
FROM Productos
WHERE precio_prod < (SELECT AVG(precio_prod) FROM productos)
ORDER BY precio_prod ASC;

-- SELECT * FROM Vista_Productos_Baratos;


-- Vista producto mas caro
DROP VIEW IF EXISTS Vista_Producto_Mas_Caro;
CREATE VIEW
Vista_Producto_Mas_Caro AS
SELECT producto_id, precio_prod AS Precio, nombre_prod AS Producto
FROM productos
WHERE precio_prod = (SELECT MAX(precio_prod) FROM productos);

-- SELECT * FROM Vista_Producto_Mas_Caro;


-- Vista empleado mas viejo
DROP VIEW IF EXISTS Vista_Empleado_Viejo;
CREATE VIEW
Vista_Empleado_Viejo AS
SELECT empleado_id, nombre_emp AS Nombre, apellido_emp AS Apellido, fecha_ingreso AS FechaIngreso
FROM empleados
WHERE fecha_ingreso = (SELECT MIN(fecha_ingreso) FROM empleados);

-- SELECT * FROM Vista_Empleado_Viejo;


-- Vista cantidad de compras por cliente ordenados de forma descendente
DROP VIEW IF EXISTS Vista_Compras_Cliente;
CREATE VIEW Vista_Compras_Cliente AS
SELECT Compras.cliente_id, Clientes.nombre_cliente AS Nombre,
Clientes.apellido_cliente AS Apellido, COUNT(*) AS CantidadCompras
FROM compras
INNER JOIN Clientes ON Compras.cliente_id = Clientes.cliente_id
GROUP BY cliente_id
ORDER BY CantidadCompras DESC;


-- SELECT * FROM Vista_Compras_Cliente;

-- Vista de cantidad de productos distintos por categoria ordenados de forma ascendente
DROP VIEW IF EXISTS Vista_Productos_Categoria;
CREATE VIEW Vista_Productos_Categoria AS
SELECT Productos.categoria_id, Categorias.nombre_cat AS Categoria,
COUNT(*) AS ProductosDistintos
FROM productos
INNER JOIN Categorias ON Productos.categoria_id = Categorias.categoria_id
GROUP BY categoria_id
ORDER BY categoria_id ASC;

-- SELECT * FROM Vista_Productos_Categoria;


-- Vista de gasto total por compra ordenando por monto de forma descendente 
-- trayendo id, nombre y apellido del cliente
DROP VIEW IF EXISTS Vista_Gasto_Compra;
CREATE VIEW Vista_Gasto_Compra AS
SELECT Clientes.cliente_id, Clientes.nombre_cliente AS Nombre,
Clientes.apellido_cliente AS Apellido, Compras.compra_id,
SUM(Productos.precio_prod*DetallesCompras.cantidad) AS TotalGastoCompra
FROM DetallesCompras
INNER JOIN Productos ON DetallesCompras.producto_id = Productos.producto_id
INNER JOIN Compras ON DetallesCompras.compra_id = Compras.compra_id
INNER JOIN Clientes ON Compras.cliente_id = Clientes.cliente_id
GROUP BY compra_id
ORDER BY TotalGastoCompra DESC;

-- SELECT * FROM Vista_Gasto_Compra;


-- ----------------------Funciones--------------------------


-- Funcion stock_producto. Me trae la cantidad de stock del producto en el local asignado
-- Primer parametro = id del local, Segundo parametro = id del producto.
-- Si devuelve null es porque no hay stock de ese producto en el local asignado
DROP FUNCTION IF EXISTS stock_producto;
DELIMITER $$
CREATE FUNCTION stock_producto (param_local INT, param_producto INT)
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE resultado INT;
    SET resultado = (SELECT LocalesProductos.stock AS Stock
					FROM productos
                    INNER JOIN LocalesProductos 
                    ON LocalesProductos.producto_id = Productos.producto_id
                    WHERE LocalesProductos.local_id = param_local 
                    AND LocalesProductos.producto_id = param_producto);
	RETURN resultado;
END $$
DELIMITER ;

-- Llamado a la funcion "stock_producto"
-- SELECT stock_producto(4,17) AS Stock;


-- Funcion acumulado_local me devuelve el monto de dinero total
-- de todos los productos que se encuentran en ese local
-- Suma de todos los productos del precio del producto
-- multiplicado por el stock del local que se asigna por parametro
DROP FUNCTION IF EXISTS acumulado_local;
DELIMITER $$
CREATE FUNCTION acumulado_local (param_local INT)
RETURNS DECIMAL(12,2)
READS SQL DATA
BEGIN
	DECLARE sumaTotal INT;
    SET sumaTotal = (SELECT SUM(Productos.precio_prod * LocalesProductos.stock)
					FROM LocalesProductos
					INNER JOIN Locales ON LocalesProductos.local_id = Locales.local_id
					INNER JOIN Productos ON Productos.producto_id = LocalesProductos.producto_id
					WHERE LocalesProductos.local_id = param_local);
	RETURN sumaTotal;
END $$
DELIMITER ;

-- Llamado a la funcion "acumulado_local"
-- SELECT acumulado_local(5) AS TotalAcumulado;


-- ----------------------------Stored Procedures-----------------------

-- Traer los n productos mas caros o los n productos mas baratos.
-- Segundo parametro = 1 para los mas caros(descendente), 0 para los baratos(ascendente). 
-- Cualquier otro numero no trae nada
DROP PROCEDURE IF EXISTS productos_caros_baratos;
DELIMITER $$
CREATE PROCEDURE productos_caros_baratos (IN cantidad_productos INT, IN orden INT)
BEGIN
	IF orden = 1 THEN
    SELECT producto_id, nombre_prod AS Producto, precio_prod AS Precio
    FROM productos
    ORDER BY precio_prod DESC
    LIMIT cantidad_productos;
    ELSEIF  orden = 0 THEN
    SELECT producto_id, nombre_prod AS Producto, precio_prod AS Precio
    FROM productos
    ORDER BY precio_prod ASC
    LIMIT cantidad_productos;
    END IF;
END$$
DELIMITER ;

-- CALL productos_caros_baratos(15,0);



-- Insertar empleado
DROP PROCEDURE IF EXISTS agregar_empleado;
DELIMITER $$
CREATE PROCEDURE agregar_empleado (IN id INT, IN localId INT, IN cargoId INT,
IN nombre varchar(20), IN apellido varchar(20),IN dni INT,IN tel varchar(20),IN fecha Date)
BEGIN
	INSERT INTO Empleados (Empleado_ID, LOCAL_ID, CARGO_ID, NOMBRE_EMP, APELLIDO_EMP, DNI, TEL_EMP, FECHA_INGRESO)
    VALUES (id, localId, cargoId, nombre, apellido, dni, tel, fecha);
END$$
DELIMITER ;
-- CALL agregar_empleado('50', '5', '2', 'Jorge', 'Prueba', '20500200', '5', '2020-05-15');
-- SELECT * FROM Empleados;


-- Cantidad de productos por categoria ingresando nombre de la categoria
DROP PROCEDURE IF EXISTS productos_nombreCategoria;
DELIMITER $$
CREATE PROCEDURE productos_nombreCategoria (IN categoria VARCHAR(25))
BEGIN
    SELECT COUNT(Productos.categoria_id) AS Cantidad, Categorias.nombre_cat AS Categoria
	FROM productos 
	INNER JOIN categorias ON Productos.categoria_id = Categorias.categoria_id
	WHERE nombre_cat LIKE CONCAT('%', categoria, '%')
	GROUP BY Productos.categoria_id, Categorias.nombre_cat;
END $$
DELIMITER ;

-- CALL productos_nombreCategoria('Refrigeracion');


-- Muestra todos los productos disponibles por local, stock, precio y nombre de producto,
-- ingresando el id del local. Ordenados de forma ascendente

DROP PROCEDURE IF EXISTS productos_local;
DELIMITER $$
CREATE PROCEDURE productos_local (param_local INT)
BEGIN
	SELECT LocalesProductos.local_id, LocalesProductos.producto_id,
    LocalesProductos.stock, Productos.precio_prod AS Precio, Productos.nombre_prod AS Producto
    FROM LocalesProductos
	INNER JOIN Productos ON LocalesProductos.producto_id = Productos.producto_id
    WHERE local_id = param_local
    ORDER BY Productos.precio_prod;
END $$
DELIMITER ;

-- CALL productos_local(1);


-- Muestra la cantidad total de empleados dependiendo el cargo ingresado por parametro

DROP PROCEDURE IF EXISTS empleados_cargo;
DELIMITER $$
CREATE PROCEDURE empleados_cargo (IN CargoIn VARCHAR(10))
BEGIN
	SELECT COUNT(Cargos.cargo_id) AS Cantidad, Cargos.cargo_empleado AS Cargo
	FROM Empleados
	INNER JOIN Cargos ON Empleados.cargo_id = Cargos.cargo_id
	WHERE Cargos.cargo_empleado LIKE CONCAT('%', CargoIn, '%');
END $$
DELIMITER ;

-- CALL empleados_cargo('Capataz');


-- ---------------------------------- Triggers -----------------------------------

-- SHOW TRIGGERS;

-- --------------------------Trigger de insercion de productos AFTER------------------

DROP TABLE IF EXISTS log_productos;
CREATE TABLE log_productos (
    ID_LOGP INT PRIMARY KEY AUTO_INCREMENT,
    PRODUCTO_ID INT NOT NULL,
    CATEGORIA_ID INT NOT NULL, 
    PRECIO_PROD DECIMAL(10 , 2 ) NOT NULL,
    NOMBRE_PROD VARCHAR(80) NOT NULL UNIQUE,
    USUARIO VARCHAR(50),
    FECHA DATETIME
);

-- SELECT * FROM log_productos;

DROP TRIGGER IF EXISTS log_insercion_producto;
CREATE 
    TRIGGER  log_insercion_producto
 AFTER INSERT ON productos FOR EACH ROW 
    INSERT INTO log_productos VALUES (DEFAULT, new.producto_id,
    new.categoria_id, new.precio_prod, new.nombre_prod, user(), now());
    
-- SELECT * FROM log_productos;
-- INSERT INTO productos VALUES (31, 2, 50000.00,"PRUEBAPRODUCTO");
-- INSERT INTO productos VALUES (32, 2, 50000.00,"PRUEBAPRODUCTO2");
-- INSERT INTO productos VALUES (33, 2, 50000.00,"PRUEBAPRODUCTO3");
-- DELETE from productos Where producto_id = 31 ;
-- DELETE from log_productos Where id_logp = 3;


-- ------------------------Trigger de insercion de empleados AFTER----------------------------------

DROP TABLE IF EXISTS log_empleados;
CREATE TABLE log_empleados (
    ID_LOGE INT PRIMARY KEY AUTO_INCREMENT,
    EMPLEADO_ID INT NOT NULL,
    LOCAL_ID INT NOT NULL,
    CARGO_ID INT NOT NULL,
    NOMBRE_EMP VARCHAR(20) NOT NULL,
    APELLIDO_EMP VARCHAR(20) NOT NULL,
    DNI INT NOT NULL UNIQUE,
    TEL_EMP VARCHAR(20) NOT NULL UNIQUE,
    USUARIO VARCHAR(50),
    FECHA_INGRESO DATETIME
);

DROP TRIGGER IF EXISTS log_insercion_empleado;
CREATE 
    TRIGGER  log_insercion_empleado
 AFTER INSERT ON empleados FOR EACH ROW 
    INSERT INTO log_empleados VALUES (DEFAULT , new.EMPLEADO_ID , new.LOCAL_ID ,
    new.CARGO_ID , new.NOMBRE_EMP , new.APELLIDO_EMP , new.DNI , new.TEL_EMP ,  USER() , NOW());

-- SELECT * FROM log_empleados;
-- INSERT INTO empleados VALUES (21, 3, 1, "NOMBREEMP", "APELLIDOEMP", 27000000, 3410000001, now());
-- INSERT INTO empleados VALUES (22, 3, 1, "NOMBREEMP", "APELLIDOEMP", 27000001, 3410000002, now());
-- INSERT INTO empleados VALUES (23, 3, 1, "NOMBREEMP", "APELLIDOEMP", 27000002, 3410000003, now());
-- DELETE from empleados Where empleado_id = 21 ;
-- DELETE from log_empleados Where id_loge = 1;


-- -------------------------Trigger espacios vacios---------------------

DROP TRIGGER IF EXISTS chequeo_empleado_vacio;

DELIMITER $$
CREATE TRIGGER chequeo_empleado_vacio
BEFORE INSERT ON empleados
FOR EACH ROW
BEGIN
IF new.nombre_emp = ' ' THEN
		signal sqlstate '45000';
        END IF;
END $$
DELIMITER $$

-- INSERT INTO empleados VALUES (22, 3, 1, " ", "APELLIDOEMP", 27000000, 3410000000, now());

-- -------------------------Trigger precio menor a X-----------------

DROP TRIGGER IF EXISTS chequeo_precio;

DELIMITER $$
CREATE TRIGGER chequeo_precio
BEFORE INSERT ON productos
FOR EACH ROW
BEGIN
IF NEW.precio_prod < 1000 THEN
		SIGNAL SQLSTATE '45000';
        END IF;
END $$
DELIMITER $$

-- INSERT INTO productos VALUES (33, 4, 900, "PRUEBAPRODUCTO");

-- ---------------------------Creacion de Usuarios-------------------------
-- -----------------------------Sublenguaje DCL----------------------------
-- --------------------------Data Control Language-------------------------


-- Creacion de Usuario
DROP USER IF EXISTS 'user_only_reading'@'localhost';
DROP USER IF EXISTS 'user_more_actions'@'localhost';
CREATE USER 'user_only_reading'@'localhost' identified by '1234';
CREATE USER 'user_more_actions'@'localhost' identified by '12345';

-- Checkeo de Usuarios
-- SELECT * FROM mysql.user;

-- ------------------- Permisos para 'user_only_reading' -----------------

-- Select sobre todas las tablas
GRANT SELECT ON empresa_pc.* TO 'user_only_reading'@'localhost';

-- ------------------- Permisos para 'user_more_actions' ------------------

-- Select sobre todas las tablas
GRANT SELECT ON empresa_pc.* TO 'user_more_actions'@'localhost';
-- Insercion sobre todas las tablas 
GRANT INSERT ON empresa_pc.* TO 'user_more_actions'@'localhost';
-- Modificacion sobre todas las tablas 
GRANT UPDATE ON empresa_pc.* TO 'user_more_actions'@'localhost';  

-- Mostrar permisos
-- SHOW GRANTS FOR 'user_only_reading'@'localhost';
-- SHOW GRANTS FOR 'user_more_actions'@'localhost';

-- Refresh de privilegios
FLUSH PRIVILEGES;

-- ----------------------------Sublenguaje TCL--------------------------

START TRANSACTION;
INSERT INTO CATEGORIAS VALUES (15, 'Sillas Gamers');
ROLLBACK;
-- COMMIT;
DELETE FROM CATEGORIAS WHERE CATEGORIA_ID=15;

-- SELECT * FROM ClientesPremium;

DROP TABLE IF EXISTS ClientesPremium;
CREATE TABLE ClientesPremium (
CLIENTEP_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
NOMBRE_CLIENTEP VARCHAR(20) NOT NULL, 
APELLIDO_CLIENTEP VARCHAR(20) NOT NULL
);

START TRANSACTION;
INSERT INTO ClientesPremium VALUES (DEFAULT, 'Jose', 'Sanchez');
INSERT INTO ClientesPremium VALUES (DEFAULT, 'Leonel', 'Perez');
INSERT INTO ClientesPremium VALUES (DEFAULT, 'Sofia', 'Garcia');
INSERT INTO ClientesPremium VALUES (DEFAULT, 'Maria', 'Robledo');
SAVEPOINT primer_registro;
INSERT INTO ClientesPremium VALUES (DEFAULT, 'Roberto', 'Rojas');
INSERT INTO ClientesPremium VALUES (DEFAULT, 'Josefina', 'Valverde');
INSERT INTO ClientesPremium VALUES (DEFAULT, 'Uriel', 'Dominguez');
INSERT INTO ClientesPremium VALUES (DEFAULT, 'Gabriel', 'Godoy');
SAVEPOINT segundo_registro;
-- ROLLBACK TO primer_registro;
-- ROLLBACK TO segundo_registro;
-- RELEASE SAVEPOINT primer_registro;
-- COMMIT;
