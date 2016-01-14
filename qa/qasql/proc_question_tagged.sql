DROP PROCEDURE IF EXISTS qa.proc_question_tagged;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_question_tagged`(IN tag_name VARCHAR(20))
  BEGIN
    SET @tag_id = (SELECT id FROM tag WHERE name = tag_name LIMIT 1);

    SELECT q.*
    FROM question q
      JOIN question_tags qt ON q.id = qt.question_id
      JOIN tag t on t.id = qt.tag_id
    WHERE t.id = @tag_id;

  END;