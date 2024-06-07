SELECT table_professors.name_prof, subjects.name_subject, AVG(grades.score) AS average_score FROM professors AS table_professors
JOIN subjects ON table_professors.id = subjects.prof_id
JOIN grades ON subjects.id = grades.subject_id
WHERE table_professors.id  = '4'
GROUP BY table_professors.name_prof, subjects.name_subject;
