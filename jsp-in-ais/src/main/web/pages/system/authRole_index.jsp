<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>角色列表</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<%--	<STYLE type="text/css">
		.datagrid-row {
		  	height: 30px;
		}
		.datagrid-cell {
			height:10%;
			padding:1px;
		}
	</STYLE>--%>
	<SCRIPT type="text/javascript">
		function myGo(){
			document.getElementsByName("authRole.froleid")[0].value=0;
			var url = "${contextPath}/system/editAuthRole.action"
			showWinIf('editPage',url,'新增角色');
			//document.authForm.action="editAuthRole.action";
			//document.authForm.submit();
		}
		//对修改后的备注进行保存
		function save(id){	
			//获取输入域的值
			var value=$("input.datagrid-editable-input").val();				
			$.ajax({
				url:"${contextPath}/system/edit.action",
				type:"post",
				dataType:'json',
				data:{
					'id':id,
					'value':value,
					}				
			});
		}
		function doPermission(froleid,frolename){
			var url = "${contextPath}/system/authAuthorityAction!authRolePerSet.action?p_froleid="+froleid+"&p_frolename="+encodeURIComponent(frolename)
			showWinIf('editPage',url,'操作授权',750);

			//showPopWin("../system/authAuthorityAction!authRolePerSet.action?p_froleid="+froleid+"&p_frolename="+encodeURIComponent(frolename),700,750,'操作授权');
			//OpenNewWindow("../system/authAuthorityAction!authRolePerSet.action?p_froleid="+froleid+"&p_frolename="+encodeURIComponent(frolename),700,750,'操作授权');
		}
		function doDatePermission(roleId,name){
			var url = '/ais/system/authAuthorityAction!authRoleForData.action?p_froleid=888_'+roleId+'&url=/ais/system/allDataAuthModules.action';
			showWinIf('editPage',url,'数据授权',750);
			//OpenNewWindow('/ais/system/authAuthorityAction!authRoleForData.action?p_froleid=888_'+roleId+'&url=/ais/system/allDataAuthModules.action',700,750,'数据授权');
		}
		function doAdminMenu(roleId,name){
			var url = '/ais/system/authAuthorityAction!authForAdminMenu.action?p_froleid=888_'+roleId
				showWinIf('editPage',url,'权限授权');
			//OpenNewWindow('/ais/system/authAuthorityAction!authForAdminMenu.action?p_froleid=888_'+roleId,700,750,'权限授权');
		}
		function doCtrlRole(roleId,name){
			var url = '/ais/system/authAuthorityAction!authCtrlRoleSet.action?p_froleid='+roleId
			showWinIf('editPage',url,'可控角色设置',750,450);
			//OpenNewWindow('/ais/system/authAuthorityAction!authCtrlRoleSet.action?p_froleid='+roleId,600,600,'可控角色设置');
		}
		function doDelRole(idV,codeV){
			$.messager.confirm('确认','确定要删除角色吗?', function(flag){
				if(flag){
					document.getElementById("mypara1").value=idV;
					document.getElementById("mypara2").value=codeV;
					//改成token验证，需要表单提交
					hiddenTokenForm.submit();
					//reload();				
				}
			});
		}
		function clicka(rowIndex){
			$('#clicka'+rowIndex).click();
		}
		function authorizeById(obj,rowIndex,id,name){
			//var url = '<%=request.getContextPath()%>/pages/system/search/mutiselect4role.jsp?url=../morg/userindex4morg.jsp&paraName='+encodeURIComponent(name)+'&paraid='+id+'&p_issel=5'
			//showWinIf('editPage',url,'');
			//showPopWin('<%=request.getContextPath()%>/pages/system/search/mutiselect4role.jsp?url=../morg/userindex4morg.jsp&paraName='+encodeURIComponent(name)+'&paraid='+id+'&p_issel=5',720,570);
			$.ajax({
				url:'${pageContext.request.contextPath}/system/authAuthorityAction!role4users.action',
				type:'get',
				data:{
					'roleId':id,
					'source':'newauth'
				},
				dataType:'json',
				cache:false,
				async:false,
				success:function(json){
					$('#roleUserIds'+rowIndex).val(json.roleUserIds);
					$('#roleUserNames'+rowIndex).val(json.roleUserNames);
				}
			});
			showSysTree(obj,
					{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?org=local&p_item=1',
						title:name,
						defaultDeptId:'1', 
						type:'treeAndUser',
						onAfterSure:function(ele, dms,mcs,personnelCode,company,companyCode){
							saveRole4users(id,name,ele);
						}
					});
		}
		function saveRole4users(roleId,roleName,ele){
			$.ajax({
				url:'${pageContext.request.contextPath}/system/authAuthorityAction!saveRole4users.action',
				type:'post',
				cache:false,
				data:{
					'roleId':roleId,
					'roleName':roleName,
					'loginNames':String(ele)
				},
				success:function(data){
					if(data=='success'){
						showMessage1("用户授权成功!");
					}else{
						showMessage1("用户授权失败!");
					}
				}
			});
		}
		function reload(){
			$('#authRole').datagrid('reload');
			showMessage2('保存角色成功！');
		}
		
		$(function(){
			showWin('editPage','新增角色');			
			$('#authRole').datagrid({
				url:'${pageContext.request.contextPath}/system/listAuthRole.action?querySource=grid',
				showFooter:true,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit:true,
				pageSize: 20,
				fitColumns: true,
				border:false,
				singleSelect:true,
				remoteSort: true,
				//双击进行编辑，失去焦点触发保存事件
				onDblClickRow:function(rowIndex, field, value){
					$('#authRole').datagrid('beginEdit', rowIndex);
					var id =$('#authRole').datagrid('getSelected').froleid;
					var fnote = $('#authRole').datagrid('getSelected').fnote;
					$("input.datagrid-editable-input").val(fnote).bind("blur",function(evt){							
						save(id);
                        $('#authRole').datagrid('endEdit',rowIndex);                           
                    }).focus(); 
					},
				toolbar:[{
						id:'add',
						text:'新增',
						iconCls:'icon-add',
						handler:function(){
							myGo()
						}
					},'-',helpBtn
				],
				onLoadSuccess:function(){
					initHelpBtn();
				},
				columns:[[
					{field:'fname',
						title:'名称',
						width: 200,
						halign: 'center',
						align:'left', 
						sortable:true,
						formatter:function(value,row,rowIndex){
							return row.fname;
						}
					},	
					{field:'fscopename',
						title:'角色类型',
						width: 80,
						halign: 'center',
						align:'center', 
						sortable:true,
						formatter:function(value,row,rowIndex){
							return row.fscopename;
						}
					},
					{field:'fnote',
						title:'备注(双击该行进行修改)',
						width: 180,
						halign: 'center',
						align:'left', 
						sortable:true,
						//编辑器
						editor:{type:"text"},
						formatter:function(value,row,rowIndex){
							return row.fnote;
					   },
					},
					{field:'xxx',
						title:'操作',
						halign: 'center',
						width: 240,
						align:'center', 
						sortable:false,
						formatter:function(value,row,rowIndex){
							var btn = "<a href=\"javascript:void(0)\"  onclick=\"doPermission('"+row.froleid+"','"+row.fname+"')\">操作授权</a>" //权限设置
							if (row.fscopecode != 'mr') {
								btn += " | <a href=\"javascript:void(0)\"  onclick=\"doDatePermission('"+row.froleid+"','"+row.fname+"')\">数据授权</a>" //权限设置
							} 
							if (row.fscopecode=='wr') {
								btn += " | <a href=\"javascript:void(0)\"  onclick=\"doCtrlRole('"+row.froleid+"','"+row.fname+"')\">可控角色设置</a>"; //管理角色可控角色设置 
							}
							if (row.fscopecode!='mr') {
								btn += " | <div style=\"display:none;\"><input type=\"text\" id=\"roleUserNames"+rowIndex+"\" name=\"roleUserNames"+rowIndex+"\"/><input type=\"hidden\" id=\"roleUserIds"+rowIndex+"\" name=\"roleUserIds"+rowIndex+"\"/><a id=\"clicka"+rowIndex+"\" href=\"javascript:void(0)\"  onclick=\"authorizeById(this,'"+rowIndex+"','"+row.froleid+"','"+row.fname+"')\"></a></div><a href=\"javascript:void(0)\" onclick=\"clicka("+rowIndex+");\">用户授权</a>";
							}
							if (row.froleid=='1' || row.froleid=='2' || row.froleid=='3') {
								btn += " | <a href=\"javascript:void(0)\"  onclick=\"javascript:doDelRole('"+row.froleid+"','"+row.fscopecode+"');\" disabled=\"true\">删除</a>";
							} else {
								btn += " | <a href=\"javascript:void(0)\"  onclick=\"javascript:doDelRole('"+row.froleid+"','"+row.fscopecode+"');\">删除</a>";
							}
							return btn;
						}
					}
				]]
			});
		});
	</SCRIPT>
</head>

<body class="easyui-layout">
	<!-- <table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" width="100%" align="center">
		<tr class="listtablehead">
			<td colspan="5" align="left" class="edithead">
				<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/system/listAuthRole.action')"/>
			</td>
		</tr>
	</table>  
	-->
	<div>
		<s:form action="listAuthRole" namespace="/system" method="post" name="authForm">
			<s:hidden name="authRole.froleid" value="${authRole.froleid}"></s:hidden>
		</s:form>
	</div>
	<div region='center' style="width:100%;">
		<table id="authRole"></table>
	</div>
		<!-- 
		 -->
		${message}  
	<div id="editPage"></div>
	<div style="display:none;">
		<s:form action="delAuthRole" id="hiddenTokenForm" namespace="/system" method="post">
			<input type="hidden" name="authRole.froleid" id="mypara1"/>
			<input type="hidden" name="authRole.fscopecode" id="mypara2"/>
		</s:form>
	</div>
</body>
</html>