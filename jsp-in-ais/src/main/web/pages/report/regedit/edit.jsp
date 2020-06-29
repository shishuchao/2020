<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link href="<%=request.getContextPath()%>/styles/main/ais.css"
			rel="stylesheet" type="text/css">

		<script type='text/javascript'
			src='${pageContext.request.contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/engine.js'></script>
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript"
			src="${contextPath}/pages/report/regedit/regedit.js"></script>
				<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>	
		<title></title>
		<script type="text/javascript">
			function openDialog()
			{
				var num=Math.random();
				var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
				window.showModalDialog('${contextPath}/commons/file/welcome.action?guid=${register.fileKey}&&param='+rnm+'&&isEdit=false&&deletePermission=<s:property value="true"/>',accelerys,'dialogWidth:700px;dialogHeight:450px;status:yes');
			}
			/*DWR2删除附件回传附件列表---LIHAIFENG 2007-12-20*/
			function deleteFile(fileId,guid,isDelete,isEdit,appType){
				var boolFlag=window.confirm("确认删除吗?");
				if(boolFlag==true){
					DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
					{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType},
					xxx);
					function xxx(data){document.getElementById("accelerys").innerHTML=data['accessoryList'];} 
				}
			}
			
			function edit(){
				window.location="regAction!edit.action?register.id=${register.id}";
			}
			function del(){
				window.location="regAction!del.action?register.id=${register.id}";
			}
			<s:if test="${flush}">
				function flushLeft(){
					window.parent.left.location.reload();
				}
				flushLeft();
			</s:if>
		</script>
	</head>
	<body>
		<center>
			<s:form action="regAction!save.action" namespace="/report/apply"
				method="post" theme="simple">
				<s:if test="${not empty tip }"><font size="4" color="red">${tip}</font></s:if>
				<s:hidden name="register.id" />
				<s:hidden name="register.fileKey" />
				<s:hidden name="register.regmanCode" />
				<s:hidden name="register.regman" />
				<s:hidden name="register.company" />
				<s:hidden name="register.companyId" />
				<s:hidden name="register.creatDate" />
				<s:hidden name="register.handleCls" />
				<table id="tt" cellpadding=0 cellspacing=1 border=0
					bgcolor="#409cce" class="ListTable">
					<tr>
						<td class="ListTableTr11">
							报表名称<FONT color=red>*</FONT>
						</td>
						<td class="ListTableTr22">
							<s:if test="${empty view}">
								<s:textfield name="register.name" />
							</s:if>
							<s:else>
							${register.name}
							</s:else>
						</td>
						<td class="ListTableTr11" nowrap="nowrap">
							所在位置<FONT color=red>*</FONT>
						</td>
						<td class="ListTableTr22">
							<s:if test="${empty view}">
								<s:textfield name="register.order" />
							</s:if>
							<s:else>
							${register.order}
							</s:else>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							数据源<FONT color=red>*</FONT>
						</td>
						<td class="ListTableTr22">
							<s:if test="${empty view}">
								<s:select list="#@java.util.LinkedHashMap@{'sql':'数据表','javabean':'数据集'}" name="register.dataSource" emptyOption="true" required="true"/>
							</s:if>
							<s:else>
								<s:if test="${register.dataSource=='sql'}">
									数据表
								</s:if><s:elseif test="${register.dataSource=='javabean'}">数据集</s:elseif>
							</s:else>
						</td>
						<td class="ListTableTr11" nowrap="nowrap">
							查询参数编码
						</td>
						<td class="ListTableTr22">
							<s:if test="${empty view}">
								<s:textfield name="register.searchCode" />
							</s:if>
							<s:else>
							${register.searchCode}
							</s:else>
						</td>
					</tr>
					<%-- 
					<tr>
						<td class="ListTableTr11">
							存储表名称
						</td>
						<td class="ListTableTr22">
							<s:if test="${empty view}">
								<s:textfield name="register.reportName" />
							</s:if>
							<s:else>
							${register.reportName}
							</s:else>
						</td>
						<td class="ListTableTr11">
							
						</td>
						<td class="ListTableTr22" >
							
						</td>
					</tr>
					--%><s:hidden name="register.reportName"/>
					<tr>
						<td class="ListTableTr11">
							描述
						</td>
						<td class="ListTableTr22" colspan="3">
							<s:if test="${empty view}">
								<s:textfield name="register.describe" />
							</s:if>
							<s:else>
							${register.describe}
							</s:else>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							<s:if test="${empty view}">
								<s:button onclick="openDialog()" value="上传zip包" id="editFileBtn"></s:button>
							</s:if>
							<s:else>
								<s:button onclick="openDialog()" value="上传zip包" disabled="true"></s:button>
							</s:else>
						</td>
						<td class="ListTableTr22" colspan="3">
							<div id="accelerys" align="center">
								<s:property escape="false" value="accessoryList" />
							</div>
						</td>
					</tr>
				</table>
				<s:if test="${empty view}">
					<s:submit value="保存" />
				</s:if>
				<s:else>
					<s:button onclick="edit()" value="编辑"></s:button>
					<s:if test="${not empty register.id}">
						<s:button onclick="del()" value="删除"></s:button>
					</s:if>
				</s:else>
			</s:form>
		</center>
	</body>
</html>