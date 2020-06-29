<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>

<script type="text/javascript">

	function getUrlParam(){
		return "&mCodeType=${mCodeType}";
	}
	function doSearch(){
		$('#objectList').datagrid({
			queryParams:form2Json('lawsForm')
		});
	}
	function restal(){
		resetForm('lawsForm');
		doSearch();
	}
	</script>
<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
	<tr >
		<td class="EditHead">
			名称
		</td>
		<td class="editTd">
			<s:textfield name="assistSuportLawslib.title"  cssClass="noborder"/>
		</td>
		<td class="EditHead">
			案例编号
		</td>
		<td class="editTd">
			<s:textfield name="assistSuportLawslib.codification"  cssClass="noborder"/>
		</td>
	</tr>
	<tr >
		<td class="EditHead">
			类别
		</td>
		<td class="editTd">
			<div>
				<s:textfield name="assistSuportLawslib.category" cssClass="noborder" />
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
			<input name="assistSuportLawslib.createDate" Class="easyui-datebox noborder"  value="${assistSuportLawslib.promulgationDate}"   title="单击选择日期" editable="false" Style="width:150px;"/>
		</td>
	</tr>
	<tr >
		<td class="EditHead">
			创建单位
		</td>
		<td class="editTd">
			<s:textfield name="assistSuportLawslib.sundept"  cssClass="noborder"/>
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
</table>
		<div style="text-align:right;padding-right:20px;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;&nbsp;
			<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>
		</div>