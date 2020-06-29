<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>修改任务办理人</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
		<script type="text/javascript">
			
			/*
			*	 选择节点处理人
			*/
			function selectActor(){
				showPopWin('${pageContext.request.contextPath}/pages/system/search/mutiselect.jsp?url=${pageContext.request.contextPath}/pages/system/userindex.jsp&paraname=actorName&paraid=actorId',600,350);
			}
			
			/**
			*	提交任务
			*/
			function okOnClick(){
				var actorName = document.getElementById('actorName').value;
				var actorId = document.getElementById('actorId').value;
				if(actorName == '' || actorId == ''){
					showMessage1('请选择下一步处理人！');
				}else {
					top.$.messager.confirm('确认','确认要人工干预流程节点办理人吗?',function(r){
						if(r){
							var opener = window.dialogArguments;
							opener.editTaskActorSubmit(actorId, actorName);
							window.close();
						}
					});
				}
			}
			
		</script>
	</head>
	<body class="easyui-layout">
	<div region="center">
		<fieldset style="border: 1px solid #C0C0C0;">
			<legend>
				&nbsp;跳转到...&nbsp;
			</legend>
			办理人:
			<s:buttonText2 id="actorName"
						   name="actorName" cssStyle="width:80%"
						   hiddenId="actorId" hiddenName="actorId"
						   doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?org=local',
								title:'选择办理人',
								singleSelect:true,
								defaultDeptId:'1',
								type:'treeAndUser'
							})"
						   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
						   doubleCssStyle="cursor:pointer;border:0"
						   readonly="true" />
			<div style="text-align: right;margin-right: 50px;margin-top: 10px;">
				<a class="easyui-linkbutton" iconCls="icon-ok" onclick="okOnClick()">确定</a>
				<a class="easyui-linkbutton" iconCls="icon-cancel" onclick="window.close()">取消</a>
			</div>
		</fieldset>
	</div>
	</body>
</html>
