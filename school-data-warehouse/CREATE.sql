--CREATE DATABASE HD_Etap_4

USE HD_Etap_4
-- Table: Data
CREATE TABLE Data_Wystawienia (
    ID_Data INT IDENTITY(1, 1) PRIMARY KEY, -- Surrogate Key
    Data DATETIME UNIQUE,
    Rok VARCHAR(4),
    Miesiac VARCHAR(25),
    Dzien VARCHAR(25),
    Polrocze VARCHAR(25),
    Dzien_Pracujacy BIT,
    Dzien_Tygodnia VARCHAR(50),
    Numer_Miesiaca INT
);

-- Table: Sala
CREATE TABLE Sala (
    ID_Sali INT IDENTITY(1, 1) PRIMARY KEY, -- Surrogate Key
    Numer_Sali VARCHAR(50) NOT NULL,
    Rodzaj_Sali VARCHAR(50)
);

-- Table: Junk
CREATE TABLE Junk (
    ID_Junk INT IDENTITY(1, 1) PRIMARY KEY, -- Surrogate Key
    Rodzaj_Oceny VARCHAR(50) NOT NULL,
    Czy_Zatwierdzona BIT
);

-- Table: Uczen
CREATE TABLE Uczen (
    ID_Ucznia INT IDENTITY(1, 1) PRIMARY KEY, -- Surrogate Key
	Pesel VARCHAR(25),
    Nazwisko_Imie VARCHAR(100) NOT NULL,
    Czy_Absolwent BIT,
	Is_Current BIT
);

-- Table: Nauczyciel
CREATE TABLE Nauczyciel (
    ID_Nauczyciela INT IDENTITY(1, 1) PRIMARY KEY, -- Surrogate Key
    Nazwisko_Imie VARCHAR(100) NOT NULL,
    Stopien_Naukowy VARCHAR(50),
    Email VARCHAR(100),
    Przedmiot VARCHAR(50)
);

-- Table: Wystawienie_Oceny
CREATE TABLE Wystawienie_Oceny (
    FK_Uczen INT NOT NULL FOREIGN KEY REFERENCES Uczen(ID_Ucznia),
    FK_Nauczyciel INT NOT NULL FOREIGN KEY REFERENCES Nauczyciel(ID_Nauczyciela),
    FK_Data INT NOT NULL FOREIGN KEY REFERENCES Data_Wystawienia(ID_Data),
    FK_Sala INT NOT NULL FOREIGN KEY REFERENCES Sala(ID_Sali),
    FK_Junk INT NOT NULL FOREIGN KEY REFERENCES Junk(ID_Junk),
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
