DROP PROCEDURE IF EXISTS qa.proc_question_details;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_question_details`(
  IN qid INT,
  IN uid INT)
BEGIN
    SELECT q.id,q.title,q.votes,q.content,q.answers,q.views,q.ct,
      u.username,q.user_id,q.favorite as favorites ,qv.vote_type,
      CASE WHEN fq.id IS NOT NULL then 1 end as favorite,
      GROUP_CONCAT(t.name SEPARATOR ',') as tags
    FROM question q
      LEFT JOIN auth_user u ON q.user_id = u.id
      LEFT JOIN profile p ON u.id = p.user_id
      LEFT JOIN question_tags qt ON q.id = qt.question_id
      LEFT JOIN tag t ON t.id = qt.tag_id
      -- 关联已登陆用户的投票和收藏情况
      LEFT JOIN qvote qv ON qv.user_id = uid AND qv.question_id = q.id
      LEFT JOIN fquestion fq on fq.user_id = uid AND fq.question_id = q.id
    WHERE q.id = qid
    GROUP BY q.id;
    IF uid <> 0 THEN
      -- update question views 
      UPDATE question SET views = views + 1 WHERE id = qid;
      -- 查询该用户的浏览记录
      SET @qv = (SELECT count(1) FROM qviews WHERE user_id = uid AND question_id = qid);
      IF @qv = 0 THEN
        -- 不存在则添加
        INSERT INTO qviews(user_id, question_id, first_view_time, last_view_time, times) 
        VALUES(uid,qid,now(),now(),1); 
      ELSE 
        -- 更新浏览记录 最后浏览时间和浏览次数
        UPDATE qviews SET last_view_time = now(), times = times + 1 WHERE user_id = uid AND question_id = qid;
      END IF ;
    END IF;
    
  END;