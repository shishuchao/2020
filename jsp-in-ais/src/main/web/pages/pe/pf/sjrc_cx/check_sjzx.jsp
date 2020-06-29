<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
		<title>绩效考核--中介机构(项目)</title>
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
			
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>

	</head>
	<body>
		<table cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce"
			class="ListTable" align="center">
			<tr class="listtablehead">
				<td colspan="4" align="left" class="edithead">
					<span style="display: inline; width: 80%;float: left;">
						绩效考核-中介机构(项目)考核查询
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
					中介机构名称
					</TD>
					<TD class=listtabletr1>
                      <s:textfield name="sco.name"></s:textfield>
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
						<s:select name="sjzx.pro_type" labelposition="top" cssStyle="width:60%"
								listKey="key" listValue="value"
								list="#@java.util.LinkedHashMap@{'':'','开工前审计':'开工前审计','建设期间审计':'建设期间审计','竣工结算审计':'竣工结算审计','竣工决算审计':'竣工决算审计'}" 
						/>
					</TD>					
				</TR>
				<tr class="listtablehead">
					<TD class=listtabletr1>
						项目名称
					</TD>
					<TD class=listtabletr1>
	        			 <s:textfield name="sco.item_name"></s:textfield>	
                    </TD>
					<TD align=center class=listtabletr1>
						被审计单位
					</TD>
					<TD class=listtabletr1>
					<s:buttonText name="sco.audit_object_name"
					 hiddenName="sco.audit_object"  cssStyle="width:60%"
					 doubleOnclick="showPopWin('/pages/system/search/searchdata.jsp?url=/mng/audobj/object/objselecttree.action&paraname=sco.audit_object_name&paraid=sco.audit_object',600,450,'被审计单位')"
					 doubleSrc="/resources/images/s_search.gif" doubleCssStyle="cursor:hand;border:0" readonly="true" doubleDisabled="false" />			
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
							<s:reset value="重置" />
						</div>
					</td>
				</tr>
			</TABLE>
		</s:form>
		<s:form namespace="/pe/pf/sjrc_cx" name="myforml" action="check" method="post">		
			<center>
				<display:table requestURI="${contextPath}/pe/pf/sjrc_cx/check.action" name="scoList" id="row" class="its" pagesize="10" >
				    	
				     <display:column property="item_name" title="项目名称" headerClass="center" sortable="true"/>	
					<display:column property="peTypeName" title="考核方式" headerClass="center" sortable="true" />										
					<display:column property="plan_type_name" title="计划类别" sortable="true" headerClass="center" />		
					<display:column property="pro_type_name" title="项目类别" sortable="true" headerClass="center" />	
	                <display:column property="audit_dept_name" title="审计单位" headerClass="center" sortable="true" />
	                <display:column property="object_name" title="中介机构名称" headerClass="center" sortable="true"/>	
	                <display:column property="audit_object_name" title="被审计单位" headerClass="center" sortable="true" />
					<display:column property="real_start_time" title="项目开始时间" headerClass="center" sortable="true" />
			        <display:column property="real_closed_time" title="项目结束时间" headerClass="center" sortable="true" />	
					<display:column property="totalScore" title="最终得分" headerClass="center" sortable="true" />	
				    </display:table>
					<display:column title="详细信息" headerClass="center" sortable="true">
					<s:a cssStyle="cursor:hand"  onclick="openWindowByUrl_common('${contextPath}/pe/pf/sjrc_cx/getMore.action?id=${row.id}&tag=sjzx')"><s:div cssStyle="text-align:center; color:gray">详细信息</s:div></s:a>			
					</display:column> 
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
	 document.getElementById('export').value=bool;	
	 return true;
}	           		     
</script>

	</body>
</html>
