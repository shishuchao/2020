
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<s:text id="title" name="''"></s:text>
		<title><s:property value="#title" />列表</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">

		<script type="text/javascript">
          function baogao(){
            window.open("/ais/pages/operate/manu/general_edit_redirect.jsp?project_id=${project_id}","baogao","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
          }
          
          function taizhang(s){
            window.open("/ais/proledger/problem/listEditProblem.action?project_code=${project_id}&&manuscript_code="+s+"&&view=add","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
          }
          function add1(){
             window.location.href='/ais/operate/manu/edit.action?type=${type}&project_id=${project_id}&taskId=${taskId}&taskPid=${taskPid}';
           }
           
           	function add()
		  {
	  	    var title="增加审计程序";
		     window.paramw = "模态窗口";
             //window.open('${contextPath}/operate/task/addLeaf.action?type=2&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&project_id=<%=request.getParameter("project_id")%>');
		     showPopWin('${contextPath}/operate/task/addLeaf.action?tab=proc&type=2&taskPid=${taskTemplateId}&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&project_id=<%=request.getParameter("project_id")%>',550,460,title);
		     var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
	                    
	} 
	 
           //删除
          function deleteRecord(s,q,p)
		  {
		  if('${user.floginname}'==p){
		                    //alert("123");
		                  }else{
		                    alert("没有权限删除！");
		                    return false;
		                  }
		                  
		                  if(q=='040'){
		                    alert("正在复核，不能删除！");
		                    return false;
		                  }else{
		                  }
		                  if(q=='050'){
		                    alert("已复核完毕，不能删除！");
		                    return false;
		                  }else{
		                  }
		     
						if(confirm("确认删除这条记录?")){
						
						//window.location.href='/ais/operate/doubt/delete.action?type=${type}&doubt_id='+doubt_idArray[i].value;
						//document.getElementsByName("manu_id")[0].value=doubt_idArray[i].value;
						myform.action = "${contextPath}/operate/manu/deleteManu.action?crudId="+s;
	                    myform.submit();
	                    }
	            
		   } 
		   
		  //编辑
          function editRecord(s,q,p)
		  {
		  if('${user.floginname}'==p){
		                    //alert("123");
		                  }else{
		                    alert("没有权限编辑！");
		                    return false;
		                  }
		                  
		                  if(q=='040'){
		                    alert("正在复核，不能编辑！");
		                    return false;
		                  }else{
		                  }
		                  
		                  if(q=='050'){
		                    alert("已复核完毕，不能编辑！");
		                    return false;
		                  }else{
		                  }
		     
						//window.location.href='/ais/operate/doubt/delete.action?type=${type}&doubt_id='+doubt_idArray[i].value;
						//document.getElementsByName("doubt_id")[0].value=doubt_idArray[i].value;
						myform.action = "${contextPath}/operate/manu/edit.action?crudId="+s;
	                    myform.submit();
	                    
		   } 
           
           //查看
          function showContentLeafView(s,q,a)
		  { 
			 window.open("${contextPath}/operate/task/showContentLeafView.action?taskPid="+a+"&taskTemplateId="+s+"&project_id="+q,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
		   } 
		     //编辑
          function showContentLeaf(s,p,q)
		  { 
			 //window.open("${contextPath}/operate/task/showContentLeafEdit.action?taskPid="+p+"&taskTemplateId="+s+"&project_id="+q);
		     title="编辑审计程序";
		     window.paramw = "模态窗口";
		     showPopWin("${contextPath}/operate/task/showContentLeafEdit.action?taskPid="+p+"&taskTemplateId="+s+"&project_id="+q,550,460,title);
		     var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		   } 
		     //删除
		     
	   function checkManu(s,q,t,tempId){
	    var resullt=''; 
	    var project_id=t;
	    var taskPid=q;
	    var taskId=tempId;
		DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/operate/task', action:'manuList', executeResult:'false' }, 
		{'project_id':project_id,'taskPid':taskPid,'taskId':taskId},xxx);
	     function xxx(data){
	     result =data['auth'];
         //alert(data['auth']);
		} 
	  if(result=='1'){
	     //alert("请先删除该审计事项下的底稿！");
	     return false;
	  }else{
	      return true;
	  }
	  
	}
		function checkDoubt(s,q,t,tempId){
	    var resullt=''; 
	    var project_id=t;
	    var taskPid=q;
	    var taskId=tempId;
		DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/operate/task', action:'doubtList', executeResult:'false' }, 
		{'project_id':project_id,'taskPid':taskPid,'taskId':taskId},xxx);
	     function xxx(data){
	     result =data['auth'];
         //alert(data['auth']);
		} 
	  if(result=='1'){
	     //alert("请先删除该审计事项下的疑点！");
	     return false;
	  }else{
	      return true;
	  }
	  
	}  
		     
		     
          function deleteLeafList(s,q,t,tempId)
		  { 
		   if(!checkManu(s,q,t,tempId)&&!checkDoubt(s,q,t,tempId)){
		     alert("请先删除该审计程序下的审计底稿和审计疑点！")
		    return false;
		    }else if(!checkManu(s,q,t,tempId)){
		     alert("请先删除该审计程序下的审计底稿！")
		    return false;
		    }else if(!checkDoubt(s,q,t,tempId)){
		     alert("请先删除该审计程序下的审计疑点！");
		    return false;
		    }
		  
		  if(confirm("确认删除吗？")){
			 window.location.href="${contextPath}/operate/task/deleteLeafList.action?pid="+q+"&taskTemplateId="+s+"&project_id="+t;
			} 
		   } 
     </script>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
		type="text/css">
	<link href="${contextPath}/resources/csswin/subModal.css"
		rel="stylesheet" type="text/css" />
	<!-- 引入dwr的js文件 -->
	<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='/ais/dwr/engine.js'></script>
	<script type='text/javascript' src='/ais/dwr/util.js'></script>
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type="text/javascript"
		src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript"
		src="${contextPath}/resources/csswin/subModal.js"></script>
	<SCRIPT type="text/javascript" src="${contextPath}/scripts/calendar.js"></SCRIPT>
	 
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" />
		</title>
	 
	</head>
	<body>
		<center>
			<form id="myform" name="my_form" onsubmit="return true;"
				action="/ais/operate/template/showContentLeafList.action" method="post" style="">
				<s:hidden name="project_id" />
				<s:hidden name="taskPid" />
				<s:hidden name="taskId" />
				<s:hidden name="taskTemplateId" /> 
				<display:table name="list" id="row"
					requestURI="${contextPath}/operate/task/showContentLeafEditList.action" class="its"
					pagesize="10" partialList="true" size="resultSize">

 


					<display:column property="taskName" title="审计程序"
						headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
						class="center" sortable="true"></display:column>

					<display:column property="taskCode" title="程序编码"
						headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
						class="center" sortable="true"></display:column>
					<display:column property="taskTarget" title="审计目的"
						headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
						class="center" sortable="true"></display:column>	
					<display:column property="taskAssignName" title="执行人"
						headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
						class="center" sortable="true"></display:column>
					<display:column  title="是否必做"
						headerClass="center" maxLength="60" style="WHITE-SPACE: nowrap"
						class="center" sortable="true">
						<s:if test="${row.taskMust=='1'}">是</s:if><s:else>否</s:else>
						</display:column>	
					<display:column title="操作" headerClass="center"
					style="WHITE-SPACE: nowrap" class="center">
					<s:if test="${teamAuth=='1'}">
				      <a href="javascript:void(0);" onclick="showContentLeaf('${row.taskTemplateId}','${row.taskPid}','${row.project_id}')">编辑</a>&nbsp;&nbsp;
					<a href="javascript:void(0);" onclick="deleteLeafList('${row.id}','${row.taskPid}','${row.project_id}','${row.taskTemplateId}')">删除</a>&nbsp;&nbsp;
					<a href="javascript:void(0);" onclick="showContentLeafView('${row.taskTemplateId}','${row.project_id}','${row.taskPid}')">查看</a>&nbsp;&nbsp;
					
                    </s:if>
                    <s:else>
                    <a href="javascript:void(0);" onclick="showContentLeafView('${row.taskTemplateId}','${row.project_id}','${row.taskPid}')">查看</a>&nbsp;&nbsp;
                    </s:else>
					
					
	                      </display:column>

				</display:table>
				<br>
				<br>
				<div align="center">
					<%
					String taskPid = (String) request.getParameter("taskPid");
					if (taskPid!=null&&!"null".equals(taskPid) && !"-1".equals(taskPid)) {
				%>
			   <s:if test="${teamAuth=='1'}">
				<input type="button" value="增加" onclick="add()" />
               </s:if>
				<%
				}else{
				%>
				 
				<%}%>
				</div>
		</center>
		</form>
	</body>
</html>
