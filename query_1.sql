SELECT s.name , AVG(g.score) as avg_score from students s
JOIN grades g  ON s.id=g.student_id
GROUP BY s.name
ORDER BY avg_score DESC
LIMIT 5;
