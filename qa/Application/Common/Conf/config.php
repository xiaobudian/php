<?php
return array(
    //'配置项'=>'配置值'
    // Url pattern
    'URL_MODEL' => 3, // 路由模式 - 兼容模式

    'DB_TYPE' => 'mysql', // 数据库类型
    'DB_HOST' => '127.0.0.1', // 服务器地址127.0.0.1
    'DB_NAME' => 'qa', // 数据库名称
    'DB_USER' => 'root', // 数据库登陆名称
    'DB_PWD' => '/.b0303nabCqa', // 登陆密码
    'DB_PORT' => '3306', // 数据库端口
    'DB_CHARSET' => 'utf8', // 字符集

    'DATA_CACHE_TIME' => 60, // 缓存过期时间  单位：秒
    // layout
    //'LAYOUT_ON' => true, // 使用模板
    //'LAYOUT_NAME' => 'layout', // 模板名称

    // 'ACTION_SUFFIX' => 'Action', // 操作方法后缀

    //邮件配置
    'MAIL_HOST' => 'smtp.163.com',//smtp服务器的名称
    'MAIL_SMTPAUTH' => TRUE, //启用smtp认证
    'MAIL_USERNAME' => 'olayule@163.com',//发件人的邮箱名
    'MAIL_PASSWORD' => '/.b0303nabColayl',//163邮箱发件人授权密码
    'MAIL_FROM' => 'olayule@163.com',//发件人邮箱地址
    'MAIL_FROMNAME' => '刘帅',//发件人姓名
    'MAIL_CHARSET' => 'utf-8',//设置邮件编码
    'MAIL_ISHTML' => TRUE, // 是否HTML格式邮件

    'PAGESIZE' => 5,
    'TAGPAGESIZE' => 32,
    'TAGSUGGESTION' => 6,

    // 系统配置
    // reputation
    'MAX_REPUTATION_PER_DAY' => 200,
//You gain reputation when:
//question is voted up: +5
//answer is voted up: +10
//answer is marked “accepted”: +15 (+2 to acceptor)
//suggested edit is accepted: +2 (up to +1000 total per user)
//bounty awarded to your answer: + full bounty amount
//one of your answers is awarded a bounty automatically: + half of the bounty amount (see more details about how bounties work)
//site association bonus: +100 on each site (awarded a maximum of one time per site)
    'QUESTION_VOTED_UP' => 5,
    'ANSWER_VOTED_UP' => 10,
    'ANSWER_ACCEPTED' => 15,
    'ACCEPTOR' => 2,
    'SUGGESTED_EDIT_ACCEPTED' => 2,
    'SUGGESTED_TOTAL' => 1000,
    //'SITE_ASSOCIATION_BONUS'=>100,

//You lose reputation when:
//
//your question is voted down: −2
//your answer is voted down: −2
//you vote down an answer: −1
//you place a bounty on a question: − full bounty amount
//one of your posts receives 6 spam or offensive flags: −100
    'QUESTION_VOTEDOWN' => -2,
    'ANSWER_VOTEDOWN' => -2,
    'VOTEDOWN_ANSWER' => -1,
    'SPAMOR_OR_OFFENSIVE_FLAGS'=>-100,
);