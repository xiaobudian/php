# author:liushuai <849351660@qq.com>
# date  :2016年1月12日10:17:11
# desc  :查询问题分页数据 查询前几页效率比较高 采用GROUP_CONCAT 对问题关联的tag进行处理 有效减少数据库查询次数
# 以后可以指定排序字段和排序方式
DELIMITER $$
DROP PROCEDURE IF EXISTS proc_question_orderby_votes_desc;
CREATE PROCEDURE proc_question_orderby_votes_desc(IN firstRow INT,IN listRows INT)

  BEGIN
    SELECT q.*,u.username,p.pic,p.reputation,
      ifnull(a.accepted,0) as accept,
      GROUP_CONCAT(t.name SEPARATOR ',') as tags
    FROM (
           SELECT id,title,summary,votes,answers,views,user_id,ct,modifytime
           FROM question
           #             WHERE votes <= ( SELECT votes
           #                              FROM question
           #                              ORDER BY votes DESC,ct DESC
           #                              LIMIT firstRow,1)
           ORDER BY votes DESC,ct desc
           LIMIT firstRow,listRows
         ) q
      LEFT JOIN answer a ON a.question_id = q.id AND a.accepted
      LEFT JOIN auth_user u ON q.user_id = u.id
      LEFT JOIN profile p ON u.id = p.user_id
      LEFT JOIN question_tags qt ON q.id = qt.question_id
      LEFT JOIN tag t ON t.id = qt.tag_id

    GROUP BY q.id
    ORDER BY votes DESC,ct DESC
    ;
  END $$

DELIMITER ;
