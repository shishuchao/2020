<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
<title>台账信息</title>
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>   
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
$(function(){
	var apId = "${apId}";
	var isView = "${view}" == "true" || "${view}" == true ? true : false;
	var parentTabId ="${param.parentTabId}";
	if(parentTabId!=''){
		var curTabIdac = aud$getActiveTabId();//当前台账选项卡的id
	}
	
	var gridTableId = "mTable";
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'SpAccount',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'said',
        order :'desc',
        sort  :'doTime',
	    whereSql:"type='account' and apId='${apId}'",
	    myToolbar:['export', 'reload'],
        // 表格控件dataGrid配置参数; 必填
        gridJson:{	
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
    		columns:[[
    			{field:'state',title:'状态', width:'90px',align:'center',   halign:'center',  sortable:true, show:'false',
					formatter:function(value){
						//0-待处理，1-已审批, 2-已完成
						var rtval = "";
						if(value == "0"){
							rtval = "待处理";
						}else if(value == "1"){
							rtval = "已处理";
						}else if(value == "2"){
							rtval = "<font color='green'>已完成</font>";
						}
						return rtval;
					}
    			},
                {field:'currentUser',title:'处理人', width:'100px',align:'center',   halign:'center',  sortable:true},
                {field:'deptName',   title:'处理人所在部门', width:'15%',align:'center',   halign:'center',  sortable:true},
                {field:'spcontent',  title:'处理意见', width:'25%',align:'center', halign:'center',  sortable:true},
                {field:'doTime',     title:'处理时间', width:'180px',align:'center',   halign:'center',  sortable:true},
                {field:'nextPeople', title:'下一步处理人', width:'100px',align:'center',   halign:'center',  sortable:true}
			]]
        }
    });
	window.spAccountInfo = g1;
	
	
    //把frame页面窗口ID赋给里面iframe，用于iframe里面的页面打开新窗口后，访问iframe
	setTimeout(function(){
		var topDialogTargetId = parent.aud$getActiveDialogTargetId();
		if(topDialogTargetId){
			$('body').attr("topDialogTargetId", topDialogTargetId);	
			var ifmWin = $('#b_ifr')[0].contentWindow;
			ifmWin.$('body').attr("topDialogTargetId", topDialogTargetId);			
		}
	},100)
})
</script>
</head>
<body  class="easyui-layout" fit="true" border='0'>
	<div region="center" border="false"  border='0' split="true">
		<div id="tt" class="easyui-tabs" fit="true" border='0'>
			<%
		        List list= (List)request.getAttribute("proledgerList");
		        for(int i=0;i<list.size();i++){
		            String name= (String)list.get(i);	
					{
					%>
					<div title='<%=name%>'>
						<iframe id="b_ifr" name="b_ifr" src="${contextPath}/ea/audAccount/createLedgerTable.action?fromtodo=${fromtodo}&view=${view}&oldSaid=${oldSaid}&view=process&apId=${apId}&permission=full&isView=${view}&index=<%=i%>&parentTabId=${param.parentTabId}" frameborder="0" width="100%" height="99%" ></iframe>
					</div>
					<%
					}
		        }
		    %>				
		</div>
	</div>
	<div region='south' id="approveInfo"  title="审批信息" border='0' split="true" style="height:250px;overflow:hidden;">
		<table id="mTable"></table>
	</div>
	<!-- 引入公共文件 -->
 	<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
 	<input type='hidden' id="dvAccountState" value="${accountState}"/>
</body>
</html>