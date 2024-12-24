from datetime import date, datetime, timedelta
from faker import Faker
import random
import pyodbc
import csv

subjects = [
    'Matematyka', 'Fizyka', 'Chemia', 'Biologia', 'Jezyk polski', 
    'Jezyk angielski', 'Historia', 'Geografia', 'Informatyka', 'Wiedza o spoleczenstwie'
]

subject_types = ['Wyklad', 'Cwiczenia', 'Laboratorium']
class_types = ['Sala Wykladowa', 'Sala Komputerowa', 'Sala Laboratoryjna', 'Sala Cwiczeniowa']
grade_types = ['Sprawdzian', 'Kartkowka', 'Praca Klasowa', 'Odpowiedz Ustna', 'Projekt', 'Zadanie Domowe', 'Inne']

driver_name = 'SQL SERVER'
server_name = 'LAPTOP-7M14R3G4\\MSSQLSERVER01'
database_name = 'HD_Data_Source'
csv_files_path = './csv'

class SqlDataGenerator:
    def __init__(self) -> None:
        # self.connection = connection
        # self.cursor = connection.cursor()
        self.fake = Faker()
        self.Data_Wystawienia = []
        self.Wystawienie_Oceny = []
        self.Sala = []
        self.Junk = []

    def generate_data(self) -> None:
        # self.generate_teacher_data()
        #self.generate_student_data()
        # self.generate_data_wystawienia()
        # self.generate_sala()
        # self.generate_junk()
        # self.generate_wystawienie_oceny()

        self.generate_wystawienie_oceny_t1()
        # self.generate_sala_t1()
        self.generate_wystawienie_oceny_t2()
        # self.generate_sala_t2()

    def random_degree(self) -> str:
        degrees = ['Magister', 'Doktor', 'Profesor']
        return degrees[random.randint(0, 2)]

    def generate_teacher_data(self) -> None:
        with open(f'{csv_files_path}/Nauczyciel.csv', mode='w', newline='', encoding='utf-8') as file:
            writer = csv.writer(file)
            writer.writerow(['Imie', 'Nazwisko', 'Email', 'Stopien_Naukowy', 'Przedmiot'])
            for _ in range(50):
                writer.writerow([self.fake.first_name(), self.fake.last_name(), self.fake.email(), self.random_degree() , random.choice(subjects)])

    def generate_student_pesel(self) -> str:
        return f'{random.randint(1, 99):02}{random.randint(1, 12):02}{random.randint(1, 28):02}{random.randint(1, 9999):04}'


    def generate_student_data(self) -> None:
        with open(f'{csv_files_path}/Uczen.csv', mode='w', newline='', encoding='utf-8') as file:
            writer = csv.writer(file)
            writer.writerow(['Imie', 'Nazwisko', 'Pesel', 'Czy_Absolwent'])
            for _ in range(250):
                first_name = self.fake.first_name()
                writer.writerow([first_name, self.fake.last_name(),  self.generate_student_pesel(),random.choice([0, 1])])

    def generate_class_code(self) -> str:
        return f'{random.randint(1, 9)}{random.choice("ABCDEF")}{random.randint(10, 99)}'

    def generate_sala(self) -> None:
        for _ in range(30):
            self.Sala.append([self.generate_class_code(), random.choice(class_types)])

        with open('Sala.csv', mode='w', newline='', encoding='utf-8') as file:
            writer = csv.writer(file)
            writer.writerow(['Numer_Sali', 'Rodzaj_Sali'])
            writer.writerows(self.Sala)

        # self.cursor.executemany(
        #     "INSERT INTO Sala (Numer_Sali, Rodzaj_Sali) VALUES (?, ?)",
        #     self.Sala
        # )

        # self.connection.commit()

    def generate_sala_t1(self) -> None:
        for i in range(15):
            self.Sala.append([i + 1, self.generate_class_code(), random.choice(class_types)])

        with open('Sala_T1.csv', mode='w', newline='', encoding='utf-8') as file:
            writer = csv.writer(file)
            writer.writerow(['Numer_Sali', 'Rodzaj_Sali'])
            writer.writerows(self.Sala)

        self.Sala = []

    def generate_sala_t2(self) -> None:
        for i in range(15):
            self.Sala.append([i + 1, self.generate_class_code(), random.choice(class_types)])

        with open('Sala_T2.csv', mode='w', newline='', encoding='utf-8') as file:
            writer = csv.writer(file)
            writer.writerow(['Numer_Sali', 'Rodzaj_Sali'])
            writer.writerows(self.Sala)

        self.Sala = []

    def generate_junk(self) -> None:      
        for _, grade_type in enumerate(grade_types):
            self.Junk.append([grade_type, 1])
            self.Junk.append([grade_type, 0])


        with open('Junk.csv', mode='w', newline='', encoding='utf-8') as file:
            writer = csv.writer(file)
            writer.writerow(['Rodzaj_Oceny', 'Czy_Zatwierdzona'])
            writer.writerows(self.Junk)

        # self.cursor.executemany(
        #     "INSERT INTO Junk (Rodzaj_Oceny, Czy_Zatwierdzona) VALUES (?, ?)",
        #     self.Junk
        # )

        # self.connection.commit()

        
    def generate_data_wystawienia(self) -> None:
        start_date = datetime(2021, 1, 1)
        end_date = datetime(2025, 1, 1)

        current_date = start_date
        while current_date <= end_date:
            rok = current_date.strftime('%Y')  # Year as string
            miesiac = current_date.strftime('%B')  # Full month name
            dzien = current_date.day  # Day of the month as a number
            polrocze = 'Pierwsze' if current_date.month <= 6 else 'Drugie'  # First or second half of the year
            dzien_pracujacy = 0 if current_date.weekday() >= 5 else 1  # Weekdays are working days (0: weekend, 1: working day)
            dzien_tygodnia = current_date.strftime('%A')  # Day of the week
            numer_miesiaca = current_date.month  # Numeric month
            
            self.Data_Wystawienia.append([
                current_date,
                rok,
                miesiac,
                dzien,
                polrocze,
                dzien_pracujacy,
                dzien_tygodnia,
                numer_miesiaca
            ])

            # Increment the date by one day
            current_date += timedelta(days=1)

        with open('Data_Wystawienia.csv', mode='w', newline='', encoding='utf-8') as file:
            writer = csv.writer(file)
            writer.writerow(['rok', 'miesiac', 'dzien', 'polrocze', 'dzien_pracujacy', 'dzien_tygodnia', 'numer_miesiaca'])
            writer.writerows(self.Data_Wystawienia)

        # self.cursor.executemany(
        #     """
        #     INSERT INTO Data_Wystawienia (
        #         Data, Rok, Miesiac, Dzien, Polrocze, Dzien_Pracujacy, Dzien_Tygodnia, Numer_Miesiaca
        #     ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        #     """,
        #     self.Data_Wystawienia
        # )

        # self.connection.commit()

    def generate_grade_and_percentage(self) -> tuple:
        grade = random.randint(1, 6)
        
        if grade == 1:
            percentage = random.randint(1, 20)
        elif grade == 2:
            percentage = random.randint(21, 40)
        elif grade == 3:
            percentage = random.randint(41, 60)
        elif grade == 4:
            percentage = random.randint(61, 80)
        else:
            percentage = random.randint(81, 100)

        return grade, percentage

    def generate_wystawienie_oceny(self) -> None:
        for student in range(1, 251):
            teachers = random.sample(range(1, 51), 10)
            dates = random.sample(range(1, 1461), 15)
            classes = random.sample(range(1, 31), 5)
            junks = random.sample(range(1, 15), 5)

            for teacher in teachers:
                for date in dates:
                    for sala in classes:
                        for junk in junks:
                            grade, percentage = self.generate_grade_and_percentage()
                            self.Wystawienie_Oceny.append([
                                student,  # FK_Uczeń
                                teacher,  # FK_Nauczyciel
                                date,  # FK_Data (ID_Data from Data_Wystawienia)
                                sala,  # FK_Sala (ID_Sali from Sala)
                                junk,  # FK_Junk (ID_Junk from Junk)
                                grade,  # Wartosc_Oceny
                                random.randint(1, 10),  # Waga_Oceny
                                percentage  # Uzyskany_Wynik
                            ])


        with open('Wystawienie_Oceny.csv', mode='w', newline='', encoding='utf-8') as file:
            writer = csv.writer(file)
            writer.writerow(['FK_Uczeń', 'FK_Nauczyciel', 'FK_Data', 'FK_Sala', 'FK_Junk', 'Wartosc_Oceny', 'Waga_Oceny', 'Uzyskany_Wynik'])
            writer.writerows(self.Wystawienie_Oceny)

        # self.cursor.executemany(
        #     """
        #     INSERT INTO Wystawienie_Oceny (
        #         FK_Uczeń, FK_Nauczyciel, FK_Data, FK_Sala, FK_Junk, Wartosc_Oceny, Waga_Oceny, Uzyskany_Wynik
        #     ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        #     """,
        #     self.Wystawienie_Oceny
        # )

        # self.connection.commit()
        
    def generate_wystawienie_oceny_t1(self) -> None:
        for student in range(1, 251):
            teachers = random.sample(range(1, 51), 10)
            dates = random.sample(range(1, 731), 10)
            classes = random.sample(range(1, 16), 5)
            junks = random.sample(range(1, 15), 5)

            for teacher in teachers:
                for date in dates:
                    for sala in classes:
                        for junk in junks:
                            grade, percentage = self.generate_grade_and_percentage()
                            self.Wystawienie_Oceny.append([
                                student,  # FK_Uczeń
                                teacher,  # FK_Nauczyciel
                                date,  # FK_Data (ID_Data from Data_Wystawienia)
                                sala,  # FK_Sala (ID_Sali from Sala)
                                junk,  # FK_Junk (ID_Junk from Junk)
                                grade,  # Wartosc_Oceny
                                random.randint(1, 10),  # Waga_Oceny
                                percentage  # Uzyskany_Wynik
                            ])

        with open('Wystawienie_Oceny_T1.csv', mode='w', newline='', encoding='utf-8') as file:
            writer = csv.writer(file)
            writer.writerow(['FK_Uczeń', 'FK_Nauczyciel', 'FK_Data', 'FK_Sala', 'FK_Junk', 'Wartosc_Oceny', 'Waga_Oceny', 'Uzyskany_Wynik'])
            writer.writerows(self.Wystawienie_Oceny)

        self.Wystawienie_Oceny = []
        

    def generate_wystawienie_oceny_t2(self) -> None:
        for student in range(1, 251):
            teachers = random.sample(range(1, 51), 10)
            dates = random.sample(range(731, 1461), 10)
            classes = random.sample(range(16, 31), 5)
            junks = random.sample(range(1, 15), 5)

            for teacher in teachers:
                for date in dates:
                    for sala in classes:
                        for junk in junks:
                            grade, percentage = self.generate_grade_and_percentage()
                            self.Wystawienie_Oceny.append([
                                student,  # FK_Uczeń
                                teacher,  # FK_Nauczyciel
                                date,  # FK_Data (ID_Data from Data_Wystawienia)
                                sala,  # FK_Sala (ID_Sali from Sala)
                                junk,  # FK_Junk (ID_Junk from Junk)
                                grade,  # Wartosc_Oceny
                                random.randint(1, 10),  # Waga_Oceny
                                percentage  # Uzyskany_Wynik
                            ])          

        with open('Wystawienie_Oceny_T2.csv', mode='w', newline='', encoding='utf-8') as file:
            writer = csv.writer(file)
            writer.writerow(['FK_Uczeń', 'FK_Nauczyciel', 'FK_Data', 'FK_Sala', 'FK_Junk', 'Wartosc_Oceny', 'Waga_Oceny', 'Uzyskany_Wynik'])
            writer.writerows(self.Wystawienie_Oceny)

        self.Wystawienie_Oceny = []

def main() -> None:
    # connection = pyodbc.connect(
    #     'DRIVER={SQL Server};'
    #     'SERVER=LAPTOP-7M14R3G4\\MSSQLSERVER01;'
    #     'DATABASE=HD_Data_Source;'
    #     'Trust_Connection=yes;'
    # )
    
    generator = SqlDataGenerator()
    generator.generate_data()

    # connection.close()


if __name__ == '__main__':
    main()
