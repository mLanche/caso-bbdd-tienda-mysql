DROP DATABASE IF EXISTS negocio; 
CREATE DATABASE negocio;
USE negocio;

/* Creación de tablas */

CREATE TABLE CATEGORIA_TIENDA(
	ID_CATEGORIA INT NOT NULL AUTO_INCREMENT,
    NOMBRE VARCHAR (100),
    PORCENTAJE_DESCUENTO DOUBLE NOT NULL, 
    PRIMARY KEY (ID_CATEGORIA),
    CONSTRAINT DESCUENTO_SUPERADO CHECK(PORCENTAJE_DESCUENTO<=20)
);


CREATE TABLE TIENDA (
	ID_TIENDA INT NOT NULL AUTO_INCREMENT,
    ID_CATEGORIA INT NOT NULL,
    NOMBRE_TIENDA VARCHAR(50) NOT NULL,
    LIMITE_CREDITO DECIMAL(7,2) NOT NULL,
    PRIMARY KEY(ID_TIENDA),
    FOREIGN KEY (ID_CATEGORIA) REFERENCES CATEGORIA_TIENDA(ID_CATEGORIA),
    CONSTRAINT CREDITO_SUPERADO CHECK(LIMITE_CREDITO<=30000)
);


CREATE TABLE DIRECCION_ENTREGA(
	ID_DIRECCION INT NOT NULL AUTO_INCREMENT,
    ID_TIENDA INT NOT NULL,
    Nº VARCHAR(10) NOT NULL,
    CALLE VARCHAR(100) NOT NULL, 
    POBLACION VARCHAR(100) NOT NULL, 
    CIUDAD VARCHAR(100) NOT NULL, 
    TELEFONO VARCHAR(15) NOT NULL, 
    EMAIL VARCHAR(100) NOT NULL,
	PRIMARY KEY(ID_DIRECCION),
    FOREIGN KEY(ID_TIENDA) REFERENCES TIENDA(ID_TIENDA)
);


CREATE TABLE PROVEEDOR(
	ID_PROVEEDOR INT NOT NULL AUTO_INCREMENT,
    NOMBRE VARCHAR(150),
    Nº VARCHAR(10) NOT NULL,
    CALLE VARCHAR(100) NOT NULL, 
    POBLACION VARCHAR(100) NOT NULL, 
    CIUDAD VARCHAR(100) NOT NULL, 
    TELEFONO VARCHAR(15) NOT NULL, 
    EMAIL VARCHAR(100) NOT NULL,
    PRIMARY KEY(ID_PROVEEDOR)
);


CREATE TABLE PEDIDO(
	ID_PEDIDO INT NOT NULL AUTO_INCREMENT,
    ID_DIRECCION INT NOT NULL,
    ID_PROVEEDOR INT NOT NULL,
    FECHA DATETIME NOT NULL,
    PRIMARY KEY (ID_PEDIDO),
    FOREIGN KEY(ID_DIRECCION) REFERENCES DIRECCION_ENTREGA(ID_DIRECCION),
    FOREIGN KEY(ID_PROVEEDOR) REFERENCES PROVEEDOR(ID_PROVEEDOR)
);


CREATE TABLE ARTICULO(
ID_ARTICULO INT NOT NULL AUTO_INCREMENT,
NOMBRE VARCHAR(50) NOT NULL,
DESCRIPCION VARCHAR (150) NOT NULL,
IMPORTE DECIMAL(10,2) NOT NULL, 
PRIMARY KEY(ID_ARTICULO)
);


CREATE TABLE LINEA_PEDIDO(
	ID_LINEA_PEDIDO INT NOT NULL AUTO_INCREMENT,
    ID_PEDIDO INT NOT NULL,
    ID_ARTICULO INT NOT NULL,
    Nº_UNIDADES INT NOT NULL, 
    PRIMARY KEY(ID_LINEA_PEDIDO),
    FOREIGN KEY (ID_PEDIDO) REFERENCES PEDIDO (ID_PEDIDO),
    FOREIGN KEY (ID_ARTICULO) REFERENCES ARTICULO (ID_ARTICULO)
);

/*INSERCIÓN DE DATOS 

DE AQUÍ SAQUÉ EN UN SCRIPT APARTE LOS DATOS PARA EL EJERCICIO 2

*/

INSERT INTO CATEGORIA_TIENDA(NOMBRE,PORCENTAJE_DESCUENTO) 
	VALUES 
		("Premium",20),
		("Extra",15),
		("Normal",10);

INSERT INTO TIENDA (ID_CATEGORIA,NOMBRE_TIENDA,LIMITE_CREDITO) 
	VALUES 		
		(1, "ZARA", 15000),
        (3, "LEFTIES", 18000),
		(2, "H&M", 25000),
		(3, "Sfera", 29000);

