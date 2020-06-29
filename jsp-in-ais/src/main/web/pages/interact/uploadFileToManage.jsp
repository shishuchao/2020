<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
			<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	
		<title>管理系统-作业交互</title>
		<s:head />
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/ais_functions.js"></script>
			
	<script>	
	/*
	 * 提取作业数据
	 */	
	function importToManage(){
		var url ="${contextPath}/interact/interactProxyToWork/uploadWork.action";
		var num=Math.random();
        var rnm=Math.round(num*9000000000+1000000000);/*随机参数清除模态窗口缓存*/
        window.showModalDialog(url,'dialogWidth:900px;dialogHeight:200px;status:yes');
	}
	</script>
			
			
	<body>
		<center>
             <s:form action="mutualToWork" namespace="/interact/interactProxyToWork"   id="myform">
             
             <h5>审计项目管理－交互管理模块:</h5>
             <br>
               <h5>选择并提取作业数据</h5>
                <display:table id="row" name="projectList" pagesize="10"
					           class="its"
					requestURI="${contextPath}/interact/interactProxyToWork/uploadFileToManage.action">
					
					<display:column title="项目编号" headerClass="center" class="center"
						property="project_code" maxLength="10" sortable="true"></display:column>
					<display:column title="项目名称" headerClass="center" class="center"
						property="project_name" maxLength="10" sortable="true"></display:column>
					<display:column title="开始日期" headerClass="center" class="center"
						property="real_start_time" sortable="true"></display:column>
					<display:column title="结束日期" headerClass="center" class="center"
						property="real_closed_time" sortable="true"></display:column>
					<display:column title="审计单位" headerClass="center" class="center"
						property="audit_dept_name" maxLength="10" sortable="true"></display:column>
					
						</display:table>
		<div align="right">
               <s:button  value="提取作业数据" title="从作业提取数据至管理系统"  onclick="importToManage();" />	
   		</div>         
			</s:form>
		</center>
	</body>
</html>
