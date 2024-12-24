USE HD_Etap_4;
GO

IF OBJECT_ID('dbo.OcenyTemp', 'U') IS NOT NULL DROP TABLE dbo.OcenyTemp;
CREATE TABLE dbo.OcenyTemp (
    FK_Uczen INT,
    FK_Nauczyciel INT,
    FK_Data INT,
    FK_Sala INT,
    FK_Junk INT,
    Wartosc_Oceny INT,
    Waga_Oceny DECIMAL(5, 2),
    Uzyskany_Wynik DECIMAL(5, 2)
);
GO

INSERT INTO dbo.OcenyTemp (FK_Uczen, FK_Nauczyciel, FK_Data, FK_Sala, FK_Junk, Wartosc_Oceny, Waga_Oceny, Uzyskany_Wynik)
SELECT 
    FK_Uczen,
    FK_Nauczyciel,
    FK_Data,
    FK_Sala,
    FK_Junk,
    Wartosc_Oceny,
    Waga_Oceny,
    Uzyskany_Wynik
FROM HD_Data_Source.dbo.Wystawienie_Oceny;
GO

-- Update the view to use correct column names
IF OBJECT_ID('vETLWystawienieOcenyData', 'V') IS NOT NULL DROP VIEW vETLWystawienieOcenyData;
GO

CREATE VIEW vETLWystawienieOcenyData AS
SELECT 
    u.ID_Ucznia AS FK_Uczen,
    n.ID_Nauczyciela AS FK_Nauczyciel,
    d.ID_Data AS FK_Data,
    s.ID_Sali AS FK_Sala,
    j.ID_Junk AS FK_Junk,
    o.Waga_Oceny AS Waga_Oceny,
    o.Wartosc_Oceny AS Wartosc_Oceny,
    o.Uzyskany_Wynik AS Uzyskany_Wynik
FROM dbo.OcenyTemp o
LEFT JOIN dbo.Uczen u ON o.FK_Uczen = u.ID_Ucznia            -- Po³¹czenie z tabel¹ uczniów
LEFT JOIN dbo.Nauczyciel n ON o.FK_Nauczyciel = n.ID_Nauczyciela -- Po³¹czenie z tabel¹ nauczycieli
LEFT JOIN dbo.Data_Wystawienia d ON o.FK_Data = d.ID_Data           -- Po³¹czenie z tabel¹ dat
LEFT JOIN dbo.Sala s ON o.FK_Sala = s.ID_Sali           -- Po³¹czenie z tabel¹ sal
LEFT JOIN dbo.Junk j ON o.FK_Junk = j.ID_Junk;          -- Po³¹czenie z tabel¹ "œmieci"
GO


MERGE INTO Wystawienie_Oceny AS Fakt
USING vETLWystawienieOcenyData AS Widok
ON Fakt.FK_Uczen = Widok.FK_Uczen 
   AND Fakt.FK_Nauczyciel = Widok.FK_Nauczyciel
   AND Fakt.FK_Data = Widok.FK_Data
   AND Fakt.FK_Sala = Widok.FK_Sala
   AND Fakt.FK_Junk = Widok.FK_Junk
WHEN NOT MATCHED THEN
    INSERT (
        FK_Uczen, FK_Nauczyciel, FK_Data, FK_Sala, FK_Junk, 
        Wartosc_Oceny, Waga_Oceny, Uzyskany_Wynik
    )
    VALUES (
        Widok.FK_Uczen, Widok.FK_Nauczyciel, Widok.FK_Data, Widok.FK_Sala, Widok.FK_Junk,
        Widok.Wartosc_Oceny, Widok.Waga_Oceny, Widok.Uzyskany_Wynik
    );
GO


IF OBJECT_ID('vETLDimData', 'V') IS NOT NULL DROP VIEW vETLDimData;
GO

DROP TABLE dbo.OcenyTemp;
GO