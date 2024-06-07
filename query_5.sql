SELECT subjects.name_subject AS course_name
FROM subjects
JOIN professors ON subjects.prof_id = professors.id
WHERE professors.id = '3';
