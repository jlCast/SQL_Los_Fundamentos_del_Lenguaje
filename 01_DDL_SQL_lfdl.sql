-- Verificar usuario actual
SHOW USER;
-- CREACIÓN DE TABLAS SIN RESTRICCIONES
CREATE TABLE Tarifas (
    idTarifa       NUMBER(38,0),
    Hotel          NUMBER(38,0),
    Tipohabitacion NUMBER(38,0),
    FechaInicio    DATE,
    FechaFin       DATE,
    Precio         DECIMAL(7,3)
);
CREATE TABLE Hoteles(
    idHotel        INT,
    Nombre         VARCHAR(50),
    Estrella       VARCHAR(5)
);
CREATE TABLE TipoHabitacion(
    idTipoHabitaciones  INT,
    NumeroCamas         INT,
    TipoCama            VARCHAR(20),
    Descripcion         VARCHAR(255)
);
-- CREACIÓN DE TABLAS TEMPORALES
--En Oracle no existe el concepto de Tablas temporales tal y como se utiliza en SQL Server.
--Lo mas parecido que existe son tablas que puedes crearlas para que los datos se borren al cerrar la sesión o al hacer COMMIT 
--pero la tabla preserva su existencia (no se borra).
CREATE GLOBAL TEMPORARY TABLE TMP_TARIFAS2019( --NO me permite la creación con LOCAL
    idTarifa       NUMBER(38,0),
    Hotel          NUMBER(38,0),
    Tipohabitacion NUMBER(38,0),
    FechaInicio    DATE,
    FechaFin       DATE,
    Precio         DECIMAL(7,3)
)ON COMMIT PRESERVE ROWS;-- ON COMMIT DELETE ROWS para que las filas se eliminen durante cada una de las validaciones
-- COMENTARIOS
-- Comentario en una tabla
COMMENT ON TABLE Tarifas IS 'Tarifa por hotel y tipo de habitación.';
-- Comentario en una columna
COMMENT ON COLUMN Hoteles.idHotel IS 'Número del hotel.';
-- Vemos los comentarios
SELECT * FROM user_tab_comments;--Comentarios de las tablas
SELECT * FROM user_col_comments;--Comentarios de las columnas
-- CREAR TABLAS A PARTIR DE OTRAS
-- Copia de estructura y datos de la tabla
CREATE TABLE Copia_Hoteles1 AS SELECT * FROM Hoteles;
-- Copia de toda la estructura
CREATE TABLE Copia_Hoteles2 AS SELECT * FROM Hoteles WHERE 1=2;
-- Copia de una parte de la estructura
CREATE TABLE Copia_Hoteles3 AS SELECT nombre, estrella FROM Hoteles WHERE 1=2;
-- Copia de una parte de la estructura y selección de filas
CREATE TABLE Copia_Hoteles4 AS SELECT nombre, estrella FROM Hoteles WHERE idHotel=2;
--UTILIZACIÓN DE SINÓNIMOS
--Sirve para simplificar un nombre de una tabla que esté normalizado
CREATE SYNONYM preciosHoteles FOR tarifas;
--Uso del sinónimo
SELECT * FROM preciosHoteles;
-- SECUENCIAS
CREATE SEQUENCE s_numero START WITH 5 INCREMENT BY 1
MINVALUE 2 MAXVALUE 999999 CYCLE;-- CYCLE: Al llegar al valo máximo vuelve a empezar
--Incrementa la secuencia según lo indicado
SELECT s_numero.NEXTVAL FROM DUAL;
--Valor actual de la secuencia
SELECT s_numero.CURRVAL FROM DUAL;
--Permite crear una columna autoincrementada mediante un Trigger
CREATE OR REPLACE TRIGGER ht_numero
BEFORE INSERT ON Hoteles
FOR EACH ROW
DECLARE
BEGIN
    SELECT s_numero.NEXTVAL
    INTO :NEW.idHotel FROM DUAL;
