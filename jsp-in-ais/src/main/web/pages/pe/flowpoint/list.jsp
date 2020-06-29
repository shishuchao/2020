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
			
		<title>绩效考核-考核节点</title>
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
						&nbsp;考核节点管理
					</td>
				</tr>
			</table>
	<s:form ></s:form>
		<!-- 列表FORM -->
		<s:form namespace="/pe/flowpoint">
		<s:hidden name="peSystem_id" value="${id}"></s:hidden>		
			<display:table name="fpList" id="row" requestURI="${contextPath}/pe/flowpoint/listAll.action" 
				class="its" pagesize="30" cellspacing="0">
				<display:column>
					<input type="checkbox" name="ids" value="${row.id}">
				</display:column>
					
				<display:column property="code" title="节点编码"
					headerClass="center" sortable="true" >
				</display:column>
    					
				<display:column property="name" title="节点名称"
					headerClass="center" sortable="true" >
				</display:column>
				<display:column property="discript" title="节点描述"
					headerClass="center" sortable="true" >
				</display:column>
				<display:column property="weight" title="节点权重"
					headerClass="center" sortable="true" >
				<display:column title="是否为加分项">
					<s:if test="${row.isAdd=='0'}">否</s:if>
					<s:if test="${row.isAdd=='1'}">是</s:if>
				</display:column>					
				</display:column>				
				<display:column property="creator" title="创建人"
					headerClass="center" sortable="true" >
				</display:column>	
				<display:column property="cts" title="创建时间"
					headerClass="center" sortable="true" >
				</display:column>  		
			</display:table>
        <div align="right">
				<input type="button" class="btn3_mouseout"
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="location.href='<s:url action="toAddPageAction" namespace="/pe/flowpoint"/>';"
					value="新建" />
				&nbsp;&nbsp;
				<s:button onclick="delete_submit('ids')" value="删除"/>
				&nbsp;&nbsp;
				<s:button onclick="initUpdate_submit('ids')" value="编辑"/>
				&nbsp;&nbsp;																
				<s:button onclick="selall_inform('ids')" value="全选"/>
				&nbsp;&nbsp;
				<s:button onclick="selall_inform('ids',false)" value="全不选"/>
				&nbsp;&nbsp;&nbsp;			
			</div>
		</s:form>
		<script type="text/javascript">
		function preview(src){		
		window.open("${contextPath}/pe/flowpointzb/preview.action?id='+src+'","_blank","height=500,width=800,top=0,left=200,toolbar=no,menubar=no,scrollbars=no, resizable=yes,location=no, status=no");		
		}
		</script>
	</body>
</html>
