
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
            window.open("/ais/pages/operate/manu/general_edit_redirect.jsp?pro_id=${pro_id}","baogao","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
          }
          
          function taizhang(s){
            window.open("/ais/proledger/problem/listEditProblem.action?project_code=${pro_id}&&manuscript_code="+s+"&&view=add","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
          }
          function add1(){
             window.location.href='/ais/operate/manu/edit.action?type=${type}&pro_id=${pro_id}&taskId=${taskId}&taskPid=${taskPid}';
           }
           
           	function add()
		  {
	  	     var type='<%=request.getParameter("type")%>';
		     title="增加审计程序";
		     window.paramw = "模态窗口";
             //window.open('${contextPath}/operate/template/addLeaf.action?type='+type+'&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>','leaf');
		     showPopWin('${contextPath}/operate/template/addLeaf.action?tab=proc&type='+type+'&taskPid=<%=request.getParameter("taskPid")%>&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>',550,460,title);
		     var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		     //window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
		     //document.getElementsByName("newDoubt_type")[0].value=s;
             //myform.action = "${contextPath}/operate/doubt/genDoubt.action";
	         //myform.submit();
	                    
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
          function showContentLeafView(s)
		  { 
			 window.open("${contextPath}/operate/template/showContentLeafView.action?taskTemplateId="+s,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
		   } 
		     //编辑
          function showContentLeaf(s)
		  { 
		     var type='<%=request.getParameter("type")%>';
		     title="编辑审计程序";
		     window.paramw = "模态窗口";
		     //window.open('${contextPath}/operate/template/showContentLeaf.action?type='+type+'&taskTemplateId='+s+'&audTemplateId=<%=request.getParameter("audTemplateId")%>','leaf','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
		     showPopWin('${contextPath}/operate/template/showContentLeaf.action?tab=proc&type='+type+'&tid=<%=request.getParameter("taskTemplateId")%>&taskTemplateId='+s+'&audTemplateId=<%=request.getParameter("audTemplateId")%>&taskPid=<%=request.getParameter("taskPid")%>',550,460,title);
		     var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		   } 
		   
		   
		   	function generateLeaf()
		  {
	 
		     title="增加审计程序";
		     window.paramw = "模态窗口";
             //window.open('${contextPath}/operate/template/addLeaf.action?taskTemplateId=<%=request.getParameter("taskTemplateId")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>','leaf');
		     showPopWin('${contextPath}/operate/template/showContentLeaf.action?type='+type+'&taskTemplateId='+s+'&audTemplateId=<%=request.getParameter("audTemplateId")%>',550,460,title);
		     var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		     //window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
		     //document.getElementsByName("newDoubt_type")[0].value=s;
             //myform.action = "${contextPath}/operate/doubt/genDoubt.action";
	         //myform.submit();
	                    
	}
		     //删除
          function deleteLeafList(s,q)
		  { 
		  if(confirm("确认删除吗？")){
			 window.location.href="${contextPath}/operate/template/deleteLeafList.action?pid="+q+"&taskTemplateId="+s+"&audTemplateId=<%=request.getParameter("audTemplateId")%>";
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
				<s:hidden name="pro_id" />
				<s:hidden name="taskPid" />
				<s:hidden name="taskId" />
				<display:table name="list" id="row"
					requestURI="${contextPath}/operate/template/showContentLeafList.action" class="its"
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
					<display:column property="taskAssign" title="执行人"
						headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
						class="center" sortable="true"></display:column>
					<display:column  title="是否必做"
						headerClass="center" maxLength="60" style="WHITE-SPACE: nowrap"
						class="center" sortable="true">
						<s:if test="${row.taskMust=='1'}">是</s:if><s:else>否</s:else> 
						</display:column>	
					<display:column title="操作" headerClass="center"
					style="WHITE-SPACE: nowrap" class="center">
					<a href="javascript:void(0);" onclick="showContentLeaf('${row.taskTemplateId}')">编辑</a>&nbsp;&nbsp;
					<a href="javascript:void(0);" onclick="deleteLeafList('${row.taskTemplateId}','${row.taskPid}')">删除</a>&nbsp;&nbsp;
					<a href="javascript:void(0);" onclick="showContentLeafView('${row.taskTemplateId}')">查看</a>&nbsp;&nbsp;
					
	                      </display:column>

				</display:table>
				<br>
				<br>
				<div align="center">
				<%
					String taskPid = (String) request.getParameter("taskPid");
					if (taskPid!=null&&!"null".equals(taskPid) && !"-1".equals(taskPid)) {
				%>
				<input type="button" value="增加" onclick="add()" />

				<%
				}else{
				%>
				 
				<%}%>
				</div>
		</center>
		</form>
	</body>
</html>
