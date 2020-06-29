<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>授权结果查看-列表</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
<script type="text/javascript">
	$(function(){
		$('#showSelfRoles').datagrid({
			url : "<%=request.getContextPath()%>/system/authRoleAction!showSelfRoles.action?querySource=grid&companyId=<%=request.getParameter("companyId")%>",
			method:'post',
			showFooter:false,
			rownumbers:true,
			pagination:true,
			striped:true,
			autoRowHeight:false,
			fit: true,
			fitColumns:true,
			border:false,
			singleSelect:true,
			pageSize:20,
			remoteSort: false,
			columns:[[  
				{field:'fname',
					title:'名称',
					halign:'center',
					align:'left',
					width:'40%',
					sortable:true
				},
				{field:'fscopename',
					title:'角色类型',
					width:'15%', 
					align:'center', 
					sortable:true
				},
				{field:'fnote',
					title:'备注',
					width:'25%',
					align:'center', 
					sortable:true
				},
				{field:'operate',
					title:'操作',
					width:'80px', 
					align:'center', 
					sortable:true,
					formatter:function(value,row,rowIndex){
						return '<a href=\"javascript:void(0)\" onclick=\"authRoleDetailsShow(\''+row.froleid+'\',\''+row.fscopecode+'\');\">详细信息</a>';
					}
				}
			]]   
		});
	});
	function authRoleDetailsShow(froleid,fscopecode){
		var url = "<%=request.getContextPath()%>/system/authRoleDetails.action?authRole.froleid="+froleid+"&authRole.fscopecode="+fscopecode+"&companyId=<%=request.getParameter("companyId")%>";
		top.addTab('tabs','授权结果查看-详细信息', 'authRoleDetails_tab', url, true);
		/*
		$('#authRoleDetails_ifr').attr('src',url);
		$('#authRoleDetails_div').window({
			width:document.documentElement.clientWidth, 
			height:document.documentElement.clientHeight,  
			modal:true,
			collapsible:false,
			maximizable:true,
			minimizable:false,
			closed:false    
		});*/
	}
</script>

</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" fit='true' border='0'>
	<div region="center" border='0'>
		<table id="showSelfRoles"></table>
	</div>
	<div id="authRoleDetails_div" title="详细信息" style="overflow:hidden;padding:0px">
		<iframe id="authRoleDetails_ifr" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
	</div>
</body>
</html>