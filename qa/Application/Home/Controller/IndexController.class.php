<?php
namespace Home\Controller;

use Think\Controller;
use Think\Cache\Driver\Memcached;
use Think\Exception;

class IndexController extends Controller
{
    public function index()
    {
        $this->redirect('/Home/Question/index');
    }

    public function mem()
    {
        $mem = Memcached::getInstance();
        $tags = $mem->get('tags');
        dump($tags);
        if (!$tags) {
            $mem->set('tags', M('tag')->select());
        }
        dump($mem->get('tags'));
//        $mem = Memcached::getInstance();
//        $mem->set('ls', 'liushuai');
//        echo $mem->get('ls');
//        dump($mem);
//        $Cache = Cache::getInstance('memcache');
//////或者:
////        $options = array('host' => '127.0.0.1', 'port' => 11211, 'timeout' => 10,
////            'persistent' => false);
////        $Cache = Cache::getInstance('memcache', $options);
//        $Cache->set('name','ThinkPHP'); // 缓存name数据
//        $value = $Cache->get('name'); // 获取缓存的name数据
//        $Cache->close();
//        echo $value;


    }

    public function phpinfo()
    {

        echo phpinfo();
    }

    public function search()
    {
        if(isset($_POST)){
            $keyword = $_POST['keyword'];
            echo $keyword;
            if (isset($keyword)) {
                $questions = M('question')->query("select * from question where title like '%$keyword%' OR question.content like '%$keyword%'");
                dump($questions);
//                $this->assign('questions',$questions);
//                $this->display();
                die();
            }
        }

        echo 'please input keyword.';
    }

    public function testquerytaggedquestion()
    {
        dump(M('tag')->query("CALL proc_question_tagged(0,5,'php')"));
    }

    public function testprocexception()
    {
        try {
            $result = M('question')->execute("CALL  proc_question_vote(1,10)");
            dump($result);
        } catch (Exception $e) {
            $this->redirect('index');
        }
    }

    public function testqvoteproc()
    {
        $result = M('question')->query("CALL  proc_question_vote(3,7,2,false)");
        dump($result);
    }

    public function testimagecreatefrompng()
    {
        header('Content-Type: image/png');
        try {
            $src = 'D:\Studio\XBD\php\qa\Public\img\uploads\无标题22.png';
            $src = iconv('UTF-8','gb2312',$src);
            $img = @imagecreatefrompng($src);
            imagepng($img);
            imagedestroy($img);
        }catch(Exception $e){
            dump($e->getMessage());
        }
    }
    public function test_iconv($name){
        echo iconv_get_encoding($name);
        echo iconv('UTF-8','gb2312',$name);
    }
}