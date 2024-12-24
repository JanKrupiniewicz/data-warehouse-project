USE HD_Etap_4;
GO

IF OBJECT_ID('dbo.SalaTemp', 'U') IS NOT NULL DROP TABLE dbo.SalaTemp;
CREATE TABLE dbo.SalaTemp (
    Numer_Sali VARCHAR(50),
    Rodzaj_Sali VARCHAR(50)
);
GO

INSERT INTO dbo.Sala (Numer_Sali, Rodzaj_Sali)
SELECT DISTINCT 
    Numer_Sali, Rodzaj_Sali
FROM HD_Data_Source.dbo.Sala;
GO

MERGE INTO Sala AS TT
USING (SELECT DISTINCT Numer_Sali, Rodzaj_Sali FROM dbo.SalaTemp) AS ST
ON TT.Numer_Sali = ST.Numer_Sali
WHEN NOT MATCHED THEN
INSERT (Numer_Sali, Rodzaj_Sali)
VALUES (ST.Numer_Sali, ST.Rodzaj_Sali);
GO

DROP TABLE dbo.SalaTemp;
GO