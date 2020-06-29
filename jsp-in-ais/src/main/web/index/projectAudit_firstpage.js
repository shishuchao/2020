/**
 * Created by xujun on 2017/2/15.
 */
var projectAuditFirstPage = function(){

    return {
    	toDoTable: function () {
            var tBody = $("#toDoTable").find("tbody");
            tBody.html('');
            $.getJSON(contextPath+'/ea/audAccount/showToDo.action?fromtodo=true', {'random':Math.random()}, function (data) {
                var spaList = data.spatList;
                if (spaList.length>0) {
                    for (var index in spaList) {
                        var obj = spaList[index];
                        //新建一行
                        var newTr = $("<tr></tr>");
                        //新建节点
                        var proNameTd = $("<td class='longTD' style='color:#666' title='"+obj.audProjectName+"【"+obj.apName+"】'></td>");
                        if(obj.type=="account"){
                            var typeTd = $("<td class='longTD' style='color:#666' title='项目台账'></td>");
                        }else{
                            var typeTd = $("<td class='longTD' style='color:#666' title='审计结论'></td>");
                        }
                        var currentUserTd = $("<td class='longTD' style='color:#666' title='"+obj.currentUser+"'></td>");
                        var operationTd = $("<td></td>");
                        var operation = "", winUrl = "", winTitle = "";
                        if(obj.type=="account"){
                            //operation = $("<a href='javascript:;' onclick=\"parent.goMenu('台账处理','"+contextPath+"/ea/audAccount/initPage.action?fromtodo=true&oldSaid="+obj.said+"&apId="+obj.apId+"','2')\">处理</a>");
                            winUrl = contextPath+"/ea/audAccount/initPage.action?fromtodo=true&oldSaid="+obj.said+"&apId="+obj.apId;
                            winTitle = obj.audProjectName+"【"+obj.apName+"】台账处理";
                        }else{
                            //operation = $("<a href='javascript:;' onclick=\"parent.goMenu('审计报告处理','"+contextPath+"/ea/audAccount/initClusionPage.action?fromtodo=true&oldSaid="+obj.said+"&apId="+obj.apId+"','2')\">处理</a>");
                            winUrl = contextPath+"/ea/audAccount/initClusionPage.action?fromtodo=true&oldSaid="+obj.said+"&apId="+obj.apId;
                            winTitle = obj.audProjectName+"【"+obj.apName+"】审计结论处理";
                        }
                        
                        operation = $("<a href='javascript:void(0);'>处理</a>")
                        .data("winUrl", winUrl).data("winTitle", winTitle).bind('click', function(){
                    		new parent.aud$createTopDialog({
                    			"title":$(this).data("winTitle"),
                    			"url"  :$(this).data("winUrl")
                    		}).open();
                    	});

                        proNameTd.text(obj.audProjectName);
                        if(obj.type=="account"){
                            typeTd.text("项目台账");
                        }else{
                            typeTd.text("审计结论");
                        }
                        currentUserTd.text(obj.currentUser);
                        operationTd.append(operation);

                        newTr.append(proNameTd);
                        newTr.append(typeTd);
                        newTr.append(currentUserTd);
                        newTr.append(operationTd);
                        tBody.append(newTr);
                    }
                }
            });
        },
        myProjectTable: function () {
            var tBody = $("#myProjectTable").find("tbody");
            tBody.html('');
            $.getJSON(contextPath+'/ea/dvAudProject/myProject.action?fromtodo=true', {'random':Math.random()}, function (data) {
                var apList =data.apList;
                if (apList.length > 0) {
                    for (var index in apList) {
                        var obj = apList[index];
                        if(obj['apStatusCode'] == '4') continue;
                        //新建一行
                        var newTr = $("<tr></tr>");
                        //新建节点
                        var proNameTd = $("<td class='longTD' style='color:#666' title='"+obj.audProjectName+"【"+obj.eaProjectName+"】'></td>");
                        if(obj.memberIds==null){
                            var typeTd = $("<td class='longTD' style='color:#666'></td>");
                        }else{
                            var typeTd = $("<td class='longTD' style='color:#666' title='"+obj.audType+"'></td>");
                        }
                        var memberTd = $("<td class='longTD' style='color:#666' title='"+obj.memberNames+"'></td>");
                        var stageTd = $("<td></td>");
                        //新建超链接
                        var stage = "";
                        var apStatusCode = obj.apStatusCode;
                        var winTitle = "", winUrl = contextPath+"/ea/dvAudProject/showFrame.action?apId="+obj.apId;
                        if(apStatusCode=="1"){
                            //stage = $("<a href='javascript:;' onclick=\"parent.goMenu('项目送审','"+contextPath+"/ea/dvAudProject/initPage.action?apId="+obj.apId+"','2')\">项目送审</a>");
                        	winTitle = "项目送审";
                        	//winUrl = contextPath+"/ea/dvAudProject/showFrame.action?apId="+obj.apId;
                        }else if(apStatusCode=="2"){
                            //stage = $("<a href='javascript:;' onclick=\"parent.goMenu('项目受理','"+contextPath+"/ea/dvAudProject/acceptAp.action?apId=" +obj.apId+"','2')\">项目受理</a>");
                        	winTitle = "项目受理";
                        	//winUrl = contextPath+"/ea/dvAudProject/showFrame.action?apId="+obj.apId;
                        }else if(apStatusCode=="3"){
                            //stage = $("<a href='javascript:;' onclick=\"parent.goMenu('项目实施','"+contextPath+"/ea/dvAudProject/showFrame.action?apId="+obj.apId+"','2')\">项目实施</a>");
                        	winTitle = "项目实施";
                        	//winUrl = contextPath+"/ea/dvAudProject/showFrame.action?apId="+obj.apId;
                        }
                    	stage = $("<a href='javascript:void(0);'>"+winTitle+"</a>").data("url", winUrl).bind('click', function(){
                    		new parent.aud$createTopDialog({
                    			"title":winTitle,
                    			"url"  :$(this).data("url")
                    		}).open();
                    	});
                        proNameTd.text(obj.audProjectName);
                        typeTd.text(obj.audType);
                        if(obj.memberIds==null){
                            memberTd.text("");
                        }else{
                            memberTd.text(obj.memberNames);
                        }
                        stageTd.append(stage);

                        newTr.append(proNameTd);
                        newTr.append(typeTd);
                        newTr.append(memberTd);
                        newTr.append(stageTd);
                        tBody.append(newTr);
                    }
                }
            });
        }
    }
}();

$(document).ready(function(){

    projectAuditFirstPage.toDoTable();
    projectAuditFirstPage.myProjectTable();

    $('#toDo .portlet-title a[id="toDo_reload"]').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        projectAuditFirstPage.toDoTable();
    });
    $('#toDo .portlet-title a[id="toDo_more"]').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        parent.addTab('tabs','待办事项','toDo',contextPath+'/ea/audAccount/initToDoPage.action',true);
    });

    $('#myProject .portlet-title a[id="myProject_reload"]').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        projectAuditFirstPage.myProjectTable();
    });
    $('#myProject .portlet-title a[id="myProject_more"]').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        parent.addTab('tabs','我的项目','myProject',contextPath+'/ea/dvAudProject/initPage.action?myProject=true',true);
    });
});