<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:directive.page import="java.util.List" />
<jsp:directive.page import="ais.operate.task.model.AudDoubt" />
 

 


<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="审计日记" />
		</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link href="${contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>

		<script type="text/javascript">
          function add(){
             window.location.href='/ais/operate/diary/editDiary.action?pro_id=${pro_id}&taskId=${taskId}';
           }
           //删除
          function deleteRecord(s,q)
		  {             if('${user.floginname}'==q){
		                    //alert("123");
		                  }else{
		                    alert("没有权限删除！");
		                    return false;
		                  }
		                  
		    
						if(confirm("确认删除这条记录?")){
						
						//window.location.href='/ais/operate/doubt/delete.action?type=${type}&doubt_id='+doubt_idArray[i].value;
						//document.getElementsByName("doubt_id")[0].value=doubt_idArray[i].value;
						myform.action = "${contextPath}/operate/diary/delete.action?diary_id="+s;
	                    myform.submit();
	                    
		   } 
		  } 
		  //编辑
          function editRecord(s,q)
		  {
		                  //alert(s);
		                  //alert(p);
		                  //alert(q);
		                  //alert('${user.floginname}');
		                  if('${user.floginname}'==q){
		                    //alert("123");
		                  }else{
		                    alert("没有权限编辑！");
		                    return false;
		                  }
		                  
						//alert(doubt_idArray[i].value); 
						//if(confirm("确认删除这条记录?")){
						
						//window.location.href='/ais/operate/doubt/delete.action?type=${type}&doubt_id='+doubt_idArray[i].value;
						//document.getElementsByName("doubt_id")[0].value=doubt_idArray[i].value;
						myform.action = "${contextPath}/operate/diary/editDiary.action?diary_id="+s;
	                    myform.submit();
	            
           }
           //查看
          function viewRecord(s)
		  {
		     window.open("${contextPath}/operate/diary/view.action?diary_id="+s,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	         //myform.submit();
		   } 
     </script>
	</head>
	<body>


		<!--  <table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
			class="ListTable" width="100%" align="center">
			<tr class="listtablehead">
				<td colspan="5" align="left" class="edithead">
					<s:property
						escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/operate/doubt/search.action')" />
				</td>
			</tr>
		</table>
    -->

		<form id="myform" name="my_form" onsubmit="return true;"
			action="/ais/operate/doubt/search.action" method="post" style="">
			<s:hidden name="type" />
			<s:hidden name="pro_id" />
			<s:hidden name="taskPid" />
			<s:hidden name="taskId" />
			<display:table name="list" id="row"
				requestURI="${contextPath}/operate/doubt/search.action" class="its"
				pagesize="10" partialList="true" size="resultSize">
             
				<display:column property="diary_name" title="日记名称"
					headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
					class="center" sortable="true"></display:column>

				<display:column property="diary_code" title="日记编码"
					headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
					class="center" sortable="true"></display:column>
				 
				<display:column property="diary_author" title="提交人"
					headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
					class="center" sortable="true"></display:column>


				<display:column property="diary_date" title="提交日期"
					headerClass="center" maxLength="10" style="WHITE-SPACE: nowrap"
					class="center" sortable="true"></display:column>
				<display:column title="操作" headerClass="center"
					style="WHITE-SPACE: nowrap" class="center">
					<a href="javascript:void(0);" onclick="editRecord('${row.diary_id}','${row.diary_author_code}')">编辑</a>&nbsp;&nbsp;
					<a href="javascript:void(0);" onclick="deleteRecord('${row.diary_id}','${row.diary_author_code}')">删除</a>&nbsp;&nbsp;
					<a href="javascript:void(0);" onclick="viewRecord('${row.diary_id}')">查看</a>&nbsp;&nbsp;
	                      </display:column>
			</display:table>
			<br>
			<div align="center">
			
			
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


		</form>

	</body>
</html>
