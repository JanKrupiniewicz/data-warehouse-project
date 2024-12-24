USE HD_Etap_4;
GO

-- Usuñ tabelê tymczasow¹, jeœli istnieje
IF OBJECT_ID('dbo.DataTemp', 'U') IS NOT NULL DROP TABLE dbo.DataTemp;
GO

-- Utwórz tabelê tymczasow¹
CREATE TABLE dbo.DataTemp (
    Data DATETIME,
    Rok VARCHAR(4),
    Miesiac VARCHAR(25),
    Dzien VARCHAR(25),
    Polrocze VARCHAR(25),
    Dzien_Pracujacy BIT,
    Dzien_Tygodnia VARCHAR(50),
    Numer_Miesiaca INT
);
GO

-- Generowanie dat i wstawianie do tabeli tymczasowej
DECLARE @Start DATE = '2021-01-01',
        @End DATE = '2025-01-01';

WITH Dates AS (
    SELECT TOP (DATEDIFF(DAY, @Start, @End) + 1)
           DATEADD(DAY, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1, @Start) AS FullDate
    FROM master.dbo.spt_values -- Generowanie du¿ej liczby wierszy
)
INSERT INTO dbo.DataTemp (Data, Rok, Miesiac, Dzien, Polrocze, Dzien_Pracujacy, Dzien_Tygodnia, Numer_Miesiaca)
SELECT 
    FullDate AS Data,
    YEAR(FullDate) AS Rok,
    CASE MONTH(FullDate)
        WHEN 1 THEN 'Styczen'
        WHEN 2 THEN 'Luty'
        WHEN 3 THEN 'Marzec'
        WHEN 4 THEN 'Kwiecien'
        WHEN 5 THEN 'Maj'
        WHEN 6 THEN 'Czerwiec'
        WHEN 7 THEN 'Lipiec'
        WHEN 8 THEN 'Sierpien'
        WHEN 9 THEN 'Wrzesien'
        WHEN 10 THEN 'Pazdziernik'
        WHEN 11 THEN 'Listopad'
        WHEN 12 THEN 'Grudzien'
    END AS Miesiac,
    CASE DATENAME(WEEKDAY, FullDate)
        WHEN 'Monday' THEN 'Poniedzialek'
        WHEN 'Tuesday' THEN 'Wtorek'
        WHEN 'Wednesday' THEN 'Sroda'
        WHEN 'Thursday' THEN 'Czwartek'
        WHEN 'Friday' THEN 'Piatek'
        WHEN 'Saturday' THEN 'Sobota'
        WHEN 'Sunday' THEN 'Niedziela'
    END AS Dzien,
    CASE 
        WHEN MONTH(FullDate) BETWEEN 1 AND 6 THEN 'Pierwsze'
        ELSE 'Drugie'
    END AS Polrocze,
    CASE 
        WHEN DATEPART(WEEKDAY, FullDate) IN (1, 7) THEN 0 -- 0 oznacza weekend
        ELSE 1 -- 1 oznacza dzieñ roboczy
    END AS Dzien_Pracujacy,
    DATENAME(WEEKDAY, FullDate) AS Dzien_Tygodnia,
    MONTH(FullDate) AS Numer_Miesiaca
FROM Dates;
GO

-- Po³¹cz dane z tabeli tymczasowej z tabel¹ docelow¹
MERGE INTO Data_Wystawienia AS TT
USING (SELECT DISTINCT Data, Rok, Miesiac, Dzien, Polrocze, Dzien_Pracujacy, Dzien_Tygodnia, Numer_Miesiaca FROM dbo.DataTemp) AS ST
ON TT.Data = ST.Data
WHEN NOT MATCHED THEN
INSERT (Data, Rok, Miesiac, Dzien, Polrocze, Dzien_Pracujacy, Dzien_Tygodnia, Numer_Miesiaca)
VALUES (ST.Data, ST.Rok, ST.Miesiac, ST.Dzien, ST.Polrocze, ST.Dzien_Pracujacy, ST.Dzien_Tygodnia, ST.Numer_Miesiaca);
GO

-- Usuñ tabelê tymczasow¹
DROP TABLE dbo.DataTemp;
GO
