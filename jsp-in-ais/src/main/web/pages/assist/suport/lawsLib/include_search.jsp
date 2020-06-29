<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/checkboxSelected.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>	
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/checkboxSelected.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>

<script type="text/javascript">
	 function doSearch(){
	    	$('#objectList').datagrid({
				queryParams:form2Json('myform')
			});
	    }
		function restal(){
			resetForm('myform');
			doSearch();
		}
</script>
<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">

	<tr >
		<td class="EditHead">
			名称
		</td>
		<td class="editTd">
			<s:textfield cssClass="noborder" cssStyle="width:160px;" name="assistSuportLawslib.title" />
		</td>

		<td class="EditHead">
			文号
		</td>
		<td class="editTd">
			<s:textfield  cssClass="noborder"  cssStyle="width:160px;"
				name="assistSuportLawslib.codification" />
		</td>
	</tr>

	<tr >
		<td class="EditHead">
			颁布日期
		</td>
		<td class="editTd">
			<!-- 
			<s:textfield  cssClass="easyui-datebox noborder"  name="assistSuportLawslib.promulgationDate"
				value="${assistSuportLawslib.promulgationDate}" title="单击选择日期"  cssStyle="width:160px;"/>
			-->
			<input type="text" Class="easyui-datebox noborder"  name="assistSuportLawslib.promulgationDate"
				value="${assistSuportLawslib.promulgationDate}" title="单击选择日期"  Style="width:160px;" editable="false" >	
		</td>
		<td class="EditHead">
			生效日期
		</td>
		<td class="editTd">
			<!-- 
			<s:textfield  cssClass="easyui-datebox noborder"  name="assistSuportLawslib.effctiveDate"
				value="${assistSuportLawslib.effctiveDate}" title="单击选择日期"  cssStyle="width:160px;"/>
			-->
			<input type="text" class="easyui-datebox noborder"  name="assistSuportLawslib.effctiveDate"
				value="${assistSuportLawslib.effctiveDate}" title="单击选择日期"  Style="width:160px;" editable="false">	
		</td>
	</tr>
	<tr >
		<td class="EditHead">
			失效日期
		</td>
		<td class="editTd">
			<!--
			<s:textfield  cssClass="easyui-datebox noborder" name="assistSuportLawslib.invalidationDate"
				value="${assistSuportLawslib.invalidationDate}" title="单击选择日期"  cssStyle="width:160px;"/>
			-->	
			<input type="text" class="easyui-datebox noborder" name="assistSuportLawslib.invalidationDate"
				value="${assistSuportLawslib.invalidationDate}" title="单击选择日期"  Style="width:160px;" editable="false" >	
		</td>
		<td class="EditHead">
			颁布单位
		</td>
		<td class="editTd">
			<s:textfield   cssClass="noborder" cssStyle="width:160px;"
				name="assistSuportLawslib.promulgationDept" />
		</td>
	</tr>
	<tr class="titletable1">
		<td class="ListTableTr11">
			创建日期
		</td>
		<td class="ListTableTr22" colspan="3">
			<s:textfield name="assistSuportLawslib.createDateStart"
				onclick="calendar();" readonly="true" />到
			<s:textfield name="assistSuportLawslib.createDateEnd"
							onclick="calendar();" readonly="true" />				
		</td>	
	</tr>		
	<tr >
		<td class="EditHead">
			正文
		</td>
		<td class="editTd">
			<s:textfield  cssClass="noborder"  cssStyle="width:160px;"
				name="assistSuportLawslib.content" />
		</td>
		<td class="EditHead">
			有效性
		</td>
		<td class="editTd">
			<!-- 
			<s:select cssClass="easyui-combobox" list="#@java.util.LinkedHashMap@{'有效':'有效','无效':'无效'}"
				emptyOption="true" name="assistSuportLawslib.effective"
				cssStyle="width:160px" />
			-->	
			<select  class="easyui-combobox" name="assistSuportLawslib.effective" style="width:150px;" >
		        <option value="">&nbsp;</option>
		        <s:iterator value="#@java.util.LinkedHashMap@{'有效':'有效','无效':'无效'}" id="entry">
		  	        <option value="<s:property value="key"/>"><s:property value="value"/></option>
		       </s:iterator>
		    </select> 	
		</td>
	</tr>
	<tr >
		<td  class="editTd"  colspan="6">
			<div style="text-align:right;padding-right:20px;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>
			</div>
		</td>

	</tr>
	<s:if test="m_view!=null&&m_view=='view'">
		<input type="hidden" name="assistSuportLawslib.pub_state" value="Y">
	</s:if>
	<s:hidden name="assistSuportLawslib.categoryFk"></s:hidden>
</table>
<s:hidden name="mCodeType" value="${mCodeType}"></s:hidden>
<s:hidden name="m_view" value="view"></s:hidden>
	