INSERT INTO  DIRECCION_ENTREGA(ID_TIENDA,Nº,CALLE, POBLACION,CIUDAD,TELEFONO,EMAIL) 
	VALUES 
		(1,"5","Princesa", "Madrid","Madrid","+34 683874617","zaraprincesa@gmail.com"),
        (1,"105","Principe de Vergara", "Madrid","Madrid","+34 683874655","zaravergara@gmail.com"),
		(2,"12","Vinateros", "Madrid","Madrid","+34 663874617","leftiesvinateros@gmail.com"),
		(2,"6","Gomez", "Madrid","Madrid","+34 655574617","leftiesgomez@gmail.com"),
		(3,"85","Sierra", "Madrid","Madrid","+34 65556617","hym@gmail.com"),
		(4,"15","Esperanza", "Madrid","Madrid","+34 69956617","sfera@gmail.com");
         

INSERT INTO  PROVEEDOR(NOMBRE,Nº,CALLE, POBLACION,CIUDAD,TELEFONO,EMAIL) 
	VALUES 
		("SEUR","200","Velazquez", "Madrid","Madrid","985647558","seur@gmail.com"),
        ("Correos","25","Bronce", "Madrid","Madrid","985647108","correos@gmail.com"),
		("DHL","200","Paz", "Madrid","Madrid","984847558","dhl@gmail.com");


INSERT INTO  PEDIDO(ID_DIRECCION,ID_PROVEEDOR,FECHA)
	VALUES 
		(1, 1, "2022-12-25 15:30:45"),
        (2, 3, "2020-10-25 15:30:45"),
		(4, 2, "2021-05-25 21:30:45"),
		(3, 2, "2021-11-25 17:30:45"),
		(5, 1, "2022-02-25 12:30:45"),
		(1, 3, "2022-07-16 15:30:45"),
		(6, 2, "2022-05-16 15:30:45");



INSERT INTO  ARTICULO(NOMBRE, DESCRIPCION, IMPORTE) 
	VALUES 	
		("BOTAS", "PIEL", 40.99),
		("ZAPATILLAS", "DEPORTE", 50.99),
		("JERSEY", "LANA", 15),
		("CINTURON", "NEGRO", 9.99),
		("CAMISA", "SEDA", 18),
		("VAQUERO", "SLIM FIT", 22.50),
		("VESTIDO", "FIESTA", 22.50); 




INSERT INTO  LINEA_PEDIDO(ID_PEDIDO,ID_ARTICULO,Nº_UNIDADES)
	VALUES 
		(1, 1, 3),
		(1,4,10),
		(1,3 ,15),
		(2,2,20),
		(2,5 ,30),
		(3, 1,10),
		(3, 7,15),
		(4, 4,30),
		(4, 6,10),
		(5, 6,60),
		(5, 1,20),
		(6, 7,10),
		(6, 5,30),
		(7, 3,15);



/*EJERCICIO 3*/

SELECT T.NOMBRE_TIENDA, D.CALLE, D.Nº, D.POBLACION, D.CIUDAD, D.TELEFONO, D.EMAIL, T.NOMBRE AS DESCRIPCION_CATEGORIA, 
	   T.PORCENTAJE_DESCUENTO, T.LIMITE_CREDITO
FROM (SELECT T.ID_TIENDA, T.NOMBRE_TIENDA, T.LIMITE_CREDITO, C.NOMBRE, C.PORCENTAJE_DESCUENTO 
		FROM TIENDA T 
LEFT JOIN CATEGORIA_TIENDA C ON T.ID_CATEGORIA=C.ID_CATEGORIA) as T LEFT JOIN DIRECCION_ENTREGA D ON T.ID_TIENDA = D.ID_TIENDA;


/*EJERCICIO 4*/

SELECT TIENDA.NOMBRE_TIENDA, TOTAL_DIRECCION.ID_PEDIDO AS Nº_PEDIDO, TOTAL_DIRECCION.FECHA AS FECHA_SUMINISTRO, 
 TOTAL_DIRECCION.CALLE, TOTAL_DIRECCION.Nº, TOTAL_DIRECCION.POBLACION, TOTAL_DIRECCION.CIUDAD, TOTAL_DIRECCION.TELEFONO,
 TOTAL_DIRECCION.EMAIL, TOTAL_DIRECCION.IMPORTE_PEDIDO
FROM (SELECT TOTALP_PEDIDO.ID_PEDIDO, TOTALP_PEDIDO.IMPORTE_PEDIDO, TOTALP_PEDIDO.FECHA, DIRECCION_ENTREGA.* 
		FROM  (SELECT PEDIDO.ID_PEDIDO, TOTAL_PEDIDO.IMPORTE_PEDIDO, PEDIDO.ID_DIRECCION, PEDIDO.FECHA 
				FROM (SELECT ID_PEDIDO, SUM(IMPORTE_LINEA) AS IMPORTE_PEDIDO 
						FROM (SELECT LINEA_PEDIDO.ID_PEDIDO, (LINEA_PEDIDO.Nº_UNIDADES * ARTICULO.IMPORTE) AS IMPORTE_LINEA 
								FROM LINEA_PEDIDO LEFT JOIN ARTICULO ON LINEA_PEDIDO.ID_ARTICULO = ARTICULO.ID_ARTICULO) AS TOTAL_LINEA 
						GROUP BY ID_PEDIDO) AS TOTAL_PEDIDO
				INNER JOIN PEDIDO ON TOTAL_PEDIDO.ID_PEDIDO = PEDIDO.ID_PEDIDO) AS TOTALP_PEDIDO
		LEFT JOIN DIRECCION_ENTREGA  ON TOTALP_PEDIDO.ID_DIRECCION = DIRECCION_ENTREGA.ID_DIRECCION) AS TOTAL_DIRECCION
