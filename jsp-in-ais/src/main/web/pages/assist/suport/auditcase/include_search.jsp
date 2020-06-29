<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript">
	function getUrlParam(){
		return "&mCodeType=${mCodeType}";
	}
	
	function reset2(){
	setNull("assistSuportLawslib.title");
	setNull("assistSuportLawslib.codification");
	setNull("assistSuportLawslib.category");
	setNull("assistSuportLawslib.createDate");
	setNull("assistSuportLawslib.sundept");
	setNull("assistSuportLawslib.content");

	
	//提交重置
	document.forms[0].submit();
}
</script>
<table id="searchTable" style="display: none;"
	class="ListTable">

	<tr >
		<td class="EditHead">
			名称
		</td>
		<td class="editTd">
			<s:textfield cssClass="noborder" name="assistSuportLawslib.title" />
		</td>
		<td class="EditHead">
			案例编号
		</td>
		<td class="editTd">
			<s:textfield cssClass="noborder" name="assistSuportLawslib.codification" />
		</td>
		
	</tr>

	<tr >
		<td class="EditHead">
			类别
		</td>
		<td class="editTd">
			<div>
				<s:textfield cssClass="noborder" name="assistSuportLawslib.category" />

				&nbsp;
				<img
					src="<%=request.getContextPath()%>/resources/images/s_search.gif"
					onclick="showPopWin('<%=request.getContextPath()%>/pages/system/search/searchdata.jsp?url=<%=request.getContextPath()%>/pages/assist/suport/lawsLib/allLawsLibMenus.action&urlpara=getUrlParam&paraname=assistSuportLawslib.category&paraid=assistSuportLawslib.categoryFk',500,460)"
					border=0 style="cursor: hand">
			</div>
		</td>
		<td class="EditHead">
			创建日期
		</td>
		<td class="editTd">
			<s:textfield name="assistSuportLawslib.createDateStart"
				onclick="calendar();" readonly="true" />到
			<s:textfield name="assistSuportLawslib.createDateEnd"
							onclick="calendar();" readonly="true" />
		</td>
		
	</tr>
	<tr >
		<td class="EditHead">
			创建单位
		</td>
		<td class="editTd">
			<s:textfield cssClass="noborder" name="assistSuportLawslib.sundept" />
		</td>
		<td class="EditHead">
			正文
		</td>
		<td class="editTd">
			<s:textfield cssClass="noborder" name="assistSuportLawslib.content" />
		</td>
	</tr>
	<s:if test="m_view!=null&&m_view=='view'">
		<input type="hidden" name="assistSuportLawslib.pub_state" value="Y">
	</s:if>
	<s:hidden name="assistSuportLawslib.categoryFk" />

	<s:hidden name="mCodeType" value="${mCodeType}"></s:hidden>
	<s:hidden name="m_view" value="view"></s:hidden>
	<s:hidden name="nodeid" value="${nodeid}"></s:hidden>
</table>