USE HD_Etap_4;
GO

IF OBJECT_ID('dbo.NauczycielTemp', 'U') IS NOT NULL DROP TABLE dbo.NauczycielTemp;
CREATE TABLE dbo.NauczycielTemp (
    Imie VARCHAR(50),
    Nazwisko VARCHAR(50),
    Email VARCHAR(100),
	Stopien_Naukowy VARCHAR(50),
    Przedmiot VARCHAR(50)
);
GO

-- Bulk insert from CSV
BULK INSERT dbo.NauczycielTemp
FROM 'C:\Users\jkrup\studia\HD\data-generator\school-excel\Nauczyciel.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
GO

MERGE INTO Nauczyciel AS Target
USING (
    SELECT DISTINCT 
        CONCAT(Nazwisko, ' ', Imie) AS Nazwisko_Imie,
        NULLIF(Email, '') AS Email,
		Stopien_Naukowy,
        Przedmiot
    FROM dbo.NauczycielTemp
) AS Source
ON Target.Nazwisko_Imie = Source.Nazwisko_Imie
WHEN NOT MATCHED THEN
    INSERT (Nazwisko_Imie, Email, Stopien_Naukowy, Przedmiot)
    VALUES (Source.Nazwisko_Imie, Source.Email, Source.Stopien_Naukowy, Source.Przedmiot);
GO

DROP TABLE dbo.NauczycielTemp;
GO