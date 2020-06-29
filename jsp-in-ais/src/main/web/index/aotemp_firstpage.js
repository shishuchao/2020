/**
 * Created by xujun on 2017/2/15.
 */
var AotempFirstPage = function(){
    return {
        msgReminderTable: function () {
            var msgReminder = $("#msgReminder");
            var maxRows = 5;
            msgReminder.empty();
            $.getJSON(contextPath+'/msg/innerMsg_list.action?readFlag=2', {'random':Math.random(),'querySource':'grid'}, function (json) {
                if (json && json.rows && json.rows.length > 0) {
                    $('#msgTitleTip').text(json.rows.length);
                    var titleRow = '<li style="background:#e3eefd;font-weight:bold;">' +
                        '<div class="task-title row" >' +
                        '<div class="col-xs-6"><span style="text-align: center;" class="task-title-sp headRow">' +
                        '消息标题</span></div>' +
                        '<div class="col-xs-2"><span style="text-align: center;" class="task-title-sp headRow">' +
                        '发送人</span></div>' +
                        '<div class="col-xs-4"><span style="text-align: center;" class="task-title-sp headRow">' +
                        '发送时间</span></div>' +
                        '</div></li>';
                    msgReminder.append(titleRow);
                    for (var index in json.rows) {
                        if(index > maxRows) break;
                        var obj = json.rows[index];
                        var f = index % 2 == 1 ;
                        var t = obj.createTime;
                        if(t){
                            t = t.replace('T',' ');
                        }
                        var li = (f ? "<li class='datagrid-row-alt'>" : '<li>') +
                            '<div class="task-title row" style="cursor: pointer;color:#0088cc" onclick="parent.goMenu(\'消息提醒\',\''+contextPath+'/msg/innerMsg_view.action?innerMsg.msgId='+obj.msgId+'\',\'1\')">' +
                            '<div class="col-xs-6"><span class="task-title-sp dataRow" title="'+obj.subject+'">' +
                            obj.subject +
                            '</span></div>' +
                            '<div class="col-xs-2"><span class="task-title-sp dataRow">'+obj.fromUserName+'</span></div>' +
                            '<div class="col-xs-4"><span class="task-title-sp dataRow">'+t+'</span></div>' +
                            '</div>' +
                            '</li>';
                        msgReminder.append(li);
                    }
                }else{
                    $('#msgTitleTip').text("0");
                    var titleRow = '<li style="background:#e3eefd;font-weight:bold;">' +
                        '<div class="task-title row" >' +
                        '<div class="col-xs-6"><span class="task-title-sp dataRow" style="text-align: center;">' +
                        '消息标题</span></div>' +
                        '<div class="col-xs-2"><span class="task-title-sp dataRow" style="text-align: center;">' +
                        '发送人</span></div>' +
                        '<div class="col-xs-4"><span class="task-title-sp dataRow" style="text-align: center;">' +
                        '发送时间</span></div>' +
                        '</div></li>';
                    msgReminder.append(titleRow);
                    msgReminder.append('<h3 style="text-align:center;">您没有消息</h3>');
                }
            });
        },
        specialData: function () {
            var dataList = $("#specialList");
            dataList.empty();
            $.getJSON(contextPath+'/riskManagement/keyRiskMonitor/reportKeyRiskMonitor/listReportKeyRiskMonitor.action',
                {'random':Math.random(),'rows':5,'querySource':'grid','reportKeyRiskMonitor.applicant':floginname,'reportKeyRiskMonitor.status':'010'}, function (json) {
                if (json && json.rows && json.rows.length > 0) {
                    var titleRow = '<li style="padding:5px;background:#e3eefd;font-weight:bold;">' +
                        '<div class="task-title row" >' +
                        '<div class="col-xs-6" style="text-align: center;"><span class="task-title-sp headRow">' +
                        '任务名称</span></div>' +
                        '<div class="col-xs-4" style="text-align: center;"><span class="task-title-sp headRow">' +
                        '发起人</span></div>' +
                        '<div class="col-xs-2" style="text-align: center;"><span class="task-title-sp headRow">' +
                        '操作</span></div>' +
                        '</div></li>';
                    dataList.append(titleRow);
                    for (var index in json.rows) {
                        var row = json.rows[index];
                        var f = index % 2 == 1 ;
                        var li = (f ? "<li class='datagrid-row-alt'>" : '<li >') +
                            '<div class="task-title row" >' +
                            '<div class="col-xs-6"><span class="task-title-sp dataRow" title="'+row.start_name+'">' +
                            row.start_name + '</span></div>'+
                            '<div class="col-xs-4"><span class="task-title-sp dataRow" title="'+(row.impPersonName ? row.impPersonName:'')+'">' +
                            (row.impPersonName ? row.impPersonName:'') + '</span></div>'+
                            "<div class='col-xs-2' onclick=\"parent.goMenu('专项填报处理','"+contextPath+"/riskManagement/keyRiskMonitor/reportKeyRiskMonitor/edit.action?crudId="+row.formId+"&from=1&time='+Math.random(),'2')\">" +
                            "<span class='task-title-sp dataRow' style='cursor: pointer;color: #0088cc;'>处理</span></div>"+
                            '</div></li>';
                        dataList.append(li);
                    }
                }else{
                    dataList.append('<div style="text-align:center;"><h3>暂时没有专项填报任务</h3></div>');
                }
            });
        },feedbackTable: function () {
            var dataList = $("#feedbackTable");
            dataList.empty();
            $.getJSON(contextPath+'/project/rework/listAllForAuditObject.action?querySource=grid&proYear=', {'random':Math.random(),'rows':5}, function (json) {
                if (json && json.rows && json.rows.length > 0) {
                    var titleRow = '<li style="padding:5px;background:#e3eefd;font-weight:bold;">' +
                        '<div class="task-title row" >' +
                        '<div class="col-xs-6" style="text-align: center;"><span class="task-title-sp headRow">' +
                        '项目名称</span></div>' +
                        '<div class="col-xs-4" style="text-align: center;"><span class="task-title-sp headRow">' +
                        '审计单位</span></div>' +
                        '<div class="col-xs-2" style="text-align: center;"><span class="task-title-sp headRow">' +
                        '操作</span></div>' +
                        '</div></li>';
                    dataList.append(titleRow);
                    for (var index in json.rows) {
                        var row = json.rows[index];
                        var f = index % 2 == 1 ;
                        var li = (f ? "<li class='datagrid-row-alt'>" : '<li >') +
                            '<div class="task-title row" >' +
                            '<div class="col-xs-6"><span class="task-title-sp dataRow" title="'+row.project_name+'">' +
                            row.project_name + '</span></div>'+
                            '<div class="col-xs-4"><span class="task-title-sp dataRow" title="'+row.audit_dept_name+'">' +
                            row.audit_dept_name + '</span></div>'+
                            "<div class='col-xs-2' onclick=\"parent.goMenu('问题整改反馈','"+contextPath+"/workprogram/auditDeptTabFile.action?projectid="+row.formId+"&wpd_stagecode=rework','222')\">" +
                            "<span class='task-title-sp dataRow' style='cursor: pointer;color: #0088cc;'>处理</span></div>"+
                            '</div></li>';
                        dataList.append(li);
                    }
                }else{
                    dataList.append('<div style="text-align:center;"><h3>暂时没有待反馈问题</h3></div>');
                }
            });
        },
        uploadDataTable: function () {
	        var dataList = $("#uploadDataTable");
            dataList.empty();;
	        $.getJSON(contextPath+'/project/rework/listAllForAuditObjectUp.action?querySource=grid', {'random':Math.random(),'rows':5}, function (json) {
	            if (json && json.rows && json.rows.length > 0) {
                    var titleRow = '<li style="padding:5px;background:#e3eefd;font-weight:bold;">' +
                        '<div class="task-title row" >' +
                        '<div class="col-xs-6" style="text-align: center;"><span class="task-title-sp headRow">' +
                        '项目名称</span></div>' +
                        '<div class="col-xs-4" style="text-align: center;"><span class="task-title-sp headRow">' +
                        '审计单位</span></div>' +
                        '<div class="col-xs-2" style="text-align: center;"><span class="task-title-sp headRow">' +
                        '操作</span></div>' +
                        '</div></li>';
                    dataList.append(titleRow);
	                for (var index in json.rows) {
	                    var row = json.rows[index];
                        var f = index % 2 == 1 ;
                        var li = (f ? "<li class='datagrid-row-alt'>" : '<li >') +
                            '<div class="task-title row" >' +
                            '<div class="col-xs-6"><span class="task-title-sp dataRow" title="'+row.project_name+'">' +
                            row.project_name + '</span></div>'+
                            '<div class="col-xs-4"><span class="task-title-sp dataRow" title="'+row.audit_dept_name+'">' +
                            row.audit_dept_name + '</span></div>'+
                            "<div class='col-xs-2' onclick=\"parent.goMenu('项目资料上传','"+contextPath+"/auditAccessoryList/list.action?view=process&cruProId="+row.formId+"&pro_type="+row.pro_type+"&pro_child_type="+row.pro_type_child+"','3')\">" +
                            "<span class='task-title-sp dataRow' style='cursor: pointer;color: #0088cc;'>上传</span></div>"+
                            '</div></li>';
                        dataList.append(li);
	                }
	            }else{
                    dataList.append('<div style="text-align:center;"><h3>暂时没有项目资料需要上传</h3></div>');
                }
	        });
	    },
        createMeeting:function () {
            // $.ajax({
            //     url:contextPath+'/meeting/login',
            //     dataType:'text',
            //     success:function (retUrl) {
            //         if(retUrl != null&&retUrl != ''){
            //             $('#loginFrame').attr('src',retUrl);
            //             $.ajax({
            //                 url:contextPath+'/meeting/createMeeting',
            //                 dataType:'text',
            //                 success:function (url) {
            //                     if(url != null&&url != ''){
            //                         parent.addTab('tabs','远程沟通','meeting',url,true);
            //                     }
            //                 }
            //             });
            //         }
            //     }
            // });
            $.ajax({
                url:contextPath+'/zhumu/createMeeting',
                dataType:'json',
                success:function (data) {
                    if(data != null){
                        window.open(data.start_url);
                    }
                }
            });
        }
    }
}();

