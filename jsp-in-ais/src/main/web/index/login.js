/**
 * Created by xujun on 2017/8/8.
 */
var w_main = b_cloud = mainwidth = null;
var offset1 = 450;
var offset2 = 0;

$(function() {
    w_main = $("#mainBody");
    $body = $("body");
    b_cloud1 = $("#cloud1");
    b_cloud2 = $("#cloud2");
    mainwidth = w_main.outerWidth();

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

function fsubmit(obj){
    var username=document.all.j_username.value;
    var psw=document.all.password2.value;
    if (username == ""){
        alert("请输入用户名！");
        document.all.j_username.focus();
        return false;
    }else {
        if (psw == "") {
            alert("请输入密码！");
            document.all.password2.focus();
            return false;
        }
    }
    //Login();
    if(canLogin=="true"){
        alert("当前登陆用户数已经达到最大限制，请稍后重试！窗口将自动关闭！");
        window.close();
    }
    chg64();
    obj.submit();
}
function freset(obj){
    obj.reset();
}
function init() {
    document.getElementById("j_username").select();
}

function guestLogin(){
    document.all.username.value='guest';
    document.all.password.value=encode64('admin');
    document.forms[0].submit();
    return true;
}

function Login(){
    var username=document.all.j_username.value;
    var psw=document.all.j_password.value;
    var succ=true;
    if (username == ""){
        alert("请输入用户名！");
        document.all.j_username.focus();
        succ=false;
        return false;
    }else{
        if (psw == ""){
            alert("请输入密码！");
            document.all.j_password.focus();
            succ=false;
            return false;
        }else{
            document.forms[0].submit();
            return true;
        }
    }
}

function chg64(){
    document.getElementsByName("j_password")[0].value=encode64(document.getElementsByName("password2")[0].value);
    return true;
}

$(document).ready(function(){
    if(error =='1'){
        alert("用户名或密码错误！或此用户已注销或冻结!");
    }
    $("#j_username").focus();
    document.onkeydown = function(e){
        var ev = document.all ? window.event : e;
        if(ev.keyCode==13) {
            fsubmit(document.mainform);
        }
    }
});


function iptFocus(obj,tableid){

    $(obj).removeClass('input_normal_center_bg');
    $(obj).addClass('input_highlight_center_bg');

    var parent = $(obj).parent();
    parent.removeClass();
    parent.addClass('input_highlight_center_div_bg');
    var left = parent.prev();
    var right = parent.next();

    left.removeClass();
    left.addClass('input_highlight_left_bg');
    right.removeClass();
    right.addClass('input_highlight_right_bg');
    $('#'+tableid).addClass("inputf");
}

function disappear(tableid) {
	$('#' + tableid).html('');
}

function iptBlur(obj,tableid){
    $(obj).removeClass('input_highlight_center_bg');
    $(obj).addClass('input_normal_center_bg');

    var parent = $(obj).parent();
    parent.removeClass();
    parent.addClass('input_normal_center_div_bg');
    var left = parent.prev();
    var right = parent.next();

    left.removeClass();
    left.addClass('input_normal_left_bg');
    right.removeClass();
    right.addClass('input_normal_right_bg');
    $('#'+tableid).removeClass("inputf");
}

/**
 * 自定义加载提示条
 */
function showLoginLoadingBar() {
    var btns = document.getElementById('submitBtn').getElementsByTagName("button");
    if(btns && btns.length > 0){
        btns[0].className = 'btn_loading';
    }
}

//点击输入框提示文字的处理，聚焦到输入框
function loginTipWordClick(obj){
    var parentDiv = obj.parentNode;
    var inputs = parentDiv.getElementsByTagName("INPUT");
    if(inputs && inputs.length>0){
        inputs[0].focus();
        $(obj).html('');
    }
    //e = EventUtil.getEvent();
    //stopAll(e);
    //clearEventSimply(e);
    if(obj.id=="randimglab" && obj.style.left=="6px"){
        obj.style.fontSize="12px";
    }
}

function submitButtonStatus(obj,type){
    if(type === 'focus'){
        $(obj).removeClass('btn_off');
        $(obj).addClass('btn_on');
    }else if(type === 'blur'){
        $(obj).removeClass('btn_on');
        $(obj).addClass('btn_off');
    }

}