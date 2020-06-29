<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:directive.page import="java.util.List" />
<jsp:directive.page import="ais.operate.task.model.AudDoubt" />
<s:if test="type == 'BW'">
	<s:text id="title" name="'审计备忘'"></s:text>
</s:if>


<s:if test="type == 'YD'">
	<s:text id="title" name="'审计疑点'"></s:text>
</s:if>


<s:if test="type == 'FX'">
	<s:text id="title" name="'审计发现'"></s:text>
</s:if>

<s:if test="type == 'DS'">
	<s:text id="title" name="'重大事项'"></s:text>
</s:if>




<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" /></title>
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
             window.location.href='/ais/operate/doubt/editDoubt.action?type=${type}&pro_id=${pro_id}&taskId=${taskId}';
           }
           //删除
          function deleteRecord(s,p,q)
		  {             if('${user.floginname}'==q){
		                    //alert("123");
		                  }else{
		                    alert("没有权限编辑！");
		                    return false;
		                  }
		                  if(p=='050'){
		                    alert("已处理状态，不能删除！");
		                    return false;
		                  }else{
		                  }
		    
						if(confirm("确认删除这条记录?")){
						
						//window.location.href='/ais/operate/doubt/delete.action?type=${type}&doubt_id='+doubt_idArray[i].value;
						//document.getElementsByName("doubt_id")[0].value=doubt_idArray[i].value;
						myform.action = "${contextPath}/operate/doubt/delete.action?doubt_id="+s;
	                    myform.submit();
	                    
		   } 
		  } 
		  //编辑
          function editRecord(s,p,q)
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
		                  if(p=='050'){
		                    alert("已处理状态，不能编辑！");
		                    return false;
		                  }else{
		                  }
						//alert(doubt_idArray[i].value); 
						//if(confirm("确认删除这条记录?")){
						
						//window.location.href='/ais/operate/doubt/delete.action?type=${type}&doubt_id='+doubt_idArray[i].value;
						//document.getElementsByName("doubt_id")[0].value=doubt_idArray[i].value;
						myform.action = "${contextPath}/operate/doubt/editDoubt.action?doubt_id="+s;
	                    myform.submit();
	            
           }
           //查看
          function viewRecord(s)
		  {
		     window.open("${contextPath}/operate/doubt/view.action?doubt_id="+s,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
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
				<%
						String type = (String) request.getAttribute("type");
						if ("BW".equals(type)) {
				%>
				<display:column property="doubt_name" title="备忘名称"
					headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
					class="center" sortable="true"></display:column>

				<display:column property="doubt_statusName" title="备忘状态"
					headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
					class="center" sortable="true"></display:column>

				<display:column property="doubt_code" title="备忘编码"
					headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
					class="center" sortable="true"></display:column>
				<%
				} else if ("YD".equals(type)) {
				%>
				<display:column property="doubt_name" title="疑点名称"
					headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
					class="center" sortable="true"></display:column>

				<display:column property="doubt_statusName" title="疑点状态"
					headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
					class="center" sortable="true"></display:column>

				<display:column property="doubt_code" title="疑点编码"
					headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
					class="center" sortable="true"></display:column>
				<%
				} else if ("FX".equals(type)) {
				%>
				<display:column property="doubt_name" title="发现名称"
					headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
					class="center" sortable="true"></display:column>

				<display:column property="doubt_statusName" title="发现状态"
					headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
					class="center" sortable="true"></display:column>

				<display:column property="doubt_code" title="发现编码"
					headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
					class="center" sortable="true"></display:column>


				<%
				} else if ("DS".equals(type)) {
				%>
				<display:column property="doubt_name" title="重大事项名称"
					headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
					class="center" sortable="true"></display:column>

				<display:column property="doubt_statusName" title="重大事项状态"
					headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
					class="center" sortable="true"></display:column>

				<display:column property="doubt_code" title="重大事项编码"
					headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
					class="center" sortable="true"></display:column>


				<%
				}
				%>
				<display:column property="doubt_author" title="提交人"
					headerClass="center" maxLength="12" style="WHITE-SPACE: nowrap"
					class="center" sortable="true"></display:column>


				<display:column property="doubt_date" title="提交日期"
					headerClass="center" maxLength="10" style="WHITE-SPACE: nowrap"
					class="center" sortable="true"></display:column>
				<display:column title="操作" headerClass="center"
					style="WHITE-SPACE: nowrap" class="center">
					<a href="javascript:void(0);"
						onclick="editRecord('${row.doubt_id}','${row.doubt_status}','${row.doubt_author_code}')">编辑</a>&nbsp;&nbsp;
					<a href="javascript:void(0);"
						onclick="deleteRecord('${row.doubt_id}','${row.doubt_status}','${row.doubt_author_code}')">删除</a>&nbsp;&nbsp;
					<a href="javascript:void(0);" onclick="viewRecord('${row.doubt_id}')">查看</a>&nbsp;&nbsp;
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
