-- CREATE DATABASE HD_Data_Source

USE HD_Data_Source
-- Table: Sala
CREATE TABLE Sala (
    ID_Sali INT IDENTITY(1, 1) PRIMARY KEY, -- Surrogate Key
    Numer_Sali VARCHAR(50) NOT NULL,
    Rodzaj_Sali VARCHAR(50)
);

-- Table: Wystawienie_Oceny
CREATE TABLE Wystawienie_Oceny (
    FK_Uczen INT NOT NULL,
    FK_Nauczyciel INT NOT NULL,
    FK_Data INT NOT NULL,
    FK_Sala INT NOT NULL FOREIGN KEY REFERENCES Sala(ID_Sali),
    FK_Junk INT NOT NULL,
    Wartosc_Oceny INT NOT NULL,
    Waga_Oceny DECIMAL(5, 2) NOT NULL,
    Uzyskany_Wynik DECIMAL(5, 2) NOT NULL

	CONSTRAINT Composite_PK PRIMARY KEY (
		FK_Uczen,
		FK_Nauczyciel,
		FK_Data,
		FK_Sala,
		FK_Junk
	)
);

