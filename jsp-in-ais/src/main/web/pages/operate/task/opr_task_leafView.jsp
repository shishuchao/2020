<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
    <%-- <s:text id="title" name="'编辑审计事项'"></s:text> --%>
 	  <%	
	    String s = (String)request.getParameter("edit");
	    %>
<html>
<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   

	    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
		<title>
		<s:if test="'enabled' == '${shenjichengxu}'">
         <title><s:property value="#title" />
        </s:if>
		</title>
	</head>
	<body class='easyui-layout' >
		<div region="center" style="overflow: auto; width: 100%;height: 100%;">
		<s:if test="'enabled' == '${shenjichengxu}'">
            <table class="ListTable">
				<tr>
					<td colspan="5" align="left" class="editTd">
						<s:property value="#title" />
					</td>
				</tr>
			</table>
         </s:if>
			<s:form id="myform" onsubmit="return true;" action="/ais/operate/task" method="post" >
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr >
						<td class="EditHead">
							事项名称
						</td>
						<td  class="editTd" colspan="3">
						<s:property value="audTask.taskName"/>
						</td>
						 
					</tr>
                     <s:hidden name="audTask.taskTemplateId" />
                     <s:hidden name="audTask.taskPid" />
                     <s:hidden name="audTemplateId" />
                     <s:hidden name="taskTemplateId" />
                     <s:hidden name="audTask.templateId" />
                      <s:hidden name="audTask.id" />
                      <s:hidden name="audTask.project_id" />
					<%-- <tr>
						<td class="EditHead" style="width:20%">
						事项序号
						</td>
						<td class="editTd" style="width:35%">
						<s:property value="audTask.taskOrder"/>
						</td>						
						<td class="EditHead" style="width:15%">事项编码
						</td>
						<td class="editTd" style="width:30%">
							<s:property value="audTask.taskCode"/>
						</td>					
					</tr> --%>
<%-- 					<tr>
						<td class="EditHead">
							<font color="red"></font>&nbsp;&nbsp;&nbsp;执行人
						</td>
						<td class="editTd" colspan="3">
						<s:property value="audTask.taskAssignName"/>
						</td>
					</tr>  --%>
					<tr>
							<td class="EditHead" style="width: 130px">
								事项开始时间
							</td>
							<td class="editTd">
							<s:property value="audTask.taskStartTime"/>
							</td>
							<td class="EditHead" style="width: 130px">
								事项结束时间
							</td>
							<td class="editTd">
							<s:property value="audTask.taskEndTime"/>
							</td>
						</tr>
						
					 <s:if test="'enabled' == '${shenjichengxu}'">	
                  <tr >
						<td class="EditHead">
                                    是否必做
						</td>
						<!--标题栏-->
						<td class="editTd" colspan="3">
						<s:property value="audTask.taskMust"/>
						</td>
					</tr>
                   
                    </s:if>
                   
					<tr>
						<td class="EditHead">
							审计程序和方法
							
						</td>
						<td class="editTd" colspan="3">
							<%-- <s:property value="audTask.taskOther"/> --%>
							<s:textarea cssClass="noborder" name="audTask.taskOther"
								cssStyle="width:100%;height:80px;overflow-y:hidden;" />
						</td>
					</tr>
				    <tr>
						<td class="EditHead" style="width:170px">
							相关法律法规和监管规定
							
						</td>
						<td class="editTd" colspan="3">
							<%-- <s:property value="audTask.law"/> --%>
							<s:textarea cssClass="noborder" name="audTask.law"
								cssStyle="width:100%;height:80px;overflow-y:hidden;" />
						</td>
					</tr> 
					<tr>
						<td class="EditHead">
							所需资料
							
						</td>
						<td class="editTd" colspan="3">
							<%-- <s:property value="audTask.taskTarget"/> --%>
							<s:textarea cssClass="noborder" name="audTask.taskTarget" 
								cssStyle="width:100%;height:80px;overflow-y:hidden;" />
						</td>
					</tr>
				    <tr>
						<td class="EditHead">
							审计查证要点
							
						</td>
						<td class="editTd" colspan="3">
							<%-- <s:property value="audTask.taskMethod"/> --%>
							<s:textarea cssClass="noborder" name="audTask.taskMethod" 
								cssStyle="width:100%;height:80px;overflow-y:hidden;" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							重点关注内容
						</td>
						<td class="editTd" colspan=3>
							<%-- <s:property value="audTask.pointContent"/> --%>
							<s:textarea cssClass="noborder" name="audTask.pointContent" 
								cssStyle="width:100%;height:80px;overflow-y:hidden;" />
						</td>
					</tr>
					 <s:if test="${fromAdjust=='yes'}">
					<tr>
						<td class="EditHead">
							调整说明
						</td>
						<td class="editTd" colspan=3>
							<%-- <s:property value="audTask.taskFile"/> --%>
							<s:textarea cssClass="noborder" name="audTask.taskFile" 
								cssStyle="width:100%;height:80px;overflow-y:hidden;"/>
						</td>
					</tr>
					</s:if>
				</table>
                <s:hidden name="audTask.template_type"/>
				<s:hidden name="audTemplate.doubt_id" />
				<s:hidden name="audTask.haveLevel" />
				<s:hidden name="doubt_id" />
				<s:hidden name="audTask.taskProgress" />
				<s:hidden name="audTask.taskPcode" />
				<s:hidden name="type" />
				<s:hidden name="project_id" />
                <s:hidden name="path" />
                <s:hidden name="node" />
			</s:form>
		</div> 
	</body>
	<script type="text/javascript">
	$("#myform").find("textarea").each(function(){
		autoTextarea(this);
	});
	
	</script>
</html>
