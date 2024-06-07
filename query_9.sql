SELECT table_students."name" AS student_name, subjects.name_subject  FROM students AS table_students
JOIN grades ON table_students.id = grades.student_id
JOIN subjects ON subjects.id = grades.subject_id
WHERE table_students.id  ='13';