$(document).ready(function(){
    AotempFirstPage.msgReminderTable();
    AotempFirstPage.specialData();
    AotempFirstPage.feedbackTable();
    AotempFirstPage.uploadDataTable();

    $('#msgTitleTip').parent().bind('click', function() {
        AotempFirstPage.msgReminderTable();
    });

    $('#msg_more').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        parent.addTab('tabs','消息提醒','pending',contextPath+'/msg/innerMsg_list.action?readFlag=-1',true);
    });

    $('#special_more').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        parent.addTab('tabs','专项填报处理','special',contextPath+'/riskManagement/keyRiskMonitor/reportKeyRiskMonitor/listReportKeyRiskMonitor.action?from=1&reportKeyRiskMonitor.applicant='+floginname,true);
    });
    //
    // $('#feedback .portlet-title a[id="feedback_reload"]').click(function(e){
    //     e.preventDefault();
    //     e.stopPropagation();
    //     AotempFirstPage.feedbackTable();
    // });
    $('#feedback .portlet-title a[id="feedback_more"]').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        parent.addTab('tabs','问题整改反馈','feedback',contextPath+'/project/rework/listAllForAuditObject.action',true);
    });
    // $('#uploadData .portlet-title a[id="uploadData_reload"]').click(function(e){
    //     e.preventDefault();
    //     e.stopPropagation();
    //     AotempFirstPage.uploadDataTable();
    // });
    $('#uploadData .portlet-title a[id="uploadData_more"]').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        parent.addTab('tabs','项目资料上传','uploadData',contextPath+'/project/rework/listAllForAuditObjectUp.action',true);
    });

});