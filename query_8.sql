SELECT p.name_prof, subj.name_subject, AVG(gr.score)  FROM professors p
JOIN subjects subj ON p.id = subj.prof_id
JOIN grades gr ON subj.id = gr.subject_id
WHERE p.name_prof = 'певний викладач'
GROUP BY p.name_prof, subj.name_subject
