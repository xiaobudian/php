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

/**
 * Determines the difference between two timestamps.
 *
 * The difference is returned in a human readable format such as "1 hour",
 * "5 mins", "2 days".
 *
 * User: liushuai <849351660@qq.com>
 * DateTime: 2016-01-15 10:32:23
 */
// define const
define('MINUTE_IN_SECONDS', 60);
define('HOUR_IN_SECONDS', 60 * MINUTE_IN_SECONDS);
define('DAY_IN_SECONDS', 24 * HOUR_IN_SECONDS);
define('WEEK_IN_SECONDS', 7 * DAY_IN_SECONDS);
define('MONTH_IN_SECONDS', 30 * DAY_IN_SECONDS);
define('YEAR_IN_SECONDS', 365 * DAY_IN_SECONDS);
// choice single or plural
function _n($single, $plural, $number)
{
    if ($number > 1) {
        return $plural;
    }
    return $single;
}

function human_time_diff($from, $to = '')
{
    if (empty($to)) {
        $to = time();
    }
    $date = DateTime::createFromFormat('Y-m-d H:i:s', $from);
    $from = $date->getTimestamp();
    $to = time();

    if ($to - $from < 0) {
        echo "Please enter the time before";
        die();
    }
    $diff = (int)abs($to - $from);

    if ($diff < HOUR_IN_SECONDS) {
        $mins = round($diff / MINUTE_IN_SECONDS);
        if ($mins <= 1)
            $mins = 1;
        /* translators: min=minute */
        $since = sprintf(_n('%s min', '%s mins', $mins), $mins);
    } elseif ($diff < DAY_IN_SECONDS && $diff >= HOUR_IN_SECONDS) {
        $hours = round($diff / HOUR_IN_SECONDS);
        if ($hours <= 1)
            $hours = 1;
        $since = sprintf(_n('%s hour', '%s hours', $hours), $hours);
    } elseif ($diff < WEEK_IN_SECONDS && $diff >= DAY_IN_SECONDS) {
        $days = round($diff / DAY_IN_SECONDS);
        if ($days <= 1)
            $days = 1;
        $since = sprintf(_n('%s day', '%s days', $days), $days);
    } elseif ($diff < MONTH_IN_SECONDS && $diff >= WEEK_IN_SECONDS) {
        $weeks = round($diff / WEEK_IN_SECONDS);
        if ($weeks <= 1)
            $weeks = 1;
        $since = sprintf(_n('%s week', '%s weeks', $weeks), $weeks);
    } elseif ($diff < YEAR_IN_SECONDS && $diff >= MONTH_IN_SECONDS) {
        $months = round($diff / MONTH_IN_SECONDS);
        if ($months <= 1)
            $months = 1;
        $since = sprintf(_n('%s month', '%s months', $months), $months);
    } elseif ($diff >= YEAR_IN_SECONDS) {
        $years = round($diff / YEAR_IN_SECONDS);
        if ($years <= 1)
            $years = 1;
        $since = sprintf(_n('%s year', '%s years', $years), $years);
    }
    return $since . ' ago';
}

function pageinfo($count){
//    <div class="pager fl">
//
//
//
//
//
//    <a href="/questions?page=1&amp;sort=votes" rel="prev" title="go to page 1"> <span class="page-numbers prev">prev </span> </a>
//    <a href="/questions?page=1&amp;sort=votes" title="go to page 1"> <span class="page-numbers">1</span> </a>
//    <span class="page-numbers current">2</span>         <a href="/questions?page=3&amp;sort=votes" title="go to page 3"> <span class="page-numbers">3</span> </a>
//    <a href="/questions?page=4&amp;sort=votes" title="go to page 4"> <span class="page-numbers">4</span> </a>
//    <a href="/questions?page=5&amp;sort=votes" title="go to page 5"> <span class="page-numbers">5</span> </a>
//    <span class="page-numbers dots">…</span>         <a href="/questions?page=725237&amp;sort=votes" title="go to page 725237"> <span class="page-numbers">725237</span> </a>
//    <a href="/questions?page=3&amp;sort=votes" rel="next" title="go to page 3"> <span class="page-numbers next"> next</span> </a>
//
//</div>
    return "sss";
}