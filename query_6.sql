SELECT s.name, g.name_group  FROM students s
JOIN groups g  ON s.group_id  = g.id
WHERE g.name_group  = 'певна група'
ORDER BY s."name"
