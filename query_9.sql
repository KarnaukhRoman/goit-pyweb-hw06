SELECT s.name, subj.name_subject  FROM students s
JOIN grades gr ON s.id = gr.student_id
JOIN subjects subj ON gr.subject_id = subj.id
WHERE s."name" ='Певний студент'

