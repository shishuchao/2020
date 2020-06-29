
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<s:text id="title" name="''"></s:text>
<title><s:property value="#title" />列表</title>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
          function baogao(){
            window.open("/ais/pages/operate/manu/general_edit_redirect.jsp?pro_id=${pro_id}","baogao","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
          }
          
          function taizhang(s){
            window.open("/ais/proledger/problem/listEditProblem.action?project_code=${pro_id}&&manuscript_code="+s+"&&view=add","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
          }
          function add(){
             window.location.href='/ais/operate/manu/edit.action?type=${type}&pro_id=${pro_id}&taskId=${taskId}&taskPid=${taskPid}';
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
          function viewRecord(s)
		  {
		     
						//alert(doubt_idArray[i].value); 
						//if(confirm("确认删除这条记录?")){
						
						//window.location.href='/ais/operate/doubt/delete.action?type=${type}&doubt_id='+doubt_idArray[i].value;
						//document.getElementsByName("doubt_id")[0].value=doubt_idArray[i].value;
						window.open("${contextPath}/operate/manu/view.action?crudId="+s,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	                   // myform.submit();
	            
		   } 
     </script>
</head>
<body>
<center>
		<form id="myform" name="my_form" onsubmit="return true;"
			action="/ais/operate/manu/search.action" method="post" style="">
			<s:hidden name="pro_id" />
			<s:hidden name="taskPid" />
			<s:hidden name="taskId" />
<display:table name="list" id="row" requestURI="${contextPath}/operate/manu/search.action" class="its" pagesize="10" partialList="true" size="resultSize">
  

	<display:column property="ms_statusName" title="底稿状态" headerClass="center"  maxLength="12" style="WHITE-SPACE: nowrap" class="center"  sortable="true"></display:column>	
	
	<display:column property="ms_code" title="底稿编码"  headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap" class="center" sortable="true"></display:column>	
	
		
		
		
		
	
		
	<display:column property="ms_name" title="底稿名称" headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap" class="center" sortable="true"></display:column>	
	
	<display:column property="ms_author_name" title="提交人"  headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap" class="center" sortable="true"></display:column>
	
	
	<display:column property="ms_date" title="提交日期"  headerClass="center" maxLength="10" style="WHITE-SPACE: nowrap" class="center" sortable="true"></display:column>			
<display:column title="操作" headerClass="center"
					style="WHITE-SPACE: nowrap" class="center">
					<a href="javascript:void(0);" onclick="editRecord('${row.formId}','${row.ms_status}','${row.ms_author}')">编辑</a>&nbsp;&nbsp;
					<a href="javascript:void(0);" onclick="deleteRecord('${row.formId}','${row.ms_status}','${row.ms_author}')">删除</a>&nbsp;&nbsp;
					<a href="javascript:void(0);" onclick="viewRecord('${row.formId}')">查看</a>&nbsp;&nbsp;
					<a href="javascript:void(0);" onclick="taizhang('${row.ms_code}')">项目台账</a>&nbsp;&nbsp;
	                      </display:column>

</display:table>
<br>
<br>
			<div align="center">
			    <input type="button" value="导出到报告" onclick="baogao()" />
			    <%
					String auth = (String) request.getAttribute("auth");
					String taskPid = (String) request.getAttribute("taskPid");
					if ("1".equals(auth) && !"-1".equals(taskPid)) {
				%>
				<input type="button" value="增加" onclick="add()" />

				<%
				}
				%>
				 
				 

			</div>
</center>
</form>
</body>
</html>
