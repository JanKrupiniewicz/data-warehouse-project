USE HD_Etap_4

INSERT INTO Data_Wystawienia (Data, Rok, Miesiac, Dzien, Polrocze, Dzien_Pracujacy, Dzien_Tygodnia, Numer_Miesiaca)
VALUES
('2024-11-01', '2024', 'Listopad', '1', 'Pierwsze', 1, 'Pi¹tek', 11),
('2024-11-02', '2024', 'Listopad', '2', 'Pierwsze', 0, 'Sobota', 11),
('2024-11-03', '2024', 'Listopad', '3', 'Pierwsze', 0, 'Niedziela', 11),
('2024-11-04', '2024', 'Listopad', '4', 'Pierwsze', 1, 'Poniedzia³ek', 11),
('2024-11-05', '2024', 'Listopad', '5', 'Pierwsze', 1, 'Wtorek', 11),
('2024-11-06', '2024', 'Listopad', '6', 'Pierwsze', 1, 'Œroda', 11),
('2024-11-07', '2024', 'Listopad', '7', 'Pierwsze', 1, 'Czwartek', 11),
('2024-11-08', '2024', 'Listopad', '8', 'Pierwsze', 1, 'Pi¹tek', 11);

INSERT INTO Sala (Numer_Sali, Rodzaj_Sali)
VALUES
('101', 'Sala lekcyjna'),
('102', 'Sala komputerowa'),
('201', 'Sala chemiczna'),
('202', 'Sala fizyczna'),
('301', 'Sala matematyczna'),
('302', 'Sala jêzykowa'),
('401', 'Sala biologiczna'),
('402', 'Sala geograficzna');

INSERT INTO Junk (Rodzaj_Oceny, Czy_Zatwierdzona)
VALUES
('Sprawdzian', 1),
('Kartkówka', 1),
('OdpowiedŸ ustna', 1),
('Zadanie domowe', 1),
('Projekt', 1),
('Aktywnoœæ', 1),
('Praca klasowa', 1),
('Test diagnostyczny', 1);

INSERT INTO Uczen (Nazwisko_Imie, Czy_Absolwent)
VALUES
('Kowalski Jan', 0),
('Nowak Anna', 0),
('Wiœniewski Piotr', 0),
('Kowalczyk Maria', 0),
('Zieliñski Tomasz', 0),
('Lewandowska Ewa', 0),
('Baran Wojciech', 0),
('Nowicka Aleksandra', 0);

INSERT INTO Nauczyciel (Nazwisko_Imie, Stopien_Naukowy, Email, Przedmiot)
VALUES
('Nowakowski Adam', 'Mgr', 'adam.nowakowski@example.com', 'Matematyka'),
('Wojciechowska Eliza', 'Dr', 'eliza.wojciechowska@example.com', 'Fizyka'),
('Lewandowski Pawe³', 'Mgr', 'pawel.lewandowski@example.com', 'Chemia'),
('Krawczyk Zofia', 'Dr', 'zofia.krawczyk@example.com', 'Biologia'),
('Kamiñski Micha³', 'Mgr', 'michal.kaminski@example.com', 'Informatyka'),
('Jankowski Marek', 'Dr', 'marek.jankowski@example.com', 'Historia'),
('Zawadzka Marta', 'Mgr', 'marta.zawadzka@example.com', 'Geografia'),
('Urbanek Katarzyna', 'Dr', 'katarzyna.urbanek@example.com', 'Jêzyk polski');

INSERT INTO Wystawienie_Oceny (FK_Uczen, FK_Nauczyciel, FK_Data, FK_Sala, FK_Junk, Wartosc_Oceny, Waga_Oceny, Uzyskany_Wynik)
VALUES
(1, 1, 1, 1, 1, 5, 2.00, 85.00),
(1, 2, 2, 2, 2, 4, 1.50, 75.00),
(2, 3, 3, 3, 3, 6, 2.00, 95.00),
(2, 4, 4, 4, 4, 3, 1.00, 60.00),
(3, 5, 5, 5, 5, 2, 1.00, 50.00),
(3, 6, 6, 6, 6, 5, 2.50, 90.00),
(4, 7, 7, 7, 7, 4, 1.50, 70.00),
(4, 8, 8, 8, 8, 3, 1.00, 60.00),
(5, 1, 1, 2, 1, 6, 3.00, 100.00),
(5, 2, 2, 3, 2, 2, 1.00, 55.00);