END;
/
--También es psible usar la secuencia en la sentencia Insert
INSERT INTO Hoteles VALUES (s_numero.NEXTVAL,'Hotel de Prueba',3);
-- ELIMINACIÓN DE TABLAS - DROP
--Elimina estructura, datos, índices y comentarios. No elimina sonónimos.
DROP TABLE Tarifas;
DROP TABLE Hoteles;
DROP TABLE TipoHabitacion;
DROP TABLE TMP_TARIFAS2019;
DROP TABLE Copia_Hoteles1;
DROP TABLE Copia_Hoteles2;
DROP TABLE Copia_Hoteles3;
DROP TABLE Copia_Hoteles4;
DELETE TRIGGER ht_numero;
DELETE SEQUENCE s_numero;
--MODIFICACIÓN DE TABLAS - ALTER
CREATE TABLE Habitaciones(
    idHabitaciones      INT,
    Hotel               INT,
    TipoHabitacion      INT,
    NumHabitacion       INT,
    Comentario          VARCHAR(255),
    Vista               VARCHAR (2)
);
DESC Habitaciones;
--Añadimos una columna
ALTER TABLE Habitaciones ADD Telef_Num_Pin INT;
DESC Habitaciones;
--Eliminamos unas columna
ALTER TABLE Habitaciones DROP COLUMN Vista;
ALTER TABLE Habitaciones DROP COLUMN Telef_Num_Pin;
DESC Habitaciones;
--RENOMBRAR TABLAS
RENAME Habitaciones TO Copia_Habitaciones;
DROP TABLE Copia_Habitaciones;
--TRUNCATE
--Elimina las ocurrencias de una tabla
TRUNCATE TABLE Habitaciones;
--VISTAS
INSERT INTO Habitaciones(idHabitaciones,Hotel,TipoHabitacion,NumHabitacion,Comentario)
VALUES (23,4,2,2,'');
INSERT INTO Habitaciones(idHabitaciones,Hotel,TipoHabitacion,NumHabitacion,Comentario)
VALUES (16,3,2,2,'');
INSERT INTO Habitaciones(idHabitaciones,Hotel,TipoHabitacion,NumHabitacion,Comentario)
VALUES (9,2,2,2,'');
INSERT INTO Habitaciones(idHabitaciones,Hotel,TipoHabitacion,NumHabitacion,Comentario)
VALUES (2,1,2,2,'');
INSERT INTO Habitaciones(idHabitaciones,Hotel,TipoHabitacion,NumHabitacion,Comentario)
VALUES (3,1,3,3,'');
INSERT INTO Habitaciones(idHabitaciones,Hotel,TipoHabitacion,NumHabitacion,Comentario)
VALUES (10,2,3,3,'');
INSERT INTO Habitaciones(idHabitaciones,Hotel,TipoHabitacion,NumHabitacion,Comentario)
VALUES (17,3,3,3,'');
INSERT INTO Habitaciones(idHabitaciones,Hotel,TipoHabitacion,NumHabitacion,Comentario)
VALUES (24,4,3,3,'');
INSERT INTO Habitaciones(idHabitaciones,Hotel,TipoHabitacion,NumHabitacion,Comentario)
VALUES (25,4,4,4,'');
INSERT INTO TipoHabitacion (idTipoHabitaciones,NumeroCamas,TipoCama,Descripcion)
VALUES (1,1,'cama individual','1 cama individual con ducha');
INSERT INTO TipoHabitacion (idTipoHabitaciones,NumeroCamas,TipoCama,Descripcion)
VALUES (2,2,'cama individual','2 camas individuales con ducha');
INSERT INTO TipoHabitacion (idTipoHabitaciones,NumeroCamas,TipoCama,Descripcion)
VALUES (3,3,'cama individual','3 camas individuales con ducha y WC separados');
INSERT INTO TipoHabitacion (idTipoHabitaciones,NumeroCamas,TipoCama,Descripcion)
VALUES (4,1,'cama doble','1 cama doble con ducha');
INSERT INTO TipoHabitacion (idTipoHabitaciones,NumeroCamas,TipoCama,Descripcion)
VALUES (5,1,'cama doble','1 cama doble con ducha y WC separados');
INSERT INTO TipoHabitacion (idTipoHabitaciones,NumeroCamas,TipoCama,Descripcion)
VALUES (6,1,'cama doble','1 cama doble con baño y WC separados');
INSERT INTO TipoHabitacion (idTipoHabitaciones,NumeroCamas,TipoCama,Descripcion)
VALUES (7,1,'cama XL','1 cama doble grande con baño y WC separados');
SELECT * FROM Habitaciones;
SELECT * FROM TipoHabitacion;
--NO se almacenan en disco si no en memoria
DROP VIEW V_Habitaciones;
CREATE VIEW V_Habitaciones AS SELECT
Habitaciones.Hotel,Habitaciones.NumHabitacion,TipoHabitacion.TipoCama,
TipoHabitacion.NumeroCamas,TipoHabitacion.Descripcion
FROM Habitaciones,Tipohabitacion
WHERE Habitaciones.TipoHabitacion = TipoHabitacion.idTipoHabitaciones;
SELECT * FROM V_Habitaciones;
--Eliminamos la vista creada
DROP VIEW V_Habitaciones;
-- ÍNDICES
CREATE INDEX I1_Tipohabitacion ON Habitaciones(TipoHabitacion);
CREATE INDEX I2_TipoHotel ON Habitaciones (TipoHabitacion,Hotel);
CREATE INDEX I3_NumHabitacion ON Habitaciones (NumHabitacion DESC);--Búsqueda en modo descendente
--Eliminar índices
DROP INDEX I1_Tipohabitacion;
DROP INDEX I3_NumHabitacion;
--PRIMAY KEY
DROP TABLE Habitaciones;
--Con una columna
CREATE TABLE Habitaciones(
    idHabitaciones      INT PRIMARY KEY,
    Hotel               INT,
    TipoHabitacion      INT,
    NumHabitacion       INT,
    Comentario          VARCHAR(255)
);
DROP TABLE Habitaciones;
--Con varias columnas
CREATE TABLE Habitaciones(
    idHabitaciones      INT,
    Hotel               INT,
    TipoHabitacion      INT,
    NumHabitacion       INT,
    Comentario          VARCHAR(255),
    CONSTRAINT pk_Habitaciones PRIMARY KEY(Hotel,NumHabitacion)
);
--Añadir restricciones a una tabla ya creada
ALTER TABLE Tarifas ADD CONSTRAINT pk_Tarifas PRIMARY KEY (IdTarifa,Hotel);
ALTER TABLE TipoHabitacion ADD CONSTRAINT pk_TipoHabitacion PRIMARY KEY (IdTipoHabitaciones);
--Creación de las tablas con restricciones primaria y ajena
DROP TABLE Habitaciones;
CREATE TABLE Habitaciones(
    idHabitaciones      INT PRIMARY KEY,
    Hotel               INT,
    TipoHabitacion      INT,
    NumHabitacion       INT,
    Comentario          VARCHAR(255),
    Vista               VARCHAR (2),
    CONSTRAINT fk_TipoHabitacion FOREIGN KEY(TipoHabitacion) REFERENCES
    TipoHabitacion (idTipoHabitaciones) ON DELETE SET NULL
);
--VALORES POR DEFECTO
DROP TABLE Habitaciones;
--Al crear la tabla
CREATE TABLE Habitaciones(
    idHabitaciones      INT PRIMARY KEY,
    Hotel               INT,
    TipoHabitacion      INT DEFAULT 2,
    NumHabitacion       INT,
    Comentario          VARCHAR(255),
    Vista               VARCHAR (2),
    CONSTRAINT fk_TipoHabitacion FOREIGN KEY(TipoHabitacion) REFERENCES
    TipoHabitacion (idTipoHabitaciones) ON DELETE SET NULL
);
--Modificándola
ALTER TABLE Habitaciones DROP (Vista);
ALTER TABLE Habitaciones ADD (Vista VARCHAR(20) DEFAULT 'Mar');
--VALOR NULL
INSERT INTO Habitaciones(idHabitaciones,Hotel,TipoHabitacion,NumHabitacion,Comentario)
VALUES (1,1,1,1,'Vistas al mar');
INSERT INTO Habitaciones(idHabitaciones,Hotel,TipoHabitacion,NumHabitacion,Comentario)
VALUES (2,1,2,2,' ');
INSERT INTO Habitaciones(idHabitaciones,Hotel,TipoHabitacion,NumHabitacion)
VALUES (3,1,3,3);
INSERT INTO Habitaciones(idHabitaciones,Hotel,TipoHabitacion,NumHabitacion)
VALUES (4,1,4,4);
INSERT INTO Habitaciones(idHabitaciones,Hotel,TipoHabitacion,NumHabitacion,Comentario)
VALUES (5,1,5,5,'Vistas al mar');
INSERT INTO Habitaciones(idHabitaciones,Hotel,TipoHabitacion,NumHabitacion)
VALUES (6,1,6,6);
INSERT INTO Habitaciones(idHabitaciones,Hotel,TipoHabitacion,NumHabitacion,Comentario)
VALUES (7,1,7,7,'Vistas al mar');
SELECT * FROM Habitaciones;
SELECT COUNT(*)FROM Habitaciones WHERE Comentario NOT IN ('Vistas al mar');
--RESTRICCION UNIQUE
DROP TABLE Hoteles;
CREATE TABLE Hoteles(
    idHotel        INT,
    Nombre         VARCHAR(50) UNIQUE,
    Estrella       VARCHAR(5)
);
DROP TABLE Hoteles;
CREATE TABLE Hoteles(
    idHotel        INT,
    Nombre         VARCHAR(50),
    Estrella       VARCHAR(5)
);
ALTER TABLE Hoteles MODIFY (NOmbre UNIQUE);
--RESTRICCIÓN CHECK
DROP TABLE Habitaciones;
--Al crear la tabla
CREATE TABLE Habitaciones(
    idHabitaciones      INT PRIMARY KEY,
    Hotel               INT CHECK (VALUE BETWEEN 1 AND 999),
    TipoHabitacion      CHECK (VALUE IN (SELECT IdTipohabitaciones FROM TipoHabitacion)),
    NumHabitacion       INT,
    Comentario          VARCHAR(255),
    Vista               VARCHAR (2)
);


