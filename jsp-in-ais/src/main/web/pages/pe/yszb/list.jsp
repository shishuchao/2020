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
				
		<title>绩效考核-要素指标</title>
		<script language="javascript">
function doSubmit()
{	
  document.forms[0].submit();
}

function gotoback(src)
{	
  window.location="${contextPath}/pe/ys/listAll.action?id="+src;
}
</script>
	</head>
	<body>		
		  <table id="tableTitle" cellpadding=0 cellspacing=1 border=0
				bgcolor="#409cce" class="ListTable" width="100%">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						&nbsp;要素指标管理
					</td>
				</tr>
			</table>
	<s:form ></s:form>
		<!-- 列表FORM -->
		<s:form namespace="/pe/yszb">
		<s:hidden name="ys_id" value="${id}"></s:hidden>		
			<display:table name="yszbList" id="row" requestURI="${contextPath}/pe/yszb/listAll.action" 
				class="its" pagesize="30" cellspacing="0">
				<display:column>
					<input type="checkbox" name="ids" value="${row.id}">
				</display:column>
					
				<display:column property="yszb_number" title="指标序号"
					headerClass="center" sortable="true" >
				</display:column>
    					
				<display:column property="name" title="指标名称"
					headerClass="center" sortable="true" >
				</display:column>

				<display:column property="basicScore" title="指标权重"
					headerClass="center" sortable="true" >
				</display:column>	
		
			    <display:column  title="评分标准" headerClass="center" sortable="true"  media="html">
				<s:a href="${contextPath}/pe/pfbz/listOne.action?id=${row.pfbz_id}&status=out">${row.pfbz_name}</s:a>
				</display:column>																				
	  		
			</display:table>
        <div align="right">
				<input type="button" class="btn3_mouseout"
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="location.href='<s:url action="toAddPageAction" namespace="/pe/yszb"/>';"
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
				<s:button value="返回" onclick="gotoback('${peSystem_id}')" ></s:button>										
			</div>
		</s:form>
	</body>
</html>
