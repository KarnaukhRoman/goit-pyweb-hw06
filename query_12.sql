SELECT students."name" AS student_name, grades.score, groups.name_group FROM grades
JOIN students ON students.id = grades.student_id
JOIN subjects ON subjects.id = grades.subject_id
JOIN groups ON students.group_id = groups.id
WHERE groups.id = '1'
  AND subjects.id  = '8'
  AND grades.score_date::DATE = (
    SELECT MAX(score_date::DATE)
    FROM grades
    JOIN subjects ON subjects.id = grades.subject_id
    WHERE subjects.id  = '8'
  );