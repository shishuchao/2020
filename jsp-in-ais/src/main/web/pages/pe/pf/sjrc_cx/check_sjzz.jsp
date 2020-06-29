<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
		<title>绩效考核--中介机构（周期）</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/resources/csswin/subModal.css">
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/pe/validate/checkboxSelected.js"></script>
					<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/pe/validate/validateCommon.js"></script>
			
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		
	</head>
	<body>
		 <table cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce"
			class="ListTable" align="center">
			<tr class="listtablehead">
				<td colspan="4" align="left" class="edithead">
					<span style="display: inline; width: 80%;float: left;">
						<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/pe/pf/sjrc_cx/check.action?peObjectCode=1000205')"/>
					</span>
					<span style="float: right;"><a href="javascript:void(0);" onclick="triggerSearchTable();">查询条件</a></span>>
				</td>
			</tr>
		</table>
		<s:form name="myform" namespace="/pe/pf/sjrc_cx" action="check" onsubmit="return doSome('false')">
				<s:hidden name="peObjectCode"></s:hidden>
				<s:hidden id="export" name="export"></s:hidden>
			<table id="searchTable" style="display: none;" cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce"
				class="ListTable" align="center">
	 <s:doubleselect 
      name="sco.peTypeCode" emptyOption="true"  firstName="考核方式" 
      list="cnList"
      listKey="code" listValue="name"     
      
      doubleName="sco.range_value" doubleEmptyOption="true" secondName="考核周期"
      doubleList="peRangeValueMap[top]"
      doubleListKey="code" doubleListValue="name"      
      theme="ufaud_2" templateDir="/strutsTemplate">
     </s:doubleselect>

		
				<tr class="listtablehead">
					<TD class=listtabletr1>
						中介机构名称
					</TD>
					<TD class=listtabletr1>
                      <s:textfield name="sco.object_name"/>
					</TD>
					<TD align=center class=listtabletr1>
						所属审计部门
					</TD>
					<TD class=listtabletr1>
					<s:buttonText name="sco.up_department" 
							hiddenName="sco.up_departmentCode" 
							
							doubleOnclick="showPopWin('/pages/system/search/searchdata.jsp?url=/system/uSystemAction!morgList.action&paraname=sco.up_department&paraid=sco.up_departmentCode',600,450,'组织机构选择')" 
							doubleSrc="/resources/images/s_search.gif" 
							doubleCssStyle="cursor:hand;border:0" 
							readonly="true" 
							doubleDisabled="false" />
					</TD>					
				</TR>
				<tr class="listtablehead">
					<TD align="center" class=listtabletr1>
						最终得分
					</TD>
					<TD class=listtabletr1>
						 <s:textfield name="sco.totalScore"/>
					</TD>
					<TD  align="right" class="listtabletr1">
						考核年度
					</TD>
					<TD class="listtabletr1">
						<s:select name="sco.year"  list="#@java.util.LinkedHashMap@{'':'','2008':'2008','2009':'2009','2010':'2010','2011':'2011','2012':'2012','2013':'2013'}"  />
					</TD>
					
				</TR>								
				<tr class="listtablehead" align="right">
					<td colspan="6" align="right" class="listtabletr1">
						<div align="right">
							<s:submit value="查询" />
							&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="button" value="重置"
								onclick="window.location.href='${contextPath}/pe/pf/sjrc_cx/check.action?peObjectCode=1000205'" />							

						</div>
					</td>
				</tr>
			</TABLE>
		</s:form>
		<s:form namespace="/pe/pf/sjrc_cx" name="myforml" action="check" method="post">
		
			<center>
				<display:table requestURI="${contextPath}/pe/pf/sjrc_cx/check.action" name="scoList" id="row" class="its" pagesize="10" >
					<display:column property="object_name" title="中介机构" headerClass="center" sortable="true"/>	

					<display:column property="up_department" title="所属单位" headerClass="center" sortable="true" />							
					<display:column property="peTypeName" title="考核方式" headerClass="center" sortable="true" />				
					<display:column property="range_value" title="考核周期" headerClass="center" sortable="true" />	
					<display:column property="totalScore" title="最终得分" headerClass="center" sortable="true" />
					<display:column title="详细信息" headerClass="center" sortable="true">
					<s:a cssStyle="cursor:hand"  onclick="openWindowByUrl_common('${contextPath}/pe/pf/sjrc_cx/getMore.action?id=${row.id}&tag=sjzz')"><s:div cssStyle="text-align:center; color:gray">详细信息</s:div></s:a>			
					</display:column> 	
				</display:table>
				<br>

			</center>

		</s:form>
	<div align="center">				
		<s:button id="submitButton" value="导出Excel" onclick="return saveForm('true');"></s:button>
	</div>
<script type="text/javascript">		     
function saveForm(bool){
	 document.getElementById('export').value=bool;
     document.myform.submit();
}	
function doSome(bool){

    if(!numberValidate_out('sco.object_name',50,'中介机构名称')){      
      return false;
    }else{
	 document.getElementById('export').value=bool;	
	 return true;
	 }
}	           		     
</script>
	</body>
</html>
