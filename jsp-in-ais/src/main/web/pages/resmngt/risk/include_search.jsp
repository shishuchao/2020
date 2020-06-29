<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/csswin/style.css" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>
<script type="text/javascript">
	function getUrlParam(){
		return "&mCodeType=${mCodeType}";
	}
</script>
<table id="searchTable" style="display: none;" cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
	class="ListTable">

	<tr class="titletable1">
		<td>
			名称
		</td>
		<td>
			<s:textfield name="assistSuportLawslib.title" />
		</td>
		<td>
			发布单位
		</td>
		<td>
			<s:textfield name="assistSuportLawslib.promulgationDept" />
		</td>
	</tr>

	<tr class="titletable1">
		<td>
			颁布日期
		</td>
		<td>
			<s:textfield name="assistSuportLawslib.promulgationDate"
				value="${assistSuportLawslib.promulgationDate}"
				onclick="calendar();" readonly="true" />
		</td>
		<td>
			经验类别
		</td>
		<td>
			<div>
				<s:textfield name="assistSuportLawslib.category" />

				&nbsp;
				<img
					src="<%=request.getContextPath()%>/resources/images/s_search.gif"
					onclick="showPopWin('<%=request.getContextPath()%>/pages/system/search/searchdata.jsp?url=<%=request.getContextPath()%>/pages/assist/suport/lawsLib/allLawsLibMenus.action&urlpara=getUrlParam&paraname=assistSuportLawslib.category&paraid=assistSuportLawslib.categoryFk',500,460)"
					border=0 style="cursor: hand">
			</div>
		</td>
	</tr>
	<tr class="titletable1">
		<td>
			创建人
		</td>
		<td>
			<s:textfield name="assistSuportLawslib.summan" />
		</td>
		<td>
			创建单位
		</td>
		<td>
			<s:textfield name="assistSuportLawslib.sundept" />
		</td>
	</tr>
	<tr class="titletable1">
		<td>
			正文
		</td>
		<td>
			<s:textfield name="assistSuportLawslib.content" />
		</td>
		<td></td>
		<td></td>
	</tr>
	<s:if test="m_view!=null&&m_view=='view'">
		<input type="hidden" name="assistSuportLawslib.pub_state" value="Y">
	</s:if>
	<s:hidden name="assistSuportLawslib.categoryFk" />

	<s:hidden name="mCodeType" value="${mCodeType}"></s:hidden>
	<s:hidden name="m_view" value="view"></s:hidden>
	<s:hidden name="nodeid" value="${nodeid}"></s:hidden>
	<tr class="titletable1">
		<td colspan="4">
			<span style="float: right;"> <input type="submit" value="查询">&nbsp;&nbsp;
				<input type="button" value="重置" onclick="reset2();"> </span>
		</td>
	</tr>
</table>