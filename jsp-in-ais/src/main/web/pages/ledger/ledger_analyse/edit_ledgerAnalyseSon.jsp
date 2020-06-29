
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<s:if test="id == 0">
	<s:text id="title" name="'添加'"></s:text>
</s:if>
<s:else>
	<s:text id="title" name="'修改'"></s:text>
</s:else>



<html>
	<script language="javascript">
             
function backList(fid){
	myform.action = "${contextPath}/ledger/ledgerAnalyseSon/enter.action?id="+fid;
	myform.submit();
}



//模板生成----------保存表单
function saveForm(){
var bool = true;//提交表单判断参数
//非空校验
 
	
	//保存表单
	if(bool){
	var flag=window.confirm('确认操作吗?');//isSubmit
	if(flag==true){
	var url = "${contextPath}/ledger/ledgerAnalyseSon/save.action";
	myform.action = url;
	myform.submit();
	}else{
		 	return false;
		 }
	}
}

</script>

	<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
		type="text/css">
	<link href="${contextPath}/resources/csswin/subModal.css"
		rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type="text/javascript"
		src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript"
		src="${contextPath}/resources/csswin/subModal.js"></script>
	<SCRIPT type="text/javascript" src="${contextPath}/scripts/calendar.js"></SCRIPT>
	<head>
		<title><s:property value="#title" />
		</title>
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
				namespace="/ledger/ledgerAnalyseSon">

				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">

					<tr class="titletable1">
						<td>

							po对应:
						</td>
						<!--标题栏-->
						<td>
							<s:textfield name="ledgerAnalyseSon.code" cssStyle="width:90%" />
							<!--一般文本框-->

						</td>
					</tr>






					<tr class="titletable1">
						<td>

							po对应的名称:
						</td>
						<!--标题栏-->
						<td>
							<s:textfield name="ledgerAnalyseSon.name" cssStyle="width:90%" />
							<!--一般文本框-->

						</td>
					</tr>






					<tr class="titletable1">
						<td>

							类型:
						</td>
						<!--标题栏-->
						<td>
							<s:select list="#@java.util.LinkedHashMap@{'1':'分类字段','2':'统计字段'}" listKey="key"
								listValue="value" name="ledgerAnalyseSon.type"></s:select>
						</td>
					</tr>




				</table>


				<s:hidden name="ledgerAnalyseSon.id" />
				<s:hidden name="ledgerAnalyseSon.fid" />
				<s:button value="保存" onclick="saveForm();" />&nbsp;&nbsp;

<s:button value="返回" onclick="backList('${ledgerAnalyseSon.fid}');" />
			</s:form>

		</center>
	</body>
</html>
