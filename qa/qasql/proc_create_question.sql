USE `qa`;
DROP procedure IF EXISTS `proc_create_question`;

DELIMITER $$
USE `qa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_create_question`()
BEGIN
    SELECT @q_c := COUNT(1) FROM question;
    WHILE @q_c < 1030000 DO
      if @q_c < 1 then
        INSERT INTO question(title, content,ct,votes,answers,views,favorite,user_id,summary)
        VALUES('test',
               'test',
               now(),
               rand()*10000,
               rand()*10000,
               rand()*10000,
               rand()*10000,
               1,'test');
      end if;
      INSERT INTO question(title, content,ct,votes,answers,views,favorite,user_id,summary)
        select title, content,
          now(),
          rand()*10000,
          rand()*10000,
          rand()*10000,
          rand()*10000,
          user_id,summary
        from question limit 10000;
      set @q_c = @q_c + 10000;

    END WHILE;
  END$$

DELIMITER ;

