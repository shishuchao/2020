/**
 * Created by xujun on 2017/1/23.
 */

/**
 * 获取子菜单
 * @param pid
 */

// fixed by sunny 2019-04-16
// array indexOf undefined in IE8
if (!Array.prototype.hasOwnProperty("indexOf")) {
    Array.prototype.indexOf = function (item) {
        for (var i = 0; i < this.length; i++) {
            if (this[i] == item)
                return i;
        }
        return -1;
    };
}
// fixed end

function childMenu(pid) {
    var fixMenuHeight = function () {
        // 子菜单
        var subMenuObj = $('#submenu-' + pid);
        // 父菜单高度
        var pmenuH = subMenuObj.prev().height();
        // 菜单的top(所有父菜单top的和)
        var subTop = 0;
        var menuLevel = 1;
        subMenuObj.parents(".nav-item").each(function (i, tobj) {
            var tmpTop = $(tobj).attr('initTop');
            if (!tmpTop) {
                tmpTop = Math.floor($(tobj).position().top)
                $(tobj).attr('initTop', tmpTop);
            }
            subTop += parseInt(tmpTop);
            menuLevel = i + 2;
        });
        // 当前菜单的top
        var curTop = subMenuObj.attr('initTop');
        if (!curTop) {
            curTop = Math.floor(subMenuObj.position().top);
            subMenuObj.attr('initTop', curTop);
        }
        subTop = curTop > subTop ? curTop : subTop;
        // 当前菜单的高度
        var subHeight = Math.floor(subMenuObj.height());
        // 窗口的高度
        var clientH = Math.floor($(window).height());
        // 允许的最大菜单高度
        var maxSubMenuHeight = Math.floor(clientH - subTop);
        //$('#t1').text("curTop:"+curTop+",subTop:"+subTop+",subH:"+subHeight+",maxH:"+maxSubMenuHeight+",menuLevel:"+menuLevel);
        if (subHeight + 20 >= maxSubMenuHeight) {
            var newTop = Math.floor(curTop - subHeight + 50);
            //$('#t1').text("curTop:"+curTop+",subTop:"+subTop+",newTop:"+newTop+",subHeight:"+subHeight);
            if (newTop) {
                subMenuObj.css("top", newTop);
            }
        }
    };

    if ($('#submenu-' + pid).attr('fetched') != 'true') {
        $.getJSON(
            contextPath + '/portal/simple/simple-firstPageAction!childMenu.action',
            {
                'fparentId': pid,
                'showInOnline': 'N'
            },
            function (json) {
                if (json.menus.length > 0) {
                    var html = '';
                    for (var i = 0; i < json.menus.length; i++) {
                        var obj = json.menus[i];
                        if (obj.ffundisplay.indexOf('预警') > -1) {
                            html = html + '<li class="nav-item"><a href="javascript:;" class="nav-link nav-toggle" onclick="goMenu(\'' + obj.ffundisplay + '\',\'' + obj.flink + '\',\'' + obj.ffunid + '\',\'' + obj.fparentid + '\',this)">' + obj.ffundisplay + '</span><span class="arrow"></span></a>';
                        } else {
                            if (obj.isHaveChild == 'Y') {
                                html = html + '<li class="nav-item"><a href="javascript:;" class="nav-link nav-toggle" onmouseover="childMenu(\'' + obj.ffunid + '\')">' + obj.ffundisplay + '<span class="arrow"></span></a>' +
                                    '<ul class="sub-menu" id="submenu-' + obj.ffunid + '"></ul></li>';
                            } else {
                                /*根据查询出的菜单id匹配当前菜单id*/
                                var idList = json.marksList;
                                //if (idList.indexOf(obj.ffunid) == -1) {
                                if (jQuery.inArray(obj.ffunid, idList) == -1) {  //解决ie8中array没有indexOf方法的问题 by zxl 19.04.15
                                    html = html + '<li class="nav-item"><a href="javascript:;" class="nav-link" onclick="goMenu(\'' + obj.ffundisplay + '\',\'' + obj.flink + '\',\'' + obj.ffunid + '\',\'' + obj.fparentid + '\',this)"><span class="title"  onclick="goMenu(\'' + obj.ffundisplay + '\',\'' + obj.flink + '\',\'' + obj.ffunid + '\',\'' + obj.fparentid + '\',this)">' + obj.ffundisplay + '</span><span id="heart-' + obj.ffunid + '" style="float: right;color: #d1b455;" class="glyphicon glyphicon-star-empty" onclick="menu_marks(\'' + obj.ffundisplay + '\',\'' + obj.flink + '\',\'' + obj.ffunid + '\',this)"></span></a></li>';//glyphicon glyphicon-heart-empty
                                } else {
                                    html = html + '<li class="nav-item"><a href="javascript:;" class="nav-link" onclick="goMenu(\'' + obj.ffundisplay + '\',\'' + obj.flink + '\',\'' + obj.ffunid + '\',\'' + obj.fparentid + '\',this)"><span class="title"  onclick="goMenu(\'' + obj.ffundisplay + '\',\'' + obj.flink + '\',\'' + obj.ffunid + '\',\'' + obj.fparentid + '\',this)">' + obj.ffundisplay + '</span><span id="heart-' + obj.ffunid + '" style="float: right;color: #d1b455;" class="glyphicon glyphicon-star" onclick="menu_marks(\'' + obj.ffundisplay + '\',\'' + obj.flink + '\',\'' + obj.ffunid + '\',this)"></span></a></li>';
                                }
                            }
                        }
                    }
                    $('#submenu-' + pid).attr('fetched', 'true');
                    $('#submenu-' + pid).html(html);
                }

                fixMenuHeight();
            }
        );
    } else {
        fixMenuHeight();
    }


    // setTimeout(function () {
    //     // 子菜单
    //     var subMenuObj = $('#submenu-' + pid);
    //     // 父菜单高度
    //     var pmenuH = subMenuObj.prev().height();
    //     // 菜单的top(所有父菜单top的和)
    //     var subTop = 0;
    //     var menuLevel = 1;
    //     subMenuObj.parents(".nav-item").each(function (i, tobj) {
    //         var tmpTop = $(tobj).attr('initTop');
    //         if (!tmpTop) {
    //             tmpTop = Math.floor($(tobj).position().top)
    //             $(tobj).attr('initTop', tmpTop);
    //         }
    //         subTop += parseInt(tmpTop);
    //         menuLevel = i + 2;
    //     });
    //     // 当前菜单的top
    //     var curTop = subMenuObj.attr('initTop');
    //     if (!curTop) {
    //         curTop = Math.floor(subMenuObj.position().top);
    //         subMenuObj.attr('initTop', curTop);
    //     }
    //     subTop = curTop > subTop ? curTop : subTop;
    //     // 当前菜单的高度
    //     var subHeight = Math.floor(subMenuObj.height());
    //     // 窗口的高度
    //     var clientH = Math.floor($(window).height());
    //     // 允许的最大菜单高度
    //     var maxSubMenuHeight = Math.floor(clientH - subTop);
    //     //$('#t1').text("curTop:"+curTop+",subTop:"+subTop+",subH:"+subHeight+",maxH:"+maxSubMenuHeight+",menuLevel:"+menuLevel);
    //     if (subHeight >= maxSubMenuHeight) {
    //         var newTop = null;
    //         if (menuLevel >= 3) {
    //             newTop = Math.floor(curTop - subHeight * 0.5 - 15);
    //         } else {
    //             var diff = parseInt(Math.floor(subHeight - maxSubMenuHeight));
    //             diff = diff > 0 ? diff : 0;
    //             newTop = subTop - diff - pmenuH;
    //         }
    //         //$('#t1').text("curTop:"+curTop+",subTop:"+subTop+",newTop:"+newTop+",subHeight:"+subHeight);
    //         if (newTop) {
    //             subMenuObj.css("top", newTop);
    //         }
    //     }
    // }, 0);
}

