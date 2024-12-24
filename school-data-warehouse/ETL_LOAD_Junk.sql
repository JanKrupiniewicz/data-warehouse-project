USE HD_Etap_4;
GO

-- Usuñ tabelê tymczasow¹, jeœli istnieje
IF OBJECT_ID('dbo.JunkTemp', 'U') IS NOT NULL DROP TABLE dbo.JunkTemp;
GO

CREATE TABLE dbo.JunkTemp (
    Rodzaj_Oceny VARCHAR(50),
    Czy_Zatwierdzona BIT
);
GO

INSERT INTO dbo.JunkTemp (Rodzaj_Oceny, Czy_Zatwierdzona)
VALUES
    ('Sprawdzian', 1), ('Sprawdzian', 0),
    ('Kartkowka', 1), ('Kartkowka', 0),
    ('Praca Klasowa', 1), ('Praca Klasowa', 0),
    ('Odpowiedz Ustna', 1), ('Odpowiedz Ustna', 0),
    ('Projekt', 1), ('Projekt', 0),
    ('Zadanie Domowe', 1), ('Zadanie Domowe', 0),
    ('Inne', 1), ('Inne', 0);
GO

MERGE INTO Junk AS TT
USING (SELECT DISTINCT Rodzaj_Oceny, Czy_Zatwierdzona FROM dbo.JunkTemp) AS ST
ON TT.Rodzaj_Oceny = ST.Rodzaj_Oceny AND TT.Czy_Zatwierdzona = ST.Czy_Zatwierdzona
WHEN NOT MATCHED THEN
INSERT (Rodzaj_Oceny, Czy_Zatwierdzona)
VALUES (ST.Rodzaj_Oceny, ST.Czy_Zatwierdzona);
GO

DROP TABLE dbo.JunkTemp;
GO
