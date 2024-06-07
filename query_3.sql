SELECT table_groups.name_group, subjects.name_subject, AVG(grades.score) AS average_score FROM groups AS table_groups
JOIN students ON table_groups.id = students.group_id
JOIN grades ON students.id = grades.student_id
JOIN subjects ON grades.subject_id = subjects.id
WHERE subjects.id  = '4'
GROUP BY table_groups.name_group, subjects.name_subject
ORDER BY average_score DESC;
