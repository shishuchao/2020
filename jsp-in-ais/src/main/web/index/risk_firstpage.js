/**
 * Created by pengjin on 2017/5/15.
 */
var projectAuditFirstPage = function(){

    return {
        todoTaskTable: function () {
            var tBody = $("#todoTaskTable").find("tbody");
            tBody.html('');
            $.getJSON(contextPath+'/portal/simple/getPendingTask.action?type=risk', {'random':Math.random()}, function (json) {
                if (json.rows.length > 0) {
                    for (var index in json.rows) {
                        var obj = json.rows[index];
                        //新建一行
                        var newTr = $("<tr></tr>");
                        //新建节点
                        var nameTd = $("<td class='longTD' title='"+obj.formNameDetail+"'></td>");
                        var userTd = $("<td></td>");
                        var timeTd = $("<td></td>");
                        //新建超链接
                        var nameA = $("<a href='javascript:;' onclick=\"parent.goMenu('待办事项处理','"+contextPath+ obj.editUrl+"&flag=yes&todoback=1&project_id="+obj.project_id+"&code="+obj.plan_code+"','1')\"></a>");

                        userTd.text(obj.fromActorName);
                        timeTd.text(obj.create);
                        nameA.text(obj.formNameDetail);
                        nameTd.append(nameA);

                        newTr.append(nameTd);
                        newTr.append(userTd);
                        newTr.append(timeTd);
                        tBody.append(newTr);
                    }
                }
            });
        },
        myProjectTable: function () {
            var tBody = $("#myProjectTable").find("tbody");
            tBody.html('');
            $.getJSON(contextPath+'/riskManagement/management/riskCollect/myTask.action', {'random':Math.random()}, function (data) {
                var initList =data.initList;
                if (initList.length > 0) {
                    for (var index in initList) {
                        var obj = initList[index];
                        //新建一行
                        var newTr = $("<tr></tr>");
                        //新建节点
                        var proNameTd = $("<td class='longTD' style='color:#666' title='"+obj.taskName+"'></td>");
                        var initUnitTd = $("<td class='longTD' style='color:#666' title='"+obj.initiateUnitName+"'></td>");
                        var initPersonTd = $("<td class='longTD' style='color:#666' title='"+obj.initiatePersonName+"'></td>");

                        var stageTd = $("<td></td>");
                        //新建超链接
                        var stage;
                        var finished;
                        $.ajax({
                            url:'/ais/riskManagement/management/riskRegister/isFinished.action',
                            type:'POST',
                            async:false,
                            data:{'formId':obj.formId},
                            success:function(data) {
                                finished = data;
                            }
                        });
                        if(finished == '1') {
                            stage = $("<a href='javascript:;' onclick=\"parent.goMenu('查看','"+contextPath+"/riskManagement/management/riskCollect/viewFdInfos.action?formId="+obj.formId+"','2')\">查看</a>");
                        }else{
                            stage = $("<a href='javascript:;' onclick=\"parent.goMenu('收集任务实施处理','"+contextPath+"/riskManagement/management/riskRegister/edit.action?rctFormId=" + obj.formId + '&rctTaskName=' + obj.taskName+"','1')\">处理</a>");
                        }
                       /* var currenttUser = data.currentUser;
                         var deptId = data.deptId;
                         //当前用户是发起人&&当前部门不是接收部门
                         if(currenttUser == obj.initiatePerson&&obj.acceptingDep.indexOf(deptId)==-1&&obj.status=='0'){
                         stage = $("<a href='javascript:;' onclick=\"parent.goMenu('收集任务发起处理','"+contextPath+"/riskManagement/management/riskCollect/edit.action?crudId="+obj.formId+"','1')\">处理</a>");
                         }else if(currenttUser != obj.initiatePerson&&obj.acceptingDep.indexOf(deptId)>=0&&obj.status=='0'){
                         stage = $("<a href='javascript:;' onclick=\"parent.goMenu('收集任务实施处理','"+contextPath+"/riskManagement/management/riskRegister/edit.action?rctFormId=" + obj.formId + '&rctTaskName=' + obj.taskName+"','1')\">处理</a>");
                         }else if(currenttUser == obj.initiatePerson&&obj.acceptingDep.indexOf(deptId)>=0&&obj.status=='0') {
                         stage = $("<a href='javascript:;' onclick=\"parent.goMenu('收集任务发起处理','" + contextPath + "/riskManagement/management/riskCollect/edit.action?crudId=" + obj.formId + "','1')\">处理</a>");
                         }else if(currenttUser == obj.initiatePerson&&obj.acceptingDep.indexOf(deptId)>=0&&obj.status=='1'){

                         }else{
                         stage = $("<a href='javascript:;' onclick=\"parent.goMenu('查看','"+contextPath+"/riskManagement/management/riskCollect/viewFdInfos.action?formId="+obj.formId+"','2')\">查看</a>");
                         }*/

                        proNameTd.text(obj.taskName);
                        initUnitTd.text(obj.initiateUnitName);
                        initPersonTd.text(obj.initiatePersonName);
                        stageTd.append(stage);

                        newTr.append(proNameTd);
                        newTr.append(initUnitTd);
                        newTr.append(initPersonTd);
                        newTr.append(stageTd);
                        tBody.append(newTr);
                    }
                }
            });
        },
        evaluateTaskTable: function () {
            var tBody = $("#evaluateTaskTable").find("tbody");
            tBody.html('');
            $.getJSON(contextPath+'/riskManagement/management/riskEvaluate/evaluateTask.action', {'random':Math.random()}, function (data) {
                var evaList =data.evaList;
                if (evaList.length > 0) {
                    for (var index in evaList) {
                        var obj = evaList[index];
                        //新建一行
                        var newTr = $("<tr></tr>");
                        //新建节点
                        var proNameTd = $("<td class='longTD' style='color:#666' title='"+obj.taskName+"'></td>");
                        var startTd = $("<td class='longTD' style='color:#666' title='"+obj.evaluateStartTime+"'></td>");
                        var endTd = $("<td class='longTD' style='color:#666' title='"+obj.evaluateEndTime+"'></td>");
                        var stageTd = $("<td></td>");
                        //新建超链接
                        var stage;
                        if(obj.status !=3){
                            stage = $("<a href='javascript:;' onclick=\"parent.goMenu('评估任务实施','"+contextPath+"/riskManagement/management/riskImplement/riskEvaluateTaskDetail.action?id="+obj.formId+"','2')\">评估</a>");
                        }else{
                            stage = $("<a href='javascript:;' onclick=\"parent.goMenu('评估任务实施','"+contextPath+"/riskManagement/management/riskImplement/riskEvaluateTaskDetail.action?view=Y&id="+obj.formId+"','2')\">查看</a>");
                        }

                        proNameTd.text(obj.taskName);
                        startTd.text(obj.evaluateStartTime);
                        endTd.text(obj.evaluateEndTime);
                        stageTd.append(stage);

                        newTr.append(proNameTd);
                        newTr.append(startTd);
                        newTr.append(endTd);
                        newTr.append(stageTd);
                        tBody.append(newTr);
                    }
                }
            });
        },
        answerTaskTable: function () {
            var tBody = $("#answerTaskTable").find("tbody");
            tBody.html('');
            $.getJSON(contextPath+'/riskManagement/management/riskEvaluate/answerTask.action', {'random':Math.random()}, function (data) {
                var answerList =data.answerList;
                if (answerList.length > 0) {
                    for (var index in answerList) {
                        var obj = answerList[index];
                        //新建一行
                        var newTr = $("<tr></tr>");
                        //新建节点
                        var proNameTd = $("<td class='longTD' style='color:#666' title='"+obj.riskItemName+"'></td>");
                        var ownDeptTd = $("<td class='longTD' style='color:#666' title='"+obj.affiliatedDeptName+"'></td>");
                        var responsDeptTd = $("<td class='longTD' style='color:#666' title='"+obj.responsibilityDepName+"'></td>");
                        if(obj.riskLevel==null){
                            var riskLevelTd = $("<td class='longTD' style='color:#666' title=''></td>");
                        }else{
                            var riskLevelTd = $("<td class='longTD' style='color:#666' title='"+obj.riskLevel+"'></td>");
                        }
                        if(obj.prioritySort==null){
                            var prioritySortTd = $("<td class='longTD' style='color:#666' title=''></td>");
                        }else{
                            var prioritySortTd = $("<td class='longTD' style='color:#666' title='"+obj.prioritySort+"'></td>");
                        }
                        var stageTd = $("<td></td>");
                        //新建超链接
                        var stage;
                        var handled;
                        $.ajax({
                            url:contextPath+'/riskManagement/management/riskHandle/isHandled.action',
                            type:'POST',
                            data:{'id': obj.id},
                            async:false,
                            success:function(data) {
                                handled = data;
                                if(handled != '1'){
                                    stage = $("<a href='javascript:;' onclick=\"parent.goMenu('应对','"+contextPath+"/riskManagement/management/riskHandle/edit.action?id="+obj.id+"','2')\">应对</a>");
                                    proNameTd.text(obj.riskItemName);
                                    ownDeptTd.text(obj.affiliatedDeptName);
                                    responsDeptTd.text(obj.responsibilityDepName);
                                    if(obj.riskLevel==null){
                                        riskLevelTd.text();
                                    }else{
                                        riskLevelTd.text(obj.riskLevel);
                                    }
                                    if(obj.prioritySort==null){
                                        prioritySortTd.text();
                                    }else{
                                        prioritySortTd.text(obj.prioritySort);
                                    }
                                    stageTd.append(stage);

                                    newTr.append(proNameTd);
                                    newTr.append(ownDeptTd);
                                    newTr.append(responsDeptTd);
                                    newTr.append(riskLevelTd);
                                    newTr.append(prioritySortTd);
                                    newTr.append(stageTd);
                                    tBody.append(newTr);
                                }
                            }
                        });
                    }
                }
            });
        },
    }
}();
function handle(url) {
    aud$openNewTab('处理', url, true);
}

function view(url) {
    aud$openNewTab('查看', url, true);
}


$(document).ready(function(){

    projectAuditFirstPage.todoTaskTable();
    projectAuditFirstPage.myProjectTable();
    projectAuditFirstPage.evaluateTaskTable();
    projectAuditFirstPage.answerTaskTable();

    $('#toDo .portlet-title a[id="toDo_reload"]').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        projectAuditFirstPage.todoTaskTable();
    });
    $('#toDo .portlet-title a[id="toDo_more"]').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        parent.addTab('tabs','待办事项','pending',contextPath+'/bpm/taskinstance/pending4V6.action?type=risk',true);
    });

    $('#myProject .portlet-title a[id="myProject_reload"]').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        projectAuditFirstPage.myProjectTable();
    });
    $('#myProject .portlet-title a[id="myProject_more"]').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        parent.addTab('tabs','风险收集任务','myProject',contextPath+'/riskManagement/management/riskCollect/listRegisterRisks.action',true);
    });
    $('#evaluateTask .portlet-title a[id="evaluateTask_reload"]').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        projectAuditFirstPage.evaluateTaskTable();
    });
    $('#evaluateTask .portlet-title a[id="evaluateTask_more"]').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        parent.addTab('tabs','风险评估任务','myProject',contextPath+'/riskManagement/management/riskEvaluate/listRiskEvaluates.action',true);
    });
    $('#answerTask .portlet-title a[id="answerTask_reload"]').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        projectAuditFirstPage.answerTaskTable();
    });
    $('#answerTask .portlet-title a[id="answerTask_more"]').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        parent.addTab('tabs','风险应对','myProject',contextPath+'/riskManagement/management/riskHandle/listHandleProjects.action',true);
    });
});