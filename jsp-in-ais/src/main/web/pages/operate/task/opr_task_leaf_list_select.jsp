
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@page import="ais.user.model.UUser"%>


              <%  
				UUser user = (UUser)session.getAttribute("user");		
			%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<s:text id="title" name="''"></s:text>
		<title><s:property value="#title" />列表</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">

		<script type="text/javascript">
		
		function getCheckValue2(){
			var arr=document.getElementsByName("taskTemplateId");
			var v="";
			var tt="0";
			if(arr&&arr.length!=0){
				for(var i=0;i<arr.length;i++){
					if(arr[i].checked==true){
						v=arr[i].value;
						tt="1";
						break;
					}
				}
			}
			if(tt=="1"){
			  var array1=v.split(";");
	          var taskAssign=array1[0];
	          var key=array1[1];
	          var value=array1[2];
		      var flag="0";
    	      var array = taskAssign.split(",");
    	      
    	    if(array!=null&&array.length>0){
    	      for(var i=0;i<array.length;i++){
    	        if(array[i]=="<%=user.getFloginname()%>"){
    	         flag="1";
    	         break;
    	    }
    	  }
    	}
    	if(taskAssign==""){
    	  flag="1";
    	}
    	if(flag==0){
    	   alert("您没有权限增加！");
    	   return false;
    	}else{
    	  var ss="1,"+key+","+value;
    	  return ss;
    	}
		} 
			return v
     }
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
		     showPopWin('${contextPath}/operate/task/addLeaf.action?tab=proc&type=2&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&project_id=<%=request.getParameter("project_id")%>',720,600,title);
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
          function showContentLeafView(s,q)
		  { 
			 window.open("${contextPath}/operate/task/showContentLeafView.action?taskTemplateId="+s+"&project_id="+q,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
		   } 
		     //编辑
          function showContentLeaf(s,q)
		  { 
			 window.open("${contextPath}/operate/task/showContentLeafEdit.action?taskTemplateId="+s+"&project_id="+q,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
		   } 
		     //删除
          function deleteLeafList(s,q,t)
		  { 
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
		<input type=hidden id="paraidvalue" value=""><input type=hidden id="paranamevalue" value="">
			<form id="myform" name="my_form" onsubmit="return true;"
				action="/ais/operate/template/showContentLeafList.action" method="post" style="">
				<s:hidden name="project_id" />
				<s:hidden name="taskPid" />
				<s:hidden name="taskId" />
				<display:table name="list" id="row"
					requestURI="${contextPath}/operate/task/showContentLeafListSelect.action" class="its"
					pagesize="10" partialList="true" size="resultSize">

 


					
                    <display:column title="选择" headerClass="center"  style="WHITE-SPACE: nowrap" 
                    class="center" > 
                    <input type="radio" value="${row.taskAssign};${row.taskTemplateId};${row.taskName}" name="taskTemplateId" > 
                    </display:column>
					<display:column property="taskName" title="审计程序"
						headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
						class="center" sortable="true"></display:column>
					<display:column property="taskCode" title="程序编码"
						headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
						class="center" sortable="true"></display:column>
					<display:column property="taskAssignName" title="执行人"
						headerClass="center" maxLength="4" style="WHITE-SPACE: nowrap"
						class="center" sortable="true"></display:column>
					<display:column  title="是否必做"
						headerClass="center" maxLength="60" style="WHITE-SPACE: nowrap"
						class="center" sortable="true">
						<s:if test="${row.taskMust=='1'}">是</s:if><s:else>否</s:else> 
						</display:column>	
					<display:column title="操作" headerClass="center"
					style="WHITE-SPACE: nowrap" class="center">
					<a href="javascript:void(0);" onclick="showContentLeafView('${row.taskTemplateId}','${row.project_id}')">查看</a>&nbsp;&nbsp;
					
	                      </display:column>

				</display:table>
				<br>
				<br>
				<div align="center">
					
				</div>
		</center>
		</form>
	</body>
</html>