//菜单点击事件
function goMenu(tabName,flink,tabId,fparentid,obj){
	$.ajax({
		url:contextPath+"/updateTimes.action",
        type:'POST',
        data:{
            tabId:tabId,
        }
      });
    if(tabName.indexOf('预警')>-1){
        var host = '<s:property value="@ais.project.ProjectSysParamUtil@getZXSJHostPort()" />';
        var queryString = encodeURIComponent(RSAEncode("${user.floginname}"));
        var url ="http://"+host+"/vision/Login-YY.jsp?audit="+queryString + "&vision=A6";
        var aa = document.getElementById("goYj");
        aa.href=url;
        aa.click();
        return;
    }else{

        Addtabs.add({
            id:tabId,
            title:tabName,
            url:flink,
            close:true,
            refresh:true
        });
        App.scrollTop();
        if ($(obj).parent('a').size() == 0){
        	Layout.setSidebarMenuActiveLink('click',$(obj));
        } else {
        	Layout.setSidebarMenuActiveLink('click',$(obj).parent('a'));
        }
    }
}
function addTab(navId,tabName,tabId,flink,refresh){
    Addtabs.add({
        id:tabId,
        title:tabName,
        url:flink,
        close:true,
        refresh:true
    });
}
var css1 = "glyphicon glyphicon-star";
var css2 = "glyphicon glyphicon-star-empty";
/*菜单收藏功能*/
function menu_marks(tabName,flink,tabId,obj) {
	var current_css = obj.className;

	if(current_css == css2) {
		/*添加菜单到我的收藏*/
		$.ajax({
			url:contextPath+"/addMarks.action",
	        type:'POST',
	        data:{
	            tabName:tabName,
	            flink:flink,
	            tabId:tabId,
	        },            
	        dataType:'json',
	        success:function(data) {
	        	$(obj).removeClass(css2);
        		$(obj).addClass(css1);
        		bookMarks();
	        }
	      });	
	}else {
		removeMarks(tabId);
	}	
}
/**
 * 待办催办
 */
