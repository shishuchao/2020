<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>临时账号列表</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/checkboxSelected.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/checkboxsoperation.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div region="center">
			<table id="tempAccountList"></table>
		</div>	
	<script type="text/javascript">
	
	function againNotice(projectId,sysAccountId){
		$.ajax({
			url:'${contextPath}/auditAccessoryList/sendMessage.action?projectId=${projectId}&sysAccountId='+sysAccountId,
			type:'post',
			data:{'type':'1'},
			async:false,
			success:function(data) {
				if(data == '1') {
					showMessage1('发送成功');
					$('#tempAccountList').datagrid('reload');
				} else {
					showMessage1('发送失败');
				}
			}
		});
	}
	
	 function delAcccessory(projectId,sysAccountId,loginnameValue){
		$.messager.confirm('确认', '您确认删除吗？', function(r){
			if (!r) return;
			$.post("${contextPath}/project/feedback/online/existIssuesObject.action",{project_id:projectId,loginname:loginnameValue}, function(returnValue2) {
				if(returnValue2=='no'){
			 		url = '${contextPath}/auditAccessoryList/deleteSysAccount.action?projectId=' + projectId + '&sysAccountId=' + sysAccountId;
			 		$.messager.show({title:'消息',msg:'删除账号成功！'});
			 		window.location.href=url;				
				}else if(returnValue2=='yes'){
					$.messager.show({title:'消息',msg:'此账号已存在征求反馈意见流程中，不允许删除！'});
				}
			});	
	 	});
	 }

			 function deleteAllSysAccount(){
				$.messager.confirm('确认', '您确认删除全部临时账号吗？', function(r){
					if (!r) return;
			 		document.location='${contextPath}/auditAccessoryList/deleteAllSysAccount.action?projectId=${projectId}';
			 	});
			}
	
			$(function(){
				// 初始化生成表格
				$('#tempAccountList').datagrid({
					url : "<%=request.getContextPath()%>/auditAccessoryList/listSysAccount.action?projectId=${projectId}&querySource=grid",
					method:'post',
					showFooter:false,
					rownumbers:true,
					striped:true,
					autoRowHeight:false,
					autoSizeColumn:true,
					fit: true,
					fitColumns:false,
					idField:'id',	
					border:false,
					singleSelect:true,
					remoteSort: false,
					toolbar:[/* {
							id:'newTempAcccount',
							text:'新增',
							isconCls:'icon-add',
							handler:function(){
								newTempAcccountFun();
								//window.location.href="${contextPath}/auditAccessoryList/editSysAccount.action?projectId=${projectId}";
							}
						},
						{
							id:'delAll',
							text:'全部删除',
							iconCls:'icon-delete',
							handler:function(){
								deleteAllSysAccount();
							}
						}  */
					],
					columns:[[  
						{field:'userCode',
								title:'编码',
								halign:'center',align:'left', 
								sortable:true
						},
						{field:'name',
							title:'姓名',
							sortable:true, 
							halign:'center',align:'left'
						},
						{field:'loginname',
							 title:'登录账号',
							 halign:'center', align:'left',
							 sortable:true
						},
						{field:'audit_object_name',
							 title:'被审计单位',
							 halign:'center', align:'left',width:300,
							 sortable:true
						},
						{field:'email',
							title:'电子邮件',
							sortable:true, 
							halign:'center',align:'left'
						},
						{field:'createName',
							 title:'创建人',
							 halign:'center',align:'left', 
							 sortable:true
						},
						{field:'sendMsgTime',
							 title:'通知次数',
							 align:'center',align:'right', 
							 sortable:true
						},										
						{field:'operate',
							 title:'操作',
							 align:'center', 
							 sortable:false,
							 formatter:function(value,row,index){
							 	/* return '<a href=\"javascript:void(0)\" onclick=\"delAcccessory(\'${projectId}\',\''+row.id+'\',\''+row.loginname+'\');\">删除</a>|'
							 		+  '<a href=\"javascript:void(0)\" onclick=\"modifyAcccessory(\'${projectId}\',\''+row.id+'\');\">修改</a>|'
							 		+  '<a href=\"javascript:void(0)\" onclick=\"againNotice(\'${projectId}\',\''+row.id+'\');\">重新发送通知</a>'; */
								 return '<a href=\"javascript:void(0)\" onclick=\"againNotice(\'${projectId}\',\''+row.id+'\');\">发送通知</a>';
							 }
						}
					]]   
				}); 
				
			//初始化增加窗口
		    $('#tempAccDiv').window({
				width:700, 
				height:250,  
				modal:true,
				collapsible:false,
				maximizable:false,
				minimizable:false,
				closed:true    
		    });   				    
		    
		});	
		
			function newTempAcccountFun(){
				var myurl = "${contextPath}/auditAccessoryList/editSysAccount.action?projectId=${projectId}";
				$("#myFrame").attr("src",myurl);
				$('#tempAccDiv').window('open');
				//window.location.href="${contextPath}/auditAccessoryList/editSysAccount.action?projectId=${projectId}";
			}		
			
			function editTempAcccountFun(){
				var myurl = "${contextPath}/auditAccessoryList/editSysAccount.action?projectId=${projectId}";
				$("#myFrame").attr("src",myurl);
				$('#tempAccDiv').window('open');
				//window.location.href="${contextPath}/auditAccessoryList/editSysAccount.action?projectId=${projectId}";
			}				
			
			function modifyAcccessory(projectId,sysAccountId){
				var myurl = '${contextPath}/auditAccessoryList/editSysAccount.action?projectId=${projectId}&sysAccountId='+sysAccountId;
				$("#myFrame").attr("src",myurl);
				$('#tempAccDiv').window('open');
			}			
			
			function closeWinUI(){
				$('#tempAccountList').datagrid('load');
				$('#tempAccDiv').window('close');
				//window.location.href="${contextPath}/auditAccessoryList/editSysAccount.action?projectId=${projectId}";
			}	
			
			function reloadWinUI(){
				$('#tempAccountList').datagrid('load');
			}								
	 
	</script>	
	      <div id="tempAccDiv" title="临时账号" style='overflow:hidden;padding:0px;'> 	  		
				<iframe id="myFrame" name="myFrame" title="临时账号" src="${contextPath}/auditAccessoryList/editSysAccount.action?projectId=${projectId}" width="100%" height="100%" frameborder="0"><!-- main --></iframe>				
	      </div>				
	</body>
</html>
