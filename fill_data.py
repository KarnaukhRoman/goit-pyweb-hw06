from datetime import datetime, date, time
import faker
import random
from random import randint

from connection import get_db_connection

NUMBER_GROUPS = 3
NUMBER_PROFESSORS = 8
NUMBER_SUBJECTS = 8
NUMBER_STUDENTS = 50
NUMBER_SCORES = 100


def generate_fake_data(num_groups, num_students, num_professors, num_subjects, num_scores) -> tuple():
    fake_groups = []
    fake_students = []
    fake_professors = []
    fake_subject = []
    fake_scores = []
    '''Візьмемо три компанії з faker і помістимо їх у потрібну змінну'''
    fake_data = faker.Faker("uk_UA")
    fake_data2 = faker.Faker()

    # Створимо назви груп у кількості num_groups
    for _ in range(num_groups):
        faculty_codes = ['IT', 'PyWeb', 'ME', 'CEO', 'BIO', 'CHE']
        faculty_code = random.choice(faculty_codes)
        year = random.randint(20, 28)
        course = fake_data2.word().capitalize()
        group_name = f"{faculty_code}-{year}-{course}"
        fake_groups.append(group_name)

    for _ in range(num_students):
        fake_students.append(fake_data.name())

    for _ in range(num_professors):
        fake_professors.append(fake_data.name())

    for _ in range(num_subjects):
        fake_subject.append(fake_data2.job())

    for _ in range(num_scores):
        """Генеруємо випадкову дату отримання оцінки. 
        Час генеруємо в проміжку робочого часу, для більшої правдоподібності"""
        start_date = date(2020, 9, 1)
        end_date = date(2024, 5, 31)
        fake_t = time(randint(9, 16), randint(0, 59), randint(0, 59))
        fake_d = fake_data.date_between(start_date, end_date)
        fake_dt = datetime.combine(fake_d, fake_t)
        score = randint(1, NUMBER_STUDENTS), randint(1, NUMBER_SUBJECTS), randint(3, 12), fake_dt
        fake_scores.append(score)

    return fake_groups, fake_students, fake_professors, fake_subject, fake_scores


def prepare_data(groups, students, professors, subjects, scores) -> tuple():
    for_groups = []
    # Готуємо список кортежів назв компаній
    for group in groups:
        for_groups.append((group, ))

    for_students = []
    for student in students:
        for_students.append((student, randint(1, NUMBER_GROUPS)))

    for_professors = []
    for professor in professors:
        for_professors.append((professor, ))

    for_subject = []
    for subject in subjects:
        for_subject.append((subject, randint(1, NUMBER_PROFESSORS)))

    for_scores = scores

    return for_groups, for_students, for_professors, for_subject, for_scores


def insert_data_to_db(groups, students, professors, subjects, scores) -> None:
    # Створимо з'єднання з нашою БД та отримаємо об'єкт курсору для маніпуляцій з даними
    with get_db_connection() as conn:
        cur = conn.cursor()

        sql_to_groups = """INSERT INTO groups(name_group) VALUES (%s)"""
        cur.executemany(sql_to_groups, groups)

        sql_to_students = """INSERT INTO students(name, group_id)
                               VALUES (%s, %s)"""
        cur.executemany(sql_to_students, students)

        sql_to_professors = """INSERT INTO professors(name_prof)
                                       VALUES (%s)"""
        cur.executemany(sql_to_professors, professors)

        sql_to_subjects = """INSERT INTO subjects(name_subject, prof_id)
                                       VALUES (%s, %s)"""
        cur.executemany(sql_to_subjects, subjects)

        sql_to_grades = """INSERT INTO grades(student_id, subject_id, score, score_date)
                                       VALUES (%s, %s, %s, %s)"""
        cur.executemany(sql_to_grades, grades)

        conn.commit()


if __name__ == "__main__":
    groups, students, professors, subjects, grades = prepare_data(*generate_fake_data(NUMBER_GROUPS, NUMBER_STUDENTS, NUMBER_PROFESSORS, NUMBER_SUBJECTS, NUMBER_SCORES))
    insert_data_to_db(groups, students, professors, subjects, grades)
