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
		
		<title>考核对象</title>
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
						&nbsp;考核对象
					</td>
				</tr>
	    </table>
			 
			<s:form></s:form>

		<!-- 列表FORM -->
		<s:form namespace="/pe/dx">
			<display:table name="peDxList" id="row" requestURI="${contextPath}/pe/dx/listAll.action"
				class="its" pagesize="20">
				<display:column>
					<input type="checkbox" name="ids" value="${row.id}">
				</display:column>
			    <display:column property="code" title="编码"
					headerClass="center" sortable="true" >
				</display:column>	
				<display:column property="name" title="名称"
					headerClass="center" sortable="true" >
				</display:column>

				<display:column property="creator" title="创建者"
					headerClass="center" sortable="true" >
				</display:column>				
				<display:column property="cts" title="创建时间"
					headerClass="center" sortable="true" >
				</display:column>
				<display:column title="操作" headerClass="center" sortable="true">
					<%--<a href="${contextPath}/pe/dx/preview.action?id=${row.id}">预览表单</a>
				--%>
				
				<s:button value="考核表单预览" onclick="toOtherUrl('${contextPath}/pe/dx/preview.action?id=${row.id}')"></s:button>
				
				</display:column> 				
										
			</display:table>



      <div align="right">
					<input type="button" class="btn3_mouseout"
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="location.href='<s:url action="toAddPageAction" namespace="/pe/dx"/>';"
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
					onclick="selall_inform('ids',false)" value="全不选" />
				&nbsp;&nbsp;&nbsp;

			
			</div>
		</s:form>





<script language="javascript"> 
function toOtherUrl(url){

window.open(url,"_blank","height=500,width=800,top=0,left=200,toolbar=no,menubar=no,scrollbars=no, resizable=yes,location=no, status=no")   

}
</script>

	</body>
</html>
