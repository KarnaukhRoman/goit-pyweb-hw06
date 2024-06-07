SELECT AVG(grades.score) AS average_score FROM grades
JOIN students ON students.id = grades.student_id
JOIN subjects ON grades.subject_id = subjects.id
JOIN professors ON professors.id = subjects.prof_id
WHERE students.id ='14' AND professors.id ='1';
