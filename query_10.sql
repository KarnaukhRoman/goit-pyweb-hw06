SELECT table_students.name AS name_student, subjects.name_subject, professors.name_prof  FROM students AS table_students
JOIN grades ON grades.student_id = table_students.id
JOIN subjects ON subjects.id = grades.subject_id
JOIN professors ON professors.id = subjects.prof_id
WHERE table_students.id  ='14' AND professors.id ='1';