SELECT subj.name_subject AS course_name
FROM subjects subj
JOIN professors prof ON subj.prof_id = prof.id
WHERE prof.name_prof = 'певний викладач';
