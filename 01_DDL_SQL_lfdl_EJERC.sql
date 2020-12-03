--EJERCICIO 1
CREATE TABLE Peliculas (
    Ident_Pelicula  NUMBER(40)
                    PRIMARY KEY,
    Titulo          VARCHAR2(50),
    Genero1         VARCHAR2(20),
    Recaudacion     NUMBER(15,2),
    Fecha_Estreno   DATE,
    Pais            NUMBER(40),
    Num_Entradas    NUMBER(40),
    Sinopsis        VARCHAR2(2000),
    Fecha_Alta      TIMESTAMP(6)
);
ALTER TABLE Peliculas ADD (Num_Real INTEGER);