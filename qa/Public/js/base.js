/**
 * 功能：基础层，核心库
 * 作者：刘帅 849351660@qq.com
 * 日期：2016年1月21日14:53:21
 */
function XBD(settings) {
    if (settings) {
        domain = settings.domain;
    }
    this.ajax = function (options) {
        $.ajax({
            url: domain + options.url,
            data: options.data || {},
            type: options.type || 'post',
            dataType: options.dataType || 'json',
            success: options.success,
            error: options.error,
        });
    }
}