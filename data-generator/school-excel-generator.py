from faker import Faker
import random
import xlsxwriter

subjects = [
    'Matematyka', 'Fizyka', 'Chemia', 'Biologia', 'Język polski', 
    'Język angielski', 'Historia', 'Geografia', 'Informatyka', 'Wiedza o społeczeństwie'
]

def generate_students_data() -> None:
    students_worksheet.write('A1', 'Students ID')
    students_worksheet.write('C1', 'Name and Surname')
    students_worksheet.write('E1', 'Is Active')

    fake = Faker('pl_PL')
    for i in range(2, 1002):
        students_worksheet.write(f'A{i}', i-1)
        students_worksheet.write(f'C{i}', fake.name())
        students_worksheet.write(f'E{i}', random.choice('Tak', 'Nie'))

def random_degree() -> None:
    degrees = ['Magister', 'Doktor', 'Profesor']
    return degrees[random.randint(0, 2)]

def generate_teachers_data() -> None:
    teachers_worksheet.write('A1', 'Teachers ID')
    teachers_worksheet.write('B1', 'Name and Surname')
    teachers_worksheet.write('D1', 'Degree')
    teachers_worksheet.write('E1', 'Email')
    teachers_worksheet.write('F1', 'Subject')


    fake = Faker()
    for i in range(2, 52):
        teachers_worksheet.write(f'A{i}', i-1)
        teachers_worksheet.write(f'B{i}', fake.name())
        teachers_worksheet.write(f'D{i}', random_degree())
        teachers_worksheet.write(f'E{i}', fake.email())
        teachers_worksheet.write(f'F{i}', random.choice(subjects))


students = xlsxwriter.Workbook('students.xlsx')
students_worksheet = students.add_worksheet('Students')
generate_students_data()

students.close()

teachers = xlsxwriter.Workbook('teachers.xlsx')
teachers_worksheet = teachers.add_worksheet('Teachers')
generate_teachers_data()

teachers.close()

print('Excel files created successfully.') 