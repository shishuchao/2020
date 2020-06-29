<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>跳转到...</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/pages/bpm/designer/inc/webTab/webtab.css">
		<script language=jscript
			src="${pageContext.request.contextPath}/pages/bpm/designer/inc/function.js"></script>
		<script language=jscript
			src="${pageContext.request.contextPath}/pages/bpm/designer/inc/webTab/webTab.js"></script>
		<script language="jscript"
			src="${pageContext.request.contextPath}/pages/bpm/designer/inc/webflow.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/csswin/subModal.js"></script>
		<style>
			body {
			    font-size: 9pt;
			    background-color: buttonface;
			    scroll: no;
			    margin: 7px, 0px, 0px, 7px;
			    border: none;
			    overflow: hidden;
			
			}
			td {
			    font-size: 9pt;
			}
		</style>
		<script type="text/javascript">
			
			/**
			*	初始化窗口数据
			*/
			function iniWindow(){
				var opener = window.dialogArguments;
				   try{
				     var FlowXML = opener.document.all.FlowXML;
				     if(FlowXML.value!=''){
				         var xmlDoc = new ActiveXObject('MSXML2.DOMDocument');
				         xmlDoc.async = false;
				         xmlDoc.loadXML(FlowXML.value);
				         var xmlRoot = xmlDoc.documentElement;
				         var Nodes = xmlRoot.getElementsByTagName("Nodes").item(0);
				         var to = document.all.To;
				         for ( var i = 0;i < Nodes.childNodes.length;i++ ) {
				            Node = Nodes.childNodes.item(i);
				            var id = Node.getElementsByTagName("BaseProperties").item(0).getAttribute("id");
				            var text = Node.getElementsByTagName("BaseProperties").item(0).getAttribute("text");
				            if(id!='end' && id!='begin'){
				            	var oOption = document.createElement("OPTION");
			            	    to.options.add(oOption);
			            	    oOption.innerText = text;
			            	    oOption.value = text;
				            }
				         }
				     }else{
				         ('打开节点跳转对话框时出错！');
				         window.close();
				     }
				   }catch(e){
				   		alert('打开节点跳转对话框时出错！');
				   		window.close();
				   }
			}
			
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
				var toNode = document.getElementById('To').value;
				if(actorName == '' || actorId == ''){
					showMessage1('请选择下一步处理人！');
				}else {
					top.$.messager.confirm('确认','确认要人工干预流程节点吗?',function(r){
						if(r){
							var opener = window.dialogArguments;
							opener.jumpToNodeSubmit(toNode,actorId,actorName);
							window.close();
						}
					});
				}
			}
			$(function(){
				iniWindow();
			});
		</script>
	</head>
	<body class="easyui-layout">
	<div region="center">
		<fieldset style="border: 1px solid #C0C0C0;">
			<legend>
				&nbsp;跳转到...&nbsp;
			</legend>
			<div>
				目标节点：
				<select id="To" name="To"></select>
			</div>
			<div style="margin-top: 10px;">
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

			</div>
			<div style="text-align: right;margin-right: 50px;margin-top: 10px;">
				<a class="easyui-linkbutton" iconCls="icon-ok" onclick="okOnClick()">确定</a>
				<a class="easyui-linkbutton" iconCls="icon-cancel" onclick="window.close()">取消</a>
			</div>
		</fieldset>
	</div>
	</body>
</html>
