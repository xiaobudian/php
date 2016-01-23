/**
 * Created by Administrator on 2015.12.4.
 */
$(function () {

    $("#tagfilter").keyup(function () {
        finished($('#tagfilter').val());
    })
    $("#add").click(function () {
        var name = $('#tagfilter').val();
        name = $.trim(name);
        if (name.length == 0)return;
        if ($('#desc').length != 0) {
            var desc = $('#desc').val();

            desc = $.trim(desc);
            if (desc.length == 0) {
                alert('请输入对tag的描述！');
                return;
            }
            $("form").submit();
        } else {
            window.location.href = "/index.php/Home/Tag/create/name/" + name;
        }
    });
});
var request = null;
function finished(txt) {
    $("#tags_list").html('');
    if (request) {
        request.abort();
    }
    request = $.ajax({
        type: "POST",
        url: "/index.php/Home/Tag/filter",
        data: {filter: txt},
        dataType: "html",
        success: function (result) {
            if (result == 'notfound') {
                $('#add').removeClass();
            } else {
                $('#add').addClass('hidden-important');
                var domelement = $(result);
                $("#tags_list").html(domelement);
                if (txt == "") {
                    $(".pager").show();
                } else {
                    $(".pager").hide();
                }
            }
        }
    });
}