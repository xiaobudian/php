DROP PROCEDURE IF EXISTS qa.proc_question_tagged;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_question_tagged`(
  in firstRow int,  -- 跳过行数
  in listRows int,  -- 分页大小
  in tag_name varchar(30))
  BEGIN

    -- 根据tag name 查询id
    -- 后续查询根据id进行join 提高查询效率
    set @tag_id = (select id from tag where name = tag_name limit 1);
    select qu.* ,u.username,p.pic
    from (
           select q.id,q.title,q.votes,q.answers,q.views,q.ct,q.user_id,
             GROUP_CONCAT(t.name SEPARATOR ',') as tags
           from question q
             LEFT JOIN question_tags qt on q.id = qt.question_id
             LEFT JOIN tag t on t.id = qt.tag_id
           WHERE t.id = @tag_id
           GROUP BY q.id
           ORDER BY q.votes DESC,q.ct DESC
           LIMIT firstRow,listRows
         )qu
      LEFT JOIN auth_user u on u.id = qu.user_id
      LEFT JOIN profile p on u.id = p.user_id;

  END;