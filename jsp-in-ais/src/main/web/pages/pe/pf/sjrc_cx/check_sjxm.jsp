<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
		<title>绩效考核--审计项目</title>
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
						<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/pe/pf/sjrc_cx/check.action?peObjectCode=1000201')"/>
					</span>
					<span style="float: right;"><a href="javascript:void(0);" onclick="triggerSearchTable();">查询条件</a></span>
				</td>
			</tr>
		</table>
		<s:form name="myform" namespace="/pe/pf/sjrc_cx" action="check" onsubmit="return doSome('false')">
			<s:hidden name="peObjectCode"></s:hidden>
			<s:hidden id="export" name="export"></s:hidden>
			<table id="searchTable" style="display: none;" cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce" class="ListTable" align="center">				
				<tr class="listtablehead">
					<TD class=listtabletr1>
							考核方式
					</TD>
					<TD class=listtabletr1>
	        			<s:select name="sco.peTypeCode" headerKey=""
								headerValue="请选择考核方式" list="basicUtil.peTypeList" listKey="code"
								listValue="name" />
                    </TD>
					<TD align=center class=listtabletr1>
					项目名称
					</TD>
					<TD class=listtabletr1>
                      <s:textfield name="sco.object_name"></s:textfield>
					</TD>					
				</TR>	
				<tr class="listtablehead">
					<TD class=listtabletr1>
						计划类别
					</TD>
					<TD class=listtabletr1>
	        				<s:select  name="sco.plan_type"  emptyOption="true"
							list="basicUtil.planTypeList" listKey="code" listValue="name"	
							theme="ufaud_simple"					
							templateDir="/strutsTemplate" />
                    </TD>
					<TD align=center class=listtabletr1>
						项目类别
					</TD>
					<TD class=listtabletr1>
						<s:doubleselect emptyOption="true"
							doubleList="projectTypeMap[top]" doubleListKey="code"
							doubleListValue="name" listKey="code" listValue="name"
							name="sco.pro_type" list="projectTypeMap.keySet()"
							doubleName="sco.pro_type_child" theme="ufaud_simple"
							templateDir="/strutsTemplate"></s:doubleselect>
					</TD>					
				</TR>
				<tr class="listtablehead">
					<TD class=listtabletr1>
						最终得分
					</TD>
					<TD class=listtabletr1 colspan="3">
						 <s:textfield name="sco.totalScore"/>
					</TD>
					
				</TR>
				<tr class="listtablehead" align="right">
					<td colspan="6" align="right" class="listtabletr1">
						<div align="right">
							<s:submit value="查询" />
							&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="button" value="重置"
								onclick="window.location.href='${contextPath}/pe/pf/sjrc_cx/check.action?peObjectCode=1000201'" />
						</div>
					</td>
				</tr>
			</TABLE>
		</s:form>
		<s:form namespace="/pe/pf/sjrc_cx" name="myforml" action="check" method="post">		
			<center>
				<display:table requestURI="${contextPath}/pe/pf/sjrc_cx/check.action" name="scoList" id="row" class="its" pagesize="10" >
				    <display:column property="object_name" title="项目名称" headerClass="center" sortable="true"/>		
					<display:column property="peTypeName" title="考核方式" headerClass="center" sortable="true" />										
					<display:column property="plan_type_name" title="计划类别" sortable="true" headerClass="center" />		
					<display:column property="pro_type_name" title="项目类别" sortable="true" headerClass="center" />	
	                <display:column property="audit_dept_name" title="审计单位" headerClass="center" sortable="true" />
	                <display:column property="audit_object_name" title="被审计单位" headerClass="center" sortable="true" />
					<display:column property="real_start_time" title="项目开始时间" headerClass="center" sortable="true" />
			        <display:column property="real_closed_time" title="项目结束时间" headerClass="center" sortable="true" />	
					<display:column property="totalScore" title="最终得分" headerClass="center" sortable="true" />	
				   	<display:column title="详细信息" headerClass="center" sortable="true">
					<s:a cssStyle="cursor:hand"  onclick="openWindowByUrl_common('${contextPath}/pe/pf/sjrc_cx/getMore.action?id=${row.id}&tag=sjxm')"><s:div cssStyle="text-align:center; color:gray">详细信息</s:div></s:a>			
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

    if(!numberValidate_out('sco.object_name',50,'项目名称')){      
      return false;
    }else{
	 document.getElementById('export').value=bool;	
	 return true;
	 }
}		           		     
</script>

	</body>
</html>
