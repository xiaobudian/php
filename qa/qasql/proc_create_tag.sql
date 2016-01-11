USE `qa`;
DROP procedure IF EXISTS `proc_create_tag2`;

DELIMITER $$
USE `qa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_create_tag`()
BEGIN
    SELECT @t_c := COUNT(1) FROM tag;
    WHILE @t_c < 200 DO
      if @t_c < 1 then
        INSERT INTO tag(name, `desc`,ct,reputation,user_id)
        VALUES(CONCAT('tag',floor(rand()*1000)),
               'tag-desc',
               now(),
               rand()*10000,
               1);
      end if;

      INSERT INTO tag(name, `desc`,ct,reputation,user_id)
        SELECT CONCAT('tag',floor(rand()*1000)), `desc`,now(),reputation,user_id
        FROM tag
        LIMIT 10;
      set @t_c = @t_c + 10;

    END WHILE;
  END$$

DELIMITER ;

