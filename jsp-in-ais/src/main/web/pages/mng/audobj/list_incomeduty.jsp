<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<title></title>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	function  edit(){
		var obj=findSelectObj();
		if(obj!=null){
			window.location.href="<%=request.getContextPath()%>/mng/audobj/duty/edit.action?person.id="+obj.value;
		}else{
			alert("选择一个行修改!");return false;
		}
	}
	function  view(){
		var obj=findSelectObj();
		if(obj!=null){
			window.location.href="<%=request.getContextPath()%>/mng/audobj/duty/edit.action?view=view&person.id="+obj.value;
		}else{
			alert("选择一个行查看!");return false;
		}
	}
	function add(){
		var value=document.getElementsByName("person.fk")[0].value;
		var url='<%=request.getContextPath()%>/mng/audobj/duty/edit.action?person.fk='+value+'&person.id=';
		window.location.href=url;
	}
	function del(){
		var obj=findSelectObj();
		if(obj!=null){
			if(confirm("确定删除?")){
				var value=document.getElementsByName("person.fk")[0].value;
				window.location.href="<%=request.getContextPath()%>/mng/audobj/duty/del.action?person.fk="+value+"&person.id="+obj.value;
			}
		}else{
			alert("选择一个行删除!");return false;
		}
	}
	function findSelectObj(){
		var ids=document.getElementsByName("person.id");
		for(var i=0;i<ids.length;i++){
			if(ids[i].checked==true){
				return ids[i];
			}
		}
		return null;
	}
</script> 
</head>
<body>
<center>
<display:table name="list" id="row" requestURI="" class="its" pagesize="5" size="100%">
	<display:column title="选择">
		<input type="radio" name="person.id" value="${row.id}">
	</display:column>
	<display:column property="name" title="姓名" sortable="true" headerClass="center"></display:column>
	<display:column property="workStatus" title="状态" sortable="true" headerClass="center"></display:column>
	<display:column property="dept" title="部门" sortable="true" headerClass="center"></display:column>
	<display:column property="postion" title="职务" sortable="true" headerClass="center"></display:column>
	<display:column property="startDate" title="任职开始时间" sortable="true" headerClass="center"></display:column>
	<display:column property="endDate" title="任职结束时间" sortable="true" headerClass="center"></display:column>
</display:table>
<s:form action="" namespace="/mng/audobj/history" theme="simple">
<s:hidden name="person.fk"/>
	<div style="text-align: right;">
	<s:if test="${empty(view)}">
	<s:button value="增加" onclick="add();"/>
	<s:button value="修改" onclick="edit();"/>
	<s:button value="删除" onclick="del();"/>
	</s:if>
	<s:button value="查看" onclick="view();"/>
	</div>
</s:form>
</center>
</body>
</html>
