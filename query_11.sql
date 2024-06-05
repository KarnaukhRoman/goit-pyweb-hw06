SELECT AVG(gr.score) FROM grades gr
JOIN students s ON s.id = gr.student_id
JOIN subjects subj ON gr.subject_id = subj.id
JOIN professors p ON p.id = subj.prof_id
WHERE s."name" ='певний студент' AND p.name_prof ='певний викладач'
