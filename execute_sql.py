import logging

from psycopg2 import DatabaseError
from connection import get_db_connection

sql1 = """ 
SELECT s.name , ROUND(AVG(g.score),2) as avg_score from students s
JOIN grades g  ON s.id=g.student_id
GROUP BY s.name
ORDER BY avg_score DESC
LIMIT 5;
"""
sql2 = """
SELECT table_students.name, subjects.name_subject, ROUND(AVG(grades.score),2) AS average_score FROM students AS table_students
JOIN grades ON table_students.id = grades.student_id
JOIN subjects ON grades.subject_id = subjects.id
WHERE subjects.id  = '%s'
GROUP BY table_students.id, table_students.name, subjects.name_subject 
ORDER BY average_score DESC
LIMIT 1;"""

sql3 = """
SELECT table_groups.name_group, subjects.name_subject, ROUND(AVG(grades.score),2) AS average_score FROM groups AS table_groups
JOIN students ON table_groups.id = students.group_id
JOIN grades ON students.id = grades.student_id
JOIN subjects ON grades.subject_id = subjects.id
WHERE subjects.id  = '%s'
GROUP BY table_groups.name_group, subjects.name_subject 
ORDER BY average_score DESC;
"""
sql4 = """
SELECT ROUND(AVG(score),2) AS average_score
FROM grades;
"""
sql5 = """
SELECT subjects.name_subject AS course_name
FROM subjects
JOIN professors ON subjects.prof_id = professors.id
WHERE professors.id = '%s';
"""
sql6 = """
SELECT table_students.name, groups.name_group FROM students AS table_students
JOIN groups ON table_students.group_id = groups.id
WHERE groups.id = '%s'
ORDER BY table_students."name";
"""
sql7 = """
SELECT table_students."name", "groups".name_group, grades.score, subjects.name_subject  FROM students AS table_students
JOIN "groups" ON table_students.group_id = "groups".id
JOIN grades ON table_students.id = grades.student_id
JOIN subjects ON grades.subject_id = subjects.id  
WHERE "groups".id = '%s' AND subjects.id  = '%s'
ORDER BY "groups".name_group, table_students."name" ;
"""
sql8 = """
SELECT table_professors.name_prof, subjects.name_subject, ROUND(AVG(grades.score),2) AS average_score FROM professors AS table_professors
JOIN subjects ON table_professors.id = subjects.prof_id 
JOIN grades ON subjects.id = grades.subject_id  
WHERE table_professors.id = '%s'
GROUP BY table_professors.name_prof, subjects.name_subject;
"""
sql9 = """
SELECT table_students."name" AS student_name, subjects.name_subject  FROM students AS table_students 
JOIN grades ON table_students.id = grades.student_id 
JOIN subjects ON subjects.id = grades.subject_id
WHERE table_students.id  ='%s';
"""
sql10 ="""
SELECT table_students.name AS name_student, subjects.name_subject, professors.name_prof  FROM students AS table_students
JOIN grades ON grades.student_id = table_students.id  
JOIN subjects ON subjects.id = grades.subject_id
JOIN professors ON professors.id = subjects.prof_id 
WHERE table_students.id  ='%s' AND professors.id ='%s';
"""
sql11 = """
SELECT ROUND(AVG(grades.score),2) AS average_score FROM grades
JOIN students ON students.id = grades.student_id 
JOIN subjects ON grades.subject_id = subjects.id
JOIN professors ON professors.id = subjects.prof_id 
WHERE students.id ='%s' AND professors.id ='%s';
"""
sql12 = """
SELECT students."name" AS student_name, grades.score, groups.name_group FROM grades
JOIN students ON students.id = grades.student_id
JOIN subjects ON subjects.id = grades.subject_id
JOIN groups ON students.group_id = groups.id 
WHERE groups.id = '%s' 
  AND subjects.id  = '%s'
  AND grades.score_date::DATE = (
    SELECT MAX(score_date::DATE)
    FROM grades
    JOIN subjects ON subjects.id = grades.subject_id
    WHERE subjects.id  = '%s'
  );
"""

def execute_query(sql, set_params:tuple):
    try:
        with get_db_connection() as conn:
            cur = conn.cursor()
            cur.execute(sql, set_params)
            return cur.fetchall()
    except DatabaseError as err:
        logging.error(err)
    finally:
        cur.close()

print("1. 5 студентів із найбільшим середнім балом з усіх предметів")
print(execute_query(sql1,()))
print("2. Студент із найвищим середнім балом з певного предмета")
print(execute_query(sql2,(3,)))
print("3. Cередній бал у групах з певного предмета.")
print(execute_query(sql3,(4,)))
print("4. Cередній бал на потоці (по всій таблиці оцінок)")
print(execute_query(sql4,()))
print("5. Які курси читає певний викладач")
print(execute_query(sql5,(4,)))
print("6. Cписок студентів у певній групі")
print(execute_query(sql6,(3,)))
print("7. Оцінки студентів у окремій групі з певного предмета")
print(execute_query(sql7,(3,6,)))
print("8. Cередній бал, який ставить певний викладач зі своїх предметів.")
print(execute_query(sql8,(3,)))
print("9. Cписок курсів, які відвідує студент.")
print(execute_query(sql9,(13,)))
print("10. Список курсів, які певному студенту читає певний викладач")
print(execute_query(sql10,(14,1,)))
print("***11. Середній бал, який певний викладач ставить певному студентові")
print(execute_query(sql11,(14,1,)))
print("***12. Оцінки студентів у певній групі з певного предмета на останньому занятті")
print(execute_query(sql12,(1,8,8,)))


