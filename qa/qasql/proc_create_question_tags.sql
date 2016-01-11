USE `qa`;
DROP procedure IF EXISTS `proc_create_question_tags`;

DELIMITER $$
USE `qa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_create_question_tags`()
BEGIN
    SELECT @question_max_id := max(id) FROM question;
    WHILE @question_max_id > 0 DO
      INSERT INTO question_tags (question_id, tag_id)
      VALUES (@question_max_id, 1);
      INSERT INTO question_tags (question_id, tag_id)
      VALUES (@question_max_id, 2);
       INSERT INTO question_tags (question_id, tag_id)
      VALUES (@question_max_id, 3);
      INSERT INTO question_tags (question_id, tag_id)
      VALUES (@question_max_id, 4);
      SET @question_max_id := @question_max_id - 1;
    END WHILE;
  END$$

DELIMITER ;

