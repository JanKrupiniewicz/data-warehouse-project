USE HD_Etap_4;
GO

-- Drop the temporary table if it exists
IF OBJECT_ID('dbo.UczenTemp', 'U') IS NOT NULL DROP TABLE dbo.UczenTemp;

-- Create a temporary table matching the CSV format
CREATE TABLE dbo.UczenTemp (
    Imie VARCHAR(50),
    Nazwisko VARCHAR(50),
	Pesel VARCHAR(25),
    Czy_Absolwent VARCHAR(10)
);
GO

-- Bulk insert from CSV
BULK INSERT dbo.UczenTemp
FROM 'C:\Users\jkrup\studia\HD\data-generator\school-excel\Uczen.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
GO

MERGE INTO Uczen AS Target
USING (
    SELECT 
        CONCAT(Nazwisko, ' ', Imie) AS Nazwisko_Imie,
        Pesel,
        CASE Czy_Absolwent 
            WHEN 'true' THEN 1
            ELSE 0
        END AS Czy_Absolwent
    FROM dbo.UczenTemp
) AS Source
ON Target.Pesel = Source.Pesel -- Dopasowanie na kluczu biznesowym
    AND Target.Is_Current = 1
WHEN MATCHED AND (
    Target.Czy_Absolwent <> Source.Czy_Absolwent
    OR Target.Nazwisko_Imie <> Source.Nazwisko_Imie
) THEN
    -- Deactivate current record and insert a new version
    UPDATE SET Target.Is_Current = 0
WHEN NOT MATCHED BY TARGET THEN
    INSERT (Pesel, Nazwisko_Imie, Czy_Absolwent, Is_Current)
    VALUES (Source.Pesel, Source.Nazwisko_Imie, Source.Czy_Absolwent, 1);
GO

INSERT INTO Uczen (Nazwisko_Imie, Czy_Absolwent, Is_Current)
SELECT Nazwisko_Imie, Czy_Absolwent, 1
FROM (
    SELECT 
        CONCAT(Nazwisko, ' ', Imie) AS Nazwisko_Imie,
        Czy_Absolwent
    FROM dbo.UczenTemp
) AS Source
EXCEPT
SELECT Nazwisko_Imie, Czy_Absolwent, Is_Current
FROM Uczen
WHERE Is_Current = 1;
GO

-- Drop the temporary table
DROP TABLE dbo.UczenTemp;
GO
