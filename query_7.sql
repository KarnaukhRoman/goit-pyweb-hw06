SELECT s."name", g.name_group, gr.score,  subj.name_subject  FROM students s
JOIN "groups" g ON s.group_id =g.id
JOIN grades gr ON s.id = gr.student_id
JOIN subjects subj ON gr.subject_id = subj.id
WHERE subj.name_subject = 'певний предмет'
ORDER BY g.name_group, s."name"