function reminder(has,type){
    if(has=='true'){
        $.ajax({
            url:contextPath+'/portal/simple/reminder.action?type='+type,
            cache:false,
            dataType:'json',
            success:function(data){
                if(data.rows.length > 0){
                    $('#remind').html(data.rows.length);
                    var html = [];
                    for(var i = 0;i<data.rows.length;i++){
                        var obj = data.rows[i];
                        html.push('<li><a href="javascript:;" onclick="goMenu(\'待办事项处理\',\''+contextPath+obj.editUrl+'&todoback=1\',\'taskProcess\',null)"><span class="time">'+obj.createTime+'</span><span class="details"><span class="label label-sm label-icon label-success"> <i class="fa fa-plus"></i> </span>'+obj.description+'</span> </a> </li>');
                    }
                    $('#remindList').html(html.join(''));
                }
            }
        });
    }
}

/**
 * 站内消息
 */
function innerMsg(){
    $.ajax({
        url:contextPath+'/msg/innerMsg2firstPage.action',
        cache:false,
        dataType:'json',
        success:function(data){
            if(data.size > 0){
                $('#innerMsgCount').html(data.size);
                $('#innerMsgCnt').html(data.size);
                var html = [];
                for(var i=0; i<data.inners.length; i++){
                    var obj = data.inners[i];
                    html.push('<li><a data-toggle="modal" href="#msgDialog" onclick="viewMessage(\''+obj.msgId+'\')"><span class="subject"><span class="from"> '+obj.fromUserName+' </span><span class="time"> '+obj.createTime+' </span> </span><span class="message"> '+obj.subject+' </span> </a> </li>');
                }
                $('#innerMsgList').html(html.join(''));
            } else {
            	$('#innerMsgCnt').html(data.size);
            }
        }
    });
}
/**
 * 菜单收藏
 */
function bookMarks(){
    $.ajax({
        url:contextPath+'/bookMarks.action',
        cache:false,
        dataType:'json',
        success:function(data){
        	var html = [];
    		var list = data.bookMarksList;
        	var length= list.length;
        	if(length >0){
            	for(var i=0;i<length;i++) {
            		var tabId = list[i].menuId;
            		var tabName =  list[i].menuName;
            		var flink = list[i].menuLink;
            		html.push('<li class="nav-item"><a href="javascript:;" class="nav-link"  ><h5><span class="title" onclick="goMenu(\''+tabName+'\',\''+flink+'\',\''+tabId+'\',this)">'+tabName+'</span><span style="float: right;color:darkred;" class="fa fa-trash" onclick="removeMarks(\''+tabId+'\')"></span></h5></a></li>');
            	} 
            	$('#bookMarksList').html(html.join(''));
        	}else{
                $('#bookMarksList').html('');
            }
        }
    });
}
/**
 * 收藏菜单移除按钮
 */
