
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<s:text id="title" name="'编号规则评细定义查看'"></s:text>

<html>
	<script language="javascript">
function backList(){
//返回上级list页面
	var url = "${contextPath}/code/ruledetail/codeRuleDetail/list.action";
	myform.action = url;
	myform.submit();

}
</script>
	<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
		type="text/css">
	<head>
		<title><s:property value="#title" />
		</title>
		<s:head />
	</head>

	<body>
		<center>
			<s:form id="myform" action="view"
				namespace="/code/ruledetail/codeRuleDetail">

				<table>
					<tr class="listtablehead">
						<td colspan="5" align="left" class="edithead">
							&nbsp;
							<s:property value="#title" />
						</td>
					</tr>
				</table>



				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">

					<tr class="titletable1">
						<td>
							编码字段名:
						</td>
						<td>
							<s:property value="codeRuleDetail.d_field_name" />
						</td>
					</tr>


					<tr class="titletable1">
						<td>
							值:
						</td>
						<td>
							<s:property value="codeRuleDetail.d_field_value" />
						</td>
					</tr>


					<tr class="titletable1">
						<td>
							编码类型:
						</td>
						<td>
							<s:property value="codeRuleDetail.d_field_type" />
						</td>
					</tr>


					<tr class="titletable1">
						<td>
							表名:
						</td>
						<td>
							<s:property value="codeRuleDetail.d_table_name" />
						</td>
					</tr>


					<tr class="titletable1">
						<td>
							函数:
						</td>
						<td>
							<s:property value="codeRuleDetail.d_function" />
						</td>
					</tr>


					<tr class="titletable1">
						<td>
							比较符:
						</td>
						<td>
							<s:property value="codeRuleDetail.d_comparesign" />
						</td>
					</tr>


					<tr class="titletable1">
						<td>
							比较值:
						</td>
						<td>
							<s:property value="codeRuleDetail.d_compare_value" />
						</td>
					</tr>


					<tr class="titletable1">
						<td>
							位数:
						</td>
						<td>
							<s:property value="codeRuleDetail.d_digit" />
						</td>
					</tr>


				</table>

				<s:hidden name="codeRuleDetail.id" />
				<s:button value="关闭" onclick="javascript:window.close();" />
			</s:form>

		</center>
	</body>
</html>
