<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<title></title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/scripts/validate.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/deleteFile.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<script type="text/javascript">
			function validateFrm(){
				if(frmCheck(document.forms[0], 'tab1')){
					if(document.getElementsByName("budgetInfo.budger")[0].value!=""&&!isMoneyNum(document.getElementsByName("budgetInfo.budger")[0].value)){
						alert("预算 必须为金额！");
						return false;
					}
					if(document.getElementsByName("budgetInfo.used")[0].value!=""&&!isMoneyNum(document.getElementsByName("budgetInfo.used")[0].value)){
						alert("已使用 必须为金额！");
						return false;
					}
					if(document.getElementsByName("budgetInfo.useRate")[0].value!=""&&!isPlus(document.getElementsByName("budgetInfo.useRate")[0].value)){
						alert("使用率 必须为数字！");
						return false;
					}
				}else{
					return false;
				}
				return true;
			}
			function deleteFile(fileId,guid,isDelete,isEdit,appType){
				var boolFlag=window.confirm("确认删除吗?");
				if(boolFlag==true)
				{
					DWREngine.setAsync(false);
					DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
				{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType},
				xxx);
				function xxx(data){
				  	document.getElementById("accelerys").innerHTML=data['accessoryList'];
				} 
				}
			}
			function openDialog(id,filelist){
				var guid=document.getElementById(id).value;
				var num=Math.random();
				var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
				window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=budget_info&table_guid=uuid&guid='+guid+'&&param='+rnm+'&&isEdit=false&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
			}
		</script>
	</head>
	<body>
		<s:form action="baseInfoAction!saveBudgetInfo" namespace="/assist/baseInfo" onsubmit="return validateFrm()">
				<center>
					<table id='tab1' cellpadding=0 cellspacing=1 border=0
							bgcolor="#409cce" class="ListTable">
							<tr>
								<td class="ListTableTr1" nowrap="nowrap">
								年度
								</td>
								<td class="ListTableTr22">
								<s:if test="${status==1}">
									<s:select name="budgetInfo.year" list="#@java.util.LinkedHashMap@{'':'','2005':'2005','2006':'2006','2007':'2007','2008':'2008','2009':'2009','2010':'2010','2011':'2011','2012':'2012','2013':'2013','2014':'2014','2015':'2015'}"></s:select>
								</s:if>
								<s:else>
									${budgetInfo.year}
								</s:else>
								</td>
								<td class="ListTableTr1" nowrap="nowrap">
								部门
								</td>
								<td class="ListTableTr22">
								<s:if test="${status==1}">
								<s:hidden name="budgetInfo.deptCode" value="${budgetInfo.deptCode}"></s:hidden>
								<s:textfield name="budgetInfo.deptName" value="${budgetInfo.deptName}" readonly="true"/>
								</s:if>
								<s:else>
									${budgetInfo.deptName}
								</s:else>
								</td>
							</tr>
							<tr>
								<td class="ListTableTr1" nowrap="nowrap">
								预算
								<FONT color=red>*</FONT>
								</td>
								<td class="ListTableTr22">
								<s:if test="${status==1}">
								<s:textfield name="budgetInfo.budger" value="${budgetInfo.budger}" maxlength="11"/>
								</s:if><s:else>
									${budgetInfo.budger}
								</s:else>
								</td>
								<td class="ListTableTr1" nowrap="nowrap">
								已使用
								</td>
								<td class="ListTableTr22">
								<s:if test="${status==1}">
								<s:textfield name="budgetInfo.used" value="${budgetInfo.used}" maxlength="11"/>
								</s:if>
								<s:else>
									${budgetInfo.used}
								</s:else>
								</td>
							</tr>
							<tr>
								<td class="ListTableTr1" nowrap="nowrap">
								使用率(%)
								</td>
								<td class="ListTableTr22">
								<s:if test="${status==1}">
								<s:textfield name="budgetInfo.useRate" value="${budgetInfo.useRate}" maxlength="11"/>
								</s:if><s:else>
									${budgetInfo.useRate}
								</s:else>
								</td>
								<td class="ListTableTr1" nowrap="nowrap">
								</td>
								<td class="ListTableTr22">
								</td>
							</tr>
							<s:if test="${status==1}">
							<tr>
								<td class="ListTableTr11">
									<s:button onclick="openDialog('budgetInfo.uuid', accelerys)" value="上传附件"></s:button>
									<s:hidden name="budgetInfo.uuid"/>
								</td>
								<td class="ListTableTr22" colspan="3">
									<div id="accelerys" align="center">
									<s:property escape="false" value="budgetAccessoryList" />
									</div>
								</td>
							</tr>
							</s:if>
					</table>
				</center>
				<div align="right">
					<s:if test="${status==1}">
						<s:submit value="保存"/>&nbsp;&nbsp;
					</s:if>
					<s:button value="返回" onclick="window.location.href='${contextPath}/assist/baseInfo/baseInfoAction!listBudgetInfo.action?deptCode=${deptCode}&status=${status}'"></s:button>
				</div>
				<s:hidden name="budgetInfo.id"/>
				<s:hidden name="deptCode"/>
				<s:hidden name="status"/>
		</s:form>
	</body>
</html>