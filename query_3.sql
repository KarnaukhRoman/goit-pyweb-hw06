SELECT g.name_group, subj.name_subject, AVG(gr.score) AS average_score FROM groups g
JOIN students s ON g.id = s.group_id
JOIN grades gr ON s.id = gr.student_id
JOIN subjects subj ON gr.subject_id = subj.id
WHERE subj.name_subject = 'Певний предмет'
GROUP BY g.name_group, subj.name_subject
ORDER BY average_score DESC;
