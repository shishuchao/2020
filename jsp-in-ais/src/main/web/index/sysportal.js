/**
 * Created by xujun on 2017/3/27.
 */
var windowArray = [];

function openSubsystem(sysName,link){
    if(sysName.indexOf('监控预警')>-1){
        link ="http://"+host+"/login.jsp?type=2&p="+queryString;
    }else if(sysName.indexOf('查询分析')>-1){
        link ="http://"+host+"/login.jsp?type=1&p="+queryString;
    }else if(sysName.indexOf('数据中心')>-1){
        link ="http://"+host+"/login.jsp?type=3&p="+queryString;
    }else if(sysName.indexOf('审友云')>-1){
        link ="http://cloud.yonyouaud.com/";
    }else if(sysName.indexOf('离线作业系统')>-1){
        if (!confirm("离线作业系统需要安装离线作业客户端，是否启动？")) {
            return;
        }
        link ="shenyi://offline";
    }else{
        link = contextPath+link;
        var lns = link.split("http");
        if(lns.length > 1) {
            link = "http" + lns[lns.length - 1];
        }
    }
    /*
    var udswin = window.open(
        link, sysName,
        'height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
    */
    // modified by sunny
    var udswin = window.open(
        link, sysName,
       'height='+window.screen.availHeight+'px, width='+window.screen.availWidth+'px, fullscreen=yes, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');

    udswin.moveTo(0, 0);
    udswin.resizeTo(window.screen.availWidth, window.screen.availHeight);
    // modified end

    //if(windowArray.indexOf(udswin) == -1){
    if(jQuery.inArray(udswin, windowArray) == -1){        //解决ie8中array没有indexOf方法的问题 by zxl 19.04.15
    	windowArray.push(udswin);
    }else{
    	udswin.focus();
    }
}
function closeAllWindow(){
    for(var i = 0;i<windowArray.length;i++){
        var win = windowArray[i];
        if(win && win.open && !win.closed){
            win.close();
        }
    }
    windowArray.splice(0,windowArray.length);
    window.location=contextPath+'/system/uSystemAction!loginOut.action';
    /*if(windowArray.indexOf(win) != -1){
        windowArray.splice(windowArray.indexOf(win),1);
    }*/
}
/* 用户注销 */
function logout(){
    top.$.messager.confirm('确认','您确定要注销系统登录吗？',function(r){
        if(r){
            closeAllWindow();
        }
    });
};

var w_main = b_cloud = mainwidth = null;
var offset1 = 450;
var offset2 = 0;

$(function() {
    w_main = $("#mainBody");
    $body = $("body");
    b_cloud1 = $("#cloud1");
    b_cloud2 = $("#cloud2");
    mainwidth = w_main.outerWidth();

    var left = menuSize<=8?625:810;

    // 计算布局放在页面脚本做了 $('.loginlist').width(menuSize<=8?625:810);

    /*// 计算布局放在页面脚本做了
    $('.loginbox0').css({
        'position' : 'absolute',
        'left' : ($(window).width() - left) / 2
    });
    */
    $('.loginbody').height($('.page-content').height());
    $('.loginbody').css({'top':'0px'});
    $('.loginbox0').css({'margin-top':($('.loginbody').height()-rows*245)/2});

    // $(window).resize(function() {
    //     $('.loginbox0').css({
    //         'position' : 'absolute',
    //         'left' : ($(window).width() - left) / 2
    //     });
    //     $('.loginbody').height($('.page-content').height());
    //     $('.loginbody').css({'top':'0px'});
    //     $('.loginbox0').css({'margin-top':($('.loginbody').height()-rows*245)/2});
    // });

});

/// 飘动
setInterval(function flutter() {
    if (offset1 >= mainwidth) {
        offset1 = -580;
    }

    if (offset2 >= mainwidth) {
        offset2 = -580;
    }
    offset1 += 1.1;
    offset2 += 1;
    b_cloud1.css("background-position", offset1 + "px 100px")
    b_cloud2.css("background-position", offset2 + "px 460px")
}, 70);