/**
 * Created by xujun on 2017/1/23.
 */

/**
 * 获取子菜单
 * @param pid
 */
function childMenu(pid) {
    if($('#submenu-'+pid).attr('fetched')!='true'){
        $.getJSON(contextPath+'/portal/simple/simple-firstPageAction!childMenu.action',{'fparentId':pid,'showInOnline':'Y'},
            function(json) {
                if(json.menus.length > 0){
                    var html = '';
                    for(var i = 0;i < json.menus.length;i++){
                        var obj = json.menus[i];
                        if(obj.ffundisplay.indexOf('预警') > -1){
                            html = html + '<li class="nav-item"><a href="javascript:;" class="nav-link nav-toggle" onclick="goMenu(\'' + obj.ffundisplay + '\',\'' + obj.flink + '\',\'' + obj.ffunid + '\',\'' + obj.fparentid + '\',this)">' + obj.ffundisplay + '</span><span class="arrow"></span></a>';
                        }else {
                            if (obj.isHaveChild == 'Y') {
                                html = html + '<li class="nav-item"><a href="javascript:;" class="nav-link nav-toggle" onmouseover="childMenu(\'' + obj.ffunid + '\')">' + obj.ffundisplay + '<span class="arrow"></span></a>' +
                                    '<ul class="sub-menu" id="submenu-' + obj.ffunid + '"></ul></li>';
                            } else {
                                /*根据查询出的菜单id匹配当前菜单id*/
                                var idList = json.marksList;
                                if (idList.indexOf(obj.ffunid) == -1) {
                                    html = html + '<li class="nav-item"><a href="javascript:;" class="nav-link"><span class="title" onclick="goMenu(\'' + obj.ffundisplay + '\',\'' + obj.flink + '\',\'' + obj.ffunid + '\',\'' + obj.fparentid + '\',this)">' + obj.ffundisplay + '</span><span id="heart-' + obj.ffunid + '" style="float: right;color: #d1b455;" class="glyphicon glyphicon-star-empty" onclick="menu_marks(\'' + obj.ffundisplay + '\',\'' + obj.flink + '\',\'' + obj.ffunid + '\',this)"></span></a></li>';//glyphicon glyphicon-heart-empty
                                } else {
                                    html = html + '<li class="nav-item"><a href="javascript:;" class="nav-link"><span class="title" onclick="goMenu(\'' + obj.ffundisplay + '\',\'' + obj.flink + '\',\'' + obj.ffunid + '\',\'' + obj.fparentid + '\',this)">' + obj.ffundisplay + '</span><span id="heart-' + obj.ffunid + '" style="float: right;color: #d1b455;" class="glyphicon glyphicon-star" onclick="menu_marks(\'' + obj.ffundisplay + '\',\'' + obj.flink + '\',\'' + obj.ffunid + '\',this)"></span></a></li>';
                                }
                            }
                        }
                    }
                    $('#submenu-'+pid).attr('fetched','true');
                    $('#submenu-'+pid).html(html);
                }
            });
    }
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
    if(tabName.indexOf('预警')>-1 && tabName.indexOf('指标预警区间') < 0 && tabName.indexOf('指标查看') < 0){
        var host = '<s:property value="@ais.project.ProjectSysParamUtil@getZXSJHostPort()" />';
        var queryString = encode64(encodeURI(",,,${user.floginname}"));
        var url ="http://"+host+"/login.jsp?p="+queryString;
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
        Layout.setSidebarMenuActiveLink('click',$(obj).parent('a'));
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
function reminder(has){
    if(has=='true'){
        $.ajax({
            url:contextPath+'/portal/simple/reminder.action?type=onlineSystem',
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
            }
        }
    });
}
/**
 * 菜单收藏
 */
function bookMarks(){
    $.ajax({
        url:contextPath+'/bookMarks.action?isOnline=Y',
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
            		html.push('<li class="nav-item"><a href="javascript:;" class="nav-link"><h5><span class="title" onclick="goMenu(\''+tabName+'\',\''+flink+'\',\''+tabId+'\',this)">'+tabName+'</span><span style="float: right;color:darkred;" class="fa fa-trash" onclick="removeMarks(\''+tabId+'\')"></span></h5></a></li>');
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
    var obj = $('#star-'+tabId);
    /*将菜单从我的收藏中移除*/
    $.ajax({
        url:contextPath+"/removeMarks.action",
        type:'POST',
        cache:false,
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


/* 用户注销 */
function logout(){
    top.$.messager.confirm('确认','您确定要注销系统登录吗？',function(r){
       if(r){
           if(window.opener && window.opener.open && !window.opener.closed)
                window.opener.closeAllWindow();
           else{
               window.location=contextPath+'/system/uSystemAction!loginOut.action';
           }
       }
    });
};
/* 新建消息 */
function sendF(){
	var url = contextPath+"/msg/innerMsg_edit.action?readFlag=3";
	//aud$openNewTab("新建消息", url,true);
    $('#innermsg_ifr').attr('src',url);
};
/* 查看所有页面默认选中第一个标签*/
$(function () {
    $('#new_tabs a:first').tab('show');
});


//跳转到非在线的功能，firstpage.jsp调用
var sname;
var slink;
var sid;
function goOther(formId,stage){
	if(stage == 'account'){
		sname = '项目台账';
		slink = '/ais/ledger/prjledger/projectLedgerNew/listTobeStarted.action';
		sid = '1021';
	}else if(stage == 'rework'){
		sname = '审计跟踪阶段';
		slink = '/ais/project/rework/listAll.action';
		sid = '1030';
	}else if(stage == 'archives'){
		sname = '项目归档';
		slink = '/ais/archives/pigeonhole/listTobeStarted.action?isUseTableName=noUse&projectId='+formId;
		sid = '1025';
	}
	addTab('tabs',sname,sid,slink,true);
}

$(function () {
    $('#tabs').addtabs({contextmenu:true});
    Addtabs.add({
        id:'home',
        title:'首页',
        url:contextPath+'/portal/simple/simple-firstPageAction!show.action?isOnline=Y',
        close:false
    });
    $('.page-sidebar-menu').css('margin',0);
    $('.page-sidebar-menu').height($('.page-content-wrapper').height()-20);
    $('.tab-content').height($('.page-content-wrapper').height()-$('.nav-tabs').height()-20);
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

    reminder(hasReminder);
    innerMsg();
    bookMarks();
    $('#new_tabs a:first').tab('show');
});