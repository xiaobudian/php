<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015.12.15
 * Time: 11:52
 */

namespace Home\Controller;


class AnswerController extends BaseController
{

    public function accepted()
    {
        $this->checkAuth();
        $id = $_POST['id'];
        $accepted = $_POST['accepted'];

        $answer = M('answer')->find($id);
        $question = M('question')->find($answer['question_id']);
        if ($question['user_id'] != getUserId()) {
            echo "你不是问题的主人，无权标记！";
        }else{
            $answer = M('answer');
            $answer->where('id = '.$id)->setField('accepted',$accepted);
        }
        echo json_encode('success');
    }

    function vote($vote_type, $add = false)
    {
        $this->checkAuth();

        $answer = M('answer');
        $answer->startTrans();

        $uid = getUserId();
        $id = $_POST['id'];
        $map['user_id'] = array('eq', $uid);
        $map['answer_id'] = array('eq', $id);
        //删除相关记录
        M('avote')->where($map)->delete();

        //添加相关记录
        $r1 = true;
        if ($add) {
            $av = M('avote');
            $av->user_id = $uid;
            $av->answer_id = $id;
            $av->ct = date('Y-m-d H:i:s');
            $av->vote_type = $vote_type;
            $r1 = $av->add();
        }
        //统计
        $mapav['answer_id'] = array('eq', $id);
        $mapav['vote_type'] = array('eq', VOTEUP);
        $vote_up_count = M('avote')->where($mapav)->count();
        $mapav['vote_type'] = array('eq', VOTEDOWN);
        $vote_down_count = M('avote')->where($mapav)->count();
        $count = $vote_up_count - $vote_down_count;
        $answer->where(' id = ' . $id)->setField('votes', $count);


        if ($r1) {
            $answer->commit();
            $result['id'] = $id;
            $result['result'] = true;
            $result['votes'] = $count;
        } else {
            $answer->rollback();
            $result['result'] = false;
        }
        echo json_encode($result);
    }

    public function  voteupon()
    {
        $this->vote(VOTEUP, true);
    }

    public function  voteupoff()
    {
        $this->vote(VOTECANCEL);
    }

    public function  votedownon()
    {
        $this->vote(VOTEDOWN, true);
    }

    public function  votedownoff()
    {
        $this->vote(VOTECANCEL);
    }
}