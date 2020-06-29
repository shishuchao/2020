<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/boot.js"></script>		
		<script language="javascript" type="text/javascript">   
		  function   selall_inform(chk,selected)   
		  {   
		    if   (selected==null   ||   selected===''   )   selected=true;   
		    for(var   i=0;i<chk.length;i++)   chk[i].checked=selected;   
		  }  
		</script>
		<script language="javascript" type="text/javascript">
		
		function declareExport(bool)
		{
			document.getElementById('export').value=bool;
			return true;
		}	
		function goEdit(t){
           location.href='${contextPath}/mng/examproject/members/audProjectMembersInfo/edit.action?project_members_id='+t ;  
        }
       
       </script>
		<title>参与审计项目历史</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	</head>
	<body>
	<s:form action="toJoinAuditProjectHistoryList" namespace="/mng/examproject/members/audProjectMembersInfo" method="post">
		<s:hidden name="employeeInfo.id" value="${employeeInfo.id}"/>
		<div align="center">
		<display:table name="list" id="row" class="its"
			requestURI="${contextPath}/mng/examproject/members/audProjectMembersInfo/toJoinAuditProjectHistoryList.action" 
			pagesize="${helper.pageSize}" partialList="true" 
			size="${helper.totalRows}" sort="external"
			defaultsort="2" defaultorder="descending"  >	
			<display:column value="${row.pro_type_name}" title="项目类别" sortName="pso.pro_type_name" sortable="true" headerClass="center" 
				style="WHITE-SPACE: nowrap" class="center"/>
			<display:column value="${row.project_name}" title="项目名称" sortName="pso.project_name" sortable="true" headerClass="center" style="WHITE-SPACE: nowrap;width:120" class="center">
			</display:column>
			
			<display:column title="项目角色" headerClass="center" class="center">
				<c:forEach items="${row.proMembers}" var="proMember">
					 <c:if test="${proMember.userId==employeeInfo.sysAccounts}">					 	
						<c:out value="${proMember.roleName}" />
					 </c:if>
				</c:forEach>
			</display:column>	
			
			<display:column value="${row.real_start_time}" title="启动时间" sortName="pso.real_start_time" sortable="true" headerClass="center" style="WHITE-SPACE: nowrap" class="center"/>
			<display:column value="${row.real_closed_time}" title="关闭时间" sortName="pso.real_closed_time" sortable="true" headerClass="center" style="WHITE-SPACE: nowrap" class="center"/>
			
			<display:column value="${row.audit_dept_name}" title="所属单位" sortName="pso.audit_dept_name" sortable="true" headerClass="center" style="WHITE-SPACE: nowrap" class="center"/>
			<display:column value="${row.audit_object_name}" title="被审单位" sortName="pso.audit_object_name" sortable="true" headerClass="center" class="center"/>
			<display:column title="绩效评分" headerClass="center" class="center">
				<c:forEach items="${row.proMembers}" var="proMember">
					 <c:if test="${employeeInfo.sysAccounts==proMember.userId}">					 	
					 	<c:choose>
							<c:when test="${proMember.score == '4'}">
								<c:out value="优秀" />
    						</c:when>
    						<c:when test="${proMember.score == '3'}">
								<c:out value="良好" />
    						</c:when> 
    						<c:when test="${proMember.score == '2'}">
								<c:out value="合格" />
    						</c:when> 
    						<c:when test="${proMember.score == '1'}">
								<c:out value="不合格" />
    						</c:when>
  						</c:choose>
					 </c:if>
				</c:forEach>
			</display:column>	
			<display:column title="分工事项" headerClass="center" class="center">
				<a href="javascript:void(0);"
					onclick="window.parent.parent.viewDesc('${row.formId}','${employeeInfo.sysAccounts}');">详情</a>
			</display:column>			
		</display:table>
		</div>
		<s:if test="list.size!=0">
					<br>
					<div align="right">
						<s:hidden id="export" name="export"></s:hidden>
						<s:submit value="导出" onclick="return declareExport('true');"></s:submit>
					</div>
				</s:if>
			</s:form>	
					
	</body>
</html>