LEFT JOIN TIENDA ON TOTAL_DIRECCION.ID_TIENDA = TIENDA.ID_TIENDA WHERE year(TOTAL_DIRECCION.FECHA) = year(current_date());


/*EJERCICIO 5*/

SELECT PROVEEDOR.NOMBRE AS NOMBRE_PROVEEDOR, PROVEEDOR.CALLE, PROVEEDOR.Nº, PROVEEDOR.POBLACION, PROVEEDOR.CIUDAD,
PROVEEDOR.TELEFONO, PROVEEDOR.EMAIL,PEDIDO_ART.ID_PEDIDO, PEDIDO_ART.NOMBRE AS NOMBRE_ARTICULO, PEDIDO_ART.Nº_UNIDADES
FROM (SELECT PEDIDO.ID_PROVEEDOR, PEDIDO.ID_PEDIDO, ARTICULO_LINEA.NOMBRE, ARTICULO_LINEA.Nº_UNIDADES 
		FROM PEDIDO 
		LEFT JOIN  (SELECT LINEA_PEDIDO.ID_PEDIDO, LINEA_PEDIDO.Nº_UNIDADES, ARTICULO.NOMBRE
						FROM LINEA_PEDIDO 
						LEFT JOIN ARTICULO 
                        ON LINEA_PEDIDO.ID_ARTICULO = ARTICULO.ID_ARTICULO) AS ARTICULO_LINEA
		ON PEDIDO.ID_PEDIDO = ARTICULO_LINEA.ID_PEDIDO) AS PEDIDO_ART
LEFT JOIN PROVEEDOR 
ON PEDIDO_ART.ID_PROVEEDOR = PROVEEDOR.ID_PROVEEDOR ORDER BY NOMBRE_PROVEEDOR, ID_PEDIDO;



/*EJERCICIO 6*/


SELECT P.NOMBRE AS PROVEEDOR, TOTAL_P.AÑO, TOTAL_P.TOTAL_PEDIDOS 
FROM (SELECT ID_PROVEEDOR, COUNT(ID_PEDIDO) AS TOTAL_PEDIDOS, YEAR(FECHA) AS AÑO 
		FROM PEDIDO GROUP BY ID_PROVEEDOR, YEAR(FECHA) ORDER BY ID_PROVEEDOR, AÑO) AS TOTAL_P 
LEFT JOIN PROVEEDOR  P ON TOTAL_P.ID_PROVEEDOR = P.ID_PROVEEDOR;



/*EJERCICIO 7 */


CREATE TABLE CATEGORIA_PROVEEDOR(
ID_CATEGORIA INT NOT NULL AUTO_INCREMENT,
NOMBRE_CATEGORIA VARCHAR(50) NOT NULL,
PRIMARY KEY(ID_CATEGORIA)
);

INSERT INTO CATEGORIA_PROVEEDOR(NOMBRE_CATEGORIA) VALUES ("ORDINARIO"), ("URGENTE");

ALTER TABLE PROVEEDOR 
ADD ID_CATEGORIA INT NOT null DEFAULT(1), 
ADD FOREIGN KEY(ID_CATEGORIA) REFERENCES CATEGORIA_PROVEEDOR(ID_CATEGORIA);


/*EJERCICIO 8 */

ALTER TABLE ARTICULO ADD COLUMN FABRICACION_PROPIA BOOLEAN NOT NULL DEFAULT(TRUE);


/*EJERCICIO 9 */

CREATE TABLE REGION(
ID_REGION INT NOT NULL AUTO_INCREMENT,
MOMBRE_REGION VARCHAR(100) NOT NULL,
PRIMARY KEY(ID_REGION)
);

CREATE TABLE PAIS(
ID_PAIS INT NOT NULL AUTO_INCREMENT,
ID_REGION INT NOT NULL,
NOMBRE_PAIS VARCHAR(100) NOT NULL,
PRIMARY KEY (ID_PAIS),
FOREIGN KEY(ID_REGION) REFERENCES REGION(ID_REGION)
);

CREATE TABLE COBERTURA(
ID_COBERTURA INT NOT NULL AUTO_INCREMENT,
ID_PAIS INT NOT NULL,
ID_PROVEEDOR INT NOT NULL,
PRIMARY KEY(ID_COBERTURA),
FOREIGN KEY(ID_PROVEEDOR) REFERENCES PROVEEDOR(ID_PROVEEDOR),
FOREIGN KEY(ID_PAIS) REFERENCES PAIS(ID_PAIS)
);


/* 
EJERCICIO 10

ESTÁ RESUELTO EN EL POWER POINT Y LO HICE A TRAVÉS DE CONSOLA

*/


