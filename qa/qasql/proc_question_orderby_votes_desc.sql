DELIMITER $$
DROP PROCEDURE IF EXISTS proc_question_orderby_votes_desc;
CREATE PROCEDURE proc_question_orderby_votes_desc(IN firstRow INT,IN listRows INT)

  BEGIN
    SELECT q.*,u.username,p.pic, GROUP_CONCAT(t.name SEPARATOR ',') as tags
    FROM (
           SELECT id,title,summary,votes,answers,views,user_id,ct
           FROM question
#             WHERE votes <= ( SELECT votes
#                              FROM question
#                              ORDER BY votes DESC,ct DESC
#                              LIMIT firstRow,1)
           ORDER BY votes DESC,ct desc
           LIMIT firstRow,listRows
         ) q

      JOIN auth_user u ON q.user_id = u.id
      JOIN profile p ON u.id = p.user_id
      JOIN question_tags qt ON q.id = qt.question_id
      JOIN tag t ON t.id = qt.tag_id

    GROUP BY q.id
    ORDER BY votes DESC,ct DESC
    ;
  END $$

DELIMITER ;