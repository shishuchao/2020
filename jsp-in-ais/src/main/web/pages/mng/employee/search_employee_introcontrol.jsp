<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
  <head>
    <title>内控人员检索</title>
  	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="<%=request.getContextPath()%>/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/calendar.js"></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
		<script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
		<link rel="stylesheet" href="<%=basePath%>pages/introcontrol/util/themes/gray/easyui.css" type="text/css"></link>
		<link rel="stylesheet" href="<%=basePath%>pages/introcontrol/util/themes/icon.css" type="text/css"></link>
		<script type="text/javascript">
			function toSave(){
				var empForm = document.getElementById('emp');
				var cbxs = document.getElementsByName("employeeInfo_ids");
				var cbx_count = 0;
				var cbx_no = -1;
				for(var i=0;i<cbxs.length;i++){
					if(cbxs[i].checked){
						cbx_count++;
						cbx_no = i;
					}
				}
				if(cbx_no==-1){
					alert("请选择要保存的审计人员!");
					return false;
				}
				if( window.confirm('确认保存吗？')){
					empForm.action="<%=request.getContextPath()%>/project/saveMembers!introcontrolSaveMembers.action";
					jQuery("#goOnSearch").val("");
					empForm.submit();
				}
				
			}
			
			function toSaveAndSearch(){
				var empForm = document.getElementById('emp');
				var cbxs = document.getElementsByName("employeeInfo_ids");
				var cbx_count = 0;
				var cbx_no = -1;
				for(var i=0;i<cbxs.length;i++){
					if(cbxs[i].checked){
						cbx_count++;
						cbx_no = i;
					}
				}
				if(cbx_no==-1){
					alert("请选择要保存的审计人员!");
					return false;
				}
				if( window.confirm('确认保存吗？')){
					empForm.action="<%=request.getContextPath()%>/project/saveMembers!introcontrolSaveMembers.action";
					jQuery("#goOnSearch").val("y");
					empForm.submit();
				}
				
			}
		</script>
  </head>
  
<body>
	<s:form id="searchForm" action="searchEmployee!introcontrolSearchEmployee.action" namespace="/mng/employee">
			<s:hidden name="crudId" />
			<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" align="center" >
				<tr class="listtablehead">
					<td align="left" class="listtabletr11">
						项目类别：
					</td>
					<td align="left" class="listtabletr22">
						 <s:doubleselect id="pro_type" doubleId="pro_type_child"
							doubleList="basicUtil.planProjectTypeMap[top]"
							doubleListKey="code" doubleListValue="name" listKey="code"
							listValue="name" name="employeeInfo.pro_type"
							list="basicUtil.planProjectTypeMap.keySet()"
							doubleName="employeeInfo.pro_type_child" theme="ufaud_simple"
							templateDir="/strutsTemplate" display="${varMap['pro_typeRead']}"
							emptyOption="true" />
					</td>
					<td align="left" class="listtabletr11">
						人员资格：
					</td>
					<td align="left" class="listtabletr22">
						<s:select name="employeeInfo.competenceCode" headerKey="" headerValue="" list="basicUtil.competenceList4Search" listKey="code" listValue="name"/>
					</td>
				</tr>
				<tr class="listtablehead">
					<td align="left" class="listtabletr11">
						单位名称：
					</td>
					<td align="left" class="listtabletr22">
						 <s:buttonText name="employeeInfo.company" id="company" hiddenId="companyCode" hiddenName="employeeInfo.companyCode" cssStyle="width:80%"
							doubleOnclick="showPopWin('/pages/system/search/searchdata.jsp?url=/systemnew/orgList.action&paraname=employeeInfo.company&paraid=employeeInfo.companyCode&p_item=0&orgtype=1',600,350,'所属单位')"
							doubleSrc="/resources/images/s_search.gif" doubleCssStyle="cursor:hand;border:0" readonly="true" doubleDisabled="false"/>
					</td>
					<td align="left" class="listtabletr11">
						人员姓名：
					</td>
					<td align="left" class="listtabletr22">
						<s:textfield name="employeeInfo.name" cssStyle="width:100%" />
					</td>
				</tr>
				<tr class="listtablehead">
					<td align="right" class="listtabletr1" colspan="4">
						<DIV align="right">
						   <a onclick="searchForm.submit();" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'">人员搜索</a>
							&nbsp;
							<a onclick="window.location.href='${contextPath}/mng/employee/searchEmployee!introcontrolSearchEmployee.action?crudId=${crudId}'" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-redo'">重&nbsp;&nbsp;&nbsp;&nbsp;置</a>&nbsp;&nbsp;&nbsp;&nbsp;
						</DIV>
					</td>
				</tr>
			</table>
		</s:form>
		<form name="emp" id="emp" action="">
			<div align="center">
			    <input name="crudId" type="hidden" value="${crudId}" />
				<display:table id="row" name="list" pagesize="5"
						class="its" requestURI="${contextPath}/mng/employee/searchEmployee!introcontrolSearchEmployee.action">
					<display:column title="选择" headerClass="center"  class="center">
						<input name="employeeInfo_ids" type="checkbox" value="${row.id}"/>
					</display:column>
					<display:column property="name" title="姓名" headerClass="center"  class="center" style="WHITE-SPACE: nowrap" />
					<display:column property="company" title="单位名称" headerClass="center"  class="center" style="WHITE-SPACE: nowrap" />
					<display:column property="projectNames" title="被抽调项目" headerClass="center"  class="center" style="WHITE-SPACE: nowrap"  />
					<%--<display:column title="个人绩效得分" headerClass="center"  class="center" style="WHITE-SPACE: nowrap" sortable="true" />--%>					
					<display:setProperty name="paging.banner.placement" value="bottom"/>
				</display:table>
				<input type="hidden" id="goOnSearch" name="goOnSearch">
				<br/>				
			</div>
			<div align="right" style="width: 96%;">
			<a onclick="toSave()" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">提交选中</a>
			&nbsp;&nbsp;
			<a onclick="toSaveAndSearch()" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">提交选中并继续选择</a>
			&nbsp;&nbsp;
			<a onclick="window.location.href='${contextPath}/project/getlistMembers!introcontrolGetlistMembers.action?crudId=${crudId}'" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back'">&nbsp;返&nbsp;&nbsp;&nbsp;回</a>
			</div>
		</form>
</body>

</html>