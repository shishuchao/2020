<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="ais.resmngt.employee.model.EmployeeInfo"%><html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=5">
<title>信息查看</title>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
<script type="text/javascript"
	src="${contextPath}/resources/csswin/common.js"></script>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
<s:head theme="ajax"/>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<script type="text/javascript">
	function onBodyLoad(){
		<%if(request.getAttribute("employeeInfo")==null){%>
			alert("不存在该审计人员信息!");
		<%}%>
	}
	
		function viewDesc(project_id_value,loginname_value){
				$("#tId").empty();
				$.post("/ais/operate/taskExt/getTaskList.action",{project_id:project_id_value,userId:loginname_value},function(returnValue2) {
						var jsonstr = eval( "(" + returnValue2 + ")" )
						var buffer = "<tr class='listtablehead' class='flag'><td class='ListTableTr11' style='text-align:center'>审计事项</td><td class='ListTableTr11' style='text-align:center'>审计小组</td></tr>";
						if(null!=jsonstr && jsonstr.length>0){
							for(var i=0;i<jsonstr.length;i++){
								buffer = buffer +"<tr class='listtablehead' class='flag'><td class='ListTableTr22' style='text-align:center'>"+jsonstr[i].taskName+"</td><td class='ListTableTr22' style='text-align:center'>"+jsonstr[i].taskGroupAssignName+"</td></tr>";
							}
						}
						$("#tId").append(buffer);
						$('#sjsx').window('open');
					});			
		} 	
		$(function(){
		    $('#sjsx').window({
				width:600, 
				height:300,  
				modal:true,
				collapsible:false,
				maximizable:false,
				minimizable:false,
				closed:true    
		    });   		
		});   		
	
</script>
</head>
	<body topmargin=0 onload="onBodyLoad()" class="easyui-layout">
	<div region="center">
		<div class="easyui-tabs" fit="true" border="false">
			<div id='one' title='排程计划' style="overflow:hidden;">
				<iframe name="if1" src="${contextPath}/mng/examproject/members/audProjectMembersInfo/toPlanList.action?employeeInfo.sysAccounts=<s:property value="employeeInfo.sysAccounts"/>&employeeInfo.id=<s:property value="employeeInfo.id"/>&helper.freeStartDate=${helper.freeStartDate}&helper.freeEndDate=${helper.freeEndDate}&helper.fullStartDate=${helper.fullStartDate}&helper.fullEndDate=${helper.fullEndDate}"
									frameborder="0" scrolling="yes" style="width:100%;height:100%;"></iframe>
			</div>
			<div id='two' title='在审项目' style="overflow:hidden;">
				<iframe name="if1" src="${contextPath}/mng/examproject/members/audProjectMembersInfo/toProjectList.action?employeeInfo.sysAccounts=<s:property value="employeeInfo.sysAccounts"/>&employeeInfo.id=<s:property value="employeeInfo.id"/>&helper.freeStartDate=${helper.freeStartDate}&helper.freeEndDate=${helper.freeEndDate}&helper.fullStartDate=${helper.fullStartDate}&helper.fullEndDate=${helper.fullEndDate}"
									frameborder="0" scrolling="yes" style="width:100%;height:100%;"></iframe>
			</div>
			<div id='three' title='已审项目' style="overflow:hidden;">
				<iframe name="if1" src="${contextPath}/mng/examproject/members/audProjectMembersInfo/jobtoJoinAuditProjectHistoryList.action?employeeInfo.sysAccounts=<s:property value="employeeInfo.sysAccounts"/>&employeeInfo.id=<s:property value="employeeInfo.id"/>&helper.freeStartDate=${helper.freeStartDate}&helper.freeEndDate=${helper.freeEndDate}&helper.fullStartDate=${helper.fullStartDate}&helper.fullEndDate=${helper.fullEndDate}"
									frameborder="0" scrolling="yes" style="width:100%;height:100%;"></iframe>
			</div>
		</div>	
	</div>
	<!--查看审计事项-->
	<div id="sjsx" title="审计事项" style='overflow: auto; padding: 0px;'>
				<table class="ListTable" align="center" id="tId">
				</table>
		</div>		
	</body>
</html>
