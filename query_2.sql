SELECT s.name, subj.name_subject, AVG(g.score) AS average_score FROM students s
JOIN grades g ON s.id = g.student_id
JOIN subjects subj ON g.subject_id = subj.id
WHERE subj.name_subject = 'певний предмет'
GROUP BY s.id, s.name, subj.name_subject
ORDER BY average_score DESC
LIMIT 1;
