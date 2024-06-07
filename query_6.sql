SELECT table_students.name AS name_student, groups.name_group  FROM students AS table_students
JOIN groups ON table_students.group_id  = groups.id
WHERE groups.id  = '3'
ORDER BY table_students."name";
