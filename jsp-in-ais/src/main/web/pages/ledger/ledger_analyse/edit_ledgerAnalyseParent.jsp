
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<html>
	<script language="javascript">
             
function backList(){
	myform.action = "${contextPath}/ledger/ledgerAnalyseParent/list.action";
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
	var url = "${contextPath}/ledger/ledgerAnalyseParent/save.action";
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
		<title></title>
		<s:head />
	</head>



	<body>
		<center>

			<table>
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						<s:if test="id == 0">
							<s:property
								escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/ledger/ledgerAnalyseParent/list.action','添加')" />
						</s:if>
						<s:else>
							<s:property
								escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/ledger/ledgerAnalyseParent/list.action','修改')" />
						</s:else>
					</td>
				</tr>
			</table>

			<s:form id="myform" action="save"
				namespace="/ledger/ledgerAnalyseParent">

				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">



					<tr class="titletable1">
						<td class="ListTableTr11">

							表的PO名称:
						</td>
						<!--标题栏-->
						<td class="ListTableTr22">
							<s:textfield name="ledgerAnalyseParent.code" cssStyle="width:90%" />
							<!--一般文本框-->

						</td>
					</tr>






					<tr class="titletable1">
						<td class="ListTableTr11">

							名字:
						</td>
						<!--标题栏-->
						<td class="ListTableTr22">
							<s:textfield name="ledgerAnalyseParent.name" cssStyle="width:90%" />
							<!--一般文本框-->

						</td>
					</tr>




				</table>


				<s:hidden name="ledgerAnalyseParent.id" />
				<s:button value="保存" onclick="saveForm();" />&nbsp;&nbsp;

<s:button value="返回" onclick="backList();" />
			</s:form>

		</center>
	</body>
</html>
