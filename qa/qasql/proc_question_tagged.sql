/**
 * 根据tag查询相关的问题
 *
 */

USE `qa`;
DROP procedure IF EXISTS `proc_question_tagged`;

DELIMITER $$
USE `qa`$$
CREATE PROCEDURE `proc_question_tagged` (
  in firstRow int,  -- 跳过行数
  in listRows int,  -- 分页大小
  in tag_name varchar(30)) -- tag name
  BEGIN

    -- 根据tag name 查询id
    -- 后续查询根据id进行join 提高查询效率
    set @tag_id = (select id from tag where name = tag_name limit 1);
    select qu.* ,u.username
    from (
           select q.id,q.title,q.votes,q.answers,q.views,q.ct,q.user_id,
             GROUP_CONCAT(t.name SEPARATOR ',') as tags
           from question q
             JOIN question_tags qt on q.id = qt.question_id
             JOIN tag t on t.id = qt.tag_id
           WHERE t.id = @tag_id
           GROUP BY q.id
           ORDER BY q.votes DESC,q.ct DESC
           LIMIT firstRow,listRows
         )qu
      JOIN auth_user u on u.id = qu.user_id;

  END$$

DELIMITER ;

-- CALL  proc_question_tagged(0,10,'php');