function removeMarks(tabId) {
    var obj = $('#heart-'+tabId);
    /*将菜单从我的收藏中移除*/
    $.ajax({
        url:contextPath+"/removeMarks.action",
        type:'POST',
        data:{
            tabId:tabId,
        },
        dataType:'json',
        success:function(data) {
            if(obj){
                obj.removeClass(css1);
                obj.addClass(css2);
                bookMarks();
            }
        }
    });
}
/**
 * 查看消息内容
 * @param msgId
 */
function viewMessage(msgId){
    $('#msgFrame').attr('src',contextPath+'/msg/innerMsg_view.action?innerMsg.msgId='+msgId);
}


var windowArray = [];

function openSubsystem(sysName,link){
    if(sysName.indexOf('大数据审计')>-1){
        var host = '<s:property value="@ais.project.ProjectSysParamUtil@getZXSJHostPort()" />';
        var queryString = encodeURIComponent(RSAEncode("${user.floginname}"));
        link ="http://"+host+"/vision/Login-YY.jsp?audit="+queryString + "&vision=A6";
    }else{
        link = contextPath+link;
        var lns = link.split("http");
        link = "http" + lns[lns.length - 1];
    }
    var udswin = window.open(
        link, sysName,
        'height='+window.screen.availHeight+'px, width='+window.screen.availWidth+'px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');

    udswin.moveTo(0, 0);
    udswin.resizeTo(window.screen.availWidth,window.screen.availHeight);
    if(windowArray.indexOf(udswin) == -1){
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
}
/* 用户注销 */
function logout(){
    top.$.messager.confirm('确认','您确定要注销系统登录吗？',function(r){
        if(r){
            closeAllWindow();
        }
    });
};

/* 新建消息 */
function sendF(){
	var url = contextPath+"/msg/innerMsg_edit.action?readFlag=3";
	//aud$openNewTab("新建消息", url,true);
    $('#innermsg_ifr').attr('src',url);

};

function systemMenus(){
    var length= sysMenus.length;
    if(length >0){
        var onlineName,onlineLink,onlineId;
        var html = [];
        for(var i=0;i<length;i++) {
            var tabName =  sysMenus[i].menuName;
            var menuId =  sysMenus[i].menuId;
            var flink = sysMenus[i].flink;
            var fvalue = sysMenus[i].funvalue;
            if(fvalue != parentMenuValue) {
                if(tabName.indexOf('作业系统') > -1&&$('#onlinework')&&$('#onlinework').length > 0){
                    onlineId = menuId;
                    onlineName = tabName;
                    onlineLink = flink;
                }
                html.push('<li class="nav-item"><a href="javascript:;" class="nav-link" onclick="openSubsystem(\'' + tabName + '\',\'' + flink+ menuId + '\')"><h5><i class="fa fa-desktop"></i><span class="title" style="margin-left:10px;">' + tabName + '</span></h5></a></li>');
            }

        }
        $('#onlinework').click(function () {
            openSubsystem(onlineName,onlineLink+ onlineId);
        });
        $('#systemMenus').html(html.join(''));
        if (length == 1 &&  sysMenus[0].menuName != null &&  sysMenus[0].menuName.indexOf("系统管理") == -1 ){
            $("#header_bookmarks_bar").css("display", "none");
        	 // document.getElementById("header_bookmarks_bar").style.display="none"; bugfixed by sunny [document.getElementById("header_bookmarks_bar") can be null]
        }
    }else{
        $('#systemMenus').html('');
        $("#header_bookmarks_bar").css("display", "none");
        // document.getElementById("header_bookmarks_bar").style.display="none";
    }
}

function changeLanguage(){
    var text = $('#lang').text();
    var location = window.location.href;
    if(text == 'English'){
        location = location.replace("&en=en","")+'&en=en';
        $('#lang').text('Chinese');
    }else{
        location = location.replace("&en=en","");
        $('#lang').text('English');
    }
    window.location.href = location;
}

function collepseWhenMenuEmpty() {
    if ($(".page-sidebar-menu>li").size() == 0) {
        $(".icon-logout").click();
    }
}

$(function () {
    // modified by sunny re calculate page-content-wrapper height
    // modified end
    if(en == 'en'){
        $('#lang').text('Chinese');
    }else{
        $('#lang').text('English');
    }

    var type=null;
    $('#onlinework').hide();
    if(isSystem=="Y"){
        typr = "system"
        $('#tabs').addtabs({contextmenu:true});
        Addtabs.add({
            id:'home',
            title:'首页',
            url:contextPath+'/portal/simple/simple-firstPageAction!show.action?isSystem='+isSystem,
            close:false
        });
    }else if(isProjectAudit=="Y"){
        type="projectAudit";
        //$('.top-menu').width($('.page-top').width()-$('.page-logo').width()-40);
        $('#tabs').addtabs({contextmenu:true});
        Addtabs.add({
            id:'home',
            title:'首页',
            url:contextPath+'/portal/simple/simple-firstPageAction!show.action?isProjectAudit='+isProjectAudit,
            close:false
        });
    }else if(isRisk=="Y"){
        type="risk";
        //$('.top-menu').width($('.page-top').width()-$('.page-logo').width()-40);
        $('#tabs').addtabs({contextmenu:true});
        Addtabs.add({
            id:'home',
            title:'首页',
            url:contextPath+'/portal/simple/simple-firstPageAction!show.action?isRisk='+isRisk,
            close:false
        });
    }else if(isInterCtrl=="Y"){
        type="interCtrl";
        //$('.top-menu').width($('.page-top').width()-$('.page-logo').width()-40);
        $('#tabs').addtabs({contextmenu:true});
        Addtabs.add({
            id:'home',
            title:'首页',
            url:contextPath+'/portal/simple/simple-firstPageAction!show.action?isInterCtrl='+isInterCtrl,
            close:false
        });
    }else if(isDecision=="Y"){
        type="decision";
        //$('.top-menu').width($('.page-top').width()-$('.page-logo').width()-40);
        $('#tabs').addtabs({contextmenu:true});
        Addtabs.add({
            id:'home',
            title:'首页',
            url:contextPath+'/portal/simple/simple-firstPageAction!show.action?isDecision='+isDecision,
            close:false
        });
    }else{
        $('#onlinework').show();
       /* $('#onlinework').qtip({
            content:{
                text:'在线作业系统'
            },
            show:true,
            style:{
                classes:'qtip-blue qtip-rounded'
            }
        });*/
        type="auditSystem";
        $('#tabs').addtabs({contextmenu:true});
        Addtabs.add({
            id:'home',
            title:en ? 'Homepage':'首页',
            url:contextPath+'/portal/simple/simple-firstPageAction!show.action?en='+en,
            close:false
        });
    }
    var resize = function() {
        $(".page-content-wrapper").height($(window).height() - 75);
        $('.page-sidebar-menu').css('margin', 0);
        $('.page-sidebar-menu').height($('.page-content-wrapper').height() - 17);
        //$('.tab-content').height($('.page-content-wrapper').height()-$('.nav-tabs').height());
        $('.tab-content').height($('.page-content-wrapper').height() - $('.nav-tabs').height());
    };
    $(window).resize(resize);
    $('.sidebar-toggler').on('click',function(e){
       if($(this).hasClass('icon-logout')){
           $(this).removeClass('icon-logout');
           $(this).addClass('icon-login');
           $(this).attr('title','展开菜单');
       }else if($(this).hasClass('icon-login')){
           $(this).removeClass('icon-login');
           $(this).addClass('icon-logout');
           $(this).attr('title','收起菜单');
       }
    });

    systemMenus();
    reminder(hasReminder,type);
    innerMsg();
    bookMarks();
    collepseWhenMenuEmpty();
    resize();
    $('#new_tabs a:first').tab('show');
});