<?php
/**
 * Created by liushuai.
 * User: Administrator
 * Date: 2015.11.30
 * Time: 16:33
 */

namespace Home\Controller;

use Think\Cache\Driver\Memcached;
use Think\Controller;
use Think\Exception;
use Think\Page;

class QuestionController extends BaseController
{

    public function index($p = 1)
    {
        $question = M('question');
        $count = $question->count();
        $page = new Page($count, C('PAGESIZE'));
        $show = $page->show();
        $query = "call proc_question_page_votes_desc($page->firstRow,$page->listRows) ";
        $questions = M('question')->query($query);

        $this->assign('page', $show);
        $this->assign('questions', $questions);
        $this->display();

    }

    public function details($id)
    {
        $map['q.id'] = array('eq', $id);
        $q = M('question q')->where($map)->join('auth_user u on q.user_id= u.id')
            ->field('q.id,q.title,q.votes,q.content,q.answers,q.views,q.ct,u.username,q.user_id,q.favorite')->select();
        if (hadLogin()) {
            unset($map);
            $map['user_id'] = array('eq', getUserId());
            $map['question_id'] = array('eq', $id);
            $qv = M('qvote')->where($map)->find();
            if ($qv) {
                $this->assign('vote_type', $qv['vote_type']);
            }
            $fq = M('fquestion')->where($map)->find();
            if ($fq) {
                $this->assign('favorite', 1);
            }
        }
        if ($q) {
            $q = $q[0];
            $tags = $this->getQuestionTags($id);
            $q['tags'] = $tags;

            $mapanswer['question_id'] = array('eq', $q['id']);
            $answers = M('answer a')
                ->where($mapanswer)
                ->order('votes desc')
                ->join(' auth_user u on a.user_id = u.id')
                ->field('a.id,a.votes,a.answer,a.user_id,u.username,a.ct')
                ->select();
            if (hadLogin() && $answers) {
                foreach ($answers as &$a) {
                    $mapav['answer_id'] = array('eq', $a['id']);
                    $mapav['user_id'] = array('eq', getUserId());
                    $av = M('avote')->where($mapav)->find();
                    if ($av) {
                        $a['vote_type'] = $av['vote_type'];
                    }
                    unset($mapav);
                }
            }
            $q['q_answers'] = $answers;

            $this->assign('q', $q);
            $this->display();
        }
    }

    function getQuestionTags($qid)
    {
        return M('tag t')
            ->join('question_tags qt on t.id = qt.tag_id')
            ->where('qt.question_id = ' . $qid)
            ->field('t.id,t.name')
            ->select();
    }

    public function tagged($name, $p = 1)
    {
        $question = M('question q')
            ->join(' question_tags qt on q.id = qt.question_id ')
            ->join(' tag t on qt.tag_id = t.id ')
            ->where(" t.name = '" . $name."'");

        $count = $question->count();
        $page = new \Think\Page($count, C('PAGESIZE'));
        $show = $page->show();

        $questions = M('question q')
            //->fetchSql(true)
            ->join(' question_tags qt on q.id = qt.question_id ')
            ->join('auth_user u on q.user_id = u.id')
            ->join(' tag t on qt.tag_id = t.id ')
            ->where(" t.name = '" . $name."'")
            ->order('q.votes desc')
            ->limit($page->firstRow . ',' . $page->listRows)
            ->field('q.id,q.title,q.votes,q.answers,q.views,q.ct,u.username,q.user_id')
            ->select();
        $count = count($questions);
        for ($i = 0; $i < $count; $i++) {

            $tags = $this->getQuestionTags($questions[$i]['id']);

            $questions[$i]['tags'] = $tags;
        }

        $this->assign('page', $show);
        $this->assign('questions', $questions);
        $this->display('index');
    }

    public function answer()
    {
        if (IS_POST) {
            $answer_str = $_POST['answer'];
            $answer_str = urldecode($answer_str);
            $length = strlen($answer_str);
            if ($length > 5) {
                $answer = M('answer');
                try {
                    $answer->startTrans();
                    $answer->answer = $answer_str;
                    $answer->votes = 0;
                    $answer->ct = date('Y-m-d H:i:s');
                    $answer->question_id = $_POST['question_id'];
                    $user = $_SESSION['user'][0];
                    $answer->user_id = $user['id'];
                    $added = $answer->add();
                    $map['id'] = array('eq', $_POST['question_id']);
                    $question = M('question');
                    $inced = $question->where($map)->setInc('answers', 1);
                    if ($added && $inced) {
                        $answer->commit();
                    } else {
                        $answer->rollback();
                    }
                } catch (Exception $ex) {
                    $answer->rollback();
                    echo $ex->getMessage();
                    die();
                }
            } else {
                echo '答案长度不符合要求';
                die();
            }
        }

        $this->redirect('/Home/Question/details/id/' . $_POST['question_id']);
    }

    function vote($vote_type, $add = false)
    {
        $this->checkAuth();

        $Question = M('question');
        $Question->startTrans();

        $uid = getUserId();
        $qid = $_POST['id'];
        $map['user_id'] = array('eq', $uid);
        $map['question_id'] = array('eq', $qid);
        //删除相关记录
        M('qvote')->where($map)->delete();

        //添加相关记录
        $r1 = true;
        if ($add) {
            $qv = M('qvote');
            $qv->user_id = $uid;
            $qv->question_id = $qid;
            $qv->ct = date('Y-m-d H:i:s');
            $qv->vote_type = $vote_type;
            $r1 = $qv->add();
        }
        //统计
        $mapqv['question_id'] = array('eq', $qid);
        $mapqv['vote_type'] = array('eq', VOTEUP);
        $vote_up_count = M('qvote')->where($mapqv)->count();
        $mapqv['vote_type'] = array('eq', VOTEDOWN);
        $vote_down_count = M('qvote')->where($mapqv)->count();
        $count = $vote_up_count - $vote_down_count;
        $Question->where(' id = ' . $qid)->setField('votes', $count);


        if ($r1) {
            $Question->commit();
            $result['result'] = true;
            $result['votes'] = $count;
        } else {
            $Question->rollback();
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

    function basefavorite($add = false)
    {
        $this->checkAuth();
        $r0 = true;
        $r1 = true;
        $r2 = true;
        $fq = M('fquestion');
        $fq->startTrans();

        $userid = getUserId();
        $qid = $_POST['id'];
        $map['user_id'] = array('eq', $userid);
        $map['question_id'] = array('eq', $qid);
        $r0 = $fq->where($map)->delete();
        if ($add) {
            $f = M('fquestion');
            $f->ct = date('Y-m-d H:i:s');
            $f->user_id = $userid;
            $f->question_id = $qid;
            $r1 = $f
                //->fetchSql(true)
                ->add();
        }
        $q = M('question');
        $count = $fq->where(' question_id = ' . $qid)->count();
        $r2 = $q->where(' id = ' . $qid)
            //->fetchSql(true)
            ->setField('favorite', $count);
        if ($r1 && $r2) {
            $fq->commit();
            $result['result'] = true;
            $result['favorite'] = $count;
        } else {
            $fq->rollback();
            $result['result'] = false;
        }
        echo json_encode($result);
    }

    public function favorite()
    {
        $this->basefavorite(true);
    }

    public function unfavorite()
    {
        $this->basefavorite();
    }
}