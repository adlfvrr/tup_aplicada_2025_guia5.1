

USE master

GO

DROP DATABASE IF EXISTS GUIA5_1_Ejercicio1_adolf_DB

GO

CREATE DATABASE GUIA5_1_Ejercicio1_adolf_DB

GO

USE GUIA5_1_Ejercicio1_adolf_DB

GO

CREATE TABLE Figuras
(
	Id INT IDENTITY(1,1),
	Tipo INT NOT NULL, --1 Rectangulo, 2 Circulo
	Ancho DECIMAL (18,2),
	Largo DECIMAL (18,2),
	Radio DECIMAL (18,2),
	Area DECIMAL(18,2),
	CONSTRAINT PK_Figuras PRIMARY KEY (Id)
)

GO

INSERT INTO Figuras (Tipo, Ancho, Largo, Radio)
VALUES
	(1, 1, 1,NULL),
	(1, 1, 2, NULL),
	(1, 2.2, 1, NULL),
	(2, NUll, NULL, 1),
	(2, NULL, NULL, 1)

GO


SELECT f.Id,
	   Tipo = CASE 
				WHEN f.Tipo = 1 THEN 'Rectangulo'
				WHEN f.Tipo = 2 THEN 'Circulo'
			  ELSE 'Desconocido'
			END ,
	   f.Area,
	   f.Ancho,
	   f.Largo,
	   f.Radio
FROM Figuras f

GO

CREATE PROCEDURE sp_Calcular_Area
(
	@Id INT
)
AS
BEGIN

	--UPDATE Figuras SET Area = Ancho * Largo
	--WHERE Id = @Id AND Tipo = 1;

	--UPDATE Figuras SET Area = 3.1415 * Radio * Radio
	--WHERE Id = @Id AND Tipo = 2;
	
	UPDATE Figuras SET Area = CASE 
	WHEN Tipo = 1 THEN Ancho * Largo
	WHEN Tipo = 2 THEN 3.1415 * POWER(Radio,2)
	ELSE 0 END
	WHERE Id = @Id

END

GO

EXEC sp_Calcular_Area @Id = 1

EXEC sp_Calcular_Area @Id = 4

SELECT * FROM Figuras

GO

DECLARE Figura_CURSOR CURSOR FOR SELECT f.Id FROM Figuras f

OPEN Figura_CURSOR

USE master