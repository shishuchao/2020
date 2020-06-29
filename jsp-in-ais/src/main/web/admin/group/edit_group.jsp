<%@ page language="java"  pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title></title>
<jsp:include flush="true" page="/admin/group/aisUrl.jsp"></jsp:include>
<link href="/ais/styles/main/ais.css" rel="stylesheet" type="text/css">
<link href="${contextPath}/css/main.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	 function setfmid(obj,otherName){var str;str=obj.options[obj.selectedIndex].text;document.getElementsByName(otherName)[0].value=str;}
	 function $_name(name){return document.getElementsByName(name)[0];}
	 function chgSel(){
	 	var l_names=$_name("loginNames");
	 	var names=$_name("names");
	 	var type=$_name("group.type");
	 	l_names.value="";
	 	names.value="";
	 	var sel=document.getElementById("sel");
	 	if(type.value=='o'){
	 		sel.onclick=function(){showPopWin('<%=request.getAttribute("ais_url")%>/pages/system/search/searchdatamuti.jsp?url=<%=request.getAttribute("ais_url")%>/system/uSystemAction!orgList4muti.action&paraname=names&paraid=loginNames',600,350);};
	 	}else{
	 		sel.onclick=function(){showPopWin('<%=request.getAttribute("ais_url")%>/pages/system/search/mutiselect.jsp?url=<%=request.getAttribute("ais_url")%>/pages/system/userindex.jsp&paraname=names&paraid=loginNames&p_issel=1&p_item=2',600,350);};
	 	}
	 }
	 function beforeSub(){
	 	var obj=$_name('group.name');
	 	if(obj.value.length<1){alert('群组名称 为必填项！');return false;}
	 	obj=$_name('names');
	 	if(obj.value.length<1){alert('群组人员 为必填项！');return false;}
	 	return true;
	 }
</script>
</head>
<body>
<s:form id="myForm" action="virtualGroupAction!save" namespace="/admin" method="post" theme="simple" onsubmit="return beforeSub()">
	<s:hidden name="group.id"/>
	<s:hidden name="group.typeName" value="人员"/>
	<s:hidden name="group.type" value="u"/>
	<s:hidden name="group.company"/>
	<s:hidden name="group.companyId"/>
	<s:hidden name="loginNames"/>
	<table cellpadding=1 cellspacing=1 border=0  class="ListTable">
		<tr class="listtablehead">
			<td class="listtabletr2" style="width:20%;">
				群组名称<font color="red">*</font>
			</td>
			<td class="listtabletr2" style="width:30%;">
				<s:textfield name="group.name"/>
			</td>
			<td class="listtabletr2" style="width:20%;">
			</td>
			<td class="listtabletr2" style="width:30%;">
			</td>
		</tr>
		<tr class="listtablehead">
			<td class="listtabletr2">
				群组人员<font color="red">*</font>
			</td>
			<td class="listtabletr2" colspan="3">
				<s:textfield name="names" cssStyle="width:90%" readonly="true"/>
				&nbsp;
				<s:if test="${group.type=='o'}">
				<img id="sel"
					src="<%=request.getAttribute("ais_url")%>/resources/images/s_search.gif"
					onclick="showPopWin('<%=request.getAttribute("ais_url")%>/pages/system/search/searchdatamuti.jsp?url=<%=request.getAttribute("ais_url")%>/system/uSystemAction!orgList4muti.action&paraname=names&paraid=loginNames',600,350)";
					border=0 style="cursor:hand">
				</s:if><s:else>
				<img id="sel"
					src="<%=request.getAttribute("ais_url")%>/resources/images/s_search.gif"
					onclick="showPopWin('<%=request.getAttribute("ais_url")%>/pages/system/search/mutiselect.jsp?url=<%=request.getAttribute("ais_url")%>/pages/system/userindex.jsp&paraname=names&paraid=loginNames&p_issel=1&p_item=2',600,350)"
					border=0 style="cursor:hand">
				</s:else>
			</td>
		</tr>
		
	</table>
	<table style="width:97%;border:0" > 
		<tr>
			<td>
				<span style="float:right;">
					<s:submit value="保存"/>
				</span>
			</td>
		</tr>
	</table>
</s:form>  
</body>
</html>
<%--
<s:if test="${empty (group.id)}">
				<s:select list="#@java.util.LinkedHashMap@{'o':'组织','u':'人员'}" name="group.type" emptyOption="true" required="true" onchange="setfmid(this,'group.typeName');chgSel();"></s:select>
			</s:if><s:else>
				<s:hidden name="group.type"/>
				<s:select list="#@java.util.LinkedHashMap@{'o':'组织','u':'人员'}" name="group.type" disabled="true" emptyOption="true" required="true" onchange="setfmid(this,'group.typeName');chgSel();"></s:select>
			</s:else>
--%>