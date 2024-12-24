USE HD_Etap_4;

-- 1. Liczba wystawionych ocen dla nauczyciela o ID = 1
SELECT COUNT(*) AS LiczbaWystawionychOcen
FROM Wystawienie_Oceny
WHERE FK_Nauczyciel = 1;

-- 2. Œrednia wartoœæ ocen dla nauczycieli o stopniu naukowym "Dr"
SELECT AVG(Wartosc_Oceny) AS SredniaWartoscOcen
FROM Wystawienie_Oceny
JOIN Nauczyciel ON Wystawienie_Oceny.FK_Nauczyciel = Nauczyciel.ID_Nauczyciela
WHERE Nauczyciel.Stopien_Naukowy = 'Dr';

-- 3. Œrednia wartoœæ ocen dla nauczycieli z przedmiotów: Matematyka, Informatyka, Fizyka
SELECT AVG(Wartosc_Oceny) AS SredniaWartoscOcen
FROM Wystawienie_Oceny
JOIN Nauczyciel ON Wystawienie_Oceny.FK_Nauczyciel = Nauczyciel.ID_Nauczyciela
WHERE Nauczyciel.Przedmiot IN ('Matematyka', 'Informatyka', 'Fizyka');

-- 4. Liczba ocen wystawionych miêdzy 5 a 8 listopada 2024
SELECT COUNT(*) AS LiczbaWystawionychOcen
FROM Wystawienie_Oceny
JOIN Data_Wystawienia ON Wystawienie_Oceny.FK_Data = Data_Wystawienia.ID_Data
WHERE Data_Wystawienia.Data BETWEEN '2024-11-05' AND '2024-11-08';

-- 5. Œrednia wartoœæ procentowa ocen w salach komputerowych
SELECT AVG(Uzyskany_Wynik) AS SredniaWartoscProcentowaOcen
FROM Wystawienie_Oceny
JOIN Sala ON Wystawienie_Oceny.FK_Sala = Sala.ID_Sali
WHERE Sala.Rodzaj_Sali = 'Sala komputerowa';

-- 6. Liczba wystawionych ocen, które zosta³y zatwierdzone
SELECT COUNT(*) AS LiczbaWystawionychOcen
FROM Wystawienie_Oceny
JOIN Junk ON Wystawienie_Oceny.FK_Junk = Junk.ID_Junk
WHERE Junk.Czy_Zatwierdzona = 1;

-- 7. Liczba ocen wystawionych uczniom niebêd¹cym absolwentami
SELECT COUNT(*) AS LiczbaWystawionychOcen
FROM Wystawienie_Oceny
JOIN Uczen ON Wystawienie_Oceny.FK_Uczen = Uczen.ID_Ucznia
WHERE Uczen.Czy_Absolwent = 0;

-- 8. Suma wag ocen dla nauczycieli ze stopniem naukowym "Mgr"
SELECT SUM(Waga_Oceny) AS SumaWagOcen
FROM Wystawienie_Oceny
JOIN Nauczyciel ON Wystawienie_Oceny.FK_Nauczyciel = Nauczyciel.ID_Nauczyciela
WHERE Nauczyciel.Stopien_Naukowy = 'Mgr';

-- 9. Liczba ocen wystawionych w sali matematycznej, ale bez matematyki
SELECT COUNT(*) AS LiczbaWystawionychOcen
FROM Wystawienie_Oceny
JOIN Sala ON Wystawienie_Oceny.FK_Sala = Sala.ID_Sali
JOIN Nauczyciel ON Wystawienie_Oceny.FK_Nauczyciel = Nauczyciel.ID_Nauczyciela
WHERE Sala.Rodzaj_Sali = 'Sala matematyczna'
  AND Nauczyciel.Przedmiot != 'Matematyka';

-- 10. Wyliczenie liczby wystawionych ocen przez nauczycieli o stopniu naukowym „Dr” w przedziale dat od 1 do 4 listopada 2024 roku.
SELECT COUNT(*) AS LiczbaWystawionychOcen
FROM Wystawienie_Oceny
JOIN Nauczyciel ON Wystawienie_Oceny.FK_Nauczyciel = Nauczyciel.ID_Nauczyciela
JOIN Data_Wystawienia ON Wystawienie_Oceny.FK_Data = Data_Wystawienia.ID_Data
WHERE Nauczyciel.Stopien_Naukowy = 'Dr'
  AND Data_Wystawienia.Data BETWEEN '2024-11-01' AND '2024-11-04';
