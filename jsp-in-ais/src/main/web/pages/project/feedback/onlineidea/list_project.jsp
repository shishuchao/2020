<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目反馈意见</title>
		<!-- 引入css和js -->
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />
		<!-- 时间前后校验 -->
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script> 
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>			
		<SCRIPT type="text/javascript"
				src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
	</head>
	<script type="text/javascript">
	/*
	 * 重置
	 */
	function restal(){
		document.getElementsByName("issuesObject.processType")[0].value = "";
		document.getElementsByName("projectStartObject.project_name")[0].value = "";
		document.getElementsByName("projectStartObject.pro_type")[0].value = "";
		document.getElementsByName("projectStartObject.audit_dept")[0].value = "";
		document.getElementsByName("projectStartObject.audit_dept_name")[0].value = "";
	}
	/*
     * 关闭和隐藏查询条件
     */
	
	function triggerSearchTable(){
		var isDisplay = document.getElementById('searchTable').style.display;
		if(isDisplay==''){
			document.getElementById('searchTable').style.display='none';
		}else{
			document.getElementById('searchTable').style.display='';
		}
	}
	//查询时间校验
	function check_time(){
		var start_time = document.getElementById("issue_start_time")[0].value;
		var end_time = document.getElementById("issue_end_time")[0].value;
		var delay_time = document.getElementById("issue_delay_time")[0].value;
		if(start_time!=null && end_time!=null){
			if(!compareDate(start_time,end_time))
				alert("结束征求时间要大于开始征求时间！");
		}	
		if(start_time!=null && delay_time!=null){
			if(!compareDate(start_time,delay_time))
				alert("延期征求时间要大于开始征求时间！");
		}
	}
	</script>
	<body>
		<table cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce"
			class="ListTable" width="100%" align="center">
			<tr class="listtablehead">
					<td colspan="4" class="edithead" style="text-align: left;width: 100%;">
						<div style="display: inline;width:80%;">
							项目反馈意见
						</div>
						<div style="display: inline;width:20%;text-align: right;">
							<a href="javascript:;" onclick="triggerSearchTable();">查询条件</a>
						</div>
					</td>
				</tr>
		</table>
			<center>
		<s:form name="searchFeedback" method="post">

		<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable" id="searchTable" style="display: none;">
					
					<tr class="listtablehead">

						<td align="left" class="listtabletr1">
							项目名称
						</td>
						<td align="left" class="listtabletr1">
							<s:textfield name="projectStartObject.project_name" size="28" />
						</td>
						<td align="left" class="listtabletr1">
							反馈类型
						</td>
						<td align="left" class="listtabletr1">
							<s:select name="issuesObject.processType" cssStyle="width:60%"
								list="#@java.util.LinkedHashMap@{'report':'终结反馈','rework':'整改反馈'}" headerKey="" headerValue=""></s:select>
	
						</td>

					</tr>
					
					<tr class="listtablehead">
						<td align="left" class="listtabletr1">
							项目类别
						</td>
						<td class="ListTableTr22">
							<s:doubleselect id="pro_type" doubleId="pro_type_child" cssStyle="width:60%"
								doubleList="basicUtil.planProjectTypeMap[top]" doubleListKey="code"
								doubleListValue="name" listKey="code" listValue="name"
								name="projectStartObject.pro_type" list="basicUtil.planProjectTypeMap.keySet()"
								doubleName="projectStartObject.pro_type_child" theme="ufaud_simple"
								templateDir="/strutsTemplate"
								display="${varMap['pro_typeRead']}" emptyOption="true"/>
						</td>
						<td align="left" class="listtabletr1">
							审计单位
						</td>
						<td align="left" class="listtabletr22">
							<s:buttonText name="projectStartObject.audit_dept_name" size="28"
								hiddenName="projectStartObject.audit_dept"
								doubleOnclick="showPopWin('/pages/system/search/searchdata.jsp?url=/systemnew/orgList.action&p_item=1&orgtype=1&paraname=projectStartObject.audit_dept_name&paraid=projectStartObject.audit_dept',600,350,'组织机构选择')"
								doubleSrc="/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0;" readonly="true"
								display="true" doubleDisabled="false" />
						</td>
					</tr>
					
				
					<tr class="listtablehead" align="right">
						<td colspan="4" align="right" class="listtabletr1">
							<div align="right">
								<s:submit  title="查询档案列表"
									value="查 询" onclick="return check_time();"/>
								&nbsp;&nbsp;
								<s:button onclick="restal()" title="重置查询条件" value="重 置" />
							</div>
						</td>
					</tr>
				</table>	
			</s:form>
	
		<display:table id="row" name="issuesProjectStartlist" 
				class="its" requestURI="${contextPath}/project/feedback/online/issuesProjectList.action"
				pagesize="${baseHelper.pageSize}" partialList="true" 
				size="${baseHelper.totalRows}" sort="external"
				defaultsort="2" defaultorder="descending">
				<display:column title="项目名称" headerClass="center" class="center"
					 sortable="true" sortName="pso.project_name">${row[0].project_name}</display:column>
				<display:column title="反馈类型" headerClass="center" class="center"
					 sortable="true" sortName="io.processType">
					 <s:if test="${row[1].processType=='report'}">
					 	终结意见反馈
					 </s:if><s:else>
					 	整改结果反馈
					 </s:else>
					 </display:column>					
				<display:column title="项目类别" headerClass="center" class="center"
					 sortable="true" sortName="pso.pro_type_name">${row[0].pro_type_name}</display:column>
				<display:column title="审计单位" headerClass="center" class="center"
					 sortable="true" sortName="pso.audit_dept_name">${row[0].audit_dept_name}</display:column>
				<display:column title="开始征求日期" headerClass="center" class="center"
					 sortable="true" sortName="io.issue_start_time">${row[1].issue_start_time}</display:column>
				<display:column title="结束征求日期" headerClass="center" class="center"
					 sortable="true" sortName="io.issue_end_time">${row[1].issue_end_time}</display:column>
				<display:column title="延期征求日期" headerClass="center" class="center"
					 sortable="true" sortName="io.issue_delay_time">${row[1].issue_delay_time}</display:column>	 
				<display:column title="操作" headerClass="center" class="center">
					<s:if test="${row[1].currentFeedback=='true' && ((row[1].processType=='report' && (row[0].report_closed=='0' || row[0].report_closed==null)) or 
								row[1].processType=='rework' && (row[0].rework_closed=='0' || row[0].rework_closed==null))}">
						<s:a href="${contextPath}/project/feedback/online/feedbackInfo.action?issue_id=${row[1].issue_id}">反馈</s:a>
					</s:if>
					<s:else>
						<s:a href="${contextPath}/project/feedback/online/feedbackInfo.action?issue_id=${row[1].issue_id}">查看</s:a>
					</s:else>
				</display:column>					
				<display:setProperty name="paging.banner.placement" value="bottom" />
			</display:table>
		</center>
	</body>
</html>
