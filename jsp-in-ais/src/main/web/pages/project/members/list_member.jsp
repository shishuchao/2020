<%@page import="ais.sysparam.util.SysParamUtil"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目成员列表2</title>
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	</head>
	<body>
		<s:hidden name="projectFormId" />
		<div align="center" style="height: 800px">
			<table id=trtrtr></table>
		</div>
		<div id="planName"  title="人员信息"  style="overflow:hidden;padding:0px">
	            <iframe id="employeeInfoView" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
	  	</div>
	  	<div id="planNameDetail"  title="人员状态"  style="overflow:hidden;padding:0px">
	            <iframe id="lookAtDetail" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
	  	</div>
	  	
		<script type="text/javascript">
			$(function(){
				$('#trtrtr').datagrid({
					url : "<%=request.getContextPath()%>/project/members/listMembers.action?projectFormId=${projectFormId}&querySource=grid&t="+new Date().getTime(),
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					pageSize: 20,
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns:true,
					idField:'proMemberId',	
					border:false,
					singleSelect:true,
					remoteSort: false,
					columns:[[
						{field:'userName',title:'项目成员',halign:'center',align:'left',sortable:true},     
						{field:'groupTypeName',title:'分组类型',halign:'center',align:'left',sortable:true},
						{field:'groupName',title:'分组名称',halign:'center',align:'left',sortable:true},
						{field:'roleName',title:'项目角色',halign:'center',align:'left',sortable:true},
						{field:'belongToUnitName',title:'所属单位',width:300,halign:'center',align:'left',sortable:true,
							formatter:function(value,row,index){
								if(row.isOutSystem=='Y') return '外部审计人员';
								return row.belongToUnitName;
							}
						},{field:'proMemberId',title:'查看',halign:'center',align:'center',
							formatter:function(value,row,index){
								var s='';
								if(row.isOutSystem!='Y') {
								<%
									if (ais.sysparam.util.SysParamUtil.getSysParam("ais.prepare.employee.link") == null
										|| ais.sysparam.util.SysParamUtil.getSysParam("ais.prepare.employee.link").equals("Y")) {
								%>
										s +=  '<a href=\"javascript:void(0)\" onclick=\"employeeInfoView(\''+row.userId+'\');\">人员信息</a>&nbsp;';
								<%
									}
								%>
										s +=  '<a href=\"javascript:void(0)\" onclick=\"lookAtDetail(\''+row.userId+'\');\">人员状态</a>&nbsp;';
										return s;
								}
							}
						}
					]]
				}); 
			});
			function employeeInfoView(id){
				var trackUrl = "${contextPath}/mng/employee/employeeInfoView.action?ul="+id;
				$('#employeeInfoView').attr("src",trackUrl);
	            $('#planName').window('open');
			}
			function lookAtDetail(id){
				var trackUrl = "${contextPath}/mng/examproject/members/audProjectMembersInfo/lookAtDetail.action?ul="+id;
				$('#lookAtDetail').attr("src",trackUrl);
	            $('#planNameDetail').window('open');
			}
			$('#planName').window({
	            width:1000, 
	            height:500,  
	            modal:true,
	            collapsible:false,
	            maximizable:true,
	            minimizable:false,
	            closed:true,
	            maximized:true
	        });
			$('#planNameDetail').window({
	            width:1000, 
	            height:500,  
	            modal:true,
	            collapsible:false,
	            maximizable:true,
	            minimizable:false,
	            closed:true,
	            maximized:true
	        });
			
		</script>
	</body>
</html>