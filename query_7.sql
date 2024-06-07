SELECT table_students."name" AS name_student, "groups".name_group, grades.score, subjects.name_subject  FROM students AS table_students
JOIN "groups" ON table_students.group_id ="groups".id
JOIN grades ON table_students.id = grades.student_id
JOIN subjects ON grades.subject_id = subjects.id
WHERE "groups".id = '3' AND subjects.id  = '6'
ORDER BY "groups".name_group, table_students."name";
