<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:if test="${empty(risk.riskId)}">
	<s:text id="title" name="'添加风险报告'"></s:text>
</s:if>
<s:else>
	<s:text id="title" name="'修改风险报告'"></s:text>
</s:else>
<html>
	<head>
		<title><s:property value="title"/></title> 
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<link href="<%=request.getContextPath()%>/resources/css/site.css"
			rel="stylesheet" type="text/css">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/csswin/style.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>	
	
	<script type="text/javascript">
		function openDialog()
		{
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=assist_suport_lawslib&table_guid=muuid&guid=${riskId}&&param='+rnm+'&&isEdit=false&&deletePermission=<s:property value="true"/>',accelerys,'dialogWidth:700px;dialogHeight:450px;status:yes');
		}
	 	
		function deleteFile(fileId,guid,isDelete,isEdit,appType){
			var boolFlag=window.confirm("确认删除吗?");
			if(boolFlag==true)
			{
				DWREngine.setAsync(false);DWRActionUtil.execute(
			{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
			{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType},
			xxx);
			function xxx(data){
			  	document.getElementById("accelerys").innerHTML=data['accessoryList'];
			} 
			}
		}
			/*
			* 每次提交查询之前都要验证必填项
			*/
			function validator(){
				if(frmCheck(document.forms[0], 'mytable')){
					document.forms[0].submit();
				}
			}
</script>
</head>
	<body leftmargin="0" topmargin="0" bottommargin="0">
		<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
			class="ListTable" width="100%" align="center">
			<tr class="listtablehead">
				<td colspan="4" class="edithead"
					style="text-align: left; width: 100%;">
					<div style="display: inline; width: 80%;">
						<s:property escape="false"
							value="@ais.framework.util.NavigationUtil@getNavigation('/ais/resmngt/risk/index.action')" />-->
							<s:property value="title"/>
					</div>
					<div style="display: inline; width: 20%; text-align: right;">
						<a href="javascript:;" onclick="triggerSearchTable();">查询条件</a>
					</div>
				</td>
			</tr>
		</table>
		<center>
			<s:form action="save" namespace="/resmngt/risk" id="editForm">
				<s:hidden name="riskTypeId"/>
				<s:hidden name="riskId"/>
				<s:hidden name="risk.riskId" />
				<s:hidden name="risk.riskType"/>
				<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" 
					class="ListTable" id="mytable">
					<tr>
						<td class="ListTableTr11">
							年度
							<FONT color=red>*</FONT>
						</td>
						<td class="ListTableTr22">
							<s:select list="@ais.framework.util.DateUtil@getIncrementYearList(0,5)"
								name="risk.year" />
						</td>
						<td class="ListTableTr11">
							风险报告名称<FONT color=red>*</FONT>
						</td>
						<td class="ListTableTr22">
							<s:textfield label="%{'风险报告'}"
								name="risk.title" maxlength="120" cssStyle="width:100%"/>
						</td>
					</tr>
					<tr>
						<%--<td class="ListTableTr11" nowrap="nowrap">
							风险因素
							<font color="red">*</font>
						</td>
						<td class="ListTableTr22">
							<s:doubleselect id="sourceType" doubleId="reason"
								doubleList="sourceReasonMap[top]" doubleListKey="code"
								doubleListValue="name" listKey="code" listValue="name" 
								value="risk.sourceTypeName" doubleValue="risl.reasonName"
								name="risk.sourceType" list="sourceReasonMap.keySet()"
								doubleName="risk.reason" theme="ufaud_simple"
								templateDir="/strutsTemplate"
								disabled="false" doubleDisabled="false"
								display="true"
								emptyOption="true" doubleEmptyOption="true"/>
						</td>
						--%>
						<td class="ListTableTr11">
							上传时间
						</td>
						<td class="ListTableTr22">
							<s:hidden name="risk.uploadTime"></s:hidden>
							${fn:substring(risk.uploadTime,0,10)}
						</td>
						<td class="ListTableTr11">
							风险报告人
						</td>
						<td class="ListTableTr22">
							<s:property value="user.fname"/> 
							<s:hidden name="risk.uploaderName" value="${user.fname}"></s:hidden>
							<s:hidden name="risk.uploader" value="${user.floginname}"></s:hidden>
						</td>
					</tr>	
					<tr>
						<td class="ListTableTr11" >
							单位
						</td>
						<td class="ListTableTr22">
							<s:property value="user.fdepname"/>
							<s:hidden name="risk.uploadDept" value="${user.fdepid}"></s:hidden>
							<s:hidden name="risk.uploadDeptName" value="${user.fdepname}"></s:hidden>
						</td>
						<td class="ListTableTr11" >
							&nbsp;
						</td>
						<td class="ListTableTr22">
							&nbsp;
						</td>
					</tr>
				</table>
				<div id="accelerys" align="center">
					<s:property escape="false" value="accessoryList" />
				</div>
				<br>				
				<table style="width:97%;border:0" >
					<tr>
						<td>
							<span style="float:right;">
								<s:button  onclick="openDialog()" value="上传附件"></s:button>
								&nbsp;
								<input type="button" name="sub" value="保存" onclick="validator();">
								<input type="button" name="back" value="返回" onclick="javascript:document.location='${contextPath}/resmngt/risk/index.action?helper.risk.riskType=${riskTypeId }'">
							</span>
						</td>
					</tr>
				</table>
			</s:form>
			
		</center>
	</body>

</html>