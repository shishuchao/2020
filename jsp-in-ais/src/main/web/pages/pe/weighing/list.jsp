<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>

		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>

		<script type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></script>
<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/pe/validate/checkboxSelected.js"></script>	
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		
		<title>时效性考核-权重</title>
		<script language="javascript">
function doSubmit()
{	
       document.all("advSearchValue").value="";
       document.forms[0].submit();
}
</script>
	</head>
	<body>			
		<table id="tableTitle" cellpadding=0 cellspacing=1 border=0	bgcolor="#409cce" class="ListTable" width="100%">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						&nbsp;权重管理
					</td>
				</tr>
	    </table>
			 
			<s:form></s:form>

		<!-- 列表FORM -->
		<s:form namespace="/pe/weighing">
			<display:table name="wList" id="row" requestURI="${contextPath}/pe/weighing/listAll.action"
				class="its" pagesize="20">
				<display:column>
					<input type="checkbox" name="ids" value="${row.id}">
				</display:column>
			    <display:column property="code" title="权重编码"
					headerClass="center" sortable="true" >
				</display:column>	
				<display:column property="name" title="权重名称"
					headerClass="center" sortable="true" >
				</display:column>

				<display:column property="value" title="权重值"
					headerClass="center" sortable="true" >
				</display:column>				
			</display:table>



      <div align="right">
					<input type="button" class="btn3_mouseout"
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="location.href='<s:url action="toAddPageAction" namespace="/pe/weighing"/>';"
					value="新建" />
				&nbsp;&nbsp;
				<s:button onclick="delete_submit('ids')"
					value="删除" 				 
					 />
				&nbsp;&nbsp;
				<s:button onclick="initUpdate_submit('ids')"
					value="编辑"/>
				&nbsp;&nbsp;
				<s:button
				    onclick="selall_inform('ids')" 
				    value="全选" />
				&nbsp;&nbsp;
				<s:button
					onclick="selall_inform('ids',false)" value="全取消" />
				&nbsp;&nbsp;&nbsp;

			
			</div>
		</s:form>





<script language="javascript"> 
function toOtherUrl(url){

window.open(url,"_blank","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no")   

}
</script>

	</body>
</html>
