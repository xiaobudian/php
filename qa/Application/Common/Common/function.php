<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015.12.2
 * Time: 14:26
 */
define('VOTEUP', 1);
define('VOTEDOWN', 2);
define('VOTECANCEL', 4);
define('FAVORITE', 8);
define('UNFAVORITE', 16);

function curPageURL()
{
    $pageURL = 'http';
    if ($_SERVER["HTTPS"] == "on") {
        $pageURL .= "s";
    }
    $pageURL .= "://";
    if ($_SERVER["SERVER_PORT"] != "80") {
        $pageURL .= $_SERVER["SERVER_NAME"] . ":" . $_SERVER["SERVER_PORT"] . $_SERVER["REQUEST_URI"];
    } else {
        $pageURL .= $_SERVER["SERVER_NAME"] . $_SERVER["REQUEST_URI"];
    }
    return $pageURL;
}

function sendMail($to, $title, $content)
{
    Vendor('PHPMailer.PHPMailerAutoload');
    $mail = new PHPMailer(); //实例化
    $mail->IsSMTP(); // 启用SMTP
    $mail->Host = C('MAIL_HOST'); //smtp服务器的名称（这里以QQ邮箱为例）
    $mail->SMTPAuth = C('MAIL_SMTPAUTH'); //启用smtp认证
    $mail->Username = C('MAIL_USERNAME'); //发件人邮箱名
    $mail->Password = C('MAIL_PASSWORD'); //163邮箱发件人授权密码
    $mail->From = C('MAIL_FROM'); //发件人地址（也就是你的邮箱地址）
    $mail->FromName = C('MAIL_FROMNAME'); //发件人姓名
    $mail->AddAddress($to, "尊敬的客户");
    $mail->WordWrap = 50; //设置每行字符长度
    $mail->IsHTML(C('MAIL_ISHTML')); // 是否HTML格式邮件
    $mail->CharSet = C('MAIL_CHARSET'); //设置邮件编码
    $mail->Subject = $title; //邮件主题
    $mail->Body = $content; //邮件内容
    $mail->AltBody = "这是一个纯文本的身体在非营利的HTML电子邮件客户端"; //邮件正文不支持HTML的备用显示
    return ($mail->Send());
}

function getUser()
{
    return $_SESSION['user'][0];
}

function getUserId()
{
    $user = getUser();
    return $user['id'];
}

function getUserName()
{
    $user = getUser();
    return $user['username'];
}

function hadLogin()
{
    if (!isset($_SESSION['user']) || empty($_SESSION['user'])) {
        return false;
    }
    return true;
}
const baseurl = '/index.php/Home/';
function questiondetailsurl($id)
{
    return baseurl . 'Question/details/id/' . $id;
}

function questiontaggedurl($tagname)
{
    return baseurl . 'Question/tagged/name/' . $tagname;
}

function useractivity($uid)
{
    return baseurl . 'User/activity/id/' . $uid;
}

function userdetails($uid)
{
    return baseurl . 'User/details/id/' . $uid;
}

// convert a date into a string that tells how long ago
// that date was.... eg: 2 days ago, 3 minutes ago.
function ago($d)
{
    $c = getdate();
    dump($c);
    $p = array('year', 'mon', 'mday', 'hours', 'minutes', 'seconds');
    $display = array('year', 'month', 'day', 'hour', 'minute', 'second');
    $factor = array(0, 12, 30, 24, 60, 60);
    $d = datetoarr($d);
    dump($d);
    for ($w = 0; $w < 6; $w++) {
        if ($w > 0) {
            $c[$p[$w]] += $c[$p[$w - 1]] * $factor[$w];
            $d[$p[$w]] += $d[$p[$w - 1]] * $factor[$w];
        }
        if ($c[$p[$w]] - $d[$p[$w]] > 1) {
            return ($c[$p[$w]] - $d[$p[$w]]) . ' ' . $display[$w] . 's ago';
        }
    }
    return '';
}

// you can replace this if need be.
// This converts my dates returned from a mysql date string
// into an array object similar to that returned by getdate().
function datetoarr($d)
{
    preg_match("/([0-9]{4})(\\-)([0-9]{2})(\\-)([0-9]{2})([0-9]{2})(\\:)([0-9]{2})(\\:)([0-9]{2})/", $d, $matches);
    return array(
        'seconds' => $matches[10],
        'minutes' => $matches[8],
        'hours' => $matches[6],
        'mday' => $matches[5],
        'mon' => $matches[3],
        'year' => $matches[1],
    );
}

function date2ago($date)
{
//    preg_match("/([0-9]{4})(\\-)([0-9]{2})(\\-)([0-9]{2})([0-9]{2})(\\:)([0-9]{2})(\\:)([0-9]{2})/", $date, $matches);
//    dump($matches);
    $seconds = time() - strtotime($date);
    //echo $seconds;
    $year = floor($seconds/(365*24*3600));
    echo $year;
    if($year!=0){
        return $year.'years ago';
    }

}