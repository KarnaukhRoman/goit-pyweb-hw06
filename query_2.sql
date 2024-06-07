SELECT table_students.name AS name_student, subjects.name_subject, AVG(grades.score) AS average_score FROM students AS table_students
JOIN grades ON table_students.id = grades.student_id
JOIN subjects ON grades.subject_id = subjects.id
WHERE subjects.id  = '3'
GROUP BY table_students.id, table_students.name, subjects.name_subject
ORDER BY average_score DESC
LIMIT 1;
