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
	 * 选择项目进行下达
	 * (暂未使用)
	 */		
	function  projectList_str(myform){
	  var str = "";		
	  var return_url ;
		for (var i = 0; i < document.getElementsByName("proCode").length; i++) {
			var el = document.getElementsByName("proCode")[i];
			if (el.type == "checkbox") {
				if (el.checked) {
				if(i!=document.getElementsByName("proCode").length-1)
							{
								if(el.checked)
								{
									str = str + el.value + ",";	
								
								}
							}
							else{
						 	if(el.checked)
								{
									str = str + el.value + ",";	
								}
							}			
				}
			}
		}      
		if(str==null || str ==""){
		alert("请选择需要导出的项目信息！");
		}else{
				    var url = "${contextPath}/interact/interactProxyToWork/mutualToWork.action?page_project_codeList="+str;
				    var url1 = encodeURI(url);
				    var url2 = encodeURI(url1);
				    return_url = url2;
	       		    //window.location = url2;
	
	          }
	          return return_url;
	}
	/*
	 * 下达项目数据
	 */			
	function exportToWork(myform){
	    var url = "${contextPath}/interact/interactProxyToWork/mutualToWork.action";
	    myform.action = url;
	    myform.submit();
	}
</script>
			
			
	<body>
		<center>
             <s:form action="mutualToWork" namespace="/interact/interactProxyToWork"   id="myform">
             
             <h5>审计项目管理－交互管理模块:</h5>
             <br>
               <h5>选择并下达项目数据</h5>
                <display:table id="row" name="projectList" pagesize="10"
					           class="its"
					requestURI="${contextPath}/interact/interactProxyToWork/downloadFileToWork.action">
					
				   <%--<display:column title="选择" media="html" headerClass="center"
						class="center">
						<input type="checkbox" name="proCode" value="${row.project_code}" />
					</display:column> 
					--%>
					<display:column title="项目编号" headerClass="center" class="center"
						property="project_code" maxLength="10" sortable="true" ></display:column>
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
					    <%-- 
					    <input type="button" name="Submit" value="全选"
							onClick="selectAll(myform)">
						&nbsp;
						<input type="button" name="Submit2" value="反选"
							onClick="inverse(myform)">
						--%>
						&nbsp;
						用户名：<s:textfield  name="username"  />
						
						密码：<s:textfield  name="fpassword"  />
					 	<s:button  value="下达项目数据" title="从管理系统下达项目数据至作业" onclick="exportToWork(myform);" />

   </div>         
			</s:form>
		</center>
	</body>
</html>
