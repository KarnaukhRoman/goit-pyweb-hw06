-- 1 Знайти 5 студентів із найбільшим середнім балом з усіх предметів.
SELECT table_students.name AS name_student, AVG(table_grades.score) as avg_score from students AS table_students
JOIN grades AS table_grades  ON table_students.id=table_grades.student_id
GROUP BY table_students.name
ORDER BY avg_score DESC
LIMIT 5;

-- 2 Знайти студента із найвищим середнім балом з певного предмета
SELECT table_students.name AS name_student, subjects.name_subject, AVG(grades.score) AS average_score FROM students AS table_students
JOIN grades ON table_students.id = grades.student_id
JOIN subjects ON grades.subject_id = subjects.id
WHERE subjects.id  = '3'
GROUP BY table_students.id, table_students.name, subjects.name_subject 
ORDER BY average_score DESC
LIMIT 1;

-- 3 Знайти середній бал у групах з певного предмета.
SELECT table_groups.name_group, subjects.name_subject, AVG(grades.score) AS average_score FROM groups AS table_groups
JOIN students ON table_groups.id = students.group_id
JOIN grades ON students.id = grades.student_id
JOIN subjects ON grades.subject_id = subjects.id
WHERE subjects.id  = '4'
GROUP BY table_groups.name_group, subjects.name_subject 
ORDER BY average_score DESC;

-- 4 Знайти середній бал на потоці (по всій таблиці оцінок)
SELECT AVG(score) AS average_score
FROM grades;

-- 5 Знайти які курси читає певний викладач.
SELECT subjects.name_subject AS course_name
FROM subjects
JOIN professors ON subjects.prof_id = professors.id
WHERE professors.id = '3';

-- 6 Знайти список студентів у певній групі.
SELECT table_students.name AS name_student, groups.name_group  FROM students AS table_students
JOIN groups ON table_students.group_id  = groups.id
WHERE groups.id  = '3'
ORDER BY table_students."name" 

-- 7 Знайти оцінки студентів у окремій групі з певного предмета
SELECT table_students."name" AS name_student, "groups".name_group, grades.score, subjects.name_subject  FROM students AS table_students
JOIN "groups" ON table_students.group_id ="groups".id
JOIN grades ON table_students.id = grades.student_id
JOIN subjects ON grades.subject_id = subjects.id  
WHERE "groups".id = '3' AND subjects.id  = '6'
ORDER BY "groups".name_group, table_students."name" 

-- 8 Знайти середній бал, який ставить певний викладач зі своїх предметів.
SELECT table_professors.name_prof, subjects.name_subject, AVG(grades.score) AS average_score FROM professors AS table_professors
JOIN subjects ON table_professors.id = subjects.prof_id 
JOIN grades ON subjects.id = grades.subject_id  
WHERE table_professors.id  = '4'
GROUP BY table_professors.name_prof, subjects.name_subject
 
-- 9 Знайти список курсів, які відвідує студент.
SELECT table_students."name" AS student_name, subjects.name_subject  FROM students AS table_students 
JOIN grades ON table_students.id = grades.student_id 
JOIN subjects ON subjects.id = grades.subject_id
WHERE table_students.id  ='13'
--ORDER BY s.name

-- 10 Список курсів, які певному студенту читає певний викладач
SELECT table_students.name AS name_student, subjects.name_subject, professors.name_prof  FROM students AS table_students
JOIN grades ON grades.student_id = table_students.id  
JOIN subjects ON subjects.id = grades.subject_id
JOIN professors ON professors.id = subjects.prof_id 
WHERE table_students.id  ='14' AND professors.id ='1';

--* 1 Середній бал, який певний викладач ставить певному студентові
SELECT AVG(grades.score) AS average_score FROM grades
JOIN students ON students.id = grades.student_id 
JOIN subjects ON grades.subject_id = subjects.id
JOIN professors ON professors.id = subjects.prof_id 
WHERE students.id ='14' AND professors.id ='1'

--* 2 Оцінки студентів у певній групі з певного предмета на останньому занятті    
SELECT students."name" AS student_name, grades.score, groups.name_group FROM grades
JOIN students ON students.id = grades.student_id
JOIN subjects ON subjects.id = grades.subject_id
JOIN groups ON students.group_id = groups.id 
WHERE groups.id = '1' 
  AND subjects.id  = '8'
  AND grades.score_date::DATE = (
    SELECT MAX(score_date::DATE)
    FROM grades
    JOIN subjects ON subjects.id = grades.subject_id
    WHERE subjects.id  = '8'
  );

 