<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML >
<html>
<title>项目信息详情</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>  
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
	
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' id="aylayout" class='easyui-layout' border='0' fit='true'>
		<div style="padding-top:10px">			
			<div id="proTab" class="easyui-tabs" border="false" style="width:100%;overflow:hidden">		
				<div title="在审项目" selected="true" style="padding:10px;width:100%">
					<table  class="table table-striped"id="mTable" style="width:100%;border-collapse:collapse;" >					
							<thead>
							    <tr>
							      <th class="EditHead" style="width:5%;text-align:center">序号</th>
							      <th class="EditHead" style="width:10%;text-align:center">审计项目名称</th>
							      <th class="EditHead" style="width:10%;text-align:center">工程项目名称</th>
							      <th class="EditHead" style="width:10%;text-align:center">审计类型</th>
							      <th class="EditHead" style="width:10%;text-align:center">审计单位</th>
							      <th class="EditHead" style="width:10%;text-align:center">送审单位</th>
							      <th class="EditHead" style="width:5%;text-align:center">项目负责人</th>
							      <th class="EditHead" style="width:5%;text-align:center">项目组成员</th>
							      <th class="EditHead" style="width:10%;text-align:center">中介机构名称</th>
							      <th class="EditHead" style="width:5%;text-align:center">中介机构人员</th>
							      <th class="EditHead" style="width:10%;text-align:center">项目开始时间</th>
							      <th class="EditHead" style="width:10%;text-align:center">项目结束时间</th>
							    </tr>
		  					</thead>
		  					<tbody>
		  						<c:forEach items="${processList}" var="process" varStatus="num">
				  					<tr>
				  						<td class="editTd" >${num.count}</td>
				  						<td class="editTd" >${process.audProjectName}</td>
				  						<td class="editTd">${process.eaProjectName}</td>
					  					<td class="editTd" >${process.audType}</td>
					  					 <td class="editTd" >${process.audObjectNames }</td>
				  						<td class="editTd">${process.audUnit}</td>
					  					<td class="editTd" >${process.proHeader}</td>
					  					<td class="editTd" >${process.memberNames}</td> 
				  						<td class="editTd">${process.agencyNames}</td>
					  					<td class="editTd" >${process.agMemberNames}</td>
					  					<td class="editTd" >${process.projectStartTime}</td>
					  					<td class="editTd" >${process.projectEndTime}</td>
				  					</tr>	
		  						</c:forEach>
		  					</tbody>
						</table>
				</div>
				<div title="已审项目" closable="false" style="padding:10px;width:100%">
					<table  class="table table-striped"id="mTable" style="width:100%;border-collapse:collapse;" >					
							<thead>
							    <tr>
							      <th class="EditHead" style="width:5%;text-align:center">序号</th>
							      <th class="EditHead" style="width:10%;text-align:center">审计项目名称</th>
							      <th class="EditHead" style="width:10%;text-align:center">工程项目名称</th>
							      <th class="EditHead" style="width:10%;text-align:center">审计类型</th>
							      <th class="EditHead" style="width:10%;text-align:center">审计单位</th>
							      <th class="EditHead" style="width:10%;text-align:center">送审单位</th>
							      <th class="EditHead" style="width:5%;text-align:center">项目负责人</th>
							      <th class="EditHead" style="width:5%;text-align:center">项目组成员</th>
							      <th class="EditHead" style="width:10%;text-align:center">中介机构名称</th>
							      <th class="EditHead" style="width:5%;text-align:center">中介机构人员</th>
							      <th class="EditHead" style="width:10%;text-align:center">项目开始时间</th>
							      <th class="EditHead" style="width:10%;text-align:center">项目结束时间</th>
							    </tr>
		  					</thead>
		  					<tbody>
		  						<c:forEach items="${completeList}" var="complete" varStatus="num">
				  					<tr>
				  						<td class="editTd" >${num.count}</td>
				  						<td class="editTd" >${complete.audProjectName}</td>
				  						<td class="editTd">${complete.eaProjectName}</td>
					  					<td class="editTd" >${complete.audType}</td>
					  					<td class="editTd" >${complete.audObjectNames}</td>
				  						<td class="editTd">${complete.audUnit}</td>
					  					<td class="editTd" >${complete.proHeader}</td>
					  					<td class="editTd" >${complete.memberNames}</td>
				  						<td class="editTd">${complete.agencyNames}</td>
					  					<td class="editTd" >${complete.agMemberNames}</td>
					  					<td class="editTd" >${complete.projectStartTime}</td>
					  					<td class="editTd" >${complete.projectEndTime}</td>
				  					</tr>	
		  						</c:forEach>
		  					</tbody>
						</table>
					</div>					
				</div>  
			</div>
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>