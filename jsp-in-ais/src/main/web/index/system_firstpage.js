/**
 * Created by xujun on 2017/2/15.
 */
var AotempFirstPage = function(){

    return {
    	onlineUserTable: function () {
            var tBody = $("#onlineUserTable").find("tbody");
            tBody.html('');
            $.getJSON(contextPath+'/heartbeat/list.action?querySource=grid', {'random':Math.random()}, function (json) {
                if (json.rows.length > 0) {
                    for (var index in json.rows) {
                        var obj = json.rows[index];
                        //新建一行
                        var newTr = $("<tr></tr>");
                        //新建节点
                        var orgNameTd = $("<td class='longTD' style='color:#666' title='"+obj.orgName+"'></td>");
                        var chinameTd = $("<td class='longTD' style='color:#666' title='"+obj.chiname+"'></td>");
                        var loginNameTd = $("<td class='longTD' style='color:#666' title='"+obj.loginName+"'></td>");
                        var ipTd = $("<td class='longTD' style='color:#666' title='"+obj.loginIp+"'></td>");

                        orgNameTd.text(obj.orgName);
                        chinameTd.text(obj.chiname);
                        loginNameTd.text(obj.loginName);
                        ipTd.text(obj.loginIp);

                        newTr.append(orgNameTd);
                        newTr.append(chinameTd);
                        newTr.append(loginNameTd);
                        newTr.append(ipTd);
                        tBody.append(newTr);
                    }
                }
            });
        },
        operationLogTable: function () {
            var tBody = $("#operationLogTable").find("tbody");
            tBody.html('');
            $.getJSON(contextPath+'/log/search.action?querySource=grid&exportLog=0&rowNumber=10', {'random':Math.random()}, function (json) {
                if (json.rows.length > 0) {

                    for (var index in json.rows) {
                        var obj = json.rows[index];
                        //新建一行
                        var newTr = $("<tr></tr>");
                        //新建节点
                        var orgNameTd = $("<td class='longTD' style='color:#666' title='"+obj.orgName+"'></td>");
                        var moduleTd = $("<td class='longTD' style='color:#666' title='"+obj.module+"'></td>");
                        var ipTd = $("<td class='longTD' style='color:#666' title='"+obj.ip+"'></td>");
                        var chinameTd = $("<td class='longTD' style='color:#666' title='"+obj.chiname+"'></td>");
                        var operationTd = $("<td></td>");
                        //新建超链接
                        var operation = $("<a href='javascript:;' onclick=\"parent.goMenu('查看详情','"+contextPath+"/log/view.action?logId="+obj.logId+"&onLine=','2')\">详情</a>");


                        orgNameTd.text(obj.orgName);
                        chinameTd.text(obj.chiname);
                        moduleTd.text(obj.module);
                        ipTd.text(obj.ip);
                        operationTd.append(operation);

                        newTr.append(orgNameTd);
                        newTr.append(chinameTd);
                        newTr.append(moduleTd);
                        newTr.append(ipTd);
                        newTr.append(operationTd);
                        tBody.append(newTr);
                    }
                }
            });
        }
    }
}();

$(document).ready(function(){

    AotempFirstPage.onlineUserTable();
    AotempFirstPage.operationLogTable();

    $('#onlineUser .portlet-title a[id="onlineUser_reload"]').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        AotempFirstPage.onlineUserTable();
    });
    $('#onlineUser .portlet-title a[id="onlineUser_more"]').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        parent.addTab('tabs','在线用户','onlineUser',contextPath+'/heartbeat/list.action',true);
    });

    $('#operationLog .portlet-title a[id="operationLog_reload"]').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        AotempFirstPage.operationLogTable();
    });
    $('#operationLog .portlet-title a[id="operationLog_more"]').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        parent.addTab('tabs','操作日志','operationLog',contextPath+'/log/list.action',true);
    });
});