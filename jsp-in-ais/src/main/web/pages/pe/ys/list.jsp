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
			
		<title>绩效考核-考核要素</title>
		<script language="javascript">
function doSubmit()
{	
  document.forms[0].submit();
}
</script>
	</head>
	<body onunload="init_common()">		
		  <table id="tableTitle" cellpadding=0 cellspacing=1 border=0
				bgcolor="#409cce" class="ListTable" width="100%">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						&nbsp;考核要素管理
					</td>
				</tr>
			</table>
	<s:form ></s:form>
		<!-- 列表FORM -->
		<s:form namespace="/pe/ys">
		<s:hidden name="peSystem_id" value="${id}"></s:hidden>		
			<display:table name="ysList" id="row" requestURI="${contextPath}/pe/ys/listAll.action" 
				class="its" pagesize="30" cellspacing="0">
				<display:column>
					<input type="checkbox" name="ids" value="${row.id}">
				</display:column>
					
				<display:column property="ys_number" title="要素序号"
					headerClass="center" sortable="true" >
				</display:column>
    					
				<display:column property="name" title="要素名称"
					headerClass="center" sortable="true" >
				</display:column>

	
															
			    <display:column  title="操作" headerClass="center" sortable="true"  media="html">
				<s:a href="${contextPath}/pe/yszb/listAll.action?id=${row.id}">要素指标</s:a>
				</display:column>	  		
			</display:table>
        <div align="right">
				<input type="button" class="btn3_mouseout"
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="location.href='<s:url action="toAddPageAction" namespace="/pe/ys"/>';"
					value="新建" />
				&nbsp;&nbsp;
				<s:button onclick="delete_submit('ids')" value="删除"/>
				&nbsp;&nbsp;
				<s:button onclick="initUpdate_submit('ids')" value="编辑"/>
				&nbsp;&nbsp;				
				<s:button onclick="openWindowByUrl('${contextPath}/pe/yszb/preview.action?id=${id}')" value="预览"/>
				
				&nbsp;&nbsp;												
				<s:button onclick="selall_inform('ids')" value="全选"/>
				&nbsp;&nbsp;
				<s:button onclick="selall_inform('ids',false)" value="全不选"/>
				&nbsp;&nbsp;&nbsp;			
			</div>
		</s:form>

	</body>
</html>
