/**
 * 功能简介 ：问答详情页 对问题投票 收藏 添加评论
 *          对答案进行投票 如果是问题的发起人 可以将答案标记为已接受
 * 作者    : liushuai <849351660@qq.com>
 * 创建时间 : 2015年12月03日
 */
$(function () {
    var ue = UE.getEditor('editor');
    /**
     * 提交答案
     * 检查答案是否满足条件
     */
    $("#submit-button").click(function () {
        var answer = UE.getEditor('editor').getContentTxt();
        answer = $.trim(answer);
        if (answer.length < 1) {
            alert("请输入答案");
            return;
        }
        $('#content_txt').val(answer);
        answer = UE.getEditor('editor').getContent();
        answer = encodeURI(answer);
        $("#content_html").val(answer);
        $("#post-form").submit();
    });

    function qaajax(id, controller, url, callback) {

        $.ajax({
                url: '/index.php/Home/' + controller + '/' + url,
                data: {id: id},
                type: 'post',
                dataType: 'json',
                success: callback,
            }
        );
    }

    function updatevotes(data, c1, c2, inc, c3) {
        //data = $.parseJSON(data);
        if (data.result) {
            var selector = c3;
            if (data.id > 0) {
                selector = c3 + '-' + data.id;
            }
            $(selector + ' .vote-up-on').removeClass().addClass('vote-up-off');
            $(selector + ' .vote-down-on').removeClass().addClass('vote-down-off');
            $(selector + ' .' + c1).removeClass().addClass(c2);

            $(selector + ' .vote-count-post').html(data.votes);
        }
    }

    function favorite(url, c1, c2) {
        var id = $('.question input[name=_id_]').val();
        qaajax(id, 'Question', url, function (data) {
            if (data.result) {
                $('.favoritecount').html('<b>' + data.favorite + '</b>')
                $('.question .' + c1).removeClass().addClass(c2);
            }
        })
    }

    function checklogin() {
        return $('#hadlogin').val() == '1';
    }

    function gotologin() {
        var id = $('.question input[name=_id_]').val();
        window.location.href = '/index.php/Home/Account/login?returnUrl=/Home/Question/details/id/' + id;
    }

    $('.question .vote a').click(function () {
        if (checklogin()) {
            var c = $(this).attr('class');
            var url, c2, inc;
            switch (c) {
                case 'star-off':
                    favorite('favorite', c, 'star-on');
                    return;
                    break;
                case 'star-on':
                    favorite('unfavorite', c, 'star-off');
                    return;
                    break;
                case 'vote-up-on':
                    url = "voteupoff";
                    c2 = 'vote-up-off';
                    inc = -1;
                    break;
                case 'vote-up-off':
                    url = "voteupon";
                    c2 = 'vote-up-on';
                    inc = 1;
                    break;
                case 'vote-down-on':
                    url = "votedownoff";
                    c2 = 'vote-down-off';
                    inc = 1;
                    break;
                case 'vote-down-off':
                    url = "votedownon";
                    c2 = 'vote-down-on';
                    inc = -1;
                    break;
            }
            var id = $('.question input[name=_id_]').val();
            qaajax(id, 'Question', url, function (data) {
                updatevotes(data, c, c2, inc, '.question');
            });
        } else {
            gotologin();
        }
    });

    $('.answer .vote a').click(function () {
        if (checklogin()) {
            var c = $(this).attr('class');
            var url, c2, inc;
            switch (c) {
                case 'vote-up-on':
                    url = "voteupoff";
                    c2 = 'vote-up-off';
                    inc = -1;
                    break;
                case 'vote-up-off':
                    url = "voteupon";
                    c2 = 'vote-up-on';
                    inc = 1;
                    break;
                case 'vote-down-on':
                    url = "votedownoff";
                    c2 = 'vote-down-off';
                    inc = 1;
                    break;
                case 'vote-down-off':
                    url = "votedownon";
                    c2 = 'vote-down-on';
                    inc = -1;
                    break;
            }
            var id = $(this).siblings('input[name=_id_]').val();
            qaajax(id, 'Answer', url, function (data) {
                updatevotes(data, c, c2, inc, '.answer');
            });
        } else {
            gotologin();
        }
    });
    var xbd = new XBD({domain: '/index.php/Home/'});

    function accept() {
        var id = $(this).parents('.answer').first().attr('data-answerid');
        var accepted = $(this).hasClass('vote-accepted-on') ? 0 : 1;
        xbd.ajax({
            url: 'Answer/accepted',
            data: {id: id, accepted: accepted},
            success: function (data) {
                if (data == 'success') {
                    if (accepted) {
                        $('.vote-accepted-off', $(".answer-" + id))
                            .removeClass('vote-accepted-off').addClass('vote-accepted-on');
                    } else {
                        $('.vote-accepted-on', $(".answer-" + id))
                            .removeClass('vote-accepted-on').addClass('vote-accepted-off');
                    }
                }
            },
            error: function (data) {
            }
        });
    }

    $('.vote-accepted-on').bind('click', null, accept);
    $('.vote-accepted-off').bind('click', null, accept);
});