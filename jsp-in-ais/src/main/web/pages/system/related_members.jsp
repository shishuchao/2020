<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>涉及人员table</title>

<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
<script type="text/javascript">
	$(function(){
		$('#authRoleDetails2').datagrid({
			url : "<%=request.getContextPath()%>/system/authRoleDetails2.action?querySource=grid&p_froleid=<%=request.getParameter("p_froleid")%>",
			method:'post',
			showFooter:false,
			rownumbers:true,
			pagination:true,
			striped:true,
			autoRowHeight:false,
			fit: true,
			border:false,
			fitColumns:false,
			border:false,
			singleSelect:true,
			pageSize:20,
			remoteSort: false,
			columns:[[  
				{field:'floginname',
					title:'登录名称',
					width:'20%',
					halign:'center', 
					align:'left',
					sortable:true
				},
				{field:'fname',
					title:'真实姓名',
					width:'20%',
					halign:'center', 
					align:'left', 
					sortable:true
				},
				{field:'fdepname',
					title:'公司/部门',
					width:'45%',
					halign:'center', 
					align:'left', 
					sortable:true
				}
			]]   
		});
	});
</script>

</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" fit='true' border='0'>
	<div region="center" border='0'>
		<table id="authRoleDetails2"></table>
	</div>
</body>
</html>