USE `qa`;
DROP procedure IF EXISTS `proc_question_orderby_votes_desc`;

DELIMITER $$
USE `qa`$$
CREATE PROCEDURE `proc_question_orderby_votes_desc` (in skip int, in pagesize int)
BEGIN
	select q.*,u.username
    from (
		    select * from question
		    where votes <= (SELECT votes FROM question ORDER BY votes desc limit skip,1)
		    limit pagesize;
    )q
    join auth_user u on q.user_id = u.id;
END$$

DELIMITER ;