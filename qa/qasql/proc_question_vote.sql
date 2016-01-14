/**
 * 给问题投票
 *
 */

USE `qa`;
DROP procedure IF EXISTS `proc_question_vote`;

DELIMITER $$
USE `qa`$$
CREATE PROCEDURE `proc_question_vote`(
  IN uid INT,  -- 用户id
  IN qid INT, -- 问题编号
  IN vote_type INT, -- 投票类型
  IN add_new BOOL  -- 需要添加新的投票记录
)
  BEGIN

    -- 定义异常处理
    DECLARE t_error INTEGER DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET t_error = 1;
    -- 开启事务
    START TRANSACTION;
    -- 删除该用户对这个问题的所有投票
    DELETE FROM qvote WHERE user_id = uid AND question_id = qid;
    -- 不存在记录时 需要添加新的纪录
    IF add_new = true THEN
      INSERT INTO qvote(user_id,question_id,ct,vote_type)VALUES(uid,qid,now(),vote_type);
    END IF;
    -- 统计投票总数 voteup - votedown
    SET @vote_up_count = (SELECT count(1) FROM qvote WHERE question_id = qid and vote_type = 1);
    SET @vote_down_count = (SELECT count(1) FROM qvote WHERE question_id = qid and vote_type = 2);
    UPDATE question SET votes = @vote_up_count - @vote_down_count WHERE id = qid;

    -- 出现错误时 回滚
    IF t_error = 1 THEN
      ROLLBACK;
    ELSE
      COMMIT; -- 提交事务
    END IF;
    -- 返回投票数
    SELECT votes FROM question WHERE id = qid;
  END$$

DELIMITER ;

-- CALL  proc_question_vote(3,7,1,true);