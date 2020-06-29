<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
	<head>
		<s:head theme="ajax" />
		<title>系统通知</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>

		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
			
			
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script>
//调用父窗口方法
function useParentFun(){
this.opener.stopx();  
}

function viewInfo(id,link){
var url;
if(link!=null && link!=''){
url = "${contextPath}/"+link;
window.open(url,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
}else{
url = "${contextPath}/bpm/systemprompt/viewDetailSystemPrompt.action?id="+id;
window.location = url;
}

}
</script>

	</head>
<body  onload="refurbishit()">
		<form>
		<br>
<s:tabbedPanel id='test' theme='ajax'>
<s:if test="sysList!=null && sysList.size!=0" >
<s:div id='sys' label='系统通知' theme='ajax'
							labelposition='top' loadingText="正在加载内容......">
	<display:table name="sysList" id="row"
					requestURI="/portal/simple/sysView.action"
					pagesize="5" class="its" cellpadding="1" >
					<display:column title="通知内容" headerClass="center" class="center">
				     <s:a href="javascript:void(0);" onclick="viewInfo('${row.id}','${row.link}');">${row.description}</s:a>
				     </display:column>
				     <%--
					<display:column property="description" title="通知内容" maxLength="7"
						 style="WHITE-SPACE: nowrap" headerClass="center" class="center"></display:column>
					--%>
					<display:column property="sendUserName" title="发送人"
						 style="WHITE-SPACE: nowrap" headerClass="center" class="center"></display:column>
					<display:column property="createTime" title="发送时间"
						 style="WHITE-SPACE: nowrap" headerClass="center" maxLength="11" class="center"></display:column>
    </display:table>
		<br>
</s:div>
</s:if>

<s:if test="taskInstanceList!=null && taskInstanceList.size!=0" >
<s:div id='pending' label='待办任务' theme='ajax'
							labelposition='top' loadingText="正在加载内容......">
<display:table name="taskInstanceList" id="row"
					requestURI="/portal/simple/sysView.action"
					pagesize="5" class="its" cellpadding="1" >
				<display:column property="processName" title="流程名称" sortable="true"
					headerClass="center" class="center"></display:column>
				<display:column property="name" title="任务名称" sortable="true"
					headerClass="center" class="center"></display:column>
				<display:column title="创建时间" sortable="true" headerClass="center"
					class="center">
					<c:set var="create" value="${row.create}" scope="request"></c:set>
					<s:date name="#request.create" format="yyyy-MM-dd HH:mm:ss" />
				</display:column>
</display:table>
							
<br>
</s:div>		
</s:if>		
<s:if test="memList!=null && memList.size!=0" >
<s:div id='mem' label='审计备忘' theme='ajax'
							labelposition='top' loadingText="正在加载内容......">
	<display:table name="memList" id="row"
					requestURI="/portal/simple/sysView.action"
					pagesize="5" class="its" cellpadding="1" >
					<display:column title="审计备忘" headerClass="center" class="center">
				     <s:a href="javascript:void(0);" onclick="viewInfo('${row.id}','${row.link}');">${row.description}</s:a>
				     </display:column>
				     <%--
					<display:column property="description" title="通知内容" maxLength="7"
						 style="WHITE-SPACE: nowrap" headerClass="center" class="center"></display:column>
					--%>
					<display:column property="sendUserName" title="发送人"
						 style="WHITE-SPACE: nowrap" headerClass="center" class="center"></display:column>
					<display:column property="createTime" title="发送时间"
						 style="WHITE-SPACE: nowrap" headerClass="center" maxLength="11" class="center"></display:column>
    </display:table>
		<br>
</s:div>
</s:if>
</s:tabbedPanel>		
		</form>
		
		<br><br><br>
		
		<div align="center">
		<s:button value="关 闭" onclick="javascript:window.close();"/>
		&nbsp;&nbsp;
<%--		<s:button value="不再提示" onclick="useParentFun();"/>--%>
		</div>
	<script language="JavaScript">
　　function refurbishit() {
    //window.opener.location.href=window.opener.location.href; //刷新父窗口
　　//setTimeout('window.close()',3000);//间隔10秒钟自动关闭
　  //setTimeout('window.location.href=window.location.href',10000);//间隔10秒钟自动刷新
　　}
　 </script>
	</body>
</html>

