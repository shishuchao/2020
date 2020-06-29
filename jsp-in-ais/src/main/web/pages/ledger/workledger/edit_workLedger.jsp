
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<s:if test="id == 0">
	<s:text id="title" name="'审计工作台帐==>添加工作台帐'"></s:text>
</s:if>
<s:else>
	<s:text id="title" name="'审计工作台帐==>修改工作台帐'"></s:text>
</s:else>

<html>
	<script language="javascript">
function backList(){
	myform.action = "${contextPath}/ledger/workLedger/list.action";
	myform.submit();
}


//模板生成----------保存表单
function saveForm(){
	var bool = true;//提交表单判断参数
	//非空校验

	if (checklength() == true){
		//保存表单
		if(bool){
		var flag=window.confirm('确认操作吗?');//isSubmit
		if(flag==true){
		var url = "${contextPath}/ledger/workLedger/save.action";
		myform.action = url;
		myform.submit();
		}else{
			 	return false;
			 }
		}
	}
}

function checklength(){
	var bl = true;
	var lth = document.getElementById("desc").value;
	if(lth.length<1000){
		return bl;
	}else{
	    alert("工作描述1000个汉字以内,若大于1000，请上传附件");
	    bl = false;
		return bl;
	}
}

				
   //上传附件
	function Upload(id,filelist,delete_flag,edit_flag)
		{
			var guid=document.getElementById(id).value;
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=ledger_work&table_guid=fjid&guid='+guid+'&param='+rnm+'&deletePermission=true&isEdit=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
		}

	/*
	* 删除附件
	*/
	function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
		var boolFlag=window.confirm("确认删除吗?");
		if(boolFlag==true){
			DWREngine.setAsync(false);
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
	<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
	type="text/css">
<link href="${contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript"
	src="${contextPath}/resources/csswin/subModal.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
<script type='text/javascript'
	src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript'
	src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>

	<head>
		<title><s:property value="#title" /></title>
		<s:head />
	</head>
	<body>
		<center>

			<table>
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						&nbsp;
						<s:property value="#title" />
					</td>
				</tr>
			</table>

			<s:form id="myform" action="save"
				namespace="/ledger/workLedger" method="post">

				<table cellpadding="0" cellspacing="1" border=0 bgcolor="#409cce"
					class="ListTable">
					<tr>
						<td class="ListTableTr11" align="right" valign="middle">
							工作名称
						</td>
						<!--标题栏-->
						<td class="ListTableTr22" align="right" valign="middle">
							<s:textfield name="workLedger.work_name" cssStyle="width:80%" />
						</td>
					</tr>

					<tr>
						<td class="ListTableTr11" align="right" valign="middle">
							工作开始日期
						</td>
						<td class="ListTableTr22" align="right" valign="middle">
							<s:textfield id="passdate" name="workLedger.work_startday"
								readonly="true" cssStyle="width:80%" maxlength="20"
								title="单击选择日期"
								disabled="!(varMap['pro_starttimeWrite']==null?true:varMap['pro_starttimeWrite'])"
								display="${varMap['pro_starttimeRead']}" onclick="calendar()"
								theme="ufaud_simple" templateDir="/strutsTemplate"></s:textfield>
						</td>
					</tr>


					<tr>
						<td class="ListTableTr11" align="right" valign="middle">
							工作结束日期
						</td>
						<!--标题栏-->
						<td width="31%" align="left" class="listtabletr22">
							<s:textfield id="passdate" name="workLedger.work_endday"
								readonly="true" cssStyle="width:80%" maxlength="20"
								title="单击选择日期"
								disabled="!(varMap['pro_starttimeWrite']==null?true:varMap['pro_starttimeWrite'])"
								display="${varMap['pro_starttimeRead']}" onclick="calendar()"
								theme="ufaud_simple" templateDir="/strutsTemplate"></s:textfield>
						</td>
					</tr>

					<tr>
						<td class="ListTableTr11" align="right" valign="middle">
							工作部门名称
						</td>
						<td class="ListTableTr22" align="right" valign="middle">
							<s:buttonText name="workLedger.w_dept_name" readonly="true"
								hiddenName="workLedger.w_dept_code" cssStyle="width:80%"
								doubleOnclick="showPopWin('/pages/system/search/searchdata.jsp?url=/systemnew/orgList.action&p_item=1&orgtype=1&paraname=workLedger.w_dept_name&paraid=workLedger.w_dept_code',600,450,'组织机构选择')"
								doubleSrc="/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" doubleDisabled="false" />
						</td>
					</tr>

					<tr>
						<td class="ListTableTr11" align="right" valign="middle">
							记录日期
						</td>
						<!--标题栏-->
						<td class="ListTableTr22" align="right" valign="middle">
							<s:textfield id="passdate" name="workLedger.work_time"
								readonly="true" cssStyle="width:80%" maxlength="20"
								title="单击选择日期"
								disabled="!(varMap['pro_starttimeWrite']==null?true:varMap['pro_starttimeWrite'])"
								display="${varMap['pro_starttimeRead']}" onclick="calendar()"
								theme="ufaud_simple" templateDir="/strutsTemplate"></s:textfield>
						</td>
					</tr>
					
					<tr>
						<td class="ListTableTr11" align="right" valign="middle">
							工作人
						</td>
						<td class="ListTableTr22" align="right" valign="middle">
							<s:buttonText name="workLedger.w_creator_name" readonly="true"  
								hiddenName="workLedger.w_creator_code" cssStyle="width:80%"
								doubleOnclick="showPopWin('/pages/system/search/mutiselect.jsp?url=/pages/system/userindex.jsp&paraname=workLedger.w_creator_name&paraid=workLedger.w_creator_code&p_issel=1&p_item=2',600,450)" 
								doubleSrc="/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" 
								doubleDisabled="false" />
						</td>
					</tr>
					
					<tr>
						<td class="ListTableTr11" align="right" valign="middle">
							工作描述(1000个汉字以内,若大于1000，请上传附件)
						</td>
						<td class="ListTableTr22" align="right" valign="middle">
							<s:textarea id="desc" name="workLedger.work_desc" cssStyle="width:80%" />
						</td>
					</tr>
					<tr>
					<td class="ListTableTr11">
					  <s:button onclick="Upload('workLedger.fjid',fjList)" value="上传附件"></s:button>
					</td>
					  <td class="ListTableTr22">
							<div id="fjList" align="center">
								<s:property escape="false" value="accessoryList"/>
							</div>
							<s:hidden name="workLedger.fjid"></s:hidden>
						</td>
					</tr>
				</table>
				<s:hidden name="workLedger.id" />
				<!-- 主键 -->
				<s:hidden name="workLedger.company_id"></s:hidden>
				
				<s:button value="保存" onclick="saveForm();" />&nbsp;&nbsp;
				<s:button value="返回列表" onclick="backList();" />
				
			</s:form>

		</center>
	</body>
</html>
