<!DOCTYPE html>
<%@page import="org.aspectj.weaver.patterns.TypePatternQuestions.Question"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title></title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
		<script type="text/javascript" src="/ais/resources/js/common.js"></script>  
		<link href="/ais/resources/css/common.css" rel="stylesheet" type="text/css" /> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="/ais/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="/ais/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='/ais/dwr/engine.js'></script>
  </head>
  
	<body style="margin: 0;padding: 0;overflow:hidden;" class='easyui-layout'>
		<div region='north'  style='padding:0px;margin:0px;height:80px;overflow:hidden;' title='条件查询'>
          <div id="search" style="margin:0px auto; width:80%;">
			<s:form id="myform" name="myform" action="distributeSearch" namespace="/riskManagement/statistics/riskDistribute" method="post">
				<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="left" class="ListTable">
				<tr>
					<td class="EditHead"><span style="color:red">*</span>单位</td>
					<td class="editTd" style="width:30%">
						<s:buttonText2 cssClass="noborder" id="affiliatedDeptName"
									   name="riskEvaluateWait.affiliatedDeptName"
									   cssStyle="width:80%"
									   hiddenName="riskEvaluateWait.affiliatedDeptId"
									   hiddenId="affiliatedDeptId"
									   doubleOnclick="showSysTree(this,{
							  url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?p_item=1&orgtype=1',
							  title:'组织机构选择',
							  checkbox:true
							})"
									   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
									   doubleCssStyle="cursor:pointer;border:0" readonly="true"/>
					</td>
					<td class="EditHead"><span style="color:red">*</span>项目年度</td>
					<td class="editTd" style="width:30%">
						<select class="easyui-combobox" name="riskEvaluateWait.evaluateYear" id="evaluateYear" style="width:80%"  editable="false">
					       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)" id="entry">
					       		<s:if test="${riskEvaluateWait.evaluateYear == key}">
					       			<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
					       		</s:if>	
					       		<s:else>
					       			<option value="<s:property value="key"/>"><s:property value="value"/></option>
					       		</s:else>				       		
					       </s:iterator>
					    </select>
					</td>
					<td style="padding-left:15px">
						<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
						<a class="easyui-linkbutton" data-options="iconCls:'icon-export'" onclick="exportExcel()">导出</a>&nbsp;
					</td>
				</tr>	
			</table>
	       </s:form>
          </div>
	    </div>
	    <div region='center' id="riskDistributionChart" style='padding:0px;margin:0px;height:90px;overflow:auto;' title='风险分布图'>
            <s:if test="${!search}">
                <iframe  width="100%" height="400" scrolling="no" src="/ais/pages/riskManagement/statistics/riskDistribute/riskDistributeChart.jsp" frameborder="0"></iframe>
            </s:if>
            <s:else>
                <iframe  width="100%" height="400" scrolling="no" src="/ais/pages/riskManagement/statistics/riskDistribute/riskDistributeChart2.jsp?dept=${dept}&year=${year}" frameborder="0"></iframe>
            </s:else>
	    </div>
	    <div region='south' align="center" style="margin:0px auto; height:150px;width:500px;" title="风险分布统计表">
	    	<form action="exportExcel" namespace="/riskManagement/statistics/riskDistribute" id="distributeTable" >
				<table class="table table-striped" id="myTable" style="width:100%;border-collapse:collapse;">
	    			<tr>
	    				<td class="EditHead" style="width:10%;text-align:center">风险大类</td>
	    				<td class="EditHead" style="width:10%;text-align:center">高</td>
	    				<td class="EditHead" style="width:10%;text-align:center">中</td>
	    				<td class="EditHead" style="width:10%;text-align:center">低</td>
	    				<td class="EditHead" style="width:10%;text-align:center">合计</td>
	    			</tr>
	    		   
				<s:iterator value="list" id="distributeChart">
					  <tr>
					  	<td class="editTd"><s:property value="#distributeChart.sort"/></td>
					  	<td class="editTd"><s:property value="#distributeChart.high"/></td>
					  	<td class="editTd"><s:property value="#distributeChart.middle"/></td>
					  	<td class="editTd"><s:property value="#distributeChart.low"/></td>
					  	<td class="editTd"><s:property value="#distributeChart.sum"/></td>
					  </tr>
				</s:iterator>   
				</table>	
			</form>
			<s:form id="exportForm"></s:form>			
		</div>
  <script type="text/javascript">
  function doSearch(){
		document.forms[0].action="${contextPath}/riskManagement/statistics/riskDistribute/distributeSearch.action";
		document.forms[0].submit();
  }
  function exportExcel(){
	  var dept = $('#affiliatedDeptId').val();
	  var year = $('#evaluateYear').val();
	  
	  exportForm.action="${contextPath}/riskManagement/statistics/riskDistribute/exportExcel.action?dept="+dept+"&year="+year;
	  exportForm.submit();
  } 
  </script>
  </body>
</html>
