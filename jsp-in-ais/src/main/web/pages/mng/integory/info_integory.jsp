<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
		<head>
		<s:text id="title" name="'中介机构库'"></s:text>
		<title><s:property value="#title" />
		</title>

		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">

			
		<!-- dwr -->
		<script type='text/javascript'
			src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript">
					/*DWR显示、删除附件 */
			function Upload()
			{
				var num=Math.random();
				var rnm=Math.round(num*9000000000+1000000000);/*随机参数清除模态窗口缓存*/
				window.showModalDialog('${contextPath}/commons/file/welcome.action?guid=<s:property value="integoryinfoW.fjid"/>&&param='+rnm+'&&deletePermission=<s:property value="%{varMap.deletew_fileRead}"/>&&isEdit=<s:property value="%{varMap.editw_fileRead}"/>&&title='+encodeURI(encodeURI("中介机构信息附件上传")),accelerys,'dialogWidth:700px;dialogHeight:450px;status:yes');
			}
			/*DWR2删除附件回传附件列表*/
			function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
				var boolFlag=window.confirm("确认删除吗?");
				if(boolFlag==true)
				{
					DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
				{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
				xxx);
				function xxx(data){
				  	document.getElementById(guid).parentElement.innerHTML=data['accessoryList'];
				} 
				}
			}
		</script>
		
		
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/icon.css">
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		
	</head>
	<body class='easyui-tabs' fit='true'>

		 	<div id='info' title='基本信息' >
			<s:form action="/resmngt/integory/save_integoryinfo.action"
				namespace="/resmngt/integory">
				<s:hidden name="integoryinfoW.creatorname"
					value="${user.floginname}" />
				<s:hidden name="integoryinfoW.creatorid" value="${user.fcode }"></s:hidden>
				<s:hidden name="integoryinfoW.islogout" value="N"></s:hidden>
				<table id="tab1"  class="ListTable">
					<tr>
						<td width="23%" align="right" class="ListTableTr11">
							机构名称
						</td>
						<td class="ListTableTr22">
							<s:textfield name="integoryinfoW.unitname" cssStyle="width:100%"
								value="${integoryinfoW.unitname }" disabled="true"></s:textfield>
						</td>
						<td width="23%" align="right" class="ListTableTr11">
							所属审计单位
						</td>
						<td class="ListTableTr22">
							<s:textfield name="integoryinfoW.auditunitname"
								cssStyle="width:100%" disabled="true"></s:textfield>
						</td>
					</tr>
					<tr>
						<td width="23%" align="right" class="ListTableTr11">
							公司地址
						</td>
						<td class="ListTableTr22">
							<s:textfield name="integoryinfoW.address"
								cssStyle="width:100%" disabled="true"></s:textfield>
						</td>
						<td width="23%" align="right" class="ListTableTr11">
							邮政编码
						</td>
						<td class="ListTableTr22">
							<s:textfield name="integoryinfoW.post"
								cssStyle="width:100%" disabled="true"></s:textfield>
						</td>
					</tr>
					
					<tr>
						<td width="23%" align="right" class="ListTableTr11">
							联系电话
						</td>
						<td class="ListTableTr22">
							<s:textfield name="integoryinfoW.phone"
								cssStyle="width:100%" disabled="true"></s:textfield>
						</td>
						
						<td width="23%" align="right" class="ListTableTr11">
							联系人
						</td>
						<td class="ListTableTr22">
							<s:textfield name="integoryinfoW.linkman"
								cssStyle="width:100%" disabled="true"></s:textfield>
						</td>
					</tr>
					<tr>
						<td width="23%" align="right" class="ListTableTr11">
							资质等级
						</td>
						<td class="ListTableTr22">
						<s:textfield name="integoryinfoW.zzdj"
								cssStyle="width:100%" disabled="true"></s:textfield>
						</td>
						<td width="23%" align="right" class="ListTableTr11">
							资质有效期限
						</td>
						<td class="ListTableTr22">
						<s:textfield name="integoryinfoW.zzyxqx"
								cssStyle="width:100%" disabled="true"></s:textfield>
						</td>
					</tr>
				</table>
				<!-- 附件
				<div id="accelerys" align="center">
					<s:property escape="false" value="accessoryList" />
				</div>
				 -->
			</s:form>
			</div>
			<!-- 			<s:div id='tow' label='执业资质' theme='ajax'>
							
				<iframe src="${contextPath}/resmngt/integory/integoryAptitude_List_view.action?integoryId=${interoryId }"
					frameborder="0" width="100%" height="670"></iframe>
			</s:div>
			<s:div id='proList_ing' label='在审项目' theme='ajax'>
			
				<iframe src="${contextPath}/resmngt/integory/proList_ing.action?integoryId=${interoryId }"
					frameborder="0" width="100%" height="670"></iframe>
			</s:div>
			
			<s:div id='proList_end' label='历史项目' theme='ajax'>
			
				<iframe src="${contextPath}/resmngt/integory/proList_end.action?integoryId=${interoryId }"
					frameborder="0" width="100%" height="670"></iframe>
			</s:div>
			 -->
	
	</body>
</html>
