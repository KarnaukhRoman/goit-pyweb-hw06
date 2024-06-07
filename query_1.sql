SELECT table_students.name AS name_student, AVG(table_grades.score) as avg_score from students AS table_students
JOIN grades AS table_grades  ON table_students.id=table_grades.student_id
GROUP BY table_students.name
ORDER BY avg_score DESC
LIMIT 5;