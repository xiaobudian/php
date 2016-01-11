DELIMITER $$
DROP PROCEDURE IF EXISTS proc_question_details;
CREATE PROCEDURE proc_question_details(IN id INT)
  BEGIN
    SELECT q.id,q.title,q.votes,q.content,q.answers,q.views,q.ct,
      u.username,q.user_id,q.favorite,qv.vote_type,
      CASE WHEN fq.id IS NOT NULL then 1 end as favorite,
      GROUP_CONCAT(t.name SEPARATOR ',') as tags
    FROM question q
      JOIN auth_user u ON q.user_id = u.id
      JOIN profile p ON u.id = p.user_id
      JOIN question_tags qt ON q.id = qt.question_id
      JOIN tag t ON t.id = qt.tag_id
      JOIN qvote qv ON q.id = qv.question_id
      LEFT JOIN fquestion fq on q.id = fq.question_id
    WHERE q.id = id
    GROUP BY q.id;
  END $$

DELIMITER ;