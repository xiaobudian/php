<?php
/**
 * author: liushuai 849351660@qq.com
 * date  : 2016年1月12日10:05:04
 *
 */

namespace Home\Controller;

use Think\Cache\Driver\Memcached;
use Think\Controller;
use Think\Exception;
use Think\Page;

/**
 * Class QuestionController
 * @package Home\Controller
 * 问题模块
 */
class QuestionController extends BaseController
{

    /**
     * 查询问题列表
     * @param int $p 页码
     */
    public function index($p = 1)
    {
        // 分页信息
        if ($p == 1) {
            $total = M('question')->count();
            $_SESSION["question.total"] = $total;
        }
        $page = new \Think\Page($_SESSION["question.total"], C('PAGESIZE'));
        $page->setConfig('prev','prev');
        $page->setConfig('next','next');
        $page->setConfig('first','first');

        $show = $page->show();
        //dump($show);
        // 通过执行存储过程高效查询分页数据
        // 将问题关联的tag 采用GROUP_CONCAT 有效减少数据库查询次数
        $query = "call proc_question_orderby_votes_desc($page->firstRow,$page->listRows) ";
        $questions = M('question')->query($query);
        $this->assign('page', $show);
        $this->assign('questions', $questions);
        $this->display();

    }

    /**
     * 问题详情页
     * @param $id 问题id
     */
    public function details($id)
    {
        $uid = getUserId();
        if (!$uid)
            $uid = 0;
        // 调用存储过程查询问题详情
        // 包含问题基本信息 用户信息 投票信息 收藏 相关tag
        $query = " call proc_question_details($id,$uid) ";
        $question = M('question')->query($query);
//        dump($question);
        //查询问题的答案
        $mapanswer['question_id'] = array('eq', $id);
        $answers = M('answer a')
            ->where($mapanswer)
            ->order('votes desc')
            ->join(' auth_user u on a.user_id = u.id')
            ->field('a.id,a.votes,a.answer,a.user_id,u.username,a.ct')
            ->select();
        //如果用户已经登陆并且有答案，需要处理答案的投票信息
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
        $question[0]['q_answers'] = $answers;
        $this->assign('q', $question[0]);
        $this->display();
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
        if ($p == 1) {
            $question = M('question q')
                ->join(' question_tags qt on q.id = qt.question_id ')
                ->join(' tag t on qt.tag_id = t.id ')
                ->where(" t.name = '" . $name . "'");

            $total = $question->count();
            $_SESSION["tag.$name.total"] = $total;
        }
        $page = new \Think\Page($_SESSION["tag.$name.total"], C('PAGESIZE'));
        $show = $page->show();
        $query = "CALL proc_question_tagged($page->firstRow,$page->listRows,'$name')";
//        dump($query);
        $questions = M('question')->query($query);
        $this->assign('page', $show);
        $this->assign('questions', $questions);
        $this->display('index');
    }

    public function answer()
    {
        $this->checkAuth();
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

    function vote($vote_type, $add)
    {
        $this->checkAuth();
        $uid = getUserId();
        $qid = $_POST['id'];
        $votes = M('question')->query("CALL  proc_question_vote($uid,$qid,$vote_type,$add)");
        if ($votes) {
            $result['result'] = true;
            $result['votes'] = $votes[0]['votes'];
        } else {
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
        $this->vote(VOTECANCEL, 'false');
    }

    public function  votedownon()
    {
        $this->vote(VOTEDOWN, true);
    }

    public function  votedownoff()
    {
        $this->vote(VOTECANCEL, 'false');
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