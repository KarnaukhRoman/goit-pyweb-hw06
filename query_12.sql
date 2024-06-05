SELECT s."name", gr.score, g.name_group FROM grades gr
JOIN students s ON s.id = gr.student_id
JOIN subjects subj ON subj.id = gr.subject_id
JOIN groups g ON s.group_id = g.id
WHERE g.name_group = 'певна група'
  AND subj.name_subject = 'певний предмет'
  AND gr.score_date::DATE = (
    SELECT MAX(score_date::DATE)
    FROM grades
    JOIN subjects ON subjects.id = grades.subject_id
    WHERE subjects.name_subject = 'певний предмет'
  )