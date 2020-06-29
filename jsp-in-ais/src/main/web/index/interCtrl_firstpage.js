/**
 * Created by pengjin on 2017/5/10.
 */
var projectAuditFirstPage = function(){

    return {
        todoTaskTable: function () {
            var tBody = $("#todoTaskTable").find("tbody");
            tBody.html('');
            $.getJSON(contextPath+'/portal/simple/getPendingTask.action?type=interCtrl', {'random':Math.random()}, function (json) {
                	
            	if (json.rows.length > 0) {

                    for (var index in json.rows) {
                        var obj = json.rows[index];
                        //新建一行
                        var newTr = $("<tr></tr>");
                        if(index % 2 == 1){
                        	newTr.addClass('datagrid-row-alt');
                        }
                        newTr.css('border-bottom','1px solid #e6e6e6');
                        //新建节点
                        var nameTd = $("<td class='longTD' style='color:#666;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;' title='"+obj.formNameDetail+"'></td>");
                        var userTd = $("<td class='longTD' style='color:#666;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;'></td>");
                        var timeTd = $("<td class='longTD' style='color:#666;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;'></td>");
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
                }else{
                	tBody.append('<tr><td colspan=3><h3 style="text-align:center;">您没有要处理的事项</h3></td></tr>');
                }
            });
        },
        myProjectTable: function () {
            var tBody = $("#myProjectTable").find("tbody");
            tBody.html('');
            $.getJSON(contextPath+'/intctet/evaProject/evaPlan/myProject.action', {'random':Math.random()}, function (data) {
                var planList =data.planList;
                if (planList.length > 0) {
                    for (var index in planList) {
                        var obj = planList[index];
     
                        //新建一行
                        var newTr = $("<tr></tr>");
                        if(index % 2 == 1){
                        	newTr.addClass('datagrid-row-alt');
                        }
                        newTr.css('border-bottom','1px solid #e6e6e6');
                        
                        //新建节点
                        var proNameTd = $("<td class='longTD' style='color:#666;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;' title='"+obj.epName+"'></td>");
                        var memberTd = $("<td class='longTD' style='color:#666;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;' title=''></td>");
                        var stageTd = $("<td style='color:#666;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;'></td>");
                        //新建超链接
                        var stage = "";
                        if(obj.prepareClosed=="0"){
                            stage = "<a href=\"javascript:void(0);\" style=\"font: bolder;\"onclick=\"openTarget('"+obj.formId+"','prepare');\">准备</a>";
                        }else if(obj.actualizeClosed=="0"){
                            stage = "<a href=\"javascript:void(0);\" style=\"font: bolder;\" onclick=\"openTarget('"+obj.formId+"','actualize');\">实施</a> | <a href=\"javascript:void(0);\" style=\"font: bolder;\" onclick=\"openTarget('"+obj.formId+"','report');\">报告</a>";
                        }else if(obj.archivesClosed=="0"){
                            stage = "<a href=\"javascript:void(0);\" style=\"font: bolder;\" onclick=\"openTarget('"+obj.formId+"','archives');\">归档</a>";
                        }else if(obj.reworkClosed == null || obj.reworkClosed == "0"){
                            stage = "<a href=\"javascript:void(0);\" style=\"font: bolder;\" onclick=\"openTarget('"+obj.formId+"','rework');\">整改</a>";
                        }
                        if(stage){
                            proNameTd.text(obj.epName ? obj.epName : "");
                            memberTd.text(obj.curUserRole ? obj.curUserRole : "");
                            stageTd.append(stage);
                            newTr.append(proNameTd);
                            newTr.append(memberTd);
                            newTr.append(stageTd);
                            tBody.append(newTr);
                        }
                    }
                }else{
                	tBody.append('<tr><td colspan=3><h3 style="text-align:center;">您没有要处理的项目</h3></td></tr>');
                }
            });
        },
        evaluatedUnitTable: function () {
            var tBody = $("#evaluatedUnitTable").find("tbody");
            tBody.html('');
            $.getJSON(contextPath+'/intctet/proManage/listAuditObject.action', {'random':Math.random()}, function (data) {
                var auditObjectList= data.auditObjectList;
                if (auditObjectList.length > 0) {

                    for (var index in auditObjectList) {
                        var obj = auditObjectList[index];
                        //新建一行
                        var newTr = $("<tr></tr>");
                        if(index % 2 == 1){
                        	newTr.addClass('datagrid-row-alt');
                        }
                        newTr.css('border-bottom','1px solid #e6e6e6');
                        //新建节点
                        var nameTd = $("<td class='longTD' style='color:#666;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;' title='"+obj.epName+"'></td>");
                        var deptTd = $("<td class='longTD' style='color:#666;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;' title='"+obj.evaOrgan+"'></td>");
                        var operationTd = $("<td style='color:#666;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;'></td>");
                        //新建超链接
                        var operation = $("<a href='javascript:;' onclick=\"parent.goMenu('被评价单位整改反馈','"+contextPath+"/intctet/proManage/auditDeptTabFile.action?project_id="+obj.formId+"&wpd_stagecode=rework','2')\">处理</a>");


                        nameTd.text(obj.epName);
                        deptTd.text(obj.evaOrgan);
                        operationTd.append(operation);

                        newTr.append(nameTd);
                        newTr.append(deptTd);
                        newTr.append(operationTd);
                        tBody.append(newTr);
                    }
                }else{
                	tBody.append('<tr><td colspan=3><h3 style="text-align:center;">您没有要处理的整改反馈</h3></td></tr>');
                }
            });
        }
    }
}();
/* 项目阶段入口 */
function openTarget(formId,status){
	
    var udswin = window.open(
        contextPath+'/intctet/evaProject/evaPlan/projectIndexInter.action?crudId='
        + formId + '&stage=' + status, '',
        'height='+window.screen.availHeight+'px, width='+window.screen.availWidth+'px, fullscreen=yes, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
    udswin.moveTo(0, 0);
    udswin.resizeTo(window.screen.availWidth,window.screen.availHeight);
    var topwindowArray = top.window.opener.windowArray;
    if(topwindowArray){
    	topwindowArray.push(udswin);
    }
    
    
    
}
$(document).ready(function(){

    projectAuditFirstPage.todoTaskTable();
    projectAuditFirstPage.myProjectTable();
    projectAuditFirstPage.evaluatedUnitTable();
    /*
    $('#toDo .portlet-title a[id="toDo_reload"]').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        projectAuditFirstPage.todoTaskTable();
    });


    $('#myProject .portlet-title a[id="myProject_reload"]').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        projectAuditFirstPage.myProjectTable();
    });
    $('#evaluatedUnit .portlet-title a[id="unit_reload"]').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        projectAuditFirstPage.evaluatedUnitTable();
    });
    */
    $('#task_more').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        parent.addTab('tabs','待办事项','pending',contextPath+'/bpm/taskinstance/pending4V6.action',true);
    });
    $('#myProjects_more').click(function(e){
    	e.preventDefault();
    	e.stopPropagation();
    	parent.addTab('tabs','我的项目','myProject',contextPath+'/intctet/evaProject/evaPlan/initEvaPlanPage.action?view=true',true);
    });
    $('#evaluatedUnit_more').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        parent.addTab('tabs','被评价单位整改反馈','evaluatedUnit',contextPath+'/intctet/proManage/listAllForAuditObject.action',true);
    });
});