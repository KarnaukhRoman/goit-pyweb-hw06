SELECT s.name, subj.name_subject, p.name_prof  FROM students s
JOIN grades gr ON s.id = gr.student_id
JOIN subjects subj ON gr.subject_id = subj.id
JOIN professors p ON p.id = subj.prof_id
WHERE s."name" ='певний студент' AND p.name_prof ='певний викладач